From: "Corfu, ValentinX" <valentinx.corfu@intel.com>
Subject: [alsa-plugins] [PATCH 2/2] Allow to specify a client
 name as parameters
Date: Tue, 21 Jan 2014 16:41:47 +0000
Message-ID: <9900E8BE2ADAAB43B2A4471493EDB7F94A88FF@IRSMSX104.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_9900E8BE2ADAAB43B2A4471493EDB7F94A88FFIRSMSX104gercorpi_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 466DB261A6D
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 17:41:59 +0100 (CET)
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

--_004_9900E8BE2ADAAB43B2A4471493EDB7F94A88FFIRSMSX104gercorpi_
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

0001-Modify-jack-client-name.patch is spitted in: 0001-Allow-number-of-chan=
nels.patch and 0002-Allow-to-specify-a-client-name-as-parameters-in-the-.pa=
tch


>From 8d6d397306bdd09c6c3fae83543e124c89443e94 Mon Sep 17 00:00:00 2001
From: Valentin Corfu <valentinx.corfu@intel.com>
Date: Tue, 21 Jan 2014 11:32:51 -0500
Subject: [PATCH 2/2] Allow to specify a client name as parameters

The current jack client name contains the process id of the application pro=
viding the audio samples.
This leads to unpredictable jack client names which makes handling of the c=
onnections by a controlling application very hard.
This modification now, allows to specify a client name as parameters in the=
 configuration file.
The implementation is backward compatible and simply adds a new configurati=
on option to the plugin.

Signed-off-by: Valentin Corfu <valentinx.corfu@intel.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 4306a13..61ac197 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -32,6 +32,11 @@ typedef enum _jack_format {
     SND_PCM_JACK_FORMAT_RAW
 } snd_pcm_jack_format_t;

