From: Florian Schmidt <mista.tapas@gmx.net>
Subject: aoss patch [against cvs?]
Date: Fri, 23 Jul 2004 16:48:16 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040723164816.622682b5@mango.fruits.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__23_Jul_2004_16_48_16_+0200_haewTBXeO2oEnRTE"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart=_Fri__23_Jul_2004_16_48_16_+0200_haewTBXeO2oEnRTE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi

here's a patch that builds upon my last one.. this cleans minor things up a little bit and changes the manpage.. So this is not against 1.0.5, but against 1.0.5 with my other patch applied..

Actually: is checking for the device files name in /dev/sound/ nessecary? or is every sane devfs installation required to make symlinks to /dev/ anyways?

Flo

snip-------------- [also attached]

diff -Nru alsa-oss-1.0.5-artsdsp-rip.old/alsa/alsa-oss.c alsa-oss-1.0.5-artsdsp-rip/alsa/alsa-oss.c
--- alsa-oss-1.0.5-artsdsp-rip.old/alsa/alsa-oss.c	2004-06-11 19:59:36.000000000 +0200
+++ alsa-oss-1.0.5-artsdsp-rip/alsa/alsa-oss.c	2004-07-23 16:36:46.000000000 +0200
@@ -104,6 +104,26 @@
 static int poll_fds_add = 0;
 static fd_t **fds;
 
+static int is_dsp_device(const char *pathname)
+{
+	if(!pathname) return 0;
+	if(strncmp(pathname,"/dev/dsp",8) == 0) return 1;
+	if(strncmp(pathname,"/dev/adsp",9) == 0) return 1;
+	if(strncmp(pathname,"/dev/audio",10) == 0) return 1;
+	if(strncmp(pathname,"/dev/sound/dsp",14) == 0) return 1;
+	if(strncmp(pathname,"/dev/sound/adsp",15) == 0) return 1;
+	if(strncmp(pathname,"/dev/sound/audio",16) == 0) return 1;
+	return 0;
+}
+
+static int is_mixer_device(const char *pathname)
+{
+	if(!pathname) return 0;
+	if(strncmp(pathname,"/dev/mixer",10) == 0) return 1;
+	if(strncmp(pathname,"/dev/sound/mixer",16) == 0) return 1;
+	return 0;
+}
+
 static int oss_pcm_fcntl(int fd, int cmd, ...)
 {
 	int result;
@@ -217,9 +237,7 @@
 		mode = va_arg(args, mode_t);
 		va_end(args);
 	}
