From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Subject: aplay patch to add a --seek parameter
Date: Fri, 15 Apr 2011 01:53:48 +0200
Message-ID: <m38vvc9ypf.fsf@quimbies.gnus.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 10080103807
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Apr 2011 01:54:06 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1QAWMK-00059k-GX
	for alsa-devel@alsa-project.org; Fri, 15 Apr 2011 01:54:00 +0200
Received: from cm-84.215.51.58.getinternet.no ([84.215.51.58])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2011 01:54:00 +0200
Received: from larsi by cm-84.215.51.58.getinternet.no with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2011 01:54:00 +0200
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

--=-=-=
Content-Type: text/plain

I'm using aplay in a sound editor to play PCM files.  But I need to be
able to say "start playing at point X" to be able to skip around in the
file.

I've used the following patch for years, but I think I forgot to submit
it for inclusion into alsa-utils.


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=aplay-diff
Content-Transfer-Encoding: base64

LS0tIGFwbGF5LmMub3JpZwkyMDExLTAxLTMxIDE1OjE5OjU1LjAwMDAwMDAwMCArMDEwMAorKysg
YXBsYXkuYwkyMDExLTA0LTE1IDAxOjQ0OjA1LjAwMDAwMDAwMCArMDIwMApAQCAtODYsNiArODYs
NyBAQAogCXVuc2lnbmVkIGludCByYXRlOwogfSBod3BhcmFtcywgcmh3cGFyYW1zOwogc3RhdGlj
IGludCB0aW1lbGltaXQgPSAwOworc3RhdGljIGludCBzZWVrX2xlbmd0aCA9IDA7CiBzdGF0aWMg
aW50IHF1aWV0X21vZGUgPSAwOwogc3RhdGljIGludCBmaWxlX3R5cGUgPSBGT1JNQVRfREVGQVVM
VDsKIHN0YXRpYyBpbnQgb3Blbl9tb2RlID0gMDsKQEAgLTE4Niw2ICsxODcsNyBAQAogIi1jLCAt
LWNoYW5uZWxzPSMgICAgICAgIGNoYW5uZWxzXG4iCiAiLWYsIC0tZm9ybWF0PUZPUk1BVCAgICAg
c2FtcGxlIGZvcm1hdCAoY2FzZSBpbnNlbnNpdGl2ZSlcbiIKICItciwgLS1yYXRlPSMgICAgICAg
ICAgICBzYW1wbGUgcmF0ZVxuIgorIi1TLCAtLXNlZWs9IyAgICAgICAgICAgIHNlZWsgdG8gcG9z
aXRpb24gIyBiZWZvcmUgcGxheWluZ1xuIgogIi1kLCAtLWR1cmF0aW9uPSMgICAgICAgIGludGVy
cnVwdCBhZnRlciAjIHNlY29uZHNcbiIKICItTSwgLS1tbWFwICAgICAgICAgICAgICBtbWFwIHN0
cmVhbVxuIgogIi1OLCAtLW5vbmJsb2NrICAgICAgICAgIG5vbmJsb2NraW5nIG1vZGVcbiIKQEAg
LTQwNCw3ICs0MDYsNyBAQAogaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIHsKIAlp
bnQgb3B0aW9uX2luZGV4OwotCXN0YXRpYyBjb25zdCBjaGFyIHNob3J0X29wdGlvbnNbXSA9ICJo
bmxMRDpxdDpjOmY6cjpkOk1ORjpBOlI6VDpCOnZWOklQQyI7CisJc3RhdGljIGNvbnN0IGNoYXIg
c2hvcnRfb3B0aW9uc1tdID0gImhubExEOnF0OmM6ZjpyOlM6ZDpNTkY6QTpSOlQ6Qjp2VjpJUEMi
OwogCXN0YXRpYyBjb25zdCBzdHJ1Y3Qgb3B0aW9uIGxvbmdfb3B0aW9uc1tdID0gewogCQl7Imhl
bHAiLCAwLCAwLCAnaCd9LAogCQl7InZlcnNpb24iLCAwLCAwLCBPUFRfVkVSU0lPTn0sCkBAIC00
MTcsNiArNDE5LDcgQEAKIAkJeyJjaGFubmVscyIsIDEsIDAsICdjJ30sCiAJCXsiZm9ybWF0Iiwg
MSwgMCwgJ2YnfSwKIAkJeyJyYXRlIiwgMSwgMCwgJ3InfSwKKwkJeyJzZWVrIiwgMSwgMCwgJ1Mn
fSwKIAkJeyJkdXJhdGlvbiIsIDEsIDAgLCdkJ30sCiAJCXsibW1hcCIsIDAsIDAsICdNJ30sCiAJ
CXsibm9uYmxvY2siLCAwLCAwLCAnTid9LApAQCAtNTUwLDYgKzU1Myw5IEBACiAJCQkJcmV0dXJu
IDE7CiAJCQl9CiAJCQlicmVhazsKKwkJY2FzZSAnUyc6CisJCQlzZWVrX2xlbmd0aCA9IGF0b2ko
b3B0YXJnKTsKKwkJCWJyZWFrOwogCQljYXNlICdkJzoKIAkJCXRpbWVsaW1pdCA9IHN0cnRvbChv
cHRhcmcsIE5VTEwsIDApOwogCQkJYnJlYWs7CkBAIC0yNDU3LDYgKzI0NjMsOCBAQAogCX0KIAlp
ZiAodGVzdF9hdShmZCwgYXVkaW9idWYpID49IDApIHsKIAkJcmh3cGFyYW1zLmZvcm1hdCA9IGh3
cGFyYW1zLmZvcm1hdDsKKwkJaWYgKHNlZWtfbGVuZ3RoICE9IDApCisJCSAgICAgICAgbHNlZWso
ZmQsIHNlZWtfbGVuZ3RoLCBTRUVLX1NFVCk7CiAJCXBicmVjX2NvdW50ID0gY2FsY19jb3VudCgp
OwogCQlwbGF5YmFja19nbyhmZCwgMCwgcGJyZWNfY291bnQsIEZPUk1BVF9BVSwgbmFtZSk7CiAJ
CWdvdG8gX19lbmQ7CkBAIC0yNDY4LDE3ICsyNDc2LDIzIEBACiAJCXByZ19leGl0KEVYSVRfRkFJ
TFVSRSk7OwogCX0KIAlpZiAoKG9mcyA9IHRlc3Rfdm9jZmlsZShhdWRpb2J1ZikpID49IDApIHsK
KwkJaWYgKHNlZWtfbGVuZ3RoICE9IDApCisJCSAgICAgICAgbHNlZWsoZmQsIHNlZWtfbGVuZ3Ro
LCBTRUVLX1NFVCk7CiAJCXBicmVjX2NvdW50ID0gY2FsY19jb3VudCgpOwogCQl2b2NfcGxheShm
ZCwgb2ZzLCBuYW1lKTsKIAkJZ290byBfX2VuZDsKIAl9CiAJLyogcmVhZCBieXRlcyBmb3IgV0FW
RS1oZWFkZXIgKi8KIAlpZiAoKGR0YXdhdmUgPSB0ZXN0X3dhdmVmaWxlKGZkLCBhdWRpb2J1Ziwg
ZHRhKSkgPj0gMCkgeworCQlpZiAoc2Vla19sZW5ndGggIT0gMCkKKwkJICAgICAgICBsc2Vlayhm
ZCwgc2Vla19sZW5ndGgsIFNFRUtfU0VUKTsKIAkJcGJyZWNfY291bnQgPSBjYWxjX2NvdW50KCk7
CiAJCXBsYXliYWNrX2dvKGZkLCBkdGF3YXZlLCBwYnJlY19jb3VudCwgRk9STUFUX1dBVkUsIG5h
bWUpOwogCX0gZWxzZSB7CiAJCS8qIHNob3VsZCBiZSByYXcgZGF0YSAqLwogCQlpbml0X3Jhd19k
YXRhKCk7CisJCWlmIChzZWVrX2xlbmd0aCAhPSAwKQorCQkgICAgICAgIGxzZWVrKGZkLCBzZWVr
X2xlbmd0aCwgU0VFS19TRVQpOwogCQlwYnJlY19jb3VudCA9IGNhbGNfY291bnQoKTsKIAkJcGxh
eWJhY2tfZ28oZmQsIGR0YSwgcGJyZWNfY291bnQsIEZPUk1BVF9SQVcsIG5hbWUpOwogCX0K
--=-=-=
Content-Type: text/plain


-- 
(domestic pets only, the antidote for overdose, milk.)
  bloggy blog http://lars.ingebrigtsen.no/

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-=-=--
