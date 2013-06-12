From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/3] DMA fixes for ux500 ASoC driver
Date: Wed, 12 Jun 2013 11:48:52 +0100
Message-ID: <20130612104852.GD4320@laptop>
References: <1371023879-21884-1-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id D1DB42615A6
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 12:48:57 +0200 (CEST)
Received: by mail-bk0-f48.google.com with SMTP id jf17so4429129bkc.7
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 03:48:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1371023879-21884-1-git-send-email-fabio.baltieri@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCAxMiBKdW4gMjAxMywgRmFiaW8gQmFsdGllcmkgd3JvdGU6Cgo+IEhpIE1hcmssCj4g
Cj4gVGhlIERNQSBkcml2ZXIgdXNlZCBvbiB1eDUwMCBoYXMgYmVlbiByZWNlbnRseSByZXdvcmtl
ZCB0byBtYWtlIGl0Cj4gZGV2aWNlLXRyZWUgY2FwYWJsZSwgYnV0IHRoZSByZXdvcmsgcmVxdWly
ZWQgdG8gZHJvcCBzb21lICJmZWF0dXJlcyIsCj4gc3VjaCBhcyBvcHBvcnR1bmlzdGljIGNoYW5u
ZWwgYWxsb2NhdGlvbiBhbmQgaGFyZGNvZGVkIGFkZHJlc3NlcywgdGhhdAo+IHRoZSBBU29DIGRy
aXZlciB3YXMgcmVseWluZyB1cG9uLgo+IAo+IFRoaXMgc2VyaWVzIGZpeGVzIHRoZSBhdWRpbyBk
cml2ZXIgdG8gbWFrZSBpdCB3b3JrIHdpdGggdGhlIGN1cnJlbnQKPiBkbWE0MCBpbXBsZW1lbnRh
dGlvbiwgYW5kIHdvcmtzIGZpbmUgZXZlbiB3aGVuIGJvb3Rpbmcgd2l0aCBkZXZpY2UtdHJlZS4K
PiAKPiBXb3VsZCB5b3UgY29uc2lkZXIgbWVyZ2luZyB0aGVzZSBmb3IgYXNvYy90b3BpYy91eDUw
MD8KPiAKPiBUaGFua3MsCj4gRmFiaW8KPiAKPiAKPiBGYWJpbyBCYWx0aWVyaSAoMyk6Cj4gICBB
U29DOiB1eDUwMDogTW92ZSBETUEgcGFyYW1ldGVycyBpbnRvIHV4NTAwX21zcAo+ICAgQVNvQzog
dXg1MDA6IFNldCBETUEgYWRkcmVzcyBkdXJpbmcgZGV2aWNlIGluaXQKPiAgIEFTb0M6IHV4NTAw
OiBBZGQgRE1BIHNsYXZlIGNvbmZpZyBwcmVwYXJlIHJvdXRpbmUKPiAKPiAgc291bmQvc29jL3V4
NTAwL3V4NTAwX21zcF9kYWkuYyB8IDExICsrKystLS0tLS0tCj4gIHNvdW5kL3NvYy91eDUwMC91
eDUwMF9tc3BfZGFpLmggfCAgMiAtLQo+ICBzb3VuZC9zb2MvdXg1MDAvdXg1MDBfbXNwX2kycy5j
IHwgMTMgKysrKysrKysrLS0tLQo+ICBzb3VuZC9zb2MvdXg1MDAvdXg1MDBfbXNwX2kycy5oIHwg
MTUgKysrKysrKystLS0tLS0tCj4gIHNvdW5kL3NvYy91eDUwMC91eDUwMF9wY20uYyAgICAgfCAz
MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgNSBmaWxlcyBjaGFuZ2VkLCA1MSBp
bnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkKCkkgZG9uJ3Qgc2VlIGFueXRoaW5nIHZpc3Vh
bGx5IHdyb25nIHdpdGggdGhlbSwgc28gYXMgbG9uZyBhcyB0aGV5IHdvcmsKZm9yIHlvdSwgdGhl
biB5b3UgY2FuIGFwcGx5IG15OgoKQWNrZWQtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+CgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVC1Fcmljc3NvbiBMYW5kaW5nIFRlYW0gTGVh
ZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93
IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
