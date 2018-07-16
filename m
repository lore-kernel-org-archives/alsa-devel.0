From: Jim Qu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>
Subject: [V2 1/2] ALSA: HDA: use PCI_BASE_CLASS_DISPLAY to replace
 PCI_CLASS_DISPLAY_VGA
Date: Mon, 16 Jul 2018 14:06:34 +0800
Message-ID: <1531721195-4982-1-git-send-email-Jim.Qu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: tiwai-IBi9RG/b67k@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jim Qu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>, lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org
List-Id: alsa-devel@alsa-project.org

RXhjZXB0IFBDSV9DTEFTU19ESVNQTEFZX1ZHQSwgc29tZSBQQ0kgY2xhc3MgaXMgc29tZXRpbWVz
ClBDSV9DTEFTU19ESVNQTEFZXzNEIG9yIFBDSV9DTEFTU19ESVNQTEFZX09USEVSLgoKU2lnbmVk
LW9mZi1ieTogSmltIFF1IDxKaW0uUXVAYW1kLmNvbT4KLS0tCiBzb3VuZC9wY2kvaGRhL2hkYV9p
bnRlbC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYyBiL3NvdW5kL3BjaS9o
ZGEvaGRhX2ludGVsLmMKaW5kZXggMWFlMTg1MC4uMTQ3MzNmZiAxMDA2NDQKLS0tIGEvc291bmQv
cGNpL2hkYS9oZGFfaW50ZWwuYworKysgYi9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCkBAIC0x
NDI5LDcgKzE0MjksNyBAQCBzdGF0aWMgc3RydWN0IHBjaV9kZXYgKmdldF9ib3VuZF92Z2Eoc3Ry
dWN0IHBjaV9kZXYgKnBjaSkKIAkJCXAgPSBwY2lfZ2V0X2RvbWFpbl9idXNfYW5kX3Nsb3QocGNp
X2RvbWFpbl9ucihwY2ktPmJ1cyksCiAJCQkJCQkJcGNpLT5idXMtPm51bWJlciwgMCk7CiAJCQlp
ZiAocCkgewotCQkJCWlmICgocC0+Y2xhc3MgPj4gOCkgPT0gUENJX0NMQVNTX0RJU1BMQVlfVkdB
KQorCQkJCWlmICgocC0+Y2xhc3MgPj4gMTYpID09IFBDSV9CQVNFX0NMQVNTX0RJU1BMQVkpCiAJ
CQkJCXJldHVybiBwOwogCQkJCXBjaV9kZXZfcHV0KHApOwogCQkJfQotLSAKMi43LjQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
