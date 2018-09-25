From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH 1/5] ASoC: dt-bindings: add max98088 audio codec
Date: Tue, 25 Sep 2018 16:23:48 +0200
Message-ID: <20180925142352.24106-2-m.felsch@pengutronix.de>
References: <20180925142352.24106-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id F03E72678AB
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2018 16:24:18 +0200 (CEST)
In-Reply-To: <20180925142352.24106-1-m.felsch@pengutronix.de>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

RnJvbTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgoKVGhpcyBwYXRjaCBhZGRz
IHRoZSBiaW5kaW5ncyBmb3IgbWF4aW0gbWF4OTgwODgvOSBhdWRpbyBjb2RlYy4KClNpZ25lZC1v
ZmYtYnk6IEFuZHJlYXMgRsOkcmJlciA8YWZhZXJiZXJAc3VzZS5kZT4KW20uZmVsc2NoQHBlbmd1
dHJvbml4LmRlOiBhZGFwdCBjb21taXQgbWVzc2FnZV0KW20uZmVsc2NoQHBlbmd1dHJvbml4LmRl
OiBhZGFwdCBmb3JtYXR0aW5nXQpTaWduZWQtb2ZmLWJ5OiBNYXJjbyBGZWxzY2ggPG0uZmVsc2No
QHBlbmd1dHJvbml4LmRlPgotLS0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL21heGlt
LG1heDk4MDg4LnR4dCAgfCAxNSArKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNSBp
bnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NvdW5kL21heGltLG1heDk4MDg4LnR4dAoKZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tYXhpbSxtYXg5ODA4OC50eHQgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWF4aW0sbWF4OTgwODgudHh0Cm5l
dyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uYTc5YWQ1YzdhZjg4Ci0tLSAv
ZGV2L251bGwKKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL21h
eGltLG1heDk4MDg4LnR4dApAQCAtMCwwICsxLDE1IEBACitNQVg5ODA4OCBhdWRpbyBDT0RFQwor
CitUaGlzIGRldmljZSBzdXBwb3J0cyBJMkMgb25seS4KKworUmVxdWlyZWQgcHJvcGVydGllczoK
KworLSBjb21wYXRpYmxlOiAibWF4aW0sbWF4OTgwODgiIG9yICJtYXhpbSxtYXg5ODA4OSIuCist
IHJlZzogVGhlIEkyQyBhZGRyZXNzIG9mIHRoZSBkZXZpY2UuCisKK0V4YW1wbGU6CisKK21heDk4
MDg5OiBjb2RlY0AxMCB7CisJY29tcGF0aWJsZSA9ICJtYXhpbSxtYXg5ODA4OSI7CisJcmVnID0g
PDB4MTA+OworfTsKLS0gCjIuMTkuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
