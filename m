From: "Corfu, ValentinX" <valentinx.corfu@intel.com>
Subject: [alsa-plugins] [PATCH 1/2] Allow number of channels
Date: Tue, 21 Jan 2014 16:41:15 +0000
Message-ID: <9900E8BE2ADAAB43B2A4471493EDB7F94A88F7@IRSMSX104.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_9900E8BE2ADAAB43B2A4471493EDB7F94A88F7IRSMSX104gercorpi_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 910C12617AE
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 17:41:20 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_004_9900E8BE2ADAAB43B2A4471493EDB7F94A88F7IRSMSX104gercorpi_
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

0001-Modify-jack-client-name.patch is spitted in: 0001-Allow-number-of-chan=
nels.patch and 0002-Allow-to-specify-a-client-name-as-parameters-in-the-.pa=
tch

>From d247e4d675dd68c6f683a8c09ff792172396e870 Mon Sep 17 00:00:00 2001
From: Valentin Corfu <valentinx.corfu@intel.com>
Date: Tue, 21 Jan 2014 10:10:52 -0500
Subject: [PATCH 1/2] Allow number of channels

The modification allows to specify the number of channels as parameters in =
the configuration file
The given number of channels are then created but not connected.

Signed-off-by: Valentin Corfu <valentinx.corfu@intel.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index c51fe84..4306a13 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -415,6 +415,8 @@ SND_PCM_PLUGIN_DEFINE_FUNC(jack)
     snd_config_t *playback_conf =3D NULL;
     snd_config_t *capture_conf =3D NULL;
     int err;
