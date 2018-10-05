From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH v2 0/5] MAX98088/9 of features
Date: Fri,  5 Oct 2018 09:58:07 +0200
Message-ID: <20181005075812.13986-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 5284D267909
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 09:58:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

SGksCgp0aGlzIHRoZSB2MiB3aXRoIHRoZSBpbnRlZ3JhdGVkIHJldmlldyBmcm9tIHRoZSB2MSBb
MV0uCgpJIHBpY2tlZCB1cCB0aGUgbWF4OTgwODggcGF0Y2hlcyBmcm9tIEFuZHJlYXMgc2VyaWVz
IFsyXSBhbmQgcG9ydGVkIHRoZW0KdG8gdGhlIG5ldyBrZXJuZWwuCgpSZWdhcmRzLApNYXJjbwoK
WzFdIGh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvcGlwZXJtYWlsL2Fsc2EtZGV2ZWwv
IFwKICAgIDIwMTgtU2VwdGVtYmVyLzE0MDUwMS5odG1sClsyXSBodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9waXBlcm1haWwvbGludXgtYXJtLWtlcm5lbC8gXAogICAgMjAxNS1GZWJydWFyeS8z
MjQ0NDAuaHRtbAoKQ2hhbmdlczoKCnYyOgogLSBtYWtlIG1hc3RlciBjbG9jayBvcHRpb25hbAog
LSBiZSBtb3JlIHZlcmJvc2UgaW4gY29tbWl0IG1lc3NhZ2VzCgpBbmRyZWFzIEbDpHJiZXIgKDMp
OgogIEFTb0M6IGR0LWJpbmRpbmdzOiBhZGQgbWF4OTgwODggYXVkaW8gY29kZWMKICBBU29DOiBt
YXg5ODA4ODogYWRkIE9GIHN1cHBvcnQKICBBU29DOiBtYXg5ODA4ODogQWRkIG1hc3RlciBjbG9j
ayBoYW5kbGluZwoKTWFyY28gRmVsc2NoICgyKToKICBBU29DOiBkdC1iaW5kaW5nczogbWF4OTgw
ODg6IGFkZCBleHRlcm5hbCBjbG9jayBiaW5kaW5nCiAgQVNvQzogbWF4OTg5ODg6IG1ha2UgaXQg
c2VsZWN0YWJsZQoKIC4uLi9iaW5kaW5ncy9zb3VuZC9tYXhpbSxtYXg5ODA4OC50eHQgICAgICAg
ICB8IDIzICsrKysrKysrKysrKwogc291bmQvc29jL2NvZGVjcy9LY29uZmlnICAgICAgICAgICAg
ICAgICAgICAgIHwgIDIgKy0KIHNvdW5kL3NvYy9jb2RlY3MvbWF4OTgwODguYyAgICAgICAgICAg
ICAgICAgICB8IDM2ICsrKysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgNjAgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tYXhpbSxtYXg5ODA4OC50eHQKCi0tIAoyLjE5
LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
