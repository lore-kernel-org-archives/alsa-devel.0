From: Baek Chang <baeksan@ccrma.stanford.edu>
Subject: [PATCH] ALSA: memory leak in alsaucm
Date: Mon, 2 May 2011 14:56:28 -0700
Message-ID: <BANLkTi=0c-oVOfcNL79xcY5ws9trOFVR3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e647138a72c0cd04a25218db
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0016e647138a72c0cd04a25218db
Content-Type: text/plain; charset=ISO-8859-1

First time sending a patch, please let me know if I am doing this
incorrectly.

alsaucm is leaking memory whenever execute_cset() is called.


bchang@LT74002R2XXG1:~/projects/alsa-lib-git/src/ucm$ git diff
diff --git a/src/ucm/main.c b/src/ucm/main.c
index 86f29e3..f8ceeeb 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -173,7 +173,8 @@ static int execute_cset(snd_ctl_t *ctl, char *cset)
        pos = strrchr(cset, ' ');
        if (pos == NULL) {
                uc_error("undefined value for cset >%s<", cset);
-               return -EINVAL;
+               err =  -EINVAL;
+               goto __fail;
        }
        *pos = '\0';
        err = snd_ctl_ascii_elem_id_parse(id, cset);
@@ -196,6 +197,14 @@ static int execute_cset(snd_ctl_t *ctl, char *cset)
        err = 0;
       __fail:
        *pos = ' ';
+
+       if (id != NULL)
+               free(id);
+       if (value != NULL)
+               free(value);
+       if (info != NULL)
+               free(info);
+
        return err;
 }



Thanks
-- 
-baeksanchang

--0016e647138a72c0cd04a25218db
Content-Type: text/x-patch; charset=US-ASCII; name="alsaucm.patch"
Content-Disposition: attachment; filename="alsaucm.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gn7y846a0

ZGlmZiAtLWdpdCBhL3NyYy91Y20vbWFpbi5jIGIvc3JjL3VjbS9tYWluLmMKaW5kZXggODZmMjll
My4uZjhjZWVlYiAxMDA2NDQKLS0tIGEvc3JjL3VjbS9tYWluLmMKKysrIGIvc3JjL3VjbS9tYWlu
LmMKQEAgLTE3Myw3ICsxNzMsOCBAQCBzdGF0aWMgaW50IGV4ZWN1dGVfY3NldChzbmRfY3RsX3Qg
KmN0bCwgY2hhciAqY3NldCkKIAlwb3MgPSBzdHJyY2hyKGNzZXQsICcgJyk7CiAJaWYgKHBvcyA9
PSBOVUxMKSB7CiAJCXVjX2Vycm9yKCJ1bmRlZmluZWQgdmFsdWUgZm9yIGNzZXQgPiVzPCIsIGNz
ZXQpOwotCQlyZXR1cm4gLUVJTlZBTDsKKwkJZXJyID0gIC1FSU5WQUw7CisJCWdvdG8gX19mYWls
OwogCX0KIAkqcG9zID0gJ1wwJzsKIAllcnIgPSBzbmRfY3RsX2FzY2lpX2VsZW1faWRfcGFyc2Uo
aWQsIGNzZXQpOwpAQCAtMTk2LDYgKzE5NywxNCBAQCBzdGF0aWMgaW50IGV4ZWN1dGVfY3NldChz
bmRfY3RsX3QgKmN0bCwgY2hhciAqY3NldCkKIAllcnIgPSAwOwogICAgICAgX19mYWlsOgogCSpw
b3MgPSAnICc7CisKKwlpZiAoaWQgIT0gTlVMTCkKKwkJZnJlZShpZCk7CisJaWYgKHZhbHVlICE9
IE5VTEwpCisJCWZyZWUodmFsdWUpOworCWlmIChpbmZvICE9IE5VTEwpCisJCWZyZWUoaW5mbyk7
CisKIAlyZXR1cm4gZXJyOwogfQogCg==
--0016e647138a72c0cd04a25218db
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0016e647138a72c0cd04a25218db--
