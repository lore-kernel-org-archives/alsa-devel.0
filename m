From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 08/20] ASoC: S3C64XX: I2S: Move RATE and
	FMT defines to header
Date: Wed, 10 Mar 2010 21:52:49 +0900
Message-ID: <1b68c6791003100452j69b003fk42815adf06a85aa9@mail.gmail.com>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-3-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-4-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-5-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-6-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-7-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-8-git-send-email-jassi.brar@samsung.com>
	<20100310105109.GG24422@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B7EE1038F1
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 13:52:50 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 4so474583qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 04:52:50 -0800 (PST)
In-Reply-To: <20100310105109.GG24422@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBNYXIgMTAsIDIwMTAgYXQgNzo1MSBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFdlZCwgTWFyIDEwLCAyMDEwIGF0
IDA0OjQ4OjU3UE0gKzA5MDAsIEphc3NpIEJyYXIgd3JvdGU6Cj4+IEluIG9yZGVyIGZvciB0aGUg
UkFURSBhbmQgRk1UIGRlZmluZXMgdG8gYmUgcmV1c2VhYmxlIGluIGZ1dHVyZSBieSB0aGUKPj4g
aTJzdjQgZHJpdmVyLCBtb3ZlIHRoZSBNQUNST3Mgb3V0IHRvIHRoZSBoZWFkZXIgZmlsZS4KPgo+
IEknbGwgYXBwbHkgdGhpcyBidXQgZm9yIHRoZSByYXRlcy4uLgo+Cj4+IC0jZGVmaW5lIFMzQzY0
WFhfSTJTX1JBVEVTIFwKPj4gLSDCoCDCoCAoU05EUlZfUENNX1JBVEVfODAwMCB8IFNORFJWX1BD
TV9SQVRFXzExMDI1IHwgU05EUlZfUENNX1JBVEVfMTYwMDAgfCBcCj4+IC0gwqAgwqAgU05EUlZf
UENNX1JBVEVfMjIwNTAgfCBTTkRSVl9QQ01fUkFURV8zMjAwMCB8IFNORFJWX1BDTV9SQVRFXzQ0
MTAwIHwgXAo+PiAtIMKgIMKgIFNORFJWX1BDTV9SQVRFXzQ4MDAwIHwgU05EUlZfUENNX1JBVEVf
ODgyMDAgfCBTTkRSVl9QQ01fUkFURV85NjAwMCkKPgo+IFRoaXMgaXMganVzdCBTTkRSVl9QQ01f
UkFURV84MDAwXzk2MDAwIGFueXdheSBzbyBtYXkgYXMgd2VsbCB1c2UgaXQKPiBkaXJlY3RseS4K
T2YgY291cnNlLgpCdHcsIEkgd2FzIHRoaW5raW5nIG9mIGFkZGluZyBSQVRFX0tOT1QgdG9vLCBh
cyBpdCBpcyB1c3VhbGx5IHBvc3NpYmxlCnRvIGFjaGlldmUKJ25vdCBzbyBzdGFuZGFyZCcgMTIw
MDAgYW5kIDI0MDAwIHJhdGVzLCBiZXNpZGVzIHRoZSBmbGFnIGRvZXNuJ3QKJ3Byb21pc2UnIGFu
eXRoaW5nCmFib3V0IGF2YWlsYWJpbGl0eSBvZiByYXRlcy4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
