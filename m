From: Florian Schmidt <mista.tapas@gmx.net>
Subject: aoss [patch: /dev/sound, man page]
Date: Thu, 5 Aug 2004 01:44:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040805014457.49395908@mango.fruits.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__5_Aug_2004_01_44_57_+0200_fy+kYAc.NrU/2wNo"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 00B9B260
	for <alsa-devel@alsa-project.org>; Thu,  5 Aug 2004 01:35:33 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart=_Thu__5_Aug_2004_01_44_57_+0200_fy+kYAc.NrU/2wNo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


The below patch [also attached] fixes the check for device files in
/dev/sound/ [for users of devfs who have configured their apps to use
/dev/sound/dsp, etc..] and  adds a note to the aoss manpage
about the state of mmap support:

----- snip ------
diff -Nru alsa-oss/alsa/aoss.1 alsa-oss.new/alsa/aoss.1
--- alsa-oss/alsa/aoss.1	2004-07-27 18:04:55.000000000 +0200
+++ alsa-oss.new/alsa/aoss.1	2004-08-05 01:09:48.000000000 +0200
@@ -30,6 +30,8 @@
 
 In the above configuration examples, the pcm.dsp0 definition is used to
wrap calls do /dev/dsp0. You can also wrap usage of /dev/dsp1,
/dev/dsp2, etc. by defining pcm.dsp1, pcm.dsp2, etc..
 
+Note on mmap: aoss does currently not support full mmap support. Your
results may vary when trying to use an application that uses mmap'ing to
access the OSS device files.
+
 
 .SS Arguments
 .TP
diff -Nru alsa-oss/alsa/mixer.c alsa-oss.new/alsa/mixer.c
--- alsa-oss/alsa/mixer.c	2004-02-26 11:52:40.000000000 +0100
+++ alsa-oss.new/alsa/mixer.c	2004-08-05 01:16:52.000000000 +0200
@@ -548,6 +548,10 @@
 			minor = (atoi(file + 10) << 4) | OSS_DEVICE_MIXER;
 		else if (!strncmp(file, "/dev/amixer", 11))
 			minor = (atoi(file + 11) << 4) | OSS_DEVICE_AMIXER;
