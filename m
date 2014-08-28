From: Paul Handrigan <Paul.Handrigan@cirrus.com>
Subject: [PATCH 2/3] Fix clock rates in clock map table.
Date: Thu, 28 Aug 2014 10:54:09 -0500
Message-ID: <1409241250-22097-2-git-send-email-Paul.Handrigan@cirrus.com>
References: <1409241250-22097-1-git-send-email-Paul.Handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0183.outbound.protection.outlook.com [207.46.163.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CB9B2664E3
 for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2014 17:54:40 +0200 (CEST)
In-Reply-To: <1409241250-22097-1-git-send-email-Paul.Handrigan@cirrus.com>
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
Cc: brian.austin@cirrus.com, broonie@kernel.org, lgirdwood@gmail.com, Paul Handrigan <Paul.Handrigan@cirrus.com>, zoltan@raspberrypi.org
List-Id: alsa-devel@alsa-project.org

UmVwb3J0ZWQtYnk6IFpvbHTDoW4gU3plbmN6aSA8em9sdGFuQHJhc3BiZXJyeXBpLm9yZz4KU2ln
bmVkLW9mZi1ieTogUGF1bCBIYW5kcmlnYW4gPFBhdWwuSGFuZHJpZ2FuQGNpcnJ1cy5jb20+Ci0t
LQogc291bmQvc29jL2NvZGVjcy9jczQyNjUuYyB8IDggKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29j
L2NvZGVjcy9jczQyNjUuYyBiL3NvdW5kL3NvYy9jb2RlY3MvY3M0MjY1LmMKaW5kZXggMmRhZDE1
YS4uYzMxZDI5ZCAxMDA2NDQKLS0tIGEvc291bmQvc29jL2NvZGVjcy9jczQyNjUuYworKysgYi9z
b3VuZC9zb2MvY29kZWNzL2NzNDI2NS5jCkBAIC0yODMsMTAgKzI4MywxMCBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGNzNDI2NV9jbGtfcGFyYSBjbGtfbWFwX3RhYmxlW10gPSB7CiAKIAkvKjY0ayov
CiAJezgxOTIwMDAsIDY0MDAwLCAxLCAwfSwKLQl7MTIyODgwMCwgNjQwMDAsIDEsIDF9LAotCXsx
NjkzNDQwLCA2NDAwMCwgMSwgMn0sCi0JezI0NTc2MDAsIDY0MDAwLCAxLCAzfSwKLQl7MzI3Njgw
MCwgNjQwMDAsIDEsIDR9LAorCXsxMjI4ODAwMCwgNjQwMDAsIDEsIDF9LAorCXsxNjkzNDQwMCwg
NjQwMDAsIDEsIDJ9LAorCXsyNDU3NjAwMCwgNjQwMDAsIDEsIDN9LAorCXszMjc2ODAwMCwgNjQw
MDAsIDEsIDR9LAogCiAJLyogODguMmsgKi8KIAl7MTEyODk2MDAsIDg4MjAwLCAxLCAwfSwKLS0g
CjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
