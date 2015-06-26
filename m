From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: jack: Fix endless loop at unique index
	detection
Date: Fri, 26 Jun 2015 07:04:26 +0200
Message-ID: <1435295066-6297-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3306B26071B
 for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2015 07:04:29 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 68E48ABA5
 for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2015 05:04:28 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

V2hpbGUgdGhlIGNvbW1pdCBbZDBhNjAxYzI3OGRlOiBBTFNBOiBqYWNrOiBGaXggdGhlIGlkIHVu
aXF1ZW5lc3MKY2hlY2tdIGZpeGVzIHRoZSB3cm9uZyBzdHJpbmcgY2hlY2ssIGl0IGxlYWRzIHRv
IGEgd29yc2UgcmVzdWx0IC0tIHRoZQpsb29wIGluIGdldF9hdmFpbGFibGVfaW5kZXgoKSBnb2Vz
IGludG8gYW4gZW5kbGVzcyBsb29wLiAgVGhlIGNhdXNlIGlzCnRoYXQgc25kX2N0bF9maW5kX2lk
KCkgcmV0dXJucyB0aGUgb2JqZWN0IGFzc2lnbmVkIHRvIHRoZSBudW1pZCBpZgppdCdzIHNldC4g
IFRodXMgaXQgcG9pbnRzIHRvIHRoZSBwcmV2aW91cyBlbnRyeSBhZ2Fpbi4KClRoaXMgcGF0Y2gg
Y2xlYXJzIHRoZSBudW1pZCBmaWVsZCBmb3IgdGhlIG5leHQgY2FsbCBwcm9wZXJseS4KClJlcG9y
dGVkLWFuZC10ZXN0ZWQtYnk6IFRvbcOhxaEgUHJ1xb5pbmEgPHBydXppbmF0QGdtYWlsLmNvbT4K
U2lnbmVkLW9mZi1ieTogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPgotLS0KIHNvdW5kL2Nv
cmUvY3RsamFjay5jIHwgNSArKysrLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL2NvcmUvY3RsamFjay5jIGIvc291bmQv
Y29yZS9jdGxqYWNrLmMKaW5kZXggOTE0OWE0YWVmYTk1Li44NGEzY2Q2ODMwNjggMTAwNjQ0Ci0t
LSBhL3NvdW5kL2NvcmUvY3RsamFjay5jCisrKyBiL3NvdW5kL2NvcmUvY3RsamFjay5jCkBAIC00
MSw4ICs0MSwxMSBAQCBzdGF0aWMgaW50IGdldF9hdmFpbGFibGVfaW5kZXgoc3RydWN0IHNuZF9j
YXJkICpjYXJkLCBjb25zdCBjaGFyICpuYW1lKQogCXNpZC5pZmFjZSA9IFNORFJWX0NUTF9FTEVN
X0lGQUNFX0NBUkQ7CiAJc3RybGNweShzaWQubmFtZSwgbmFtZSwgc2l6ZW9mKHNpZC5uYW1lKSk7
CiAKLQl3aGlsZSAoc25kX2N0bF9maW5kX2lkKGNhcmQsICZzaWQpKQorCXdoaWxlIChzbmRfY3Rs
X2ZpbmRfaWQoY2FyZCwgJnNpZCkpIHsKIAkJc2lkLmluZGV4Kys7CisJCS8qIHJlc2V0IG51bWlk
OyBvdGhlcndpc2Ugc25kX2N0bF9maW5kX2lkKCkgaGl0cyB0aGlzIGFnYWluICovCisJCXNpZC5u
dW1pZCA9IDA7CisJfQogCiAJcmV0dXJuIHNpZC5pbmRleDsKIH0KLS0gCjIuNC40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
