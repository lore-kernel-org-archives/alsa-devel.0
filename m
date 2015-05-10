From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] ASoC: wm8737: Fixup setting VMID Impedance
 control register
Date: Sun, 10 May 2015 11:35:06 +0800
Message-ID: <1431228906.9088.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A2592604E5
 for <alsa-devel@alsa-project.org>; Sun, 10 May 2015 05:35:13 +0200 (CEST)
Received: by pdea3 with SMTP id a3so120962129pde.3
 for <alsa-devel@alsa-project.org>; Sat, 09 May 2015 20:35:11 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

QWNjb3JkaW5nIHRvIHRoZSBkYXRhc2hlZXQ6ClIxMCAoMEFoKSBWTUlEIEltcGVkYW5jZSBDb250
cm9sCgpCSVQgMzoyIFZNSURTRUwgREVGQVVMVCAwMAoKREVTQ1JJUFRJT046IFZNSUQgaW1wZWRh
bmNlIHNlbGVjdGlvbiBjb250cm9sCjAwOiA3NWvOqSBvdXRwdXQKMDE6IDMwMGvOqSBvdXRwdXQK
MTA6IDIuNWvOqSBvdXRwdXQKCldNODczN19WTUlEU0VMX01BU0sgaXMgMHhDIChWTUlEU0VMIC0g
WzM6Ml0pLApzbyBpdCBuZWVkcyB0byBsZWZ0IHNoaWZ0IFdNODczN19WTUlEU0VMX1NISUZUIGJp
dHMgZm9yIHNldHRpbmcgdGhlc2UgYml0cy4KClNpZ25lZC1vZmYtYnk6IEF4ZWwgTGluIDxheGVs
LmxpbkBpbmdpY3MuY29tPgotLS0KIHNvdW5kL3NvYy9jb2RlY3Mvd204NzM3LmMgfCA2ICsrKyst
LQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3dtODczNy5jIGIvc291bmQvc29jL2NvZGVjcy93bTg3
MzcuYwppbmRleCA0YTk0MDdkLi5kMzhmMWE5IDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvY29kZWNz
L3dtODczNy5jCisrKyBiL3NvdW5kL3NvYy9jb2RlY3Mvd204NzM3LmMKQEAgLTQ4Myw3ICs0ODMs
OCBAQCBzdGF0aWMgaW50IHdtODczN19zZXRfYmlhc19sZXZlbChzdHJ1Y3Qgc25kX3NvY19jb2Rl
YyAqY29kZWMsCiAKIAkJCS8qIEZhc3QgVk1JRCByYW1wIGF0IDIqMi41ayAqLwogCQkJc25kX3Nv
Y191cGRhdGVfYml0cyhjb2RlYywgV004NzM3X01JU0NfQklBU19DT05UUk9MLAotCQkJCQkgICAg
V004NzM3X1ZNSURTRUxfTUFTSywgMHg0KTsKKwkJCQkJICAgIFdNODczN19WTUlEU0VMX01BU0ss
CisJCQkJCSAgICAyIDw8IFdNODczN19WTUlEU0VMX1NISUZUKTsKIAogCQkJLyogQnJpbmcgVk1J
RCB1cCAqLwogCQkJc25kX3NvY191cGRhdGVfYml0cyhjb2RlYywgV004NzM3X1BPV0VSX01BTkFH
RU1FTlQsCkBAIC00OTcsNyArNDk4LDggQEAgc3RhdGljIGludCB3bTg3Mzdfc2V0X2JpYXNfbGV2
ZWwoc3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVjLAogCiAJCS8qIFZNSUQgYXQgMiozMDBrICov
CiAJCXNuZF9zb2NfdXBkYXRlX2JpdHMoY29kZWMsIFdNODczN19NSVNDX0JJQVNfQ09OVFJPTCwK
LQkJCQkgICAgV004NzM3X1ZNSURTRUxfTUFTSywgMik7CisJCQkJICAgIFdNODczN19WTUlEU0VM
X01BU0ssCisJCQkJICAgIDEgPDwgV004NzM3X1ZNSURTRUxfU0hJRlQpOwogCiAJCWJyZWFrOwog
Ci0tIAoyLjEuMAoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcK
aHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2
ZWwK