+typedef enum _naming_scheme {
+    SND_PCM_JACK_STD_NAME,
+    SND_PCM_JACK_USER_DEFINED_NAME
+} snd_pcm_jack_naming_t;
+
 typedef struct {
     snd_pcm_ioplug_t io;

@@ -325,7 +330,8 @@ static int make_nonblock(int fd)
 static int snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
                  snd_config_t *playback_conf,
                  snd_config_t *capture_conf,
-                 snd_pcm_stream_t stream, int mode)
+                 snd_pcm_stream_t stream, int mode,
+                 snd_pcm_jack_naming_t naming)
 {
     snd_pcm_jack_t *jack;
     int err;
@@ -356,11 +362,19 @@ static int snd_pcm_jack_open(snd_pcm_t **pcmp, const =
char *name,
         return -EINVAL;
     }

-    if (snprintf(jack_client_name, sizeof(jack_client_name), "alsa-jack.%s=
%s.%d.%d", name,
-             stream =3D=3D SND_PCM_STREAM_PLAYBACK ? "P" : "C", getpid(), =
num++)
-        >=3D (int)sizeof(jack_client_name)) {
-        fprintf(stderr, "%s: WARNING: JACK client name '%s' truncated to %=
d characters, might not be unique\n",
-            __func__, jack_client_name, (int)strlen(jack_client_name));
+    if (naming =3D=3D SND_PCM_JACK_STD_NAME ) {
+        if (snprintf(jack_client_name, sizeof(jack_client_name), "alsa-jac=
k.%s%s.%d.%d", name,
+                stream =3D=3D SND_PCM_STREAM_PLAYBACK ? "P" : "C", getpid(=
), num++)
+            >=3D (int)sizeof(jack_client_name)) {
+                fprintf(stderr, "%s: WARNING: JACK client name '%s' trunca=
ted to %d characters, might not be unique\n",
+                __func__, jack_client_name, (int)strlen(jack_client_name));
+        }
+    } else {
+        if (snprintf(jack_client_name, sizeof(jack_client_name), "%s", nam=
e)
+            >=3D (int)sizeof(jack_client_name)) {
+                fprintf(stderr, "%s: WARNING: JACK client name '%s' trunca=
ted to %d characters, might not be unique\n",
+                __func__, jack_client_name, (int)strlen(jack_client_name));
+        }
     }

     jack->client =3D jack_client_new(jack_client_name);
@@ -417,6 +431,8 @@ SND_PCM_PLUGIN_DEFINE_FUNC(jack)
     int err;
     long num_channels =3D 0;
     long chan;
+    const char *local_name =3D name;
+    snd_pcm_jack_naming_t naming =3D SND_PCM_JACK_STD_NAME;

     snd_config_for_each(i, next, conf) {
         snd_config_t *n =3D snd_config_iterator_entry(i);
@@ -425,6 +441,11 @@ SND_PCM_PLUGIN_DEFINE_FUNC(jack)
             continue;
         if (strcmp(id, "comment") =3D=3D 0 || strcmp(id, "type") =3D=3D 0 =
|| strcmp(id, "hint") =3D=3D 0)
             continue;
+        if (strcmp(id, "name") =3D=3D 0) {
+            snd_config_get_string(n, &local_name);
+            naming =3D SND_PCM_JACK_USER_DEFINED_NAME;
+            continue;
+        }
         if (strcmp(id, "nchan") =3D=3D 0) {
             snd_config_get_integer(n, &num_channels);
             continue;
@@ -449,7 +470,10 @@ SND_PCM_PLUGIN_DEFINE_FUNC(jack)
         return -EINVAL;
     }

-    if ( (num_channels !=3D 0) && (playback_conf =3D=3D NULL) && (capture_=
conf =3D=3D NULL) ) {
+    if ( (naming =3D=3D SND_PCM_JACK_USER_DEFINED_NAME)
+                && (num_channels !=3D 0)
+                && (playback_conf =3D=3D NULL)
+                && (capture_conf =3D=3D NULL) ) {
         err =3D snd_config_make_compound(&playback_conf, "playback_ports",=
 0);
         if (err) {
             SNDERR("Error during snd_config_make_compound(p): %s\n", strer=
ror(err));
@@ -486,7 +510,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(jack)
                 return err;
             }
         }
-        err =3D snd_pcm_jack_open(pcmp, name, playback_conf, capture_conf,=
 stream, mode);
+        err =3D snd_pcm_jack_open(pcmp, local_name, playback_conf, capture=
_conf, stream, mode, naming);
         if (err) {
             SNDERR("Error during snd_pcm_jack_open: %s\n", strerror(err));
             return err;
@@ -513,7 +537,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(jack)
             return err;
         }
     } else {
-        err =3D snd_pcm_jack_open(pcmp, name, playback_conf, capture_conf,=
 stream, mode);
+        err =3D snd_pcm_jack_open(pcmp, local_name, playback_conf, capture=
_conf, stream, mode, naming);
     }

     return err;
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


--_004_9900E8BE2ADAAB43B2A4471493EDB7F94A88FFIRSMSX104gercorpi_
Content-Type: text/x-patch; name="0001-Allow-number-of-channels.patch"
Content-Description: 0001-Allow-number-of-channels.patch
Content-Disposition: attachment;
	filename="0001-Allow-number-of-channels.patch"; size=3692;
	creation-date="Tue, 21 Jan 2014 16:40:17 GMT";
	modification-date="Tue, 21 Jan 2014 16:40:17 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkMjQ3ZTRkNjc1ZGQ2OGM2ZjY4M2E4YzA5ZmY3OTIxNzIzOTZlODcwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWYWxlbnRpbiBDb3JmdSA8dmFsZW50aW54LmNvcmZ1QGludGVs
LmNvbT4KRGF0ZTogVHVlLCAyMSBKYW4gMjAxNCAxMDoxMDo1MiAtMDUwMApTdWJqZWN0OiBbUEFU
Q0ggMS8yXSBBbGxvdyBudW1iZXIgb2YgY2hhbm5lbHMKClRoZSBtb2RpZmljYXRpb24gYWxsb3dz
IHRvIHNwZWNpZnkgdGhlIG51bWJlciBvZiBjaGFubmVscyBhcyBwYXJhbWV0ZXJzIGluIHRoZSBj
b25maWd1cmF0aW9uIGZpbGUKVGhlIGdpdmVuIG51bWJlciBvZiBjaGFubmVscyBhcmUgdGhlbiBj
cmVhdGVkIGJ1dCBub3QgY29ubmVjdGVkLgoKU2lnbmVkLW9mZi1ieTogVmFsZW50aW4gQ29yZnUg
PHZhbGVudGlueC5jb3JmdUBpbnRlbC5jb20+CgpkaWZmIC0tZ2l0IGEvamFjay9wY21famFjay5j
IGIvamFjay9wY21famFjay5jCmluZGV4IGM1MWZlODQuLjQzMDZhMTMgMTAwNjQ0Ci0tLSBhL2ph
Y2svcGNtX2phY2suYworKysgYi9qYWNrL3BjbV9qYWNrLmMKQEAgLTQxNSw2ICs0MTUsOCBAQCBT
TkRfUENNX1BMVUdJTl9ERUZJTkVfRlVOQyhqYWNrKQogCXNuZF9jb25maWdfdCAqcGxheWJhY2tf
Y29uZiA9IE5VTEw7CiAJc25kX2NvbmZpZ190ICpjYXB0dXJlX2NvbmYgPSBOVUxMOwogCWludCBl
cnI7CisJbG9uZyBudW1fY2hhbm5lbHMgPSAwOworCWxvbmcgY2hhbjsKIAkKIAlzbmRfY29uZmln
X2Zvcl9lYWNoKGksIG5leHQsIGNvbmYpIHsKIAkJc25kX2NvbmZpZ190ICpuID0gc25kX2NvbmZp
Z19pdGVyYXRvcl9lbnRyeShpKTsKQEAgLTQyMyw2ICs0MjUsMTAgQEAgU05EX1BDTV9QTFVHSU5f
REVGSU5FX0ZVTkMoamFjaykKIAkJCWNvbnRpbnVlOwogCQlpZiAoc3RyY21wKGlkLCAiY29tbWVu
dCIpID09IDAgfHwgc3RyY21wKGlkLCAidHlwZSIpID09IDAgfHwgc3RyY21wKGlkLCAiaGludCIp
ID09IDApCiAJCQljb250aW51ZTsKKwkJaWYgKHN0cmNtcChpZCwgIm5jaGFuIikgPT0gMCkgewor
CQkJc25kX2NvbmZpZ19nZXRfaW50ZWdlcihuLCAmbnVtX2NoYW5uZWxzKTsKKwkJCWNvbnRpbnVl
OworCQl9CiAJCWlmIChzdHJjbXAoaWQsICJwbGF5YmFja19wb3J0cyIpID09IDApIHsKIAkJCWlm
IChzbmRfY29uZmlnX2dldF90eXBlKG4pICE9IFNORF9DT05GSUdfVFlQRV9DT01QT1VORCkgewog
CQkJCVNOREVSUigiSW52YWxpZCB0eXBlIGZvciAlcyIsIGlkKTsKQEAgLTQ0Myw3ICs0NDksNzIg
QEAgU05EX1BDTV9QTFVHSU5fREVGSU5FX0ZVTkMoamFjaykKIAkJcmV0dXJuIC1FSU5WQUw7CiAJ
fQogCi0JZXJyID0gc25kX3BjbV9qYWNrX29wZW4ocGNtcCwgbmFtZSwgcGxheWJhY2tfY29uZiwg
Y2FwdHVyZV9jb25mLCBzdHJlYW0sIG1vZGUpOworCWlmICggKG51bV9jaGFubmVscyAhPSAwKSAm
JiAocGxheWJhY2tfY29uZiA9PSBOVUxMKSAmJiAoY2FwdHVyZV9jb25mID09IE5VTEwpICkgewor
CQllcnIgPSBzbmRfY29uZmlnX21ha2VfY29tcG91bmQoJnBsYXliYWNrX2NvbmYsICJwbGF5YmFj
a19wb3J0cyIsIDApOworCQlpZiAoZXJyKSB7CisJCQlTTkRFUlIoIkVycm9yIGR1cmluZyBzbmRf
Y29uZmlnX21ha2VfY29tcG91bmQocCk6ICVzXG4iLCBzdHJlcnJvcihlcnIpKTsKKwkJCXJldHVy
biBlcnI7CisJCX0KKwkJZXJyID0gc25kX2NvbmZpZ19tYWtlX2NvbXBvdW5kKCZjYXB0dXJlX2Nv
bmYsICJjYXB0dXJlX3BvcnRzIiwgMCk7CisJCWlmIChlcnIpIHsKKwkJCVNOREVSUigiRXJyb3Ig
ZHVyaW5nIHNuZF9jb25maWdfbWFrZV9jb21wb3VuZChjKTogJXNcbiIsIHN0cmVycm9yKGVycikp
OworCQkJcmV0dXJuIGVycjsKKwkJfQorCQljaGFyIHZhbHVlWzRdOworCQlmb3IgKGNoYW49MDsg
Y2hhbjxudW1fY2hhbm5lbHM7ICsrY2hhbikgeworCQkJc25wcmludGYodmFsdWUsIHNpemVvZih2
YWx1ZSksICIlZCIsIGNoYW4pOworCQkJc25kX2NvbmZpZ190ICpuZXdMZWFmUGxheWJhY2s7CisJ
CQlzbmRfY29uZmlnX3QgKm5ld0xlYWZDYXB0dXJlOworCQllcnIgPSBzbmRfY29uZmlnX2ltYWtl
X2ludGVnZXIoJm5ld0xlYWZQbGF5YmFjaywgdmFsdWUsIGNoYW4pOworCQkJaWYgKGVycikgewor
CQkJCVNOREVSUigiRXJyb3IgZHVyaW5nIHNuZF9jb25maWdfaW1ha2Vfc3RyaW5nKHApOiAlc1xu
Iiwgc3RyZXJyb3IoZXJyKSk7CisJCQkJcmV0dXJuIGVycjsKKwkJCX0KKwkJZXJyID0gc25kX2Nv
bmZpZ19hZGQocGxheWJhY2tfY29uZiwgbmV3TGVhZlBsYXliYWNrKTsKKwkJCWlmIChlcnIpIHsK
KwkJCQlTTkRFUlIoIkVycm9yIGR1cmluZyBzbmRfY29uZmlnX2FkZChwKTogJXNcbiIsIHN0cmVy
cm9yKGVycikpOworCQkJCXJldHVybiBlcnI7CisJCQl9CisJCWVyciA9IHNuZF9jb25maWdfaW1h
a2VfaW50ZWdlcigmbmV3TGVhZkNhcHR1cmUsIHZhbHVlLCBjaGFuKTsKKwkJCWlmIChlcnIpIHsK
KwkJCQlTTkRFUlIoIkVycm9yIGR1cmluZyBzbmRfY29uZmlnX2ltYWtlX3N0cmluZyhjKTogJXNc
biIsIHN0cmVycm9yKGVycikpOworCQkJCXJldHVybiBlcnI7CisJCQl9CisJCWVyciA9IHNuZF9j
b25maWdfYWRkKGNhcHR1cmVfY29uZiwgbmV3TGVhZkNhcHR1cmUpOworCQkJaWYgKGVycikgewor
CQkJCVNOREVSUigiRXJyb3IgZHVyaW5nIHNuZF9jb25maWdfYWRkKGMpOiAlc1xuIiwgc3RyZXJy
b3IoZXJyKSk7CisJCQkJcmV0dXJuIGVycjsKKwkJCX0KKwkJfQorCQllcnIgPSBzbmRfcGNtX2ph
Y2tfb3BlbihwY21wLCBuYW1lLCBwbGF5YmFja19jb25mLCBjYXB0dXJlX2NvbmYsIHN0cmVhbSwg
bW9kZSk7CisJCWlmIChlcnIpIHsKKwkJCVNOREVSUigiRXJyb3IgZHVyaW5nIHNuZF9wY21famFj
a19vcGVuOiAlc1xuIiwgc3RyZXJyb3IoZXJyKSk7CisJCQlyZXR1cm4gZXJyOworCQl9CisKKwkJ
ZXJyID0gc25kX2NvbmZpZ19kZWxldGVfY29tcG91bmRfbWVtYmVycyhwbGF5YmFja19jb25mKTsK
KwkJaWYgKGVycikgeworCQkJU05ERVJSKCJFcnJvciBkdXJpbmcgc25kX2NvbmZpZ19kZWxldGVf
Y29tcG91bmRfbWVtYmVycyhwKTogJXNcbiIsIHN0cmVycm9yKGVycikpOworCQkJcmV0dXJuIGVy
cjsKKwkJfQorCQllcnIgPSBzbmRfY29uZmlnX2RlbGV0ZV9jb21wb3VuZF9tZW1iZXJzKGNhcHR1
cmVfY29uZik7CisJCWlmIChlcnIpIHsKKwkJCVNOREVSUigiRXJyb3IgZHVyaW5nIHNuZF9jb25m
aWdfZGVsZXRlX2NvbXBvdW5kX21lbWJlcnMoYyk6ICVzXG4iLCBzdHJlcnJvcihlcnIpKTsKKwkJ
CXJldHVybiBlcnI7CisJCX0KKwkJZXJyID0gc25kX2NvbmZpZ19kZWxldGUocGxheWJhY2tfY29u
Zik7CisJCWlmIChlcnIpIHsKKwkJCVNOREVSUigiRXJyb3IgZHVyaW5nIHNuZF9jb25maWdfZGVs
ZXRlKHApOiAlc1xuIiwgc3RyZXJyb3IoZXJyKSk7CisJCQlyZXR1cm4gZXJyOworCQl9CisJCWVy
ciA9IHNuZF9jb25maWdfZGVsZXRlKGNhcHR1cmVfY29uZik7CisJCWlmIChlcnIpIHsKKwkJCVNO
REVSUigiRXJyb3IgZHVyaW5nIHNuZF9jb25maWdfZGVsZXRlKGMpOiAlc1xuIiwgc3RyZXJyb3Io
ZXJyKSk7CisJCQlyZXR1cm4gZXJyOworCQl9CisJfSBlbHNlIHsKKwkJZXJyID0gc25kX3BjbV9q
YWNrX29wZW4ocGNtcCwgbmFtZSwgcGxheWJhY2tfY29uZiwgY2FwdHVyZV9jb25mLCBzdHJlYW0s
IG1vZGUpOworCX0KIAogCXJldHVybiBlcnI7CiB9Ci0tIAoxLjguMS40Cgo=

--_004_9900E8BE2ADAAB43B2A4471493EDB7F94A88FFIRSMSX104gercorpi_
Content-Type: text/x-patch; name="0001-Modify-jack-client-name.patch"
Content-Description: 0001-Modify-jack-client-name.patch
Content-Disposition: attachment;
	filename="0001-Modify-jack-client-name.patch"; size=5812;
	creation-date="Tue, 21 Jan 2014 16:40:17 GMT";
	modification-date="Tue, 21 Jan 2014 16:40:17 GMT"
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

--_004_9900E8BE2ADAAB43B2A4471493EDB7F94A88FFIRSMSX104gercorpi_
Content-Type: text/x-patch;
	name="0002-Allow-to-specify-a-client-name-as-parameters.patch"
Content-Description: 0002-Allow-to-specify-a-client-name-as-parameters.patch
Content-Disposition: attachment;
	filename="0002-Allow-to-specify-a-client-name-as-parameters.patch";
	size=4539; creation-date="Tue, 21 Jan 2014 16:40:17 GMT";
	modification-date="Tue, 21 Jan 2014 16:40:17 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4ZDZkMzk3MzA2YmRkMDljNmMzZmFlODM1NDNlMTI0Yzg5NDQzZTk0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWYWxlbnRpbiBDb3JmdSA8dmFsZW50aW54LmNvcmZ1QGludGVs
LmNvbT4KRGF0ZTogVHVlLCAyMSBKYW4gMjAxNCAxMTozMjo1MSAtMDUwMApTdWJqZWN0OiBbUEFU
Q0ggMi8yXSBBbGxvdyB0byBzcGVjaWZ5IGEgY2xpZW50IG5hbWUgYXMgcGFyYW1ldGVycwoKVGhl
IGN1cnJlbnQgamFjayBjbGllbnQgbmFtZSBjb250YWlucyB0aGUgcHJvY2VzcyBpZCBvZiB0aGUg
YXBwbGljYXRpb24gcHJvdmlkaW5nIHRoZSBhdWRpbyBzYW1wbGVzLgpUaGlzIGxlYWRzIHRvIHVu
cHJlZGljdGFibGUgamFjayBjbGllbnQgbmFtZXMgd2hpY2ggbWFrZXMgaGFuZGxpbmcgb2YgdGhl
IGNvbm5lY3Rpb25zIGJ5IGEgY29udHJvbGxpbmcgYXBwbGljYXRpb24gdmVyeSBoYXJkLgpUaGlz
IG1vZGlmaWNhdGlvbiBub3csIGFsbG93cyB0byBzcGVjaWZ5IGEgY2xpZW50IG5hbWUgYXMgcGFy
YW1ldGVycyBpbiB0aGUgY29uZmlndXJhdGlvbiBmaWxlLgpUaGUgaW1wbGVtZW50YXRpb24gaXMg
YmFja3dhcmQgY29tcGF0aWJsZSBhbmQgc2ltcGx5IGFkZHMgYSBuZXcgY29uZmlndXJhdGlvbiBv
cHRpb24gdG8gdGhlIHBsdWdpbi4KClNpZ25lZC1vZmYtYnk6IFZhbGVudGluIENvcmZ1IDx2YWxl
bnRpbnguY29yZnVAaW50ZWwuY29tPgoKZGlmZiAtLWdpdCBhL2phY2svcGNtX2phY2suYyBiL2ph
Y2svcGNtX2phY2suYwppbmRleCA0MzA2YTEzLi42MWFjMTk3IDEwMDY0NAotLS0gYS9qYWNrL3Bj
bV9qYWNrLmMKKysrIGIvamFjay9wY21famFjay5jCkBAIC0zMiw2ICszMiwxMSBAQCB0eXBlZGVm
IGVudW0gX2phY2tfZm9ybWF0IHsKIAlTTkRfUENNX0pBQ0tfRk9STUFUX1JBVwogfSBzbmRfcGNt
X2phY2tfZm9ybWF0X3Q7CiAKK3R5cGVkZWYgZW51bSBfbmFtaW5nX3NjaGVtZSB7CisJU05EX1BD
TV9KQUNLX1NURF9OQU1FLAorCVNORF9QQ01fSkFDS19VU0VSX0RFRklORURfTkFNRQorfSBzbmRf
cGNtX2phY2tfbmFtaW5nX3Q7CisKIHR5cGVkZWYgc3RydWN0IHsKIAlzbmRfcGNtX2lvcGx1Z190
IGlvOwogCkBAIC0zMjUsNyArMzMwLDggQEAgc3RhdGljIGludCBtYWtlX25vbmJsb2NrKGludCBm
ZCkKIHN0YXRpYyBpbnQgc25kX3BjbV9qYWNrX29wZW4oc25kX3BjbV90ICoqcGNtcCwgY29uc3Qg
Y2hhciAqbmFtZSwKIAkJCSAgICAgc25kX2NvbmZpZ190ICpwbGF5YmFja19jb25mLAogCQkJICAg
ICBzbmRfY29uZmlnX3QgKmNhcHR1cmVfY29uZiwKLQkJCSAgICAgc25kX3BjbV9zdHJlYW1fdCBz
dHJlYW0sIGludCBtb2RlKQorCQkJICAgICBzbmRfcGNtX3N0cmVhbV90IHN0cmVhbSwgaW50IG1v
ZGUsCisJCQkgICAgIHNuZF9wY21famFja19uYW1pbmdfdCBuYW1pbmcpCiB7CiAJc25kX3BjbV9q
YWNrX3QgKmphY2s7CiAJaW50IGVycjsKQEAgLTM1NiwxMSArMzYyLDE5IEBAIHN0YXRpYyBpbnQg
c25kX3BjbV9qYWNrX29wZW4oc25kX3BjbV90ICoqcGNtcCwgY29uc3QgY2hhciAqbmFtZSwKIAkJ
cmV0dXJuIC1FSU5WQUw7CiAJfQogCi0JaWYgKHNucHJpbnRmKGphY2tfY2xpZW50X25hbWUsIHNp
emVvZihqYWNrX2NsaWVudF9uYW1lKSwgImFsc2EtamFjay4lcyVzLiVkLiVkIiwgbmFtZSwKLQkJ
ICAgICBzdHJlYW0gPT0gU05EX1BDTV9TVFJFQU1fUExBWUJBQ0sgPyAiUCIgOiAiQyIsIGdldHBp
ZCgpLCBudW0rKykKLQkgICAgPj0gKGludClzaXplb2YoamFja19jbGllbnRfbmFtZSkpIHsKLQkJ
ZnByaW50ZihzdGRlcnIsICIlczogV0FSTklORzogSkFDSyBjbGllbnQgbmFtZSAnJXMnIHRydW5j
YXRlZCB0byAlZCBjaGFyYWN0ZXJzLCBtaWdodCBub3QgYmUgdW5pcXVlXG4iLAotCQkJX19mdW5j
X18sIGphY2tfY2xpZW50X25hbWUsIChpbnQpc3RybGVuKGphY2tfY2xpZW50X25hbWUpKTsKKwlp
ZiAobmFtaW5nID09IFNORF9QQ01fSkFDS19TVERfTkFNRSApIHsKKwkJaWYgKHNucHJpbnRmKGph
Y2tfY2xpZW50X25hbWUsIHNpemVvZihqYWNrX2NsaWVudF9uYW1lKSwgImFsc2EtamFjay4lcyVz
LiVkLiVkIiwgbmFtZSwKKwkJCQlzdHJlYW0gPT0gU05EX1BDTV9TVFJFQU1fUExBWUJBQ0sgPyAi
UCIgOiAiQyIsIGdldHBpZCgpLCBudW0rKykKKwkJCT49IChpbnQpc2l6ZW9mKGphY2tfY2xpZW50
X25hbWUpKSB7CisJCQkgICAgZnByaW50ZihzdGRlcnIsICIlczogV0FSTklORzogSkFDSyBjbGll
bnQgbmFtZSAnJXMnIHRydW5jYXRlZCB0byAlZCBjaGFyYWN0ZXJzLCBtaWdodCBub3QgYmUgdW5p
cXVlXG4iLAorCQkJCV9fZnVuY19fLCBqYWNrX2NsaWVudF9uYW1lLCAoaW50KXN0cmxlbihqYWNr
X2NsaWVudF9uYW1lKSk7CisJCX0KKwl9IGVsc2UgeworCQlpZiAoc25wcmludGYoamFja19jbGll
bnRfbmFtZSwgc2l6ZW9mKGphY2tfY2xpZW50X25hbWUpLCAiJXMiLCBuYW1lKQorCQkJPj0gKGlu
dClzaXplb2YoamFja19jbGllbnRfbmFtZSkpIHsKKwkJCSAgICBmcHJpbnRmKHN0ZGVyciwgIiVz
OiBXQVJOSU5HOiBKQUNLIGNsaWVudCBuYW1lICclcycgdHJ1bmNhdGVkIHRvICVkIGNoYXJhY3Rl
cnMsIG1pZ2h0IG5vdCBiZSB1bmlxdWVcbiIsCisJCQkJX19mdW5jX18sIGphY2tfY2xpZW50X25h
bWUsIChpbnQpc3RybGVuKGphY2tfY2xpZW50X25hbWUpKTsKKwkJfQogCX0KIAogCWphY2stPmNs
aWVudCA9IGphY2tfY2xpZW50X25ldyhqYWNrX2NsaWVudF9uYW1lKTsKQEAgLTQxNyw2ICs0MzEs
OCBAQCBTTkRfUENNX1BMVUdJTl9ERUZJTkVfRlVOQyhqYWNrKQogCWludCBlcnI7CiAJbG9uZyBu
dW1fY2hhbm5lbHMgPSAwOwogCWxvbmcgY2hhbjsKKwljb25zdCBjaGFyICpsb2NhbF9uYW1lID0g
bmFtZTsKKwlzbmRfcGNtX2phY2tfbmFtaW5nX3QgbmFtaW5nID0gU05EX1BDTV9KQUNLX1NURF9O
QU1FOwogCQogCXNuZF9jb25maWdfZm9yX2VhY2goaSwgbmV4dCwgY29uZikgewogCQlzbmRfY29u
ZmlnX3QgKm4gPSBzbmRfY29uZmlnX2l0ZXJhdG9yX2VudHJ5KGkpOwpAQCAtNDI1LDYgKzQ0MSwx
MSBAQCBTTkRfUENNX1BMVUdJTl9ERUZJTkVfRlVOQyhqYWNrKQogCQkJY29udGludWU7CiAJCWlm
IChzdHJjbXAoaWQsICJjb21tZW50IikgPT0gMCB8fCBzdHJjbXAoaWQsICJ0eXBlIikgPT0gMCB8
fCBzdHJjbXAoaWQsICJoaW50IikgPT0gMCkKIAkJCWNvbnRpbnVlOworCQlpZiAoc3RyY21wKGlk
LCAibmFtZSIpID09IDApIHsKKwkJCXNuZF9jb25maWdfZ2V0X3N0cmluZyhuLCAmbG9jYWxfbmFt
ZSk7CisJCQluYW1pbmcgPSBTTkRfUENNX0pBQ0tfVVNFUl9ERUZJTkVEX05BTUU7CisJCQljb250
aW51ZTsKKwkJfQogCQlpZiAoc3RyY21wKGlkLCAibmNoYW4iKSA9PSAwKSB7CiAJCQlzbmRfY29u
ZmlnX2dldF9pbnRlZ2VyKG4sICZudW1fY2hhbm5lbHMpOwogCQkJY29udGludWU7CkBAIC00NDks
NyArNDcwLDEwIEBAIFNORF9QQ01fUExVR0lOX0RFRklORV9GVU5DKGphY2spCiAJCXJldHVybiAt
RUlOVkFMOwogCX0KIAotCWlmICggKG51bV9jaGFubmVscyAhPSAwKSAmJiAocGxheWJhY2tfY29u
ZiA9PSBOVUxMKSAmJiAoY2FwdHVyZV9jb25mID09IE5VTEwpICkgeworCWlmICggKG5hbWluZyA9
PSBTTkRfUENNX0pBQ0tfVVNFUl9ERUZJTkVEX05BTUUpCisJCQkJJiYgKG51bV9jaGFubmVscyAh
PSAwKQorCQkJCSYmIChwbGF5YmFja19jb25mID09IE5VTEwpCisJCQkJJiYgKGNhcHR1cmVfY29u
ZiA9PSBOVUxMKSApIHsKIAkJZXJyID0gc25kX2NvbmZpZ19tYWtlX2NvbXBvdW5kKCZwbGF5YmFj
a19jb25mLCAicGxheWJhY2tfcG9ydHMiLCAwKTsKIAkJaWYgKGVycikgewogCQkJU05ERVJSKCJF
cnJvciBkdXJpbmcgc25kX2NvbmZpZ19tYWtlX2NvbXBvdW5kKHApOiAlc1xuIiwgc3RyZXJyb3Io
ZXJyKSk7CkBAIC00ODYsNyArNTEwLDcgQEAgU05EX1BDTV9QTFVHSU5fREVGSU5FX0ZVTkMoamFj
aykKIAkJCQlyZXR1cm4gZXJyOwogCQkJfQogCQl9Ci0JCWVyciA9IHNuZF9wY21famFja19vcGVu
KHBjbXAsIG5hbWUsIHBsYXliYWNrX2NvbmYsIGNhcHR1cmVfY29uZiwgc3RyZWFtLCBtb2RlKTsK
KwkJZXJyID0gc25kX3BjbV9qYWNrX29wZW4ocGNtcCwgbG9jYWxfbmFtZSwgcGxheWJhY2tfY29u
ZiwgY2FwdHVyZV9jb25mLCBzdHJlYW0sIG1vZGUsIG5hbWluZyk7CiAJCWlmIChlcnIpIHsKIAkJ
CVNOREVSUigiRXJyb3IgZHVyaW5nIHNuZF9wY21famFja19vcGVuOiAlc1xuIiwgc3RyZXJyb3Io
ZXJyKSk7CiAJCQlyZXR1cm4gZXJyOwpAQCAtNTEzLDcgKzUzNyw3IEBAIFNORF9QQ01fUExVR0lO
X0RFRklORV9GVU5DKGphY2spCiAJCQlyZXR1cm4gZXJyOwogCQl9CiAJfSBlbHNlIHsKLQkJZXJy
ID0gc25kX3BjbV9qYWNrX29wZW4ocGNtcCwgbmFtZSwgcGxheWJhY2tfY29uZiwgY2FwdHVyZV9j
b25mLCBzdHJlYW0sIG1vZGUpOworCQllcnIgPSBzbmRfcGNtX2phY2tfb3BlbihwY21wLCBsb2Nh
bF9uYW1lLCBwbGF5YmFja19jb25mLCBjYXB0dXJlX2NvbmYsIHN0cmVhbSwgbW9kZSwgbmFtaW5n
KTsKIAl9CiAKIAlyZXR1cm4gZXJyOwotLSAKMS44LjEuNAoK

--_004_9900E8BE2ADAAB43B2A4471493EDB7F94A88FFIRSMSX104gercorpi_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_004_9900E8BE2ADAAB43B2A4471493EDB7F94A88FFIRSMSX104gercorpi_--
