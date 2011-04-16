From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Subject: Re: aplay patch to add a --seek parameter
Date: Sat, 16 Apr 2011 02:54:49 +0200
Message-ID: <m3mxjryq06.fsf@quimbies.gnus.org>
References: <m38vvc9ypf.fsf@quimbies.gnus.org> <4DA7F76F.5090702@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 56EF210381D
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Apr 2011 02:55:01 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1QAtmu-0002RE-1Y
	for alsa-devel@alsa-project.org; Sat, 16 Apr 2011 02:55:00 +0200
Received: from cm-84.215.51.58.getinternet.no ([84.215.51.58])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 16 Apr 2011 02:55:00 +0200
Received: from larsi by cm-84.215.51.58.getinternet.no with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 16 Apr 2011 02:55:00 +0200
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

Clemens Ladisch <clemens@ladisch.de> writes:

> Please provide a Signed-off-by tag, document whether this option takes
> samples, frames, or (milli)seconds, and add this option to the man page.
> Furthermore, the code doesn't look as if it correctly skips over chunks
> in VOC files.

The --seek number is in bytes, so it assumes that the caller knows what
the internal structure of the file is.  For my usage (which is a simple
visual wave form editor), this makes sense, but specifying it in
milliseconds would probably be even more useful, I guess?

I'm not that familiar with the aplay internals, but so if someone who
are familiar were to transform the patch into "seek to millisecond X",
that would be nice.

Signed-off-by: Lars Magne Ingebrigtsen <larsi@gnus.org>


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=aplay-diff
Content-Transfer-Encoding: base64

