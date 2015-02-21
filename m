From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-lib: fix an unexpected byte
	sequence for micro sign
Date: Sat, 21 Feb 2015 11:50:17 +0900
Message-ID: <1424487017-24434-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CC9C261504
 for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2015 03:50:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

VGhlIHNpZ24gZm9yIG1pY3Jvc2Vjb25kIChVKzAwODUsIE1JQ1JPIFNJR04pIHdhcyBlbmNvZGVk
IHRvICcweCBjMiBiNScKYnkgVVRGLTggY2hhcmFjdGVyIGVuY29kaW5nIHNjaGVtZS4gQnV0IHRo
ZSBieXRlIHNlcXVlbmNlIHdhcyBjb252ZXJ0ZWQKdG8gJzB4IGMzIDgyIGMyIGI1JyBpbiBhIHBy
ZXZpb3VzIGNvbW1pdC4gQXMgYSByZXN1bHQsIHRoZSBieXRlCnNlcXVlbmNlIGNhbm5vdCByZXBy
ZXNlbnQgbWljcm9zZWNvbmQgc2lnbiBpbiBVVEYtOCBvciBBU0NJSS4gVGhpcwptYXkgY29uZnVz
ZSBkZXZlbG9wZXJzLgoKVGhpcyBjb21taXQgcmVwbGFjZXMgdGhlIHNpZ24gdG8gc3RyaW5nIGV4
cHJlc3Npb24gd2l0aCAnbWljcm9zZWNvbmRzJwp0byBwdXJnZSBzdXBlcmZsdW91cyB0cm91Ymxl
cy4KCkZpeGVzOiA1YzY5N2U1YjQ2ZWYoIkFMU0E6IGZpcmV3aXJlLWxpYjogcmVtb3ZlIHJ4X2Js
b2Nrc19mb3JfbWlkaSBxdWlyayIpClNpZ25lZC1vZmYtYnk6IFRha2FzaGkgU2FrYW1vdG8gPG8t
dGFrYXNoaUBzYWthbW9jY2hpLmpwPgotLS0KIHNvdW5kL2ZpcmV3aXJlL2FtZHRwLmMgfCAyICst
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9zb3VuZC9maXJld2lyZS9hbWR0cC5jIGIvc291bmQvZmlyZXdpcmUvYW1kdHAuYwppbmRl
eCAwZDU4MDE4Li43YjdiMTgzIDEwMDY0NAotLS0gYS9zb3VuZC9maXJld2lyZS9hbWR0cC5jCisr
KyBiL3NvdW5kL2ZpcmV3aXJlL2FtZHRwLmMKQEAgLTMzLDcgKzMzLDcgQEAKICAqLwogI2RlZmlu
ZSBNQVhfTUlESV9SWF9CTE9DS1MJOAogCi0jZGVmaW5lIFRSQU5TRkVSX0RFTEFZX1RJQ0tTCTB4
MmUwMCAvKiA0NzkuMTcgw4LCtXMgKi8KKyNkZWZpbmUgVFJBTlNGRVJfREVMQVlfVElDS1MJMHgy
ZTAwIC8qIDQ3OS4xNyBtaWNyb3NlY29uZHMgKi8KIAogLyogaXNvY2hyb25vdXMgaGVhZGVyIHBh
cmFtZXRlcnMgKi8KICNkZWZpbmUgSVNPX0RBVEFfTEVOR1RIX1NISUZUCTE2Ci0tIAoyLjEuMAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