+    long num_channels =3D 0;
+    long chan;

     snd_config_for_each(i, next, conf) {
         snd_config_t *n =3D snd_config_iterator_entry(i);
@@ -423,6 +425,10 @@ SND_PCM_PLUGIN_DEFINE_FUNC(jack)
             continue;
         if (strcmp(id, "comment") =3D=3D 0 || strcmp(id, "type") =3D=3D 0 =
|| strcmp(id, "hint") =3D=3D 0)
             continue;
+        if (strcmp(id, "nchan") =3D=3D 0) {
+            snd_config_get_integer(n, &num_channels);
+            continue;
+        }
         if (strcmp(id, "playback_ports") =3D=3D 0) {
             if (snd_config_get_type(n) !=3D SND_CONFIG_TYPE_COMPOUND) {
                 SNDERR("Invalid type for %s", id);
@@ -443,7 +449,72 @@ SND_PCM_PLUGIN_DEFINE_FUNC(jack)
         return -EINVAL;
     }

-    err =3D snd_pcm_jack_open(pcmp, name, playback_conf, capture_conf, str=
eam, mode);
+    if ( (num_channels !=3D 0) && (playback_conf =3D=3D NULL) && (capture_=
conf =3D=3D NULL) ) {
+        err =3D snd_config_make_compound(&playback_conf, "playback_ports",=
 0);
+        if (err) {
+            SNDERR("Error during snd_config_make_compound(p): %s\n", strer=
ror(err));
+            return err;
+        }
+        err =3D snd_config_make_compound(&capture_conf, "capture_ports", 0=
);
+        if (err) {
+            SNDERR("Error during snd_config_make_compound(c): %s\n", strer=
ror(err));
+            return err;
+        }
+        char value[4];
+        for (chan=3D0; chan<num_channels; ++chan) {
+            snprintf(value, sizeof(value), "%d", chan);
+            snd_config_t *newLeafPlayback;
+            snd_config_t *newLeafCapture;
+        err =3D snd_config_imake_integer(&newLeafPlayback, value, chan);
+            if (err) {
+                SNDERR("Error during snd_config_imake_string(p): %s\n", st=
rerror(err));
+                return err;
+            }
+        err =3D snd_config_add(playback_conf, newLeafPlayback);
+            if (err) {
+                SNDERR("Error during snd_config_add(p): %s\n", strerror(er=
r));
+                return err;
+            }
+        err =3D snd_config_imake_integer(&newLeafCapture, value, chan);
+            if (err) {
+                SNDERR("Error during snd_config_imake_string(c): %s\n", st=
rerror(err));
+                return err;
+            }
+        err =3D snd_config_add(capture_conf, newLeafCapture);
+            if (err) {
+                SNDERR("Error during snd_config_add(c): %s\n", strerror(er=
r));
+                return err;
+            }
+        }
+        err =3D snd_pcm_jack_open(pcmp, name, playback_conf, capture_conf,=
 stream, mode);
+        if (err) {
+            SNDERR("Error during snd_pcm_jack_open: %s\n", strerror(err));
+            return err;
+        }
+
+        err =3D snd_config_delete_compound_members(playback_conf);
+        if (err) {
+            SNDERR("Error during snd_config_delete_compound_members(p): %s=
\n", strerror(err));
+            return err;
+        }
+        err =3D snd_config_delete_compound_members(capture_conf);
+        if (err) {
+            SNDERR("Error during snd_config_delete_compound_members(c): %s=
\n", strerror(err));
+            return err;
+        }
+        err =3D snd_config_delete(playback_conf);
+        if (err) {
+            SNDERR("Error during snd_config_delete(p): %s\n", strerror(err=
));
+            return err;
+        }
+        err =3D snd_config_delete(capture_conf);
+        if (err) {
+            SNDERR("Error during snd_config_delete(c): %s\n", strerror(err=
));
+            return err;
+        }
+    } else {
+        err =3D snd_pcm_jack_open(pcmp, name, playback_conf, capture_conf,=
 stream, mode);
+    }

     return err;
 }
--
1.8.1.4


--------------------------------------------------------------
Intel Shannon Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263
Business address: Dromore House, East Park, Shannon, Co. Clare

This e-mail and any attachments may contain confidential material for the s=
ole use of the intended recipient(s). Any review or distribution by others =
is strictly prohibited. If you are not the intended recipient, please conta=
ct the sender and delete all copies.


--_004_9900E8BE2ADAAB43B2A4471493EDB7F94A88F7IRSMSX104gercorpi_
Content-Type: text/x-patch; name="0001-Allow-number-of-channels.patch"
Content-Description: 0001-Allow-number-of-channels.patch
Content-Disposition: attachment;
	filename="0001-Allow-number-of-channels.patch"; size=3633;
	creation-date="Tue, 21 Jan 2014 16:20:05 GMT";
	modification-date="Tue, 21 Jan 2014 16:20:05 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlOWJmZTBlY2Y3OWU3ODYwY2JlMTE5MzU1MzMwZGMyNzYyOTBkMzVjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWYWxlbnRpbiBDb3JmdSA8dmFsZW50aW54LmNvcmZ1QGludGVs
LmNvbT4KRGF0ZTogVHVlLCAyMSBKYW4gMjAxNCAxMDoxMDo1MiAtMDUwMApTdWJqZWN0OiBbUEFU
Q0ggMS8yXSBBbGxvdyBudW1iZXIgb2YgY2hhbm5lbHMKClRoZSBtb2RpZmljYXRpb24gYWxsb3dz
IHRvIHNwZWNpZnkgdGhlIG51bWJlciBvZiBjaGFubmVscyBhcyBwYXJhbWV0ZXJzIGluIHRoZSBj
b25maWd1cmF0aW9uIGZpbGUKVGhlIGdpdmVuIG51bWJlciBvZiBjaGFubmVscyBhcmUgdGhlbiBj
cmVhdGVkIGJ1dCBub3QgY29ubmVjdGVkLgoKZGlmZiAtLWdpdCBhL2phY2svcGNtX2phY2suYyBi
L2phY2svcGNtX2phY2suYwppbmRleCBjNTFmZTg0Li40MzA2YTEzIDEwMDY0NAotLS0gYS9qYWNr
L3BjbV9qYWNrLmMKKysrIGIvamFjay9wY21famFjay5jCkBAIC00MTUsNiArNDE1LDggQEAgU05E
X1BDTV9QTFVHSU5fREVGSU5FX0ZVTkMoamFjaykKIAlzbmRfY29uZmlnX3QgKnBsYXliYWNrX2Nv
bmYgPSBOVUxMOwogCXNuZF9jb25maWdfdCAqY2FwdHVyZV9jb25mID0gTlVMTDsKIAlpbnQgZXJy
OworCWxvbmcgbnVtX2NoYW5uZWxzID0gMDsKKwlsb25nIGNoYW47CiAJCiAJc25kX2NvbmZpZ19m
b3JfZWFjaChpLCBuZXh0LCBjb25mKSB7CiAJCXNuZF9jb25maWdfdCAqbiA9IHNuZF9jb25maWdf
aXRlcmF0b3JfZW50cnkoaSk7CkBAIC00MjMsNiArNDI1LDEwIEBAIFNORF9QQ01fUExVR0lOX0RF
RklORV9GVU5DKGphY2spCiAJCQljb250aW51ZTsKIAkJaWYgKHN0cmNtcChpZCwgImNvbW1lbnQi
KSA9PSAwIHx8IHN0cmNtcChpZCwgInR5cGUiKSA9PSAwIHx8IHN0cmNtcChpZCwgImhpbnQiKSA9
PSAwKQogCQkJY29udGludWU7CisJCWlmIChzdHJjbXAoaWQsICJuY2hhbiIpID09IDApIHsKKwkJ
CXNuZF9jb25maWdfZ2V0X2ludGVnZXIobiwgJm51bV9jaGFubmVscyk7CisJCQljb250aW51ZTsK
KwkJfQogCQlpZiAoc3RyY21wKGlkLCAicGxheWJhY2tfcG9ydHMiKSA9PSAwKSB7CiAJCQlpZiAo
c25kX2NvbmZpZ19nZXRfdHlwZShuKSAhPSBTTkRfQ09ORklHX1RZUEVfQ09NUE9VTkQpIHsKIAkJ
CQlTTkRFUlIoIkludmFsaWQgdHlwZSBmb3IgJXMiLCBpZCk7CkBAIC00NDMsNyArNDQ5LDcyIEBA
IFNORF9QQ01fUExVR0lOX0RFRklORV9GVU5DKGphY2spCiAJCXJldHVybiAtRUlOVkFMOwogCX0K
IAotCWVyciA9IHNuZF9wY21famFja19vcGVuKHBjbXAsIG5hbWUsIHBsYXliYWNrX2NvbmYsIGNh
cHR1cmVfY29uZiwgc3RyZWFtLCBtb2RlKTsKKwlpZiAoIChudW1fY2hhbm5lbHMgIT0gMCkgJiYg
KHBsYXliYWNrX2NvbmYgPT0gTlVMTCkgJiYgKGNhcHR1cmVfY29uZiA9PSBOVUxMKSApIHsKKwkJ
ZXJyID0gc25kX2NvbmZpZ19tYWtlX2NvbXBvdW5kKCZwbGF5YmFja19jb25mLCAicGxheWJhY2tf
cG9ydHMiLCAwKTsKKwkJaWYgKGVycikgeworCQkJU05ERVJSKCJFcnJvciBkdXJpbmcgc25kX2Nv
bmZpZ19tYWtlX2NvbXBvdW5kKHApOiAlc1xuIiwgc3RyZXJyb3IoZXJyKSk7CisJCQlyZXR1cm4g
ZXJyOworCQl9CisJCWVyciA9IHNuZF9jb25maWdfbWFrZV9jb21wb3VuZCgmY2FwdHVyZV9jb25m
LCAiY2FwdHVyZV9wb3J0cyIsIDApOworCQlpZiAoZXJyKSB7CisJCQlTTkRFUlIoIkVycm9yIGR1
cmluZyBzbmRfY29uZmlnX21ha2VfY29tcG91bmQoYyk6ICVzXG4iLCBzdHJlcnJvcihlcnIpKTsK
KwkJCXJldHVybiBlcnI7CisJCX0KKwkJY2hhciB2YWx1ZVs0XTsKKwkJZm9yIChjaGFuPTA7IGNo
YW48bnVtX2NoYW5uZWxzOyArK2NoYW4pIHsKKwkJCXNucHJpbnRmKHZhbHVlLCBzaXplb2YodmFs
dWUpLCAiJWQiLCBjaGFuKTsKKwkJCXNuZF9jb25maWdfdCAqbmV3TGVhZlBsYXliYWNrOworCQkJ
c25kX2NvbmZpZ190ICpuZXdMZWFmQ2FwdHVyZTsKKwkJZXJyID0gc25kX2NvbmZpZ19pbWFrZV9p
bnRlZ2VyKCZuZXdMZWFmUGxheWJhY2ssIHZhbHVlLCBjaGFuKTsKKwkJCWlmIChlcnIpIHsKKwkJ
CQlTTkRFUlIoIkVycm9yIGR1cmluZyBzbmRfY29uZmlnX2ltYWtlX3N0cmluZyhwKTogJXNcbiIs
IHN0cmVycm9yKGVycikpOworCQkJCXJldHVybiBlcnI7CisJCQl9CisJCWVyciA9IHNuZF9jb25m
aWdfYWRkKHBsYXliYWNrX2NvbmYsIG5ld0xlYWZQbGF5YmFjayk7CisJCQlpZiAoZXJyKSB7CisJ
CQkJU05ERVJSKCJFcnJvciBkdXJpbmcgc25kX2NvbmZpZ19hZGQocCk6ICVzXG4iLCBzdHJlcnJv
cihlcnIpKTsKKwkJCQlyZXR1cm4gZXJyOworCQkJfQorCQllcnIgPSBzbmRfY29uZmlnX2ltYWtl
X2ludGVnZXIoJm5ld0xlYWZDYXB0dXJlLCB2YWx1ZSwgY2hhbik7CisJCQlpZiAoZXJyKSB7CisJ
CQkJU05ERVJSKCJFcnJvciBkdXJpbmcgc25kX2NvbmZpZ19pbWFrZV9zdHJpbmcoYyk6ICVzXG4i
LCBzdHJlcnJvcihlcnIpKTsKKwkJCQlyZXR1cm4gZXJyOworCQkJfQorCQllcnIgPSBzbmRfY29u
ZmlnX2FkZChjYXB0dXJlX2NvbmYsIG5ld0xlYWZDYXB0dXJlKTsKKwkJCWlmIChlcnIpIHsKKwkJ
CQlTTkRFUlIoIkVycm9yIGR1cmluZyBzbmRfY29uZmlnX2FkZChjKTogJXNcbiIsIHN0cmVycm9y
KGVycikpOworCQkJCXJldHVybiBlcnI7CisJCQl9CisJCX0KKwkJZXJyID0gc25kX3BjbV9qYWNr
X29wZW4ocGNtcCwgbmFtZSwgcGxheWJhY2tfY29uZiwgY2FwdHVyZV9jb25mLCBzdHJlYW0sIG1v
ZGUpOworCQlpZiAoZXJyKSB7CisJCQlTTkRFUlIoIkVycm9yIGR1cmluZyBzbmRfcGNtX2phY2tf
b3BlbjogJXNcbiIsIHN0cmVycm9yKGVycikpOworCQkJcmV0dXJuIGVycjsKKwkJfQorCisJCWVy
ciA9IHNuZF9jb25maWdfZGVsZXRlX2NvbXBvdW5kX21lbWJlcnMocGxheWJhY2tfY29uZik7CisJ
CWlmIChlcnIpIHsKKwkJCVNOREVSUigiRXJyb3IgZHVyaW5nIHNuZF9jb25maWdfZGVsZXRlX2Nv
bXBvdW5kX21lbWJlcnMocCk6ICVzXG4iLCBzdHJlcnJvcihlcnIpKTsKKwkJCXJldHVybiBlcnI7
CisJCX0KKwkJZXJyID0gc25kX2NvbmZpZ19kZWxldGVfY29tcG91bmRfbWVtYmVycyhjYXB0dXJl
X2NvbmYpOworCQlpZiAoZXJyKSB7CisJCQlTTkRFUlIoIkVycm9yIGR1cmluZyBzbmRfY29uZmln
X2RlbGV0ZV9jb21wb3VuZF9tZW1iZXJzKGMpOiAlc1xuIiwgc3RyZXJyb3IoZXJyKSk7CisJCQly
ZXR1cm4gZXJyOworCQl9CisJCWVyciA9IHNuZF9jb25maWdfZGVsZXRlKHBsYXliYWNrX2NvbmYp
OworCQlpZiAoZXJyKSB7CisJCQlTTkRFUlIoIkVycm9yIGR1cmluZyBzbmRfY29uZmlnX2RlbGV0
ZShwKTogJXNcbiIsIHN0cmVycm9yKGVycikpOworCQkJcmV0dXJuIGVycjsKKwkJfQorCQllcnIg
PSBzbmRfY29uZmlnX2RlbGV0ZShjYXB0dXJlX2NvbmYpOworCQlpZiAoZXJyKSB7CisJCQlTTkRF
UlIoIkVycm9yIGR1cmluZyBzbmRfY29uZmlnX2RlbGV0ZShjKTogJXNcbiIsIHN0cmVycm9yKGVy
cikpOworCQkJcmV0dXJuIGVycjsKKwkJfQorCX0gZWxzZSB7CisJCWVyciA9IHNuZF9wY21famFj
a19vcGVuKHBjbXAsIG5hbWUsIHBsYXliYWNrX2NvbmYsIGNhcHR1cmVfY29uZiwgc3RyZWFtLCBt
b2RlKTsKKwl9CiAKIAlyZXR1cm4gZXJyOwogfQotLSAKMS44LjEuNAoK

--_004_9900E8BE2ADAAB43B2A4471493EDB7F94A88F7IRSMSX104gercorpi_
Content-Type: text/x-patch; name="0001-Modify-jack-client-name.patch"
Content-Description: 0001-Modify-jack-client-name.patch
Content-Disposition: attachment;
	filename="0001-Modify-jack-client-name.patch"; size=5812;
	creation-date="Tue, 21 Jan 2014 16:20:05 GMT";
	modification-date="Tue, 21 Jan 2014 16:20:05 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxMzA2OTMxMmIwOWEzMDAyZmNhMzVlNTY0OTY4Zjc0YmNjMGQ5ZmE0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWYWxlbnRpbiBDb3JmdSA8dmFsZW50aW54LmNvcmZ1QGludGVs
LmNvbT4KRGF0ZTogVHVlLCAyMSBKYW4gMjAxNCAwOTo1MjoxNyAtMDUwMApTdWJqZWN0OiBbUEFU
Q0hdIE1vZGlmeSBqYWNrIGNsaWVudCBuYW1lCgotLS0KIGphY2svcGNtX2phY2suYyB8IDEwOSAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDEwMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2phY2svcGNtX2phY2suYyBiL2phY2svcGNtX2phY2suYwppbmRleCBjNTFmZTg0Li42
MWFjMTk3IDEwMDY0NAotLS0gYS9qYWNrL3BjbV9qYWNrLmMKKysrIGIvamFjay9wY21famFjay5j
CkBAIC0zMiw2ICszMiwxMSBAQCB0eXBlZGVmIGVudW0gX2phY2tfZm9ybWF0IHsKIAlTTkRfUENN
X0pBQ0tfRk9STUFUX1JBVwogfSBzbmRfcGNtX2phY2tfZm9ybWF0X3Q7CiAKK3R5cGVkZWYgZW51
bSBfbmFtaW5nX3NjaGVtZSB7CisJU05EX1BDTV9KQUNLX1NURF9OQU1FLAorCVNORF9QQ01fSkFD
S19VU0VSX0RFRklORURfTkFNRQorfSBzbmRfcGNtX2phY2tfbmFtaW5nX3Q7CisKIHR5cGVkZWYg
c3RydWN0IHsKIAlzbmRfcGNtX2lvcGx1Z190IGlvOwogCkBAIC0zMjUsNyArMzMwLDggQEAgc3Rh
dGljIGludCBtYWtlX25vbmJsb2NrKGludCBmZCkKIHN0YXRpYyBpbnQgc25kX3BjbV9qYWNrX29w
ZW4oc25kX3BjbV90ICoqcGNtcCwgY29uc3QgY2hhciAqbmFtZSwKIAkJCSAgICAgc25kX2NvbmZp
Z190ICpwbGF5YmFja19jb25mLAogCQkJICAgICBzbmRfY29uZmlnX3QgKmNhcHR1cmVfY29uZiwK
LQkJCSAgICAgc25kX3BjbV9zdHJlYW1fdCBzdHJlYW0sIGludCBtb2RlKQorCQkJICAgICBzbmRf
cGNtX3N0cmVhbV90IHN0cmVhbSwgaW50IG1vZGUsCisJCQkgICAgIHNuZF9wY21famFja19uYW1p
bmdfdCBuYW1pbmcpCiB7CiAJc25kX3BjbV9qYWNrX3QgKmphY2s7CiAJaW50IGVycjsKQEAgLTM1
NiwxMSArMzYyLDE5IEBAIHN0YXRpYyBpbnQgc25kX3BjbV9qYWNrX29wZW4oc25kX3BjbV90ICoq
cGNtcCwgY29uc3QgY2hhciAqbmFtZSwKIAkJcmV0dXJuIC1FSU5WQUw7CiAJfQogCi0JaWYgKHNu
cHJpbnRmKGphY2tfY2xpZW50X25hbWUsIHNpemVvZihqYWNrX2NsaWVudF9uYW1lKSwgImFsc2Et
amFjay4lcyVzLiVkLiVkIiwgbmFtZSwKLQkJICAgICBzdHJlYW0gPT0gU05EX1BDTV9TVFJFQU1f
UExBWUJBQ0sgPyAiUCIgOiAiQyIsIGdldHBpZCgpLCBudW0rKykKLQkgICAgPj0gKGludClzaXpl
b2YoamFja19jbGllbnRfbmFtZSkpIHsKLQkJZnByaW50ZihzdGRlcnIsICIlczogV0FSTklORzog
SkFDSyBjbGllbnQgbmFtZSAnJXMnIHRydW5jYXRlZCB0byAlZCBjaGFyYWN0ZXJzLCBtaWdodCBu
b3QgYmUgdW5pcXVlXG4iLAotCQkJX19mdW5jX18sIGphY2tfY2xpZW50X25hbWUsIChpbnQpc3Ry
bGVuKGphY2tfY2xpZW50X25hbWUpKTsKKwlpZiAobmFtaW5nID09IFNORF9QQ01fSkFDS19TVERf
TkFNRSApIHsKKwkJaWYgKHNucHJpbnRmKGphY2tfY2xpZW50X25hbWUsIHNpemVvZihqYWNrX2Ns
aWVudF9uYW1lKSwgImFsc2EtamFjay4lcyVzLiVkLiVkIiwgbmFtZSwKKwkJCQlzdHJlYW0gPT0g
U05EX1BDTV9TVFJFQU1fUExBWUJBQ0sgPyAiUCIgOiAiQyIsIGdldHBpZCgpLCBudW0rKykKKwkJ
CT49IChpbnQpc2l6ZW9mKGphY2tfY2xpZW50X25hbWUpKSB7CisJCQkgICAgZnByaW50ZihzdGRl
cnIsICIlczogV0FSTklORzogSkFDSyBjbGllbnQgbmFtZSAnJXMnIHRydW5jYXRlZCB0byAlZCBj
aGFyYWN0ZXJzLCBtaWdodCBub3QgYmUgdW5pcXVlXG4iLAorCQkJCV9fZnVuY19fLCBqYWNrX2Ns
aWVudF9uYW1lLCAoaW50KXN0cmxlbihqYWNrX2NsaWVudF9uYW1lKSk7CisJCX0KKwl9IGVsc2Ug
eworCQlpZiAoc25wcmludGYoamFja19jbGllbnRfbmFtZSwgc2l6ZW9mKGphY2tfY2xpZW50X25h
bWUpLCAiJXMiLCBuYW1lKQorCQkJPj0gKGludClzaXplb2YoamFja19jbGllbnRfbmFtZSkpIHsK
KwkJCSAgICBmcHJpbnRmKHN0ZGVyciwgIiVzOiBXQVJOSU5HOiBKQUNLIGNsaWVudCBuYW1lICcl
cycgdHJ1bmNhdGVkIHRvICVkIGNoYXJhY3RlcnMsIG1pZ2h0IG5vdCBiZSB1bmlxdWVcbiIsCisJ
CQkJX19mdW5jX18sIGphY2tfY2xpZW50X25hbWUsIChpbnQpc3RybGVuKGphY2tfY2xpZW50X25h
bWUpKTsKKwkJfQogCX0KIAogCWphY2stPmNsaWVudCA9IGphY2tfY2xpZW50X25ldyhqYWNrX2Ns
aWVudF9uYW1lKTsKQEAgLTQxNSw2ICs0MjksMTAgQEAgU05EX1BDTV9QTFVHSU5fREVGSU5FX0ZV
TkMoamFjaykKIAlzbmRfY29uZmlnX3QgKnBsYXliYWNrX2NvbmYgPSBOVUxMOwogCXNuZF9jb25m
aWdfdCAqY2FwdHVyZV9jb25mID0gTlVMTDsKIAlpbnQgZXJyOworCWxvbmcgbnVtX2NoYW5uZWxz
ID0gMDsKKwlsb25nIGNoYW47CisJY29uc3QgY2hhciAqbG9jYWxfbmFtZSA9IG5hbWU7CisJc25k
X3BjbV9qYWNrX25hbWluZ190IG5hbWluZyA9IFNORF9QQ01fSkFDS19TVERfTkFNRTsKIAkKIAlz
bmRfY29uZmlnX2Zvcl9lYWNoKGksIG5leHQsIGNvbmYpIHsKIAkJc25kX2NvbmZpZ190ICpuID0g
c25kX2NvbmZpZ19pdGVyYXRvcl9lbnRyeShpKTsKQEAgLTQyMyw2ICs0NDEsMTUgQEAgU05EX1BD
TV9QTFVHSU5fREVGSU5FX0ZVTkMoamFjaykKIAkJCWNvbnRpbnVlOwogCQlpZiAoc3RyY21wKGlk
LCAiY29tbWVudCIpID09IDAgfHwgc3RyY21wKGlkLCAidHlwZSIpID09IDAgfHwgc3RyY21wKGlk
LCAiaGludCIpID09IDApCiAJCQljb250aW51ZTsKKwkJaWYgKHN0cmNtcChpZCwgIm5hbWUiKSA9
PSAwKSB7CisJCQlzbmRfY29uZmlnX2dldF9zdHJpbmcobiwgJmxvY2FsX25hbWUpOworCQkJbmFt
aW5nID0gU05EX1BDTV9KQUNLX1VTRVJfREVGSU5FRF9OQU1FOworCQkJY29udGludWU7CisJCX0K
KwkJaWYgKHN0cmNtcChpZCwgIm5jaGFuIikgPT0gMCkgeworCQkJc25kX2NvbmZpZ19nZXRfaW50
ZWdlcihuLCAmbnVtX2NoYW5uZWxzKTsKKwkJCWNvbnRpbnVlOworCQl9CiAJCWlmIChzdHJjbXAo
aWQsICJwbGF5YmFja19wb3J0cyIpID09IDApIHsKIAkJCWlmIChzbmRfY29uZmlnX2dldF90eXBl
KG4pICE9IFNORF9DT05GSUdfVFlQRV9DT01QT1VORCkgewogCQkJCVNOREVSUigiSW52YWxpZCB0
eXBlIGZvciAlcyIsIGlkKTsKQEAgLTQ0Myw3ICs0NzAsNzUgQEAgU05EX1BDTV9QTFVHSU5fREVG
SU5FX0ZVTkMoamFjaykKIAkJcmV0dXJuIC1FSU5WQUw7CiAJfQogCi0JZXJyID0gc25kX3BjbV9q
YWNrX29wZW4ocGNtcCwgbmFtZSwgcGxheWJhY2tfY29uZiwgY2FwdHVyZV9jb25mLCBzdHJlYW0s
IG1vZGUpOworCWlmICggKG5hbWluZyA9PSBTTkRfUENNX0pBQ0tfVVNFUl9ERUZJTkVEX05BTUUp
CisJCQkJJiYgKG51bV9jaGFubmVscyAhPSAwKQorCQkJCSYmIChwbGF5YmFja19jb25mID09IE5V
TEwpCisJCQkJJiYgKGNhcHR1cmVfY29uZiA9PSBOVUxMKSApIHsKKwkJZXJyID0gc25kX2NvbmZp
Z19tYWtlX2NvbXBvdW5kKCZwbGF5YmFja19jb25mLCAicGxheWJhY2tfcG9ydHMiLCAwKTsKKwkJ
aWYgKGVycikgeworCQkJU05ERVJSKCJFcnJvciBkdXJpbmcgc25kX2NvbmZpZ19tYWtlX2NvbXBv
dW5kKHApOiAlc1xuIiwgc3RyZXJyb3IoZXJyKSk7CisJCQlyZXR1cm4gZXJyOworCQl9CisJCWVy
ciA9IHNuZF9jb25maWdfbWFrZV9jb21wb3VuZCgmY2FwdHVyZV9jb25mLCAiY2FwdHVyZV9wb3J0
cyIsIDApOworCQlpZiAoZXJyKSB7CisJCQlTTkRFUlIoIkVycm9yIGR1cmluZyBzbmRfY29uZmln
X21ha2VfY29tcG91bmQoYyk6ICVzXG4iLCBzdHJlcnJvcihlcnIpKTsKKwkJCXJldHVybiBlcnI7
CisJCX0KKwkJY2hhciB2YWx1ZVs0XTsKKwkJZm9yIChjaGFuPTA7IGNoYW48bnVtX2NoYW5uZWxz
OyArK2NoYW4pIHsKKwkJCXNucHJpbnRmKHZhbHVlLCBzaXplb2YodmFsdWUpLCAiJWQiLCBjaGFu
KTsKKwkJCXNuZF9jb25maWdfdCAqbmV3TGVhZlBsYXliYWNrOworCQkJc25kX2NvbmZpZ190ICpu
ZXdMZWFmQ2FwdHVyZTsKKwkJZXJyID0gc25kX2NvbmZpZ19pbWFrZV9pbnRlZ2VyKCZuZXdMZWFm
UGxheWJhY2ssIHZhbHVlLCBjaGFuKTsKKwkJCWlmIChlcnIpIHsKKwkJCQlTTkRFUlIoIkVycm9y
IGR1cmluZyBzbmRfY29uZmlnX2ltYWtlX3N0cmluZyhwKTogJXNcbiIsIHN0cmVycm9yKGVycikp
OworCQkJCXJldHVybiBlcnI7CisJCQl9CisJCWVyciA9IHNuZF9jb25maWdfYWRkKHBsYXliYWNr
X2NvbmYsIG5ld0xlYWZQbGF5YmFjayk7CisJCQlpZiAoZXJyKSB7CisJCQkJU05ERVJSKCJFcnJv
ciBkdXJpbmcgc25kX2NvbmZpZ19hZGQocCk6ICVzXG4iLCBzdHJlcnJvcihlcnIpKTsKKwkJCQly
ZXR1cm4gZXJyOworCQkJfQorCQllcnIgPSBzbmRfY29uZmlnX2ltYWtlX2ludGVnZXIoJm5ld0xl
YWZDYXB0dXJlLCB2YWx1ZSwgY2hhbik7CisJCQlpZiAoZXJyKSB7CisJCQkJU05ERVJSKCJFcnJv
ciBkdXJpbmcgc25kX2NvbmZpZ19pbWFrZV9zdHJpbmcoYyk6ICVzXG4iLCBzdHJlcnJvcihlcnIp
KTsKKwkJCQlyZXR1cm4gZXJyOworCQkJfQorCQllcnIgPSBzbmRfY29uZmlnX2FkZChjYXB0dXJl
X2NvbmYsIG5ld0xlYWZDYXB0dXJlKTsKKwkJCWlmIChlcnIpIHsKKwkJCQlTTkRFUlIoIkVycm9y
IGR1cmluZyBzbmRfY29uZmlnX2FkZChjKTogJXNcbiIsIHN0cmVycm9yKGVycikpOworCQkJCXJl
dHVybiBlcnI7CisJCQl9CisJCX0KKwkJZXJyID0gc25kX3BjbV9qYWNrX29wZW4ocGNtcCwgbG9j
YWxfbmFtZSwgcGxheWJhY2tfY29uZiwgY2FwdHVyZV9jb25mLCBzdHJlYW0sIG1vZGUsIG5hbWlu
Zyk7CisJCWlmIChlcnIpIHsKKwkJCVNOREVSUigiRXJyb3IgZHVyaW5nIHNuZF9wY21famFja19v
cGVuOiAlc1xuIiwgc3RyZXJyb3IoZXJyKSk7CisJCQlyZXR1cm4gZXJyOworCQl9CisKKwkJZXJy
ID0gc25kX2NvbmZpZ19kZWxldGVfY29tcG91bmRfbWVtYmVycyhwbGF5YmFja19jb25mKTsKKwkJ
aWYgKGVycikgeworCQkJU05ERVJSKCJFcnJvciBkdXJpbmcgc25kX2NvbmZpZ19kZWxldGVfY29t
cG91bmRfbWVtYmVycyhwKTogJXNcbiIsIHN0cmVycm9yKGVycikpOworCQkJcmV0dXJuIGVycjsK
KwkJfQorCQllcnIgPSBzbmRfY29uZmlnX2RlbGV0ZV9jb21wb3VuZF9tZW1iZXJzKGNhcHR1cmVf
Y29uZik7CisJCWlmIChlcnIpIHsKKwkJCVNOREVSUigiRXJyb3IgZHVyaW5nIHNuZF9jb25maWdf
ZGVsZXRlX2NvbXBvdW5kX21lbWJlcnMoYyk6ICVzXG4iLCBzdHJlcnJvcihlcnIpKTsKKwkJCXJl
dHVybiBlcnI7CisJCX0KKwkJZXJyID0gc25kX2NvbmZpZ19kZWxldGUocGxheWJhY2tfY29uZik7
CisJCWlmIChlcnIpIHsKKwkJCVNOREVSUigiRXJyb3IgZHVyaW5nIHNuZF9jb25maWdfZGVsZXRl
KHApOiAlc1xuIiwgc3RyZXJyb3IoZXJyKSk7CisJCQlyZXR1cm4gZXJyOworCQl9CisJCWVyciA9
IHNuZF9jb25maWdfZGVsZXRlKGNhcHR1cmVfY29uZik7CisJCWlmIChlcnIpIHsKKwkJCVNOREVS
UigiRXJyb3IgZHVyaW5nIHNuZF9jb25maWdfZGVsZXRlKGMpOiAlc1xuIiwgc3RyZXJyb3IoZXJy
KSk7CisJCQlyZXR1cm4gZXJyOworCQl9CisJfSBlbHNlIHsKKwkJZXJyID0gc25kX3BjbV9qYWNr
X29wZW4ocGNtcCwgbG9jYWxfbmFtZSwgcGxheWJhY2tfY29uZiwgY2FwdHVyZV9jb25mLCBzdHJl
YW0sIG1vZGUsIG5hbWluZyk7CisJfQogCiAJcmV0dXJuIGVycjsKIH0KLS0gCjEuOC4xLjQKCg==

--_004_9900E8BE2ADAAB43B2A4471493EDB7F94A88F7IRSMSX104gercorpi_
Content-Type: text/x-patch;
	name="0002-Allow-to-specify-a-client-name-as-parameters-in-the-.patch"
Content-Description: 0002-Allow-to-specify-a-client-name-as-parameters-in-the-.patch
Content-Disposition: attachment;
	filename="0002-Allow-to-specify-a-client-name-as-parameters-in-the-.patch";
	size=4507; creation-date="Tue, 21 Jan 2014 16:21:49 GMT";
	modification-date="Tue, 21 Jan 2014 16:21:49 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1NmVlZDlkZmU0ZWE4ZDUzZGZmMTNmMjdkMTc1MWM5MmIyMDBiY2ViIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWYWxlbnRpbiBDb3JmdSA8dmFsZW50aW54LmNvcmZ1QGludGVs
LmNvbT4KRGF0ZTogVHVlLCAyMSBKYW4gMjAxNCAxMDoxNTo1OCAtMDUwMApTdWJqZWN0OiBbUEFU
Q0ggMi8yXSBBbGxvdyB0byBzcGVjaWZ5IGEgY2xpZW50IG5hbWUgYXMgcGFyYW1ldGVycyBpbiB0
aGUKIGNvbmZpZ3VyYXRpb24gZmlsZQoKVGhlIGN1cnJlbnQgamFjayBjbGllbnQgbmFtZSBjb250
YWlucyB0aGUgcHJvY2VzcyBpZCBvZiB0aGUgYXBwbGljYXRpb24gcHJvdmlkaW5nIHRoZSBhdWRp
byBzYW1wbGVzLgpUaGlzIGxlYWRzIHRvIHVucHJlZGljdGFibGUgamFjayBjbGllbnQgbmFtZXMg
d2hpY2ggbWFrZXMgaGFuZGxpbmcgb2YgdGhlIGNvbm5lY3Rpb25zIGJ5IGEgY29udHJvbGxpbmcg
YXBwbGljYXRpb24gdmVyeSBoYXJkLgpUaGlzIG1vZGlmaWNhdGlvbiBub3csIGFsbG93cyB0byBz
cGVjaWZ5IGEgY2xpZW50IG5hbWUgYXMgcGFyYW1ldGVycyBpbiB0aGUgY29uZmlndXJhdGlvbiBm
aWxlLgpUaGUgaW1wbGVtZW50YXRpb24gaXMgYmFja3dhcmQgY29tcGF0aWJsZSBhbmQgc2ltcGx5
IGFkZHMgYSBuZXcgY29uZmlndXJhdGlvbiBvcHRpb24gdG8gdGhlIHBsdWdpbi4KCmRpZmYgLS1n
aXQgYS9qYWNrL3BjbV9qYWNrLmMgYi9qYWNrL3BjbV9qYWNrLmMKaW5kZXggNDMwNmExMy4uNjFh
YzE5NyAxMDA2NDQKLS0tIGEvamFjay9wY21famFjay5jCisrKyBiL2phY2svcGNtX2phY2suYwpA
QCAtMzIsNiArMzIsMTEgQEAgdHlwZWRlZiBlbnVtIF9qYWNrX2Zvcm1hdCB7CiAJU05EX1BDTV9K
QUNLX0ZPUk1BVF9SQVcKIH0gc25kX3BjbV9qYWNrX2Zvcm1hdF90OwogCit0eXBlZGVmIGVudW0g
X25hbWluZ19zY2hlbWUgeworCVNORF9QQ01fSkFDS19TVERfTkFNRSwKKwlTTkRfUENNX0pBQ0tf
VVNFUl9ERUZJTkVEX05BTUUKK30gc25kX3BjbV9qYWNrX25hbWluZ190OworCiB0eXBlZGVmIHN0
cnVjdCB7CiAJc25kX3BjbV9pb3BsdWdfdCBpbzsKIApAQCAtMzI1LDcgKzMzMCw4IEBAIHN0YXRp
YyBpbnQgbWFrZV9ub25ibG9jayhpbnQgZmQpCiBzdGF0aWMgaW50IHNuZF9wY21famFja19vcGVu
KHNuZF9wY21fdCAqKnBjbXAsIGNvbnN0IGNoYXIgKm5hbWUsCiAJCQkgICAgIHNuZF9jb25maWdf
dCAqcGxheWJhY2tfY29uZiwKIAkJCSAgICAgc25kX2NvbmZpZ190ICpjYXB0dXJlX2NvbmYsCi0J
CQkgICAgIHNuZF9wY21fc3RyZWFtX3Qgc3RyZWFtLCBpbnQgbW9kZSkKKwkJCSAgICAgc25kX3Bj
bV9zdHJlYW1fdCBzdHJlYW0sIGludCBtb2RlLAorCQkJICAgICBzbmRfcGNtX2phY2tfbmFtaW5n
X3QgbmFtaW5nKQogewogCXNuZF9wY21famFja190ICpqYWNrOwogCWludCBlcnI7CkBAIC0zNTYs
MTEgKzM2MiwxOSBAQCBzdGF0aWMgaW50IHNuZF9wY21famFja19vcGVuKHNuZF9wY21fdCAqKnBj
bXAsIGNvbnN0IGNoYXIgKm5hbWUsCiAJCXJldHVybiAtRUlOVkFMOwogCX0KIAotCWlmIChzbnBy
aW50ZihqYWNrX2NsaWVudF9uYW1lLCBzaXplb2YoamFja19jbGllbnRfbmFtZSksICJhbHNhLWph
Y2suJXMlcy4lZC4lZCIsIG5hbWUsCi0JCSAgICAgc3RyZWFtID09IFNORF9QQ01fU1RSRUFNX1BM
QVlCQUNLID8gIlAiIDogIkMiLCBnZXRwaWQoKSwgbnVtKyspCi0JICAgID49IChpbnQpc2l6ZW9m
KGphY2tfY2xpZW50X25hbWUpKSB7Ci0JCWZwcmludGYoc3RkZXJyLCAiJXM6IFdBUk5JTkc6IEpB
Q0sgY2xpZW50IG5hbWUgJyVzJyB0cnVuY2F0ZWQgdG8gJWQgY2hhcmFjdGVycywgbWlnaHQgbm90
IGJlIHVuaXF1ZVxuIiwKLQkJCV9fZnVuY19fLCBqYWNrX2NsaWVudF9uYW1lLCAoaW50KXN0cmxl
bihqYWNrX2NsaWVudF9uYW1lKSk7CisJaWYgKG5hbWluZyA9PSBTTkRfUENNX0pBQ0tfU1REX05B
TUUgKSB7CisJCWlmIChzbnByaW50ZihqYWNrX2NsaWVudF9uYW1lLCBzaXplb2YoamFja19jbGll
bnRfbmFtZSksICJhbHNhLWphY2suJXMlcy4lZC4lZCIsIG5hbWUsCisJCQkJc3RyZWFtID09IFNO
RF9QQ01fU1RSRUFNX1BMQVlCQUNLID8gIlAiIDogIkMiLCBnZXRwaWQoKSwgbnVtKyspCisJCQk+
PSAoaW50KXNpemVvZihqYWNrX2NsaWVudF9uYW1lKSkgeworCQkJICAgIGZwcmludGYoc3RkZXJy
LCAiJXM6IFdBUk5JTkc6IEpBQ0sgY2xpZW50IG5hbWUgJyVzJyB0cnVuY2F0ZWQgdG8gJWQgY2hh
cmFjdGVycywgbWlnaHQgbm90IGJlIHVuaXF1ZVxuIiwKKwkJCQlfX2Z1bmNfXywgamFja19jbGll
bnRfbmFtZSwgKGludClzdHJsZW4oamFja19jbGllbnRfbmFtZSkpOworCQl9CisJfSBlbHNlIHsK
KwkJaWYgKHNucHJpbnRmKGphY2tfY2xpZW50X25hbWUsIHNpemVvZihqYWNrX2NsaWVudF9uYW1l
KSwgIiVzIiwgbmFtZSkKKwkJCT49IChpbnQpc2l6ZW9mKGphY2tfY2xpZW50X25hbWUpKSB7CisJ
CQkgICAgZnByaW50ZihzdGRlcnIsICIlczogV0FSTklORzogSkFDSyBjbGllbnQgbmFtZSAnJXMn
IHRydW5jYXRlZCB0byAlZCBjaGFyYWN0ZXJzLCBtaWdodCBub3QgYmUgdW5pcXVlXG4iLAorCQkJ
CV9fZnVuY19fLCBqYWNrX2NsaWVudF9uYW1lLCAoaW50KXN0cmxlbihqYWNrX2NsaWVudF9uYW1l
KSk7CisJCX0KIAl9CiAKIAlqYWNrLT5jbGllbnQgPSBqYWNrX2NsaWVudF9uZXcoamFja19jbGll
bnRfbmFtZSk7CkBAIC00MTcsNiArNDMxLDggQEAgU05EX1BDTV9QTFVHSU5fREVGSU5FX0ZVTkMo
amFjaykKIAlpbnQgZXJyOwogCWxvbmcgbnVtX2NoYW5uZWxzID0gMDsKIAlsb25nIGNoYW47CisJ
Y29uc3QgY2hhciAqbG9jYWxfbmFtZSA9IG5hbWU7CisJc25kX3BjbV9qYWNrX25hbWluZ190IG5h
bWluZyA9IFNORF9QQ01fSkFDS19TVERfTkFNRTsKIAkKIAlzbmRfY29uZmlnX2Zvcl9lYWNoKGks
IG5leHQsIGNvbmYpIHsKIAkJc25kX2NvbmZpZ190ICpuID0gc25kX2NvbmZpZ19pdGVyYXRvcl9l
bnRyeShpKTsKQEAgLTQyNSw2ICs0NDEsMTEgQEAgU05EX1BDTV9QTFVHSU5fREVGSU5FX0ZVTkMo
amFjaykKIAkJCWNvbnRpbnVlOwogCQlpZiAoc3RyY21wKGlkLCAiY29tbWVudCIpID09IDAgfHwg
c3RyY21wKGlkLCAidHlwZSIpID09IDAgfHwgc3RyY21wKGlkLCAiaGludCIpID09IDApCiAJCQlj
b250aW51ZTsKKwkJaWYgKHN0cmNtcChpZCwgIm5hbWUiKSA9PSAwKSB7CisJCQlzbmRfY29uZmln
X2dldF9zdHJpbmcobiwgJmxvY2FsX25hbWUpOworCQkJbmFtaW5nID0gU05EX1BDTV9KQUNLX1VT
RVJfREVGSU5FRF9OQU1FOworCQkJY29udGludWU7CisJCX0KIAkJaWYgKHN0cmNtcChpZCwgIm5j
aGFuIikgPT0gMCkgewogCQkJc25kX2NvbmZpZ19nZXRfaW50ZWdlcihuLCAmbnVtX2NoYW5uZWxz
KTsKIAkJCWNvbnRpbnVlOwpAQCAtNDQ5LDcgKzQ3MCwxMCBAQCBTTkRfUENNX1BMVUdJTl9ERUZJ
TkVfRlVOQyhqYWNrKQogCQlyZXR1cm4gLUVJTlZBTDsKIAl9CiAKLQlpZiAoIChudW1fY2hhbm5l
bHMgIT0gMCkgJiYgKHBsYXliYWNrX2NvbmYgPT0gTlVMTCkgJiYgKGNhcHR1cmVfY29uZiA9PSBO
VUxMKSApIHsKKwlpZiAoIChuYW1pbmcgPT0gU05EX1BDTV9KQUNLX1VTRVJfREVGSU5FRF9OQU1F
KQorCQkJCSYmIChudW1fY2hhbm5lbHMgIT0gMCkKKwkJCQkmJiAocGxheWJhY2tfY29uZiA9PSBO
VUxMKQorCQkJCSYmIChjYXB0dXJlX2NvbmYgPT0gTlVMTCkgKSB7CiAJCWVyciA9IHNuZF9jb25m
aWdfbWFrZV9jb21wb3VuZCgmcGxheWJhY2tfY29uZiwgInBsYXliYWNrX3BvcnRzIiwgMCk7CiAJ
CWlmIChlcnIpIHsKIAkJCVNOREVSUigiRXJyb3IgZHVyaW5nIHNuZF9jb25maWdfbWFrZV9jb21w
b3VuZChwKTogJXNcbiIsIHN0cmVycm9yKGVycikpOwpAQCAtNDg2LDcgKzUxMCw3IEBAIFNORF9Q
Q01fUExVR0lOX0RFRklORV9GVU5DKGphY2spCiAJCQkJcmV0dXJuIGVycjsKIAkJCX0KIAkJfQot
CQllcnIgPSBzbmRfcGNtX2phY2tfb3BlbihwY21wLCBuYW1lLCBwbGF5YmFja19jb25mLCBjYXB0
dXJlX2NvbmYsIHN0cmVhbSwgbW9kZSk7CisJCWVyciA9IHNuZF9wY21famFja19vcGVuKHBjbXAs
IGxvY2FsX25hbWUsIHBsYXliYWNrX2NvbmYsIGNhcHR1cmVfY29uZiwgc3RyZWFtLCBtb2RlLCBu
YW1pbmcpOwogCQlpZiAoZXJyKSB7CiAJCQlTTkRFUlIoIkVycm9yIGR1cmluZyBzbmRfcGNtX2ph
Y2tfb3BlbjogJXNcbiIsIHN0cmVycm9yKGVycikpOwogCQkJcmV0dXJuIGVycjsKQEAgLTUxMyw3
ICs1MzcsNyBAQCBTTkRfUENNX1BMVUdJTl9ERUZJTkVfRlVOQyhqYWNrKQogCQkJcmV0dXJuIGVy
cjsKIAkJfQogCX0gZWxzZSB7Ci0JCWVyciA9IHNuZF9wY21famFja19vcGVuKHBjbXAsIG5hbWUs
IHBsYXliYWNrX2NvbmYsIGNhcHR1cmVfY29uZiwgc3RyZWFtLCBtb2RlKTsKKwkJZXJyID0gc25k
X3BjbV9qYWNrX29wZW4ocGNtcCwgbG9jYWxfbmFtZSwgcGxheWJhY2tfY29uZiwgY2FwdHVyZV9j
b25mLCBzdHJlYW0sIG1vZGUsIG5hbWluZyk7CiAJfQogCiAJcmV0dXJuIGVycjsKLS0gCjEuOC4x
LjQKCg==

--_004_9900E8BE2ADAAB43B2A4471493EDB7F94A88F7IRSMSX104gercorpi_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_004_9900E8BE2ADAAB43B2A4471493EDB7F94A88F7IRSMSX104gercorpi_--
