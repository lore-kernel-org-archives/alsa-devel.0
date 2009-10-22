From: "Rémi Denis-Courmont" <remi@basile.remlab.net>
Subject: [PATCH alsa-lib 1/3] Open device nodes with
	close-on-exec flag
Date: Thu, 22 Oct 2009 17:49:15 +0300
Message-ID: <1256222957-24059-1-git-send-email-remi@remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yop.chewa.net (yop.chewa.net [91.121.105.214])
	by alsa0.perex.cz (Postfix) with ESMTP id F1A2524399
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 16:49:19 +0200 (CEST)
Received: from basile.remlab.net (localhost.localdomain [127.0.0.1])
	by yop.chewa.net (Postfix) with SMTP id 371CD7A5
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 16:49:18 +0200 (CEST)
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

VGhpcyBhdm9pZCBsZWFraW5nIGRldmljZSBkZXNjcmlwdG9ycyB0aHJvdWdoIGV4ZWMuIFRodXMg
QUxTQQphcHBsaWNhdGlvbnMgY2FuIHNhZmVseSBzcGF3biBvdGhlciBwcm9jZXNzZXMgaW4gdGhl
aXIgYmFja2dyb3VuZC4KClNpZ25lZC1vZmYtYnk6IFLDqW1pIERlbmlzLUNvdXJtb250IDxyZW1p
QHJlbWxhYi5uZXQ+Ci0tLQogaW5jbHVkZS9sb2NhbC5oIHwgICAyMyArKysrKysrKysrKysrKysr
Ky0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbG9jYWwuaCBiL2luY2x1ZGUvbG9jYWwuaAppbmRleCBi
NWExYzQ1Li41YjU0ZGVmIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xvY2FsLmgKKysrIGIvaW5jbHVk
ZS9sb2NhbC5oCkBAIC0yMzAsMjIgKzIzMCwzMyBAQCBleHRlcm4gc25kX2xpYl9lcnJvcl9oYW5k
bGVyX3Qgc25kX2Vycl9tc2c7CiAjIGRlZmluZSBsaW5rX3dhcm5pbmcoc3ltYm9sLCBtc2cpCiAj
ZW5kaWYKIAotLyogb3BlbiB3aXRoIHJlc21nciAqLwotI2lmZGVmIFNVUFBPUlRfUkVTTUdSCiBz
dGF0aWMgaW5saW5lIGludCBzbmRfb3Blbl9kZXZpY2UoY29uc3QgY2hhciAqZmlsZW5hbWUsIGlu
dCBmbW9kZSkKIHsKLQlpbnQgZmQgPSBvcGVuKGZpbGVuYW1lLCBmbW9kZSk7CisJaW50IGZkOwor
CisjaWZkZWYgT19DTE9FWEVDCisJZmQgPSBvcGVuKGZpbGVuYW1lLCBmbW9kZXxPX0NMT0VYRUMp
OwogCWlmIChmZCA+PSAwKQogCQlyZXR1cm4gZmQ7CisJaWYgKGVycm5vID09IEVJTlZBTCkKKyNl
bmRpZgorCXsKKwkJZmQgPSBvcGVuKGZpbGVuYW1lLCBmbW9kZSk7CisJCWlmIChmZCA+PSAwKSB7
CisJCQlmY250bChmZCwgRl9TRVRGRCwgRkRfQ0xPRVhFQyk7CisJCQlyZXR1cm4gZmQ7CisJCX0K
Kwl9CisKKy8qIG9wZW4gd2l0aCByZXNtZ3IgKi8KKyNpZmRlZiBTVVBQT1JUX1JFU01HUgogCWlm
IChlcnJubyA9PSBFQUdBSU4gfHwgZXJybm8gPT0gRUJVU1kpCiAJCXJldHVybiBmZDsKIAlpZiAo
ISBhY2Nlc3MoZmlsZW5hbWUsIEZfT0spKQogCQlyZXR1cm4gcnNtX29wZW5fZGV2aWNlKGZpbGVu
YW1lLCBmbW9kZSk7CisjZW5kaWYKIAlyZXR1cm4gLTE7CiB9Ci0jZWxzZQotI2RlZmluZSBzbmRf
b3Blbl9kZXZpY2UoZmlsZW5hbWUsIGZtb2RlKSBvcGVuKGZpbGVuYW1lLCBmbW9kZSk7Ci0jZW5k
aWYKIAogLyogbWFrZSBsb2NhbCBmdW5jdGlvbnMgcmVhbGx5IGxvY2FsICovCiAjZGVmaW5lIHNu
ZF9kbG9ial9jYWNoZV9sb29rdXAgXAotLSAKMS42LjUKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2
ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxt
YW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
