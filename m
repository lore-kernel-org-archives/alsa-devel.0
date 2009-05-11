From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] pxa2xx-ac97: fix reset gpio mode setting
Date: Mon, 11 May 2009 18:51:14 +0800
Message-ID: <f17812d70905110351w6b5250fcqd19590afbc42011e@mail.gmail.com>
References: <1242036698-29136-1-git-send-email-mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 26F9B24776
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 12:51:16 +0200 (CEST)
Received: by qyk1 with SMTP id 1so3838588qyk.16
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2009 03:51:15 -0700 (PDT)
In-Reply-To: <1242036698-29136-1-git-send-email-mike@compulab.co.il>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: alsa-devel@alsa-project.org, eric.miao@marvell.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBNYXkgMTEsIDIwMDkgYXQgNjoxMSBQTSwgTWlrZSBSYXBvcG9ydCA8bWlrZUBjb21w
dWxhYi5jby5pbD4gd3JvdGU6Cj4gU2lnbmVkLW9mZi1ieTogTWlrZSBSYXBvcG9ydCA8bWlrZUBj
b21wdWxhYi5jby5pbD4KCkFja2VkLWJ5OiBFcmljIE1pYW8gPGVyaWMubWlhb0BtYXJ2ZWxsLmNv
bT4KCkp1c3QgY3VyaW91cywgdGhpcyBkaWRuJ3QgY2F1c2UgYW55IGlzc3VlIGluIHRoZSBwYXN0
IDopCgo+IC0tLQo+IMKgc291bmQvYXJtL3B4YTJ4eC1hYzk3LWxpYi5jIHwgwqAgwqAyICstCj4g
wqAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9zb3VuZC9hcm0vcHhhMnh4LWFjOTctbGliLmMgYi9zb3VuZC9hcm0vcHhhMnh4
LWFjOTctbGliLmMKPiBpbmRleCBhMmMxMmQxLi42ZmRjYTk3IDEwMDY0NAo+IC0tLSBhL3NvdW5k
L2FybS9weGEyeHgtYWM5Ny1saWIuYwo+ICsrKyBiL3NvdW5kL2FybS9weGEyeHgtYWM5Ny1saWIu
Ywo+IEBAIC02NSw3ICs2NSw3IEBAIHN0YXRpYyB2b2lkIHNldF9yZXNldGdwaW9fbW9kZShpbnQg
cmVzZXRncGlvX2FjdGlvbikKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN3aXRjaCAocmVzZXRn
cGlvX2FjdGlvbikgewo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBSRVNFVEdQSU9fTk9S
TUFMX0FMVEZVTkM6Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocmVz
ZXRfZ3BpbyA9PSAxMTMpCj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBtb2RlID0gMTEzIHwgR1BJT19PVVQgfCBHUElPX0RGTFRfTE9XOwo+ICsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbW9kZSA9IDExMyB8IEdQSU9f
QUxUX0ZOXzJfT1VUOwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJl
c2V0X2dwaW8gPT0gOTUpCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBtb2RlID0gOTUgfCBHUElPX0FMVF9GTl8xX09VVDsKPiDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOwo+IC0tCj4gMS41LjYuNAo+Cj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBBbHNhLWRldmVsIG1haWxpbmcg
bGlzdAo+IEFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwo+IGh0dHA6Ly9tYWlsbWFuLmFsc2Et
cHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCj4KCgoKLS0gCkNoZWVycwot
IGVyaWMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