-	if (!strncmp(file, "/dev/dsp", 8) ||
-	    !strncmp(file, "/dev/adsp", 9) ||
-	    !strncmp(file, "/dev/audio", 10)) {
+	if (is_dsp_device(file)) {
 		fd = lib_oss_pcm_open(file, oflag);
 		if (fd >= 0) {
 			fds[fd] = calloc(sizeof(fd_t), 1);
@@ -232,7 +250,7 @@
 			fds[fd]->oflags = oflag;
 			poll_fds_add += lib_oss_pcm_poll_fds(fd);
 		}
-	} else if (!strncmp(file, "/dev/mixer", 10)) {
+	} else if (is_mixer_device(file)) {
 		fd = lib_oss_mixer_open(file, oflag);
 		if (fd >= 0) {
 			fds[fd] = calloc(sizeof(fd_t), 1);
@@ -632,19 +650,11 @@
 	return count1;
 }
 
-static int is_sound_device(const char *pathname)
-{
-	if(!pathname) return 0;
-	if(strncmp(pathname,"/dev/dsp",8) == 0) return 1;
-	if(strncmp(pathname,"/dev/sound/dsp",14) == 0) return 1;
-	return 0;
-}
-
 
 #include "stdioemu.c"
 
 FILE *fopen(const char* path, const char *mode) {
-	if(!is_sound_device(path)) 
+	if(!is_dsp_device(path)) 
 		return _fopen (path, mode);
 	
 	return fake_fopen(path, mode);
diff -Nru alsa-oss-1.0.5-artsdsp-rip.old/alsa/aoss.1 alsa-oss-1.0.5-artsdsp-rip/alsa/aoss.1
--- alsa-oss-1.0.5-artsdsp-rip.old/alsa/aoss.1	2004-02-24 20:40:47.000000000 +0100
+++ alsa-oss-1.0.5-artsdsp-rip/alsa/aoss.1	2004-07-23 15:27:54.000000000 +0200
@@ -30,7 +30,6 @@
 
 In the above configuration examples, the pcm.dsp0 definition is used to wrap calls do /dev/dsp0. You can also wrap usage of /dev/dsp1, /dev/dsp2, etc. by defining pcm.dsp1, pcm.dsp2, etc..
 
-In the current form, aoss is not able to wrap OSS applications that make use of libc's FILE* infrastructure (fopen() and friends) for their communication with the OSS sound driver. This is because libc uses internal versions of open() and friends which cannot be intercepted by LD_PRELOAD'ing a shared library..
 
 .SS Arguments
 .TP




-- 
Palimm Palimm!
http://affenbande.org/~tapas/


--Multipart=_Fri__23_Jul_2004_16_48_16_+0200_haewTBXeO2oEnRTE
Content-Type: application/octet-stream;
 name="alsa-oss-fopen2.patch"
Content-Disposition: attachment;
 filename="alsa-oss-fopen2.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtTnJ1IGFsc2Etb3NzLTEuMC41LWFydHNkc3AtcmlwLm9sZC9hbHNhL2Fsc2Etb3NzLmMg
YWxzYS1vc3MtMS4wLjUtYXJ0c2RzcC1yaXAvYWxzYS9hbHNhLW9zcy5jCi0tLSBhbHNhLW9zcy0x
LjAuNS1hcnRzZHNwLXJpcC5vbGQvYWxzYS9hbHNhLW9zcy5jCTIwMDQtMDYtMTEgMTk6NTk6MzYu
MDAwMDAwMDAwICswMjAwCisrKyBhbHNhLW9zcy0xLjAuNS1hcnRzZHNwLXJpcC9hbHNhL2Fsc2Et
b3NzLmMJMjAwNC0wNy0yMyAxNjozNjo0Ni4wMDAwMDAwMDAgKzAyMDAKQEAgLTEwNCw2ICsxMDQs
MjYgQEAKIHN0YXRpYyBpbnQgcG9sbF9mZHNfYWRkID0gMDsKIHN0YXRpYyBmZF90ICoqZmRzOwog
CitzdGF0aWMgaW50IGlzX2RzcF9kZXZpY2UoY29uc3QgY2hhciAqcGF0aG5hbWUpCit7CisJaWYo
IXBhdGhuYW1lKSByZXR1cm4gMDsKKwlpZihzdHJuY21wKHBhdGhuYW1lLCIvZGV2L2RzcCIsOCkg
PT0gMCkgcmV0dXJuIDE7CisJaWYoc3RybmNtcChwYXRobmFtZSwiL2Rldi9hZHNwIiw5KSA9PSAw
KSByZXR1cm4gMTsKKwlpZihzdHJuY21wKHBhdGhuYW1lLCIvZGV2L2F1ZGlvIiwxMCkgPT0gMCkg
cmV0dXJuIDE7CisJaWYoc3RybmNtcChwYXRobmFtZSwiL2Rldi9zb3VuZC9kc3AiLDE0KSA9PSAw
KSByZXR1cm4gMTsKKwlpZihzdHJuY21wKHBhdGhuYW1lLCIvZGV2L3NvdW5kL2Fkc3AiLDE1KSA9
PSAwKSByZXR1cm4gMTsKKwlpZihzdHJuY21wKHBhdGhuYW1lLCIvZGV2L3NvdW5kL2F1ZGlvIiwx
NikgPT0gMCkgcmV0dXJuIDE7CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgaXNfbWl4ZXJf
ZGV2aWNlKGNvbnN0IGNoYXIgKnBhdGhuYW1lKQoreworCWlmKCFwYXRobmFtZSkgcmV0dXJuIDA7
CisJaWYoc3RybmNtcChwYXRobmFtZSwiL2Rldi9taXhlciIsMTApID09IDApIHJldHVybiAxOwor
CWlmKHN0cm5jbXAocGF0aG5hbWUsIi9kZXYvc291bmQvbWl4ZXIiLDE2KSA9PSAwKSByZXR1cm4g
MTsKKwlyZXR1cm4gMDsKK30KKwogc3RhdGljIGludCBvc3NfcGNtX2ZjbnRsKGludCBmZCwgaW50
IGNtZCwgLi4uKQogewogCWludCByZXN1bHQ7CkBAIC0yMTcsOSArMjM3LDcgQEAKIAkJbW9kZSA9
IHZhX2FyZyhhcmdzLCBtb2RlX3QpOwogCQl2YV9lbmQoYXJncyk7CiAJfQotCWlmICghc3RybmNt
cChmaWxlLCAiL2Rldi9kc3AiLCA4KSB8fAotCSAgICAhc3RybmNtcChmaWxlLCAiL2Rldi9hZHNw
IiwgOSkgfHwKLQkgICAgIXN0cm5jbXAoZmlsZSwgIi9kZXYvYXVkaW8iLCAxMCkpIHsKKwlpZiAo
aXNfZHNwX2RldmljZShmaWxlKSkgewogCQlmZCA9IGxpYl9vc3NfcGNtX29wZW4oZmlsZSwgb2Zs
YWcpOwogCQlpZiAoZmQgPj0gMCkgewogCQkJZmRzW2ZkXSA9IGNhbGxvYyhzaXplb2YoZmRfdCks
IDEpOwpAQCAtMjMyLDcgKzI1MCw3IEBACiAJCQlmZHNbZmRdLT5vZmxhZ3MgPSBvZmxhZzsKIAkJ
CXBvbGxfZmRzX2FkZCArPSBsaWJfb3NzX3BjbV9wb2xsX2ZkcyhmZCk7CiAJCX0KLQl9IGVsc2Ug
aWYgKCFzdHJuY21wKGZpbGUsICIvZGV2L21peGVyIiwgMTApKSB7CisJfSBlbHNlIGlmIChpc19t
aXhlcl9kZXZpY2UoZmlsZSkpIHsKIAkJZmQgPSBsaWJfb3NzX21peGVyX29wZW4oZmlsZSwgb2Zs
YWcpOwogCQlpZiAoZmQgPj0gMCkgewogCQkJZmRzW2ZkXSA9IGNhbGxvYyhzaXplb2YoZmRfdCks
IDEpOwpAQCAtNjMyLDE5ICs2NTAsMTEgQEAKIAlyZXR1cm4gY291bnQxOwogfQogCi1zdGF0aWMg
aW50IGlzX3NvdW5kX2RldmljZShjb25zdCBjaGFyICpwYXRobmFtZSkKLXsKLQlpZighcGF0aG5h
bWUpIHJldHVybiAwOwotCWlmKHN0cm5jbXAocGF0aG5hbWUsIi9kZXYvZHNwIiw4KSA9PSAwKSBy
ZXR1cm4gMTsKLQlpZihzdHJuY21wKHBhdGhuYW1lLCIvZGV2L3NvdW5kL2RzcCIsMTQpID09IDAp
IHJldHVybiAxOwotCXJldHVybiAwOwotfQotCiAKICNpbmNsdWRlICJzdGRpb2VtdS5jIgogCiBG
SUxFICpmb3Blbihjb25zdCBjaGFyKiBwYXRoLCBjb25zdCBjaGFyICptb2RlKSB7Ci0JaWYoIWlz
X3NvdW5kX2RldmljZShwYXRoKSkgCisJaWYoIWlzX2RzcF9kZXZpY2UocGF0aCkpIAogCQlyZXR1
cm4gX2ZvcGVuIChwYXRoLCBtb2RlKTsKIAkKIAlyZXR1cm4gZmFrZV9mb3BlbihwYXRoLCBtb2Rl
KTsKZGlmZiAtTnJ1IGFsc2Etb3NzLTEuMC41LWFydHNkc3AtcmlwLm9sZC9hbHNhL2Fvc3MuMSBh
bHNhLW9zcy0xLjAuNS1hcnRzZHNwLXJpcC9hbHNhL2Fvc3MuMQotLS0gYWxzYS1vc3MtMS4wLjUt
YXJ0c2RzcC1yaXAub2xkL2Fsc2EvYW9zcy4xCTIwMDQtMDItMjQgMjA6NDA6NDcuMDAwMDAwMDAw
ICswMTAwCisrKyBhbHNhLW9zcy0xLjAuNS1hcnRzZHNwLXJpcC9hbHNhL2Fvc3MuMQkyMDA0LTA3
LTIzIDE1OjI3OjU0LjAwMDAwMDAwMCArMDIwMApAQCAtMzAsNyArMzAsNiBAQAogCiBJbiB0aGUg
YWJvdmUgY29uZmlndXJhdGlvbiBleGFtcGxlcywgdGhlIHBjbS5kc3AwIGRlZmluaXRpb24gaXMg
dXNlZCB0byB3cmFwIGNhbGxzIGRvIC9kZXYvZHNwMC4gWW91IGNhbiBhbHNvIHdyYXAgdXNhZ2Ug
b2YgL2Rldi9kc3AxLCAvZGV2L2RzcDIsIGV0Yy4gYnkgZGVmaW5pbmcgcGNtLmRzcDEsIHBjbS5k
c3AyLCBldGMuLgogCi1JbiB0aGUgY3VycmVudCBmb3JtLCBhb3NzIGlzIG5vdCBhYmxlIHRvIHdy
YXAgT1NTIGFwcGxpY2F0aW9ucyB0aGF0IG1ha2UgdXNlIG9mIGxpYmMncyBGSUxFKiBpbmZyYXN0
cnVjdHVyZSAoZm9wZW4oKSBhbmQgZnJpZW5kcykgZm9yIHRoZWlyIGNvbW11bmljYXRpb24gd2l0
aCB0aGUgT1NTIHNvdW5kIGRyaXZlci4gVGhpcyBpcyBiZWNhdXNlIGxpYmMgdXNlcyBpbnRlcm5h
bCB2ZXJzaW9ucyBvZiBvcGVuKCkgYW5kIGZyaWVuZHMgd2hpY2ggY2Fubm90IGJlIGludGVyY2Vw
dGVkIGJ5IExEX1BSRUxPQUQnaW5nIGEgc2hhcmVkIGxpYnJhcnkuLgogCiAuU1MgQXJndW1lbnRz
CiAuVFAK

--Multipart=_Fri__23_Jul_2004_16_48_16_+0200_haewTBXeO2oEnRTE--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
