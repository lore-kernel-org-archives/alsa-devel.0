From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/6] ASoC: dapm: If one widget fails,
 do not force all subsequent widgets to fail too
Date: Thu, 2 Aug 2012 13:21:03 +0100
Message-ID: <20120802122101.GA22228@gmail.com>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-3-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id D9DBD265202
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2012 14:21:04 +0200 (CEST)
Received: by eeke50 with SMTP id e50so1884424eek.38
 for <alsa-devel@alsa-project.org>; Thu, 02 Aug 2012 05:21:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343741493-17671-3-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

UGF0Y2ggd2l0aGRyYXduLgoKT24gVHVlLCBKdWwgMzEsIDIwMTIgYXQgMDI6MzE6MjNQTSArMDEw
MCwgTGVlIEpvbmVzIHdyb3RlOgo+IElmIGEgbGlzdCBvZiB3aWRnZXRzIGlzIHByb3ZpZGVkIGFu
ZCBvbmUgb2YgdGhlbSBmYWlscyB0byBiZSBhZGRlZCBhcwo+IGEgY29udHJvbCwgdGhlIHByZXNl
bnQgc2VtYW50aWNzIGZhaWwgYWxsIHN1YnNlcXVlbnQgd2lkZ2V0cy4gQSBiZXR0ZXIKPiBzb2x1
dGlvbiB3b3VsZCBiZSB0byBvbmx5IGZhaWwgdGhhdCB3aWRnZXQsIGJ1dCBwdXJzdWUgaW4gYXR0
ZW1wdGluZwo+IHRvIGFkZCB0aGUgcmVzdCBvZiB0aGUgbGlzdC4KPiAKPiBTaWduZWQtb2ZmLWJ5
OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+IC0tLQo+ICBzb3VuZC9zb2Mvc29j
LWRhcG0uYyB8ICAgIDIgLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9zb2MtZGFwbS5jIGIvc291bmQvc29jL3NvYy1kYXBtLmMK
PiBpbmRleCBlZGVkNjU3Li43ZDljMTU0IDEwMDY0NAo+IC0tLSBhL3NvdW5kL3NvYy9zb2MtZGFw
bS5jCj4gKysrIGIvc291bmQvc29jL3NvYy1kYXBtLmMKPiBAQCAtMzA5NSw4ICszMDk1LDYgQEAg
aW50IHNuZF9zb2NfZGFwbV9uZXdfY29udHJvbHMoc3RydWN0IHNuZF9zb2NfZGFwbV9jb250ZXh0
ICpkYXBtLAo+ICAJCQlkZXZfZXJyKGRhcG0tPmRldiwKPiAgCQkJCSJBU29DOiBGYWlsZWQgdG8g
Y3JlYXRlIERBUE0gY29udHJvbCAlc1xuIiwKPiAgCQkJCXdpZGdldC0+bmFtZSk7Cj4gLQkJCXJl
dCA9IC1FTk9NRU07Cj4gLQkJCWJyZWFrOwo+ICAJCX0KPiAgCQl3aWRnZXQrKzsKPiAgCX0KPiAt
LSAKPiAxLjcuOS41Cj4gCgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVC1Fcmljc3NvbiBMYW5kaW5n
IFRlYW0gTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNv
Q3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
