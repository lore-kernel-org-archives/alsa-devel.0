From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Add mute-LED mode control to
	Thinkpad
Date: Mon, 27 Apr 2015 10:51:00 +0200
Message-ID: <1430124660-674-2-git-send-email-tiwai@suse.de>
References: <1430124660-674-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EC972650C0
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 10:51:02 +0200 (CEST)
In-Reply-To: <1430124660-674-1-git-send-email-tiwai@suse.de>
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
Cc: David Henningsson <david.henningsson@canonical.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: alsa-devel@alsa-project.org

VGhpcyBwYXRjaCBhZGRzIHRoZSBtaXNzaW5nIGZsYWcgdG8gZW5hYmxlICJNdXRlLUxFRCBNb2Rl
IiBtaXhlciBlbnVtCmN0bCBmb3IgVGhpbmtwYWRzIHRoYXQgaGF2ZSBhbHNvIHRoZSBzb2Z0d2Fy
ZSBtdXRlLUxFRCBjb250cm9sLgoKUmVwb3J0ZWQtYW5kLXRlc3RlZC1ieTogUGFsaSBSb2jDoXIg
PHBhbGkucm9oYXJAZ21haWwuY29tPgpDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ClNpZ25l
ZC1vZmYtYnk6IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4KLS0tCiBzb3VuZC9wY2kvaGRh
L3RoaW5rcGFkX2hlbHBlci5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykK
CmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL3RoaW5rcGFkX2hlbHBlci5jIGIvc291bmQvcGNp
L2hkYS90aGlua3BhZF9oZWxwZXIuYwppbmRleCAwYTRhZDVmZWI4MmUuLmQ1MTcwM2UzMDUyMyAx
MDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS90aGlua3BhZF9oZWxwZXIuYworKysgYi9zb3VuZC9w
Y2kvaGRhL3RoaW5rcGFkX2hlbHBlci5jCkBAIC03Miw2ICs3Miw3IEBAIHN0YXRpYyB2b2lkIGhk
YV9maXh1cF90aGlua3BhZF9hY3BpKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLAogCQlpZiAobGVk
X3NldF9mdW5jKFRQQUNQSV9MRURfTVVURSwgZmFsc2UpID49IDApIHsKIAkJCW9sZF92bWFzdGVy
X2hvb2sgPSBzcGVjLT52bWFzdGVyX211dGUuaG9vazsKIAkJCXNwZWMtPnZtYXN0ZXJfbXV0ZS5o
b29rID0gdXBkYXRlX3RwYWNwaV9tdXRlX2xlZDsKKwkJCXNwZWMtPnZtYXN0ZXJfbXV0ZV9lbnVt
ID0gMTsKIAkJCXJlbW92ZWZ1bmMgPSBmYWxzZTsKIAkJfQogCQlpZiAobGVkX3NldF9mdW5jKFRQ
QUNQSV9MRURfTUlDTVVURSwgZmFsc2UpID49IDApIHsKLS0gCjIuMy41CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
