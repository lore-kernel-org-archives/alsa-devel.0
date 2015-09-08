From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH lib 2/5] topology: ctl: Fix access type checks
Date: Tue,  8 Sep 2015 22:21:38 +0200
Message-ID: <1441743701-28165-3-git-send-email-tiwai@suse.de>
References: <1441743701-28165-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D595C265114
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2015 22:21:44 +0200 (CEST)
In-Reply-To: <1441743701-28165-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

Rml4IHRoZSB3cm9uZyBiaXQtYW5kIGNoZWNrIGJ5IGFkZGluZyBwYXJlbnRoZXNlcyBwcm9wZXJs
eToKICBjdGwuYzogSW4gZnVuY3Rpb24g4oCYdHBsZ19hZGRfYnl0ZXPigJk6CiAgY3RsLmM6ODY4
OjIyOiB3YXJuaW5nOiBzdWdnZXN0IHBhcmVudGhlc2VzIGFyb3VuZCBjb21wYXJpc29uIGluIG9w
ZXJhbmQgb2Yg4oCYJuKAmSBbLVdwYXJlbnRoZXNlc10KICAgICBpZiAoYmUtPmhkci5hY2Nlc3Mg
JiBTTkRSVl9DVExfRUxFTV9BQ0NFU1NfVExWX1JFQURXUklURQogICAgICAgICAgICAgICAgICAg
ICAgICBeCgpTaWduZWQtb2ZmLWJ5OiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+Ci0tLQog
c3JjL3RvcG9sb2d5L2N0bC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL3RvcG9sb2d5L2N0bC5jIGIvc3JjL3Rv
cG9sb2d5L2N0bC5jCmluZGV4IDY4YzRjZTU4MDNkMS4uN2Q4Nzg3ZjM0N2I4IDEwMDY0NAotLS0g
YS9zcmMvdG9wb2xvZ3kvY3RsLmMKKysrIGIvc3JjL3RvcG9sb2d5L2N0bC5jCkBAIC04NjUsNyAr
ODY1LDcgQEAgaW50IHRwbGdfYWRkX2J5dGVzKHNuZF90cGxnX3QgKnRwbGcsIHN0cnVjdCBzbmRf
dHBsZ19ieXRlc190ZW1wbGF0ZSAqYnl0ZXNfY3RsLAogCiAJLyogY2hlY2sgb24gVExWIGJ5dGVz
IGNvbnRyb2wgKi8KIAlpZiAoYmUtPmhkci5hY2Nlc3MgJiBTTkRSVl9DVExfRUxFTV9BQ0NFU1Nf
VExWX0NBTExCQUNLKSB7Ci0JCWlmIChiZS0+aGRyLmFjY2VzcyAmIFNORFJWX0NUTF9FTEVNX0FD
Q0VTU19UTFZfUkVBRFdSSVRFCisJCWlmICgoYmUtPmhkci5hY2Nlc3MgJiBTTkRSVl9DVExfRUxF
TV9BQ0NFU1NfVExWX1JFQURXUklURSkKIAkJCSE9IFNORFJWX0NUTF9FTEVNX0FDQ0VTU19UTFZf
UkVBRFdSSVRFKSB7CiAJCQlTTkRFUlIoImVycm9yOiBJbnZhbGlkIFRMViBieXRlcyBjb250cm9s
IGFjY2VzcyAweCV4XG4iLAogCQkJCWJlLT5oZHIuYWNjZXNzKTsKLS0gCjIuNS4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
