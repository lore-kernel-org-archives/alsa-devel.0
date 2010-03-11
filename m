From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 2/4] mmp: support ssp in pxa168
Date: Thu, 11 Mar 2010 16:20:35 +0800
Message-ID: <f17812d71003110020g67bb7fd6tfe1381294b6cfe8f@mail.gmail.com>
References: <771cded01003100514r70f0f53eydda7b916f92bef64@mail.gmail.com>
	<20100310142832.GB24422@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f203.google.com (mail-pz0-f203.google.com
	[209.85.222.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 672E71038E9
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 09:20:56 +0100 (CET)
Received: by pzk41 with SMTP id 41so832613pzk.23
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 00:20:55 -0800 (PST)
In-Reply-To: <20100310142832.GB24422@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBNYXIgMTAsIDIwMTAgYXQgMTA6MjggUE0sIE1hcmsgQnJvd24KPGJyb29uaWVAb3Bl
bnNvdXJjZS53b2xmc29ubWljcm8uY29tPiB3cm90ZToKPiBPbiBXZWQsIE1hciAxMCwgMjAxMCBh
dCAwODoxNDo0MkFNIC0wNTAwLCBIYW9qaWFuIFpodWFuZyB3cm90ZToKPj4gRnJvbSA3NWZlNGIw
MjIzNGY2NDc2ZTcyODI3NTA4ZjExZjEwMzVkN2FhZjY4IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAw
MQo+PiBGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVsbC5jb20+Cj4+
IERhdGU6IFdlZCwgMTAgTWFyIDIwMTAgMDY6MzI6NDMgLTA1MDAKPj4gU3ViamVjdDogW1BBVENI
XSBbQVJNXSBtbXA6IHN1cHBvcnQgc3NwIGluIHB4YTE2OAo+Pgo+PiBTdXBwb3J0IHNzcCBpbiBw
eGExNjguIFRoZSBiYXNpYyBmdW5jdGlvbiBvZiBTU1AgaXMgc2FtZSBhcyBweGEsIGJ1dCBjbG9j
awo+PiBzb3VyY2UgYW5kIElSUSBpcyBjaGFuZ2VkLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBIYW9q
aWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVsbC5jb20+Cj4KPiBBY2tlZC1ieTogTWFy
ayBCcm93biA8YnJvb25pZUBvcGVuc291cmNlLndvbGZzb25taWNyby5jb20+Cj4KPiBUaGF0IHNh
aWQgbWlnaHQgaXQgbWFrZSBzZW5zZSB0byBtZXJnZSB0aGlzIGFuZCB0aGUgcHJldmlvdXMgcGF0
Y2ggdmlhCj4gQVNvQyBzaW5jZSB0aGVyZSdzIG5ldyBkcml2ZXJzIHVzaW5nIHRoaXMgZm9sbG93
aW5nIG9uIGFuZCBMaWFtJ3MKPiBtdWx0aS1jb2RlYyB3b3JrIGlzIGxpa2VseSB0byBiZSBjcmVh
dGluZyBtZXJnZSBpc3N1ZXMgdGhpcyBkZXZlbG9wbWVudAo+IGN5Y2xlPyDCoEkgY2FuIGFwcGx5
IHRoZSBwYXRjaGVzIG9uIGEgYnJhbmNoIGJ5IHRoZW1zZWx2ZXMgd2hpY2ggY2FuIGFsc28KPiBi
ZSBwdWxsZWQgaW50byB0aGUgUFhBIHRyZWUgaWYgbmVlZGVkLgo+CgpJJ2QgZXhwZWN0IHRoZXJl
IHRvIGJlIHNvbWUgbWVyZ2UgY29uZmxpY3RzIEkgbmVlZCB0byBzb2x2ZSBhbG9uZyB3aXRoCm15
IGNsZWFuaW5nIHVwIG9mIHRoZSBTU1AgY29kZS4gVGhhdCBzYWlkLCBpdCdzIGJldHRlciB0byBn
byB2aWEgLXB4YQp0cmVlIGFuZCBnZXQgdGhlIG11bHRpLWNvZGVjIHdvcmsgc29sdmVkIGluIGxp
bnV4LW5leHQ/CgpNYXJrLCBjb3VsZCB5b3UgcGxlYXNlIHBvaW50IG1lIHRoZSByZWZlcmVuY2Ug
dG8gdGhlIG11bHRpLWNvZGVjIHdvcmsKc28gSSBjYW4gaGF2ZSBhIHJvdWdoIGZlZWxpbmcgb2Yg
dGhlIHBvc3NpYmxlIG1lcmdlIGlzc3Vlcz8KCi0gZXJpYwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
