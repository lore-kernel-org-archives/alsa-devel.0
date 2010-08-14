From: Dan Carpenter <error27@gmail.com>
Subject: [patch v2] sound/usb/format: silence uninitialized
	variable	warnings
Date: Sat, 14 Aug 2010 19:29:53 +0200
Message-ID: <20100814172953.GA645@bicker>
References: <20100814085846.GV645@bicker> <s5hbp95xoem.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 775AC1037EA
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Aug 2010 19:30:26 +0200 (CEST)
Received: by fxm11 with SMTP id 11so2398426fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 14 Aug 2010 10:30:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hbp95xoem.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

R2NjIGNvbXBsYWlucyB0aGF0IHJldCBtaWdodCBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQ6Cgpzb3Vu
ZC91c2IvZm9ybWF0LmM6IEluIGZ1bmN0aW9uIOKAmHNuZF91c2JfcGFyc2VfYXVkaW9fZm9ybWF0
4oCZOgpzb3VuZC91c2IvZm9ybWF0LmM6MzU0OiB3YXJuaW5nOiDigJhyZXTigJkgbWF5IGJlIHVz
ZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uCnNvdW5kL3VzYi9mb3JtYXQuYzozNTQ6
IG5vdGU6IOKAmHJldOKAmSB3YXMgZGVjbGFyZWQgaGVyZQpzb3VuZC91c2IvZm9ybWF0LmM6NDE0
OiB3YXJuaW5nOiDigJhyZXTigJkgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1
bmN0aW9uCnNvdW5kL3VzYi9mb3JtYXQuYzo0MTQ6IG5vdGU6IOKAmHJldOKAmSB3YXMgZGVjbGFy
ZWQgaGVyZQoKSSBzdXBwb3NlIGl0IGNvdWxkIGJlIHVuaW5pdGlhbGl6ZWQgaWYgdGhlcmUgaXMg
ZXZlciBhIFVBQ19WRVJTSU9OXzMKcmVsZWFzZWQuIEFueXdheSB0aGlzIHBhdGNoIGlzIHdvcnRo
d2hpbGUgaWYgb25seSB0byBzaWxlbmNlIHRoZSBnY2MKd2FybmluZy4KClNpZ25lZC1vZmYtYnk6
IERhbiBDYXJwZW50ZXIgPGVycm9yMjdAZ21haWwuY29tPgotLS0KVjI6IFRvdGFsbHkgZGlmZmVy
ZW50LiAgQWRkZWQgcHJpbnRrKClzCgpkaWZmIC0tZ2l0IGEvc291bmQvdXNiL2Zvcm1hdC5jIGIv
c291bmQvdXNiL2Zvcm1hdC5jCmluZGV4IDQzODdmNTQuLjNhMTM3NTQgMTAwNjQ0Ci0tLSBhL3Nv
dW5kL3VzYi9mb3JtYXQuYworKysgYi9zb3VuZC91c2IvZm9ybWF0LmMKQEAgLTM5Miw2ICszOTIs
MTAgQEAgc3RhdGljIGludCBwYXJzZV9hdWRpb19mb3JtYXRfaShzdHJ1Y3Qgc25kX3VzYl9hdWRp
byAqY2hpcCwKIAkJLyogZnAtPmNoYW5uZWxzIGlzIGFscmVhZHkgc2V0IGluIHRoaXMgY2FzZSAq
LwogCQlyZXQgPSBwYXJzZV9hdWRpb19mb3JtYXRfcmF0ZXNfdjIoY2hpcCwgZnApOwogCQlicmVh
azsKKwlkZWZhdWx0OgorCQlzbmRfcHJpbnRrKEtFUk5fRVJSICIlZDoldTolZCA6IGludmFsaWQg
cHJvdG9jb2wgdmVyc2lvbiAlZFxuIiwKKwkJCSAgIGNoaXAtPmRldi0+ZGV2bnVtLCBmcC0+aWZh
Y2UsIGZwLT5hbHRzZXR0aW5nLCBwcm90b2NvbCk7CisJCXJldHVybiAtRUlOVkFMOwogCX0KIAog
CWlmIChmcC0+Y2hhbm5lbHMgPCAxKSB7CkBAIC00NTIsNiArNDU2LDEwIEBAIHN0YXRpYyBpbnQg
cGFyc2VfYXVkaW9fZm9ybWF0X2lpKHN0cnVjdCBzbmRfdXNiX2F1ZGlvICpjaGlwLAogCQlyZXQg
PSBwYXJzZV9hdWRpb19mb3JtYXRfcmF0ZXNfdjIoY2hpcCwgZnApOwogCQlicmVhazsKIAl9CisJ
ZGVmYXVsdDoKKwkJc25kX3ByaW50ayhLRVJOX0VSUiAiJWQ6JXU6JWQgOiBpbnZhbGlkIHByb3Rv
Y29sIHZlcnNpb24gJWRcbiIsCisJCQkgICBjaGlwLT5kZXYtPmRldm51bSwgZnAtPmlmYWNlLCBm
cC0+YWx0c2V0dGluZywgcHJvdG9jb2wpOworCQlyZXR1cm4gLUVJTlZBTDsKIAl9CiAKIAlyZXR1
cm4gcmV0OwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
