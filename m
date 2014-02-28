From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 07/11] ASoC: mc13783: Use
	SOC_ENUM_SINGLE_VIRT_DECL()
Date: Fri, 28 Feb 2014 08:31:08 +0100
Message-ID: <1393572672-13937-8-git-send-email-lars@metafoo.de>
References: <1393572672-13937-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id 37BF926591D
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 08:30:55 +0100 (CET)
In-Reply-To: <1393572672-13937-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Rm9yIHRoZSB1cGNvbWluZyBjb25zb2xpZGF0aW9uIGZvciBNVVhzIGFuZCB2aXJ0dWFsIE1VWHMg
d2UgbmVlZCB0byBtYXJrIHZpcnR1YWwKZW51bXMgYXMgc3VjaC4KClNpZ25lZC1vZmYtYnk6IExh
cnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPgpUZXN0ZWQtYnk6IFBoaWxpcHBlIFLD
qXRvcm5heiA8cGhpbGlwcGUucmV0b3JuYXpAZXBmbC5jaD4KLS0tCk5vIGNoYW5nZXMgc2luY2Ug
djEKLS0tCiBzb3VuZC9zb2MvY29kZWNzL21jMTM3ODMuYyB8IDYgKystLS0tCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5k
L3NvYy9jb2RlY3MvbWMxMzc4My5jIGIvc291bmQvc29jL2NvZGVjcy9tYzEzNzgzLmMKaW5kZXgg
YzYwNTAzNi4uZWM4OWI4ZiAxMDA2NDQKLS0tIGEvc291bmQvc29jL2NvZGVjcy9tYzEzNzgzLmMK
KysrIGIvc291bmQvc29jL2NvZGVjcy9tYzEzNzgzLmMKQEAgLTQwOCw4ICs0MDgsNyBAQCBzdGF0
aWMgY29uc3QgY2hhciAqIGNvbnN0IGFkY2xfZW51bV90ZXh0W10gPSB7CiAJIk1DMUwiLCAiUlhJ
TkwiLAogfTsKIAotc3RhdGljIFNPQ19FTlVNX1NJTkdMRV9ERUNMKGFkY2xfZW51bSwKLQkJCSAg
ICAwLCAwLCBhZGNsX2VudW1fdGV4dCk7CitzdGF0aWMgU09DX0VOVU1fU0lOR0xFX1ZJUlRfREVD
TChhZGNsX2VudW0sIGFkY2xfZW51bV90ZXh0KTsKIAogc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRf
a2NvbnRyb2xfbmV3IGxlZnRfaW5wdXRfbXV4ID0KIAlTT0NfREFQTV9FTlVNX1ZJUlQoIlJvdXRl
IiwgYWRjbF9lbnVtKTsKQEAgLTQxOCw4ICs0MTcsNyBAQCBzdGF0aWMgY29uc3QgY2hhciAqIGNv
bnN0IGFkY3JfZW51bV90ZXh0W10gPSB7CiAJIk1DMVIiLCAiTUMyIiwgIlJYSU5SIiwgIlRYSU4i
LAogfTsKIAotc3RhdGljIFNPQ19FTlVNX1NJTkdMRV9ERUNMKGFkY3JfZW51bSwKLQkJCSAgICAw
LCAwLCBhZGNyX2VudW1fdGV4dCk7CitzdGF0aWMgU09DX0VOVU1fU0lOR0xFX1ZJUlRfREVDTChh
ZGNyX2VudW0sIGFkY3JfZW51bV90ZXh0KTsKIAogc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfa2Nv
bnRyb2xfbmV3IHJpZ2h0X2lucHV0X211eCA9CiAJU09DX0RBUE1fRU5VTV9WSVJUKCJSb3V0ZSIs
IGFkY3JfZW51bSk7Ci0tIAoxLjguMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
