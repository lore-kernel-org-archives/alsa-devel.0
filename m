From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
Subject: [PATCH] sound working on the macbook pro
Date: Sun, 18 Feb 2007 17:06:22 +0000
Message-ID: <564d96fb0702180906u6dc0f0d9k2cd1d5e1409f1911@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_10759_9102784.1171818382928"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 67AD12DE
	for <alsa-devel@alsa-project.org>; Sun, 18 Feb 2007 18:06:23 +0100 (MET)
Received: by nf-out-0910.google.com with SMTP id n29so2071912nfc
	for <alsa-devel@alsa-project.org>; Sun, 18 Feb 2007 09:06:23 -0800 (PST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_10759_9102784.1171818382928
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The problem with the pin config of the macbook pro is that it has no
line outs. Because of this, snd_hda_parse_pin_def_config tries to hack
the speaker into being a line out. This hack makes the subsequent
setup fail.

The attached patch does the followig:
1) install the correct pin config (extracted from macos)
2) removes the hack from snd_hda_parse_pin_def_config
3) stac92xx_parse_auto_config no longuer aborts if line_outs == 0

item 2 might cause some problems for parts of the system that expect
this hack. IMHO, we should try to fix these problems and remove the
hack. It is very confusing to see an Speaker appearing as a line out!

Cheers,
Rafael

------=_Part_10759_9102784.1171818382928
Content-Type: text/x-patch; name=sound.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eybq8cue
Content-Disposition: attachment; filename="sound.patch"

ZGlmZiAtciBjNzU0MGY0MzBkNDUgcGNpL2hkYS9oZGFfY29kZWMuYwotLS0gYS9wY2kvaGRhL2hk
YV9jb2RlYy5jCUZyaSBGZWIgMTYgMTM6Mjc6MTggMjAwNyArMDEwMAorKysgYi9wY2kvaGRhL2hk
YV9jb2RlYy5jCVN1biBGZWIgMTggMTY6MTk6MjAgMjAwNyArMDAwMApAQCAtMjE3OSwyNiArMjE3
OSw2IEBAIGludCBzbmRfaGRhX3BhcnNlX3Bpbl9kZWZfY29uZmlnKHN0cnVjdCAKIAkJICAgY2Zn
LT5pbnB1dF9waW5zW0FVVE9fUElOX0NEXSwKIAkJICAgY2ZnLT5pbnB1dF9waW5zW0FVVE9fUElO
X0FVWF0pOwogCi0JLyoKLQkgKiBGSVgtVVA6IGlmIG5vIGxpbmUtb3V0cyBhcmUgZGV0ZWN0ZWQs
IHRyeSB0byB1c2Ugc3BlYWtlciBvciBIUCBwaW4KLQkgKiBhcyBhIHByaW1hcnkgb3V0cHV0Ci0J
ICovCi0JaWYgKCEgY2ZnLT5saW5lX291dHMpIHsKLQkJaWYgKGNmZy0+c3BlYWtlcl9vdXRzKSB7
Ci0JCQljZmctPmxpbmVfb3V0cyA9IGNmZy0+c3BlYWtlcl9vdXRzOwotCQkJbWVtY3B5KGNmZy0+
bGluZV9vdXRfcGlucywgY2ZnLT5zcGVha2VyX3BpbnMsCi0JCQkgICAgICAgc2l6ZW9mKGNmZy0+
c3BlYWtlcl9waW5zKSk7Ci0JCQljZmctPnNwZWFrZXJfb3V0cyA9IDA7Ci0JCQltZW1zZXQoY2Zn
LT5zcGVha2VyX3BpbnMsIDAsIHNpemVvZihjZmctPnNwZWFrZXJfcGlucykpOwotCQl9IGVsc2Ug
aWYgKGNmZy0+aHBfb3V0cykgewotCQkJY2ZnLT5saW5lX291dHMgPSBjZmctPmhwX291dHM7Ci0J
CQltZW1jcHkoY2ZnLT5saW5lX291dF9waW5zLCBjZmctPmhwX3BpbnMsCi0JCQkgICAgICAgc2l6
ZW9mKGNmZy0+aHBfcGlucykpOwotCQkJY2ZnLT5ocF9vdXRzID0gMDsKLQkJCW1lbXNldChjZmct
PmhwX3BpbnMsIDAsIHNpemVvZihjZmctPmhwX3BpbnMpKTsKLQkJfQotCX0KLQogCXJldHVybiAw
OwogfQogCmRpZmYgLXIgYzc1NDBmNDMwZDQ1IHBjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYwotLS0g
YS9wY2kvaGRhL3BhdGNoX3NpZ21hdGVsLmMJRnJpIEZlYiAxNiAxMzoyNzoxOCAyMDA3ICswMTAw
CisrKyBiL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYwlTdW4gRmViIDE4IDE2OjI2OjE3IDIwMDcg
KzAwMDAKQEAgLTUzMCw5ICs1MzAsOSBAQCBzdGF0aWMgdW5zaWduZWQgaW50IG1hY2Jvb2tfcGlu
X2NvbmZpZ3NbCiB9OwogCiBzdGF0aWMgdW5zaWduZWQgaW50IG1hY2Jvb2tfcHJvX3Bpbl9jb25m
aWdzWzEwXSA9IHsKLQkweDAyMjE0MDFmLCAweDkwYTcwMTIwLCAweDAxODEzMDI0LCAweDAxMDE0
MDEwLAotCTB4NDAwMDAwZmQsIDB4MDEwMTYwMTEsIDB4MTM0NWUyNDAsIDB4MTNjNWUyMmUsCi0J
MHg0MDAwMDBmYywgMHg0MDAwMDBmYiwKKwkweDAxMmI0MDUwLCAweDkwYTAwMTEwLCAweDkwMTAw
MTQwLCAweDQwMDAwMGYwLAorCTB4NDAwMDAwZjAsIDB4MDE4YjMwMjAsIDB4MDE0YmUwNjAsIDB4
MDFjYmUwMzAsCisJMHg0MDAwMDBmMCwgMHg0MDAwMDBmMCwKIH07CiAKIHN0YXRpYyB1bnNpZ25l
ZCBpbnQgKnN0YWM5MjJ4X2JyZF90YmxbU1RBQ185MjJYX01PREVMU10gPSB7CkBAIC0xNDAxLDgg
KzE0MDEsNiBAQCBzdGF0aWMgaW50IHN0YWM5Mnh4X3BhcnNlX2F1dG9fY29uZmlnKHN0CiAJCQkJ
CQkmc3BlYy0+YXV0b2NmZywKIAkJCQkJCXNwZWMtPmRtaWNfbmlkcykpIDwgMCkKIAkJcmV0dXJu
IGVycjsKLQlpZiAoISBzcGVjLT5hdXRvY2ZnLmxpbmVfb3V0cykKLQkJcmV0dXJuIDA7IC8qIGNh
bid0IGZpbmQgdmFsaWQgcGluIGNvbmZpZyAqLwogCiAJaWYgKChlcnIgPSBzdGFjOTJ4eF9hZGRf
ZHluX291dF9waW5zKGNvZGVjLCAmc3BlYy0+YXV0b2NmZykpIDwgMCkKIAkJcmV0dXJuIGVycjsK

------=_Part_10759_9102784.1171818382928
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------=_Part_10759_9102784.1171818382928
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------=_Part_10759_9102784.1171818382928--
