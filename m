From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Set Front Mic to input vref 50% for
	Lenovo 3000 Y410
Date: Sat, 19 Dec 2009 18:27:50 -0500
Message-ID: <604760770912191527m439a1fe7tb9f51c26e8aeab0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502cc2a6390ee047b1d341a
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f179.google.com (mail-pz0-f179.google.com
	[209.85.222.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3260F24533
	for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2009 00:27:51 +0100 (CET)
Received: by pzk9 with SMTP id 9so2776629pzk.16
	for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2009 15:27:50 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--00504502cc2a6390ee047b1d341a
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against master HEAD setting input vref 50%
for the ALC262_LENOVO_3000 model.

Thanks,
Dan

--00504502cc2a6390ee047b1d341a
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Set-Front-Mic-to-input-vref-50-for-Lenovo-3.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Set-Front-Mic-to-input-vref-50-for-Lenovo-3.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g3f0pxto0

RnJvbSA4NzI0YzExNDRkNTRlNWE2NmE2NWQ3ZDIwNzZkNGUyOWM0YzRhNzc0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFNhdCwgMTkgRGVjIDIwMDkgMTg6MTk6MDIgLTA1MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IFNldCBGcm9udCBNaWMgdG8gaW5wdXQgdnJlZiA1MCUgZm9yIExlbm92byAzMDAwIFk0
MTAKCkJ1Z0xpbms6IGh0dHBzOi8vYnVncy5sYXVuY2hwYWQubmV0L2J1Z3MvNDc5MzczCgpUaGUg
T1IgaGFzIHZlcmlmaWVkIHdpdGggaGRhLXZlcmIgdGhhdCB0aGUgaW50ZXJuYWwgbWljcm9waG9u
ZSBuZWVkcwpWUkVGNTAgc2V0IGZvciBhdWRpYmxlIGNhcHR1cmUuCgpTaWduZWQtb2ZmLWJ5OiBE
YW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+Ci0tLQogc291bmQvcGNpL2hkYS9wYXRj
aF9yZWFsdGVrLmMgfCAgIDEwICsrKysrKysrKy0KIDEgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hf
cmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggOGVhNjM1YS4u
ZDcxODUyNyAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIv
c291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTEwNzg3LDYgKzEwNzg3LDEzIEBAIHN0
YXRpYyBzdHJ1Y3QgaGRhX3ZlcmIgYWxjMjYyX2xlbm92b18zMDAwX3Vuc29sX3ZlcmJzW10gPSB7
CiAJe30KIH07CiAKK3N0YXRpYyBzdHJ1Y3QgaGRhX3ZlcmIgYWxjMjYyX2xlbm92b18zMDAwX2lu
aXRfdmVyYnNbXSA9IHsKKwkvKiBGcm9udCBNaWMgcGluOiBpbnB1dCB2cmVmIGF0IDUwJSAqLwor
CXsweDE5LCBBQ19WRVJCX1NFVF9QSU5fV0lER0VUX0NPTlRST0wsIFBJTl9WUkVGNTB9LAorCXsw
eDE5LCBBQ19WRVJCX1NFVF9BTVBfR0FJTl9NVVRFLCBBTVBfT1VUX01VVEV9LAorCXt9Cit9Owor
CiBzdGF0aWMgc3RydWN0IGhkYV9pbnB1dF9tdXggYWxjMjYyX2Z1aml0c3VfY2FwdHVyZV9zb3Vy
Y2UgPSB7CiAJLm51bV9pdGVtcyA9IDMsCiAJLml0ZW1zID0gewpAQCAtMTE4NDEsNyArMTE4NDgs
OCBAQCBzdGF0aWMgc3RydWN0IGFsY19jb25maWdfcHJlc2V0IGFsYzI2Ml9wcmVzZXRzW10gPSB7
CiAJW0FMQzI2Ml9MRU5PVk9fMzAwMF0gPSB7CiAJCS5taXhlcnMgPSB7IGFsYzI2Ml9sZW5vdm9f
MzAwMF9taXhlciB9LAogCQkuaW5pdF92ZXJicyA9IHsgYWxjMjYyX2luaXRfdmVyYnMsIGFsYzI2
Ml9FQVBEX3ZlcmJzLAotCQkJCWFsYzI2Ml9sZW5vdm9fMzAwMF91bnNvbF92ZXJicyB9LAorCQkJ
CWFsYzI2Ml9sZW5vdm9fMzAwMF91bnNvbF92ZXJicywKKwkJCQlhbGMyNjJfbGVub3ZvXzMwMDBf
aW5pdF92ZXJicyB9LAogCQkubnVtX2RhY3MgPSBBUlJBWV9TSVpFKGFsYzI2Ml9kYWNfbmlkcyks
CiAJCS5kYWNfbmlkcyA9IGFsYzI2Ml9kYWNfbmlkcywKIAkJLmhwX25pZCA9IDB4MDMsCi0tIAox
LjYuNQoK
--00504502cc2a6390ee047b1d341a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00504502cc2a6390ee047b1d341a--
