From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use LPIB for Sony VPCS11V9E
Date: Thu, 27 May 2010 18:41:34 -0400
Message-ID: <AANLkTind0hRHajyIaoYozMOLJvfnUB-4go6DrI3TD6Wu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd1471ec07fae04879b1762
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id A0D8124141
	for <alsa-devel@alsa-project.org>;
	Fri, 28 May 2010 00:41:36 +0200 (CEST)
Received: by pvc22 with SMTP id 22so272600pvc.38
	for <alsa-devel@alsa-project.org>; Thu, 27 May 2010 15:41:35 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, stable@kernel.org, Lauri Kainulainen <lauri@sokkelo.net>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--000e0cd1471ec07fae04879b1762
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against sound-2.6 master HEAD that resolves
stuttering audio on the original reporter's hardware. Please apply.

This patch is applicable to all stable trees of 2.6.3x.

Best,
-Dan

--000e0cd1471ec07fae04879b1762
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Use-LPIB-for-Sony-VPCS11V9E.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-LPIB-for-Sony-VPCS11V9E.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9q638f10

RnJvbSA3MGZiNThiNDRjNzk3MGU5MmU4ZThlMzNlNWFjYzg3ZDJjZjc3YThlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFRodSwgMjcgTWF5IDIwMTAgMTg6MzI6MTggLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IFVzZSBMUElCIGZvciBTb255IFZQQ1MxMVY5RQoKQnVnTGluazogaHR0cHM6Ly9sYXVu
Y2hwYWQubmV0L2J1Z3MvNTg2MzQ3CgpTeW1wdG9tOiBPbiB0aGUgU29ueSBWUENTMTFWOUUsIHVz
aW5nIEdTdHJlYW1lci1iYXNlZCBhcHBsaWNhdGlvbnMgd2l0aApQdWxzZUF1ZGlvIGluIFVidW50
dSAxMC4wNCBMVFMgcmVzdWx0cyBpbiBzdHV0dGVyaW5nIGF1ZGlvLiBJdCBhcHBlYXJzCnRvIHdv
cnNlbiB3aXRoIGluY3JlYXNlZCBJL08uCgpUZXN0IGNhc2U6IHVzZSBSaHl0aG1ib3ggdW5kZXIg
aW5jcmVhc2VkIEkvTyBwcmVzc3VyZS4gVGhpcyBzeW1wdG9tIGlzCnJlcHJvZHVjaWJsZSBpbiB0
aGUgY3VycmVudCBkYWlseSBzdGFibGUgYWxzYS1kcml2ZXIgc25hcHNob3RzIChhdCBsZWFzdAp1
cCB1bnRpbCAyMSBNYXkgMjAxMDsgbGF0ZXIgc25hcHNob3RzIGZhaWwgdG8gYnVpbGQgZnJvbSBz
b3VyY2UgZHVlIHRvCm1pc3NpbmcgcHJlcHJvY2Vzc29yIGRpcmVjdGl2ZXMgd2hlbiBjb21waWxl
ZCBhZ2FpbnN0IDIuNi4zMikuCgpSZXNvbHV0aW9uOiBhZGQgU1NJRCBmb3IgdGhpcyBtYWNoaW5l
IHRvIHRoZSBwb3NpdGlvbl9maXggcXVpcmsgdGFibGUsCmV4cGxpY2l0bHkgc3BlY2lmeWluZyB0
aGUgTFBJQiBtZXRob2QuCgpSZXBvcnRlZC1hbmQtVGVzdGVkLUJ5OiBMYXVyaSBLYWludWxhaW5l
biA8bGF1cmlAc29ra2Vsby5uZXQ+CkNjOiA8c3RhYmxlQGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYt
Ynk6IERhbmllbCBUIENoZW4gPGNyaW1zdW5AdWJ1bnR1LmNvbT4KLS0tCiBzb3VuZC9wY2kvaGRh
L2hkYV9pbnRlbC5jIHwgICAgMSArCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwg
MCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jIGIv
c291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYwppbmRleCA3N2UyMmMyLi5lMWZmMmI4IDEwMDY0NAot
LS0gYS9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCisrKyBiL3NvdW5kL3BjaS9oZGEvaGRhX2lu
dGVsLmMKQEAgLTIyODgsNiArMjI4OCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBw
b3NpdGlvbl9maXhfbGlzdFtdIF9fZGV2aW5pdGRhdGEgPSB7CiAJU05EX1BDSV9RVUlSSygweDEw
MjgsIDB4MDFmNiwgIkRlbGwgTGF0aXR1ZGUgMTMxTCIsIFBPU19GSVhfTFBJQiksCiAJU05EX1BD
SV9RVUlSSygweDEwM2MsIDB4MzA2ZCwgIkhQIGR2MyIsIFBPU19GSVhfTFBJQiksCiAJU05EX1BD
SV9RVUlSSygweDEwNDMsIDB4ODEzZCwgIkFTVVMgUDVBRDIiLCBQT1NfRklYX0xQSUIpLAorCVNO
RF9QQ0lfUVVJUksoMHgxMDRkLCAweDkwNjksICJTb255IFZQQ1MxMVY5RSIsIFBPU19GSVhfTFBJ
QiksCiAJU05EX1BDSV9RVUlSSygweDExMDYsIDB4MzI4OCwgIkFTVVMgTTJWLU1YIFNFIiwgUE9T
X0ZJWF9MUElCKSwKIAlTTkRfUENJX1FVSVJLKDB4MTE3OSwgMHhmZjEwLCAiVG9zaGliYSBBMTAw
LTI1OSIsIFBPU19GSVhfTFBJQiksCiAJU05EX1BDSV9RVUlSSygweDE0NTgsIDB4YTAyMiwgImdh
LW1hNzcwLXVkMyIsIFBPU19GSVhfTFBJQiksCi0tIAoxLjcuMC40Cgo=
--000e0cd1471ec07fae04879b1762
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--000e0cd1471ec07fae04879b1762--
