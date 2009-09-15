From: okias <d.okias@gmail.com>
Subject: ALSA: hda - add speaker and fix headphone switch for
	ALC883
Date: Tue, 15 Sep 2009 15:16:49 +0200
Message-ID: <c2673ca60909150616we5216adw18d73a8d176f09c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174ff0944e483c04739d985c
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 34812103872
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Sep 2009 15:16:50 +0200 (CEST)
Received: by bwz25 with SMTP id 25so175912bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2009 06:16:49 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0015174ff0944e483c04739d985c
Content-Type: text/plain; charset=UTF-8

ALSA: hda - add speaker and fix headphone switch for ALC883

This patch changing "Headphone Playback Switch" from 0x1b to 0x14
(documentation says "Port-D", 3,5 jack) and adding "Speaker Playback
Switch" 0x1b (Port-E, LINE2).

Signed-off-by: David Heidelberger <d.okias@gmail.com>

---

--- a/sound/pci/hda/patch_realtek.c	2009-09-15 14:54:37.067310114 +0200
+++ b/sound/pci/hda/patch_realtek.c	2009-09-15 14:54:43.444437970 +0200
@@ -7979,6 +7979,8 @@
 static struct snd_kcontrol_new alc883_base_mixer[] = {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
+	HDA_CODEC_MUTE("Headphone Playback Switch", 0x14, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Speaker Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Surround Playback Switch", 0x0d, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x0, HDA_OUTPUT),
@@ -7987,7 +7989,6 @@
 	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Side Playback Volume", 0x0f, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Side Playback Switch", 0x0f, 2, HDA_INPUT),
-	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),

--0015174ff0944e483c04739d985c
Content-Type: application/octet-stream;
	name="alc883_speaker-headphone_fix.patch"
Content-Disposition: attachment;
	filename="alc883_speaker-headphone_fix.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fzmo33bm0

QUxTQTogaGRhIC0gYWRkIHNwZWFrZXIgYW5kIGZpeCBoZWFkcGhvbmUgc3dpdGNoIGZvciBBTEM4
ODMgCgpUaGlzIHBhdGNoIGNoYW5naW5nICJIZWFkcGhvbmUgUGxheWJhY2sgU3dpdGNoIiBmcm9t
IDB4MWIgdG8gMHgxNCAoZG9jdW1lbnRhdGlvbiBzYXlzICJQb3J0LUQiLCAzLDUgamFjaykgYW5k
IGFkZGluZyAiU3BlYWtlciBQbGF5YmFjayBTd2l0Y2giIDB4MWIgKFBvcnQtRSwgTElORTIpLgoK
U2lnbmVkLW9mZi1ieTogRGF2aWQgSGVpZGVsYmVyZ2VyIDxkLm9raWFzQGdtYWlsLmNvbT4KCi0t
LQoKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMJMjAwOS0wOS0xNSAxNDo1NDoz
Ny4wNjczMTAxMTQgKzAyMDAKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMJMjAw
OS0wOS0xNSAxNDo1NDo0My40NDQ0Mzc5NzAgKzAyMDAKQEAgLTc5NzksNiArNzk3OSw4IEBACiBz
dGF0aWMgc3RydWN0IHNuZF9rY29udHJvbF9uZXcgYWxjODgzX2Jhc2VfbWl4ZXJbXSA9IHsKIAlI
REFfQ09ERUNfVk9MVU1FKCJGcm9udCBQbGF5YmFjayBWb2x1bWUiLCAweDBjLCAweDAsIEhEQV9P
VVRQVVQpLAogCUhEQV9CSU5EX01VVEUoIkZyb250IFBsYXliYWNrIFN3aXRjaCIsIDB4MGMsIDIs
IEhEQV9JTlBVVCksCisJSERBX0NPREVDX01VVEUoIkhlYWRwaG9uZSBQbGF5YmFjayBTd2l0Y2gi
LCAweDE0LCAweDAsIEhEQV9PVVRQVVQpLAorCUhEQV9DT0RFQ19NVVRFKCJTcGVha2VyIFBsYXli
YWNrIFN3aXRjaCIsIDB4MWIsIDB4MCwgSERBX09VVFBVVCksCiAJSERBX0NPREVDX1ZPTFVNRSgi
U3Vycm91bmQgUGxheWJhY2sgVm9sdW1lIiwgMHgwZCwgMHgwLCBIREFfT1VUUFVUKSwKIAlIREFf
QklORF9NVVRFKCJTdXJyb3VuZCBQbGF5YmFjayBTd2l0Y2giLCAweDBkLCAyLCBIREFfSU5QVVQp
LAogCUhEQV9DT0RFQ19WT0xVTUVfTU9OTygiQ2VudGVyIFBsYXliYWNrIFZvbHVtZSIsIDB4MGUs
IDEsIDB4MCwgSERBX09VVFBVVCksCkBAIC03OTg3LDcgKzc5ODksNiBAQAogCUhEQV9CSU5EX01V
VEVfTU9OTygiTEZFIFBsYXliYWNrIFN3aXRjaCIsIDB4MGUsIDIsIDIsIEhEQV9JTlBVVCksCiAJ
SERBX0NPREVDX1ZPTFVNRSgiU2lkZSBQbGF5YmFjayBWb2x1bWUiLCAweDBmLCAweDAsIEhEQV9P
VVRQVVQpLAogCUhEQV9CSU5EX01VVEUoIlNpZGUgUGxheWJhY2sgU3dpdGNoIiwgMHgwZiwgMiwg
SERBX0lOUFVUKSwKLQlIREFfQ09ERUNfTVVURSgiSGVhZHBob25lIFBsYXliYWNrIFN3aXRjaCIs
IDB4MWIsIDB4MCwgSERBX09VVFBVVCksCiAJSERBX0NPREVDX1ZPTFVNRSgiQ0QgUGxheWJhY2sg
Vm9sdW1lIiwgMHgwYiwgMHgwNCwgSERBX0lOUFVUKSwKIAlIREFfQ09ERUNfTVVURSgiQ0QgUGxh
eWJhY2sgU3dpdGNoIiwgMHgwYiwgMHgwNCwgSERBX0lOUFVUKSwKIAlIREFfQ09ERUNfVk9MVU1F
KCJMaW5lIFBsYXliYWNrIFZvbHVtZSIsIDB4MGIsIDB4MDIsIEhEQV9JTlBVVCksCg==
--0015174ff0944e483c04739d985c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0015174ff0944e483c04739d985c--
