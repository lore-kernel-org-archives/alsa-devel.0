From: =?utf-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Subject: [PATCH] ALSA: hda - fix audio on LG R510
Date: Mon,  1 Jun 2009 23:13:17 +0300
Message-ID: <1243887197-7898-1-git-send-email-ozan@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pardus.org.tr (comar.uludag.org.tr [193.140.100.220])
	by alsa0.perex.cz (Postfix) with ESMTP id F06E1103855
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Jun 2009 22:11:10 +0200 (CEST)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Q3VycmVudGx5LCBMRyBSNTEwIGlzIG9ubHkgYWJsZSB0byBwcm9kdWNlIHNvdW5kIG9uIGhlYWRw
aG9uZXMsIHRoZQppbnRlcm5hbCBzcGVha2VycyBhcmUgbm90IHdvcmtpbmcuCgpUaGUgdXNlciB0
ZXN0ZWQgYW5kIGNvbmZpcm1lZCB0aGF0IHdpdGggbW9kZWw9RGVsbCBoZWFkcGhvbmVzLAppbnRl
cm5hbCBzcGVha2VycyBhbmQgdGhlIG1pY3JvcGhvbmUgYXJlIHdvcmtpbmcgZmxhd2xlc3NseS4K
ClRlc3RlZC1ieTogU2VyZGFyIFNveXRldGlyIDx0dWxsaWFuYUBnbWFpbC5jb20+ClNpZ25lZC1v
ZmYtYnk6IE96YW4gw4dhxJ9sYXlhbiA8b3phbkBwYXJkdXMub3JnLnRyPgotLS0KIHNvdW5kL3Bj
aS9oZGEvcGF0Y2hfcmVhbHRlay5jIHwgICAgMSArCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0
aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL3BhdGNo
X3JlYWx0ZWsuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCmluZGV4IDBmZDI1OGUu
LmEyMTMzYWMgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCisrKyBi
L3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCkBAIC0xMjA2Myw2ICsxMjA2Myw3IEBAIHN0
YXRpYyBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBhbGMyNjhfY2ZnX3RibFtdID0gewogCQkJCQkJQUxD
MjY4X0FDRVJfQVNQSVJFX09ORSksCiAJU05EX1BDSV9RVUlSSygweDEwMjgsIDB4MDI1MywgIkRl
bGwgT0VNIiwgQUxDMjY4X0RFTEwpLAogCVNORF9QQ0lfUVVJUksoMHgxMDI4LCAweDAyYjAsICJE
ZWxsIEluc3Bpcm9uIE1pbmk5IiwgQUxDMjY4X0RFTEwpLAorCVNORF9QQ0lfUVVJUksoMHgxODU0
LCAweDE3NzUsICJMRyBSNTEwIiwgQUxDMjY4X0RFTEwpLAogCVNORF9QQ0lfUVVJUksoMHgxMDNj
LCAweDMwY2MsICJUT1NISUJBIiwgQUxDMjY4X1RPU0hJQkEpLAogCVNORF9QQ0lfUVVJUksoMHgx
MDNjLCAweDMwZjEsICJIUCBUWDI1eHggc2VyaWVzIiwgQUxDMjY4X1RPU0hJQkEpLAogCVNORF9Q
Q0lfUVVJUksoMHgxMDQzLCAweDEyMDUsICJBU1VTIFc3SiIsIEFMQzI2OF8zU1QpLAotLSAKMS42
LjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