+		else if (!strncmp(file, "/dev/sound/mixer", 16))
+			minor = (atoi(file + 16) << 4) | OSS_DEVICE_MIXER;
+		else if (!strncmp(file, "/dev/sound/amixer", 17))
+			minor = (atoi(file + 17) << 4) | OSS_DEVICE_AMIXER;
 		else {
 			errno = ENOENT;
 			return -1;
diff -Nru alsa-oss/alsa/pcm.c alsa-oss.new/alsa/pcm.c
--- alsa-oss/alsa/pcm.c	2004-05-04 15:02:03.000000000 +0200
+++ alsa-oss.new/alsa/pcm.c	2004-08-05 01:34:13.000000000 +0200
@@ -1651,6 +1651,14 @@
 			minor = (atoi(file + 9) << 4) | OSS_DEVICE_ADSP;
 		else if (!strncmp(file, "/dev/audio", 10))
 			minor = (atoi(file + 10) << 4) | OSS_DEVICE_AUDIO;
+		else if (!strncmp(file, "/dev/sound/dsp", 14))
+			minor = (atoi(file + 14) << 4) | OSS_DEVICE_DSP;
+		else if (!strncmp(file, "/dev/sound/dspW", 15))
+			minor = (atoi(file + 15) << 4) | OSS_DEVICE_DSPW;
+		else if (!strncmp(file, "/dev/sound/adsp", 15))
+			minor = (atoi(file + 15) << 4) | OSS_DEVICE_ADSP;
+		else if (!strncmp(file, "/dev/sound/audio", 16))
+			minor = (atoi(file + 16) << 4) | OSS_DEVICE_AUDIO;
 		else {
 			errno = ENOENT;
 			return -1;


-- 
Palimm Palimm!
http://affenbande.org/~tapas/


--Multipart=_Thu__5_Aug_2004_01_44_57_+0200_fy+kYAc.NrU/2wNo
Content-Type: application/octet-stream;
 name="dev_sound_man.patch"
Content-Disposition: attachment;
 filename="dev_sound_man.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtTnJ1IGFsc2Etb3NzL2Fsc2EvYW9zcy4xIGFsc2Etb3NzLm5ldy9hbHNhL2Fvc3MuMQot
LS0gYWxzYS1vc3MvYWxzYS9hb3NzLjEJMjAwNC0wNy0yNyAxODowNDo1NS4wMDAwMDAwMDAgKzAy
MDAKKysrIGFsc2Etb3NzLm5ldy9hbHNhL2Fvc3MuMQkyMDA0LTA4LTA1IDAxOjA5OjQ4LjAwMDAw
MDAwMCArMDIwMApAQCAtMzAsNiArMzAsOCBAQAogCiBJbiB0aGUgYWJvdmUgY29uZmlndXJhdGlv
biBleGFtcGxlcywgdGhlIHBjbS5kc3AwIGRlZmluaXRpb24gaXMgdXNlZCB0byB3cmFwIGNhbGxz
IGRvIC9kZXYvZHNwMC4gWW91IGNhbiBhbHNvIHdyYXAgdXNhZ2Ugb2YgL2Rldi9kc3AxLCAvZGV2
L2RzcDIsIGV0Yy4gYnkgZGVmaW5pbmcgcGNtLmRzcDEsIHBjbS5kc3AyLCBldGMuLgogCitOb3Rl
IG9uIG1tYXA6IGFvc3MgZG9lcyBjdXJyZW50bHkgbm90IHN1cHBvcnQgZnVsbCBtbWFwIHN1cHBv
cnQuIFlvdXIgcmVzdWx0cyBtYXkgdmFyeSB3aGVuIHRyeWluZyB0byB1c2UgYW4gYXBwbGljYXRp
b24gdGhhdCB1c2VzIG1tYXAnaW5nIHRvIGFjY2VzcyB0aGUgT1NTIGRldmljZSBmaWxlcy4KKwog
CiAuU1MgQXJndW1lbnRzCiAuVFAKZGlmZiAtTnJ1IGFsc2Etb3NzL2Fsc2EvbWl4ZXIuYyBhbHNh
LW9zcy5uZXcvYWxzYS9taXhlci5jCi0tLSBhbHNhLW9zcy9hbHNhL21peGVyLmMJMjAwNC0wMi0y
NiAxMTo1Mjo0MC4wMDAwMDAwMDAgKzAxMDAKKysrIGFsc2Etb3NzLm5ldy9hbHNhL21peGVyLmMJ
MjAwNC0wOC0wNSAwMToxNjo1Mi4wMDAwMDAwMDAgKzAyMDAKQEAgLTU0OCw2ICs1NDgsMTAgQEAK
IAkJCW1pbm9yID0gKGF0b2koZmlsZSArIDEwKSA8PCA0KSB8IE9TU19ERVZJQ0VfTUlYRVI7CiAJ
CWVsc2UgaWYgKCFzdHJuY21wKGZpbGUsICIvZGV2L2FtaXhlciIsIDExKSkKIAkJCW1pbm9yID0g
KGF0b2koZmlsZSArIDExKSA8PCA0KSB8IE9TU19ERVZJQ0VfQU1JWEVSOworCQllbHNlIGlmICgh
c3RybmNtcChmaWxlLCAiL2Rldi9zb3VuZC9taXhlciIsIDE2KSkKKwkJCW1pbm9yID0gKGF0b2ko
ZmlsZSArIDE2KSA8PCA0KSB8IE9TU19ERVZJQ0VfTUlYRVI7CisJCWVsc2UgaWYgKCFzdHJuY21w
KGZpbGUsICIvZGV2L3NvdW5kL2FtaXhlciIsIDE3KSkKKwkJCW1pbm9yID0gKGF0b2koZmlsZSAr
IDE3KSA8PCA0KSB8IE9TU19ERVZJQ0VfQU1JWEVSOwogCQllbHNlIHsKIAkJCWVycm5vID0gRU5P
RU5UOwogCQkJcmV0dXJuIC0xOwpkaWZmIC1OcnUgYWxzYS1vc3MvYWxzYS9wY20uYyBhbHNhLW9z
cy5uZXcvYWxzYS9wY20uYwotLS0gYWxzYS1vc3MvYWxzYS9wY20uYwkyMDA0LTA1LTA0IDE1OjAy
OjAzLjAwMDAwMDAwMCArMDIwMAorKysgYWxzYS1vc3MubmV3L2Fsc2EvcGNtLmMJMjAwNC0wOC0w
NSAwMTozNDoxMy4wMDAwMDAwMDAgKzAyMDAKQEAgLTE2NTEsNiArMTY1MSwxNCBAQAogCQkJbWlu
b3IgPSAoYXRvaShmaWxlICsgOSkgPDwgNCkgfCBPU1NfREVWSUNFX0FEU1A7CiAJCWVsc2UgaWYg
KCFzdHJuY21wKGZpbGUsICIvZGV2L2F1ZGlvIiwgMTApKQogCQkJbWlub3IgPSAoYXRvaShmaWxl
ICsgMTApIDw8IDQpIHwgT1NTX0RFVklDRV9BVURJTzsKKwkJZWxzZSBpZiAoIXN0cm5jbXAoZmls
ZSwgIi9kZXYvc291bmQvZHNwIiwgMTQpKQorCQkJbWlub3IgPSAoYXRvaShmaWxlICsgMTQpIDw8
IDQpIHwgT1NTX0RFVklDRV9EU1A7CisJCWVsc2UgaWYgKCFzdHJuY21wKGZpbGUsICIvZGV2L3Nv
dW5kL2RzcFciLCAxNSkpCisJCQltaW5vciA9IChhdG9pKGZpbGUgKyAxNSkgPDwgNCkgfCBPU1Nf
REVWSUNFX0RTUFc7CisJCWVsc2UgaWYgKCFzdHJuY21wKGZpbGUsICIvZGV2L3NvdW5kL2Fkc3Ai
LCAxNSkpCisJCQltaW5vciA9IChhdG9pKGZpbGUgKyAxNSkgPDwgNCkgfCBPU1NfREVWSUNFX0FE
U1A7CisJCWVsc2UgaWYgKCFzdHJuY21wKGZpbGUsICIvZGV2L3NvdW5kL2F1ZGlvIiwgMTYpKQor
CQkJbWlub3IgPSAoYXRvaShmaWxlICsgMTYpIDw8IDQpIHwgT1NTX0RFVklDRV9BVURJTzsKIAkJ
ZWxzZSB7CiAJCQllcnJubyA9IEVOT0VOVDsKIAkJCXJldHVybiAtMTsK

--Multipart=_Thu__5_Aug_2004_01_44_57_+0200_fy+kYAc.NrU/2wNo--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
