From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 2/6] sound: lx_core: Switch to using BIT macro
Date: Thu, 17 Apr 2014 11:51:17 +0200
Message-ID: <1397728281-26050-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1397728281-26050-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id DBF0A265062
 for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2014 11:55:07 +0200 (CEST)
In-Reply-To: <1397728281-26050-1-git-send-email-maxime.ripard@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, iwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

TW92ZSB0byB1c2luZyB0aGUgQklUIG1hY3JvIGZvciBhIGZldyBkZWZpbmVzLiBJdCBhbHNvIGFs
bG93cyB0byBkaXNjYXJkIHRoZQpmcmVuY2ggY29tbWVudCB0aGF0IHdhcyBzYXlpbmcgZXhhY3Rs
eSB3aGF0IHRoZSBCSVQgbWFjcm8gaXMgbm93IHBvaW50aW5nIG91dC4KClNpZ25lZC1vZmYtYnk6
IE1heGltZSBSaXBhcmQgPG1heGltZS5yaXBhcmRAZnJlZS1lbGVjdHJvbnMuY29tPgotLS0KIHNv
dW5kL3BjaS9seDY0NjRlcy9seF9jb3JlLmMgfCA3ICsrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2x4
NjQ2NGVzL2x4X2NvcmUuYyBiL3NvdW5kL3BjaS9seDY0NjRlcy9seF9jb3JlLmMKaW5kZXggNmEx
ZDkwYTMwOGVhLi42NTJmNmRmYzdlMWEgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9seDY0NjRlcy9s
eF9jb3JlLmMKKysrIGIvc291bmQvcGNpL2x4NjQ2NGVzL2x4X2NvcmUuYwpAQCAtMjQsNiArMjQs
NyBAQAogCiAvKiAjZGVmaW5lIFJNSF9ERUJVRyAxICovCiAKKyNpbmNsdWRlIDxsaW51eC9iaXRv
cHMuaD4KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KICNpbmNsdWRlIDxsaW51eC9wY2kuaD4K
ICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgpAQCAtOTY2LDkgKzk2Nyw5IEBAIGludCBseF9sZXZl
bF9wZWFrcyhzdHJ1Y3QgbHg2NDY0ZXMgKmNoaXAsIGludCBpc19jYXB0dXJlLCBpbnQgY2hhbm5l
bHMsCiAKIC8qIGludGVycnVwdCBoYW5kbGluZyAqLwogI2RlZmluZSBQQ1hfSVJRX05PTkUgMAot
I2RlZmluZSBJUlFDU19BQ1RJVkVfUENJREIgIDB4MDAwMDIwMDBMICAgICAgICAgLyogQml0IG7D
g8KDw4LCuCAxMyAqLwotI2RlZmluZSBJUlFDU19FTkFCTEVfUENJSVJRIDB4MDAwMDAxMDBMICAg
ICAgICAgLyogQml0IG7Dg8KDw4LCuCAwOCAqLwotI2RlZmluZSBJUlFDU19FTkFCTEVfUENJREIg
IDB4MDAwMDAyMDBMICAgICAgICAgLyogQml0IG7Dg8KDw4LCuCAwOSAqLworI2RlZmluZSBJUlFD
U19BQ1RJVkVfUENJREIJQklUKDEzKQorI2RlZmluZSBJUlFDU19FTkFCTEVfUENJSVJRCUJJVCg4
KQorI2RlZmluZSBJUlFDU19FTkFCTEVfUENJREIJQklUKDkpCiAKIHN0YXRpYyB1MzIgbHhfaW50
ZXJydXB0X3Rlc3RfYWNrKHN0cnVjdCBseDY0NjRlcyAqY2hpcCkKIHsKLS0gCjEuOS4xCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1h
aWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxz
YS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