LS0tIGFwbGF5LmMub3JpZwkyMDExLTAxLTMxIDE1OjE5OjU1LjAwMDAwMDAwMCArMDEwMAorKysg
YXBsYXkuYwkyMDExLTA0LTE2IDAyOjQ1OjQzLjAwMDAwMDAwMCArMDIwMApAQCAtODYsNiArODYs
NyBAQAogCXVuc2lnbmVkIGludCByYXRlOwogfSBod3BhcmFtcywgcmh3cGFyYW1zOwogc3RhdGlj
IGludCB0aW1lbGltaXQgPSAwOworc3RhdGljIGludCBzZWVrX2xlbmd0aCA9IDA7CiBzdGF0aWMg
aW50IHF1aWV0X21vZGUgPSAwOwogc3RhdGljIGludCBmaWxlX3R5cGUgPSBGT1JNQVRfREVGQVVM
VDsKIHN0YXRpYyBpbnQgb3Blbl9tb2RlID0gMDsKQEAgLTE4Niw2ICsxODcsNyBAQAogIi1jLCAt
LWNoYW5uZWxzPSMgICAgICAgIGNoYW5uZWxzXG4iCiAiLWYsIC0tZm9ybWF0PUZPUk1BVCAgICAg
c2FtcGxlIGZvcm1hdCAoY2FzZSBpbnNlbnNpdGl2ZSlcbiIKICItciwgLS1yYXRlPSMgICAgICAg
ICAgICBzYW1wbGUgcmF0ZVxuIgorIi1TLCAtLXNlZWs9IyAgICAgICAgICAgIHNlZWsgdG8gcG9z
aXRpb24gIyAoaW4gYnl0ZXMpIGJlZm9yZSBwbGF5aW5nXG4iCiAiLWQsIC0tZHVyYXRpb249IyAg
ICAgICAgaW50ZXJydXB0IGFmdGVyICMgc2Vjb25kc1xuIgogIi1NLCAtLW1tYXAgICAgICAgICAg
ICAgIG1tYXAgc3RyZWFtXG4iCiAiLU4sIC0tbm9uYmxvY2sgICAgICAgICAgbm9uYmxvY2tpbmcg
bW9kZVxuIgpAQCAtNDA0LDcgKzQwNiw3IEBACiBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJn
dltdKQogewogCWludCBvcHRpb25faW5kZXg7Ci0Jc3RhdGljIGNvbnN0IGNoYXIgc2hvcnRfb3B0
aW9uc1tdID0gImhubExEOnF0OmM6ZjpyOmQ6TU5GOkE6UjpUOkI6dlY6SVBDIjsKKwlzdGF0aWMg
Y29uc3QgY2hhciBzaG9ydF9vcHRpb25zW10gPSAiaG5sTEQ6cXQ6YzpmOnI6UzpkOk1ORjpBOlI6
VDpCOnZWOklQQyI7CiAJc3RhdGljIGNvbnN0IHN0cnVjdCBvcHRpb24gbG9uZ19vcHRpb25zW10g
PSB7CiAJCXsiaGVscCIsIDAsIDAsICdoJ30sCiAJCXsidmVyc2lvbiIsIDAsIDAsIE9QVF9WRVJT
SU9OfSwKQEAgLTQxNyw2ICs0MTksNyBAQAogCQl7ImNoYW5uZWxzIiwgMSwgMCwgJ2MnfSwKIAkJ
eyJmb3JtYXQiLCAxLCAwLCAnZid9LAogCQl7InJhdGUiLCAxLCAwLCAncid9LAorCQl7InNlZWsi
LCAxLCAwLCAnUyd9LAogCQl7ImR1cmF0aW9uIiwgMSwgMCAsJ2QnfSwKIAkJeyJtbWFwIiwgMCwg
MCwgJ00nfSwKIAkJeyJub25ibG9jayIsIDAsIDAsICdOJ30sCkBAIC01NTAsNiArNTUzLDkgQEAK
IAkJCQlyZXR1cm4gMTsKIAkJCX0KIAkJCWJyZWFrOworCQljYXNlICdTJzoKKwkJCXNlZWtfbGVu
Z3RoID0gYXRvaShvcHRhcmcpOworCQkJYnJlYWs7CiAJCWNhc2UgJ2QnOgogCQkJdGltZWxpbWl0
ID0gc3RydG9sKG9wdGFyZywgTlVMTCwgMCk7CiAJCQlicmVhazsKQEAgLTI0NTcsNiArMjQ2Myw4
IEBACiAJfQogCWlmICh0ZXN0X2F1KGZkLCBhdWRpb2J1ZikgPj0gMCkgewogCQlyaHdwYXJhbXMu
Zm9ybWF0ID0gaHdwYXJhbXMuZm9ybWF0OworCQlpZiAoc2Vla19sZW5ndGggIT0gMCkKKwkJICAg
ICAgICBsc2VlayhmZCwgc2Vla19sZW5ndGgsIFNFRUtfU0VUKTsKIAkJcGJyZWNfY291bnQgPSBj
YWxjX2NvdW50KCk7CiAJCXBsYXliYWNrX2dvKGZkLCAwLCBwYnJlY19jb3VudCwgRk9STUFUX0FV
LCBuYW1lKTsKIAkJZ290byBfX2VuZDsKQEAgLTI0NjgsMTcgKzI0NzYsMjMgQEAKIAkJcHJnX2V4
aXQoRVhJVF9GQUlMVVJFKTs7CiAJfQogCWlmICgob2ZzID0gdGVzdF92b2NmaWxlKGF1ZGlvYnVm
KSkgPj0gMCkgeworCQlpZiAoc2Vla19sZW5ndGggIT0gMCkKKwkJICAgICAgICBsc2VlayhmZCwg
c2Vla19sZW5ndGgsIFNFRUtfU0VUKTsKIAkJcGJyZWNfY291bnQgPSBjYWxjX2NvdW50KCk7CiAJ
CXZvY19wbGF5KGZkLCBvZnMsIG5hbWUpOwogCQlnb3RvIF9fZW5kOwogCX0KIAkvKiByZWFkIGJ5
dGVzIGZvciBXQVZFLWhlYWRlciAqLwogCWlmICgoZHRhd2F2ZSA9IHRlc3Rfd2F2ZWZpbGUoZmQs
IGF1ZGlvYnVmLCBkdGEpKSA+PSAwKSB7CisJCWlmIChzZWVrX2xlbmd0aCAhPSAwKQorCQkgICAg
ICAgIGxzZWVrKGZkLCBzZWVrX2xlbmd0aCwgU0VFS19TRVQpOwogCQlwYnJlY19jb3VudCA9IGNh
bGNfY291bnQoKTsKIAkJcGxheWJhY2tfZ28oZmQsIGR0YXdhdmUsIHBicmVjX2NvdW50LCBGT1JN
QVRfV0FWRSwgbmFtZSk7CiAJfSBlbHNlIHsKIAkJLyogc2hvdWxkIGJlIHJhdyBkYXRhICovCiAJ
CWluaXRfcmF3X2RhdGEoKTsKKwkJaWYgKHNlZWtfbGVuZ3RoICE9IDApCisJCSAgICAgICAgbHNl
ZWsoZmQsIHNlZWtfbGVuZ3RoLCBTRUVLX1NFVCk7CiAJCXBicmVjX2NvdW50ID0gY2FsY19jb3Vu
dCgpOwogCQlwbGF5YmFja19nbyhmZCwgZHRhLCBwYnJlY19jb3VudCwgRk9STUFUX1JBVywgbmFt
ZSk7CiAJfQotLS0gYXBsYXkuMS5vcmlnCTIwMTEtMDQtMTYgMDI6NDY6NTcuMDAwMDAwMDAwICsw
MjAwCisrKyBhcGxheS4xCTIwMTEtMDQtMTYgMDI6NDk6NTUuMDAwMDAwMDAwICswMjAwCkBAIC03
Nyw2ICs3Nyw5IEBACiBBIHZhbHVlIG9mIHplcm8gbWVhbnMgaW5maW5pdHkuCiBUaGUgZGVmYXVs
dCBpcyB6ZXJvLCBzbyBpZiB0aGlzIG9wdGlvbiBpcyBvbWl0dGVkIHRoZW4gdGhlIGFyZWNvcmQg
cHJvY2VzcyB3aWxsIHJ1biB1bnRpbCBpdCBpcyBraWxsZWQuCiAuVFAKK1xmSVwtUywgXC1cLXNl
ZWs9I1xmUAorU2VlayB0byBwb3NpdGlvbiAjIChpbiBieXRlcykgYmVmb3JlIHN0YXJ0aW5nIHRv
IHBsYXkuICBUaGlzIG9wdGlvbiBtb3N0bHkgbWFrZXMgc2Vuc2Ugb24gcmF3IGZpbGVzLgorLlRQ
CiBcZklcLXMsIFwtXC1zbGVlcFwtbWluPSNcZlAKIE1pbiB0aWNrcyB0byBzbGVlcC4gVGhlIGRl
ZmF1bHQgaXMgbm90IHRvIHNsZWVwLgogLlRQCg==
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


--=-=-=--
