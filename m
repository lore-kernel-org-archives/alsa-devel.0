From: Greg KH <greg@kroah.com>
Subject: Re: sound: latency and synchronization measurements
Date: Fri, 18 May 2018 15:12:59 +0200
Message-ID: <20180518131259.GB10497@kroah.com>
References: <CAHhAz+hFFYqz2gtVnEZVyMjAO3fe4f5EtZeFO4tvO-2W-6sv7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A9C0D266F88
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 15:13:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAHhAz+hFFYqz2gtVnEZVyMjAO3fe4f5EtZeFO4tvO-2W-6sv7g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-sound@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBNYXkgMTgsIDIwMTggYXQgMDY6MDc6MjlQTSArMDUzMCwgTXVuaSBTZWtoYXIgd3Jv
dGU6Cj4gWyBQbGVhc2Uga2VlcCBtZSBpbiBDQyBhcyBJJ20gbm90IHN1YnNjcmliZWQgdG8gdGhl
IGxpc3RdCj4gCj4gSGkgQWxsLAo+IAo+IEkgYW0gdHJ5aW5nIHRvIGNoYXJhY3Rlcml6ZSB0aGUg
YXVkaW8gc3luY2hyb25pemF0aW9uIGJldHdlZW4gdHdvCj4gc3lzdGVtcy4gVGhlcmUgaXMgYSBt
ZWNoYW5pc20gdG8gcm91dGUgYXVkaW8gYmV0d2VlbiB0d28gc3lzdGVtcywgd2UKPiBydW4g4oCY
YXBsYXnigJkgYXQgb25lIHN5c3RlbSBhbmQg4oCYYXJlY29yZOKAmSBpbiBvdGhlciBzeXN0ZW0u
Cj4gCj4gV2UgbmVlZCB0byBtZWFzdXJlIHRoZSB0aW1lIGRpZmZlcmVuY2Ugd2hlbiBhdWRpbyBz
YW1wbGUgaXMgb3V0IGF0IG9uZQo+IHBvcnQgYW5kIGFycml2aW5nIGF0IGFub3RoZXIgcG9ydCBp
biBkaWZmZXJlbnQgc3lzdGVtLgo+IAo+IEkgcGxhbiB0byBhZGQgcHJpbnRr4oCZcyBpbiDigJxz
dHJ1Y3Qgc25kX3BjbV9vcHPigJ0gY2FsbCBiYWNrcywgYnV0IGRvZXMKPiB0aGVzZSBjYWxsIGJh
Y2tzIHRlbGxzIHdoZW4gaXQgcmVjZWl2ZWQgZmlyc3QgYW5kIGxhc3QgYXVkaW8KPiBmcmFtZXNc
c2FtcGxlcz8KPiAKPiBPciBlbHNlIHBsZWFzZSBzdWdnZXN0IGFueSBvdGhlciBiZXN0IG1ldGhv
ZC4KCkZpcnN0IG9mZiB5b3UgbmVlZCBhICJzaGFyZWQgdGltZXIvY2xvY2siIGJldHdlZW4gdGhl
IHR3byBzeXN0ZW1zIGluCm9yZGVyIHRvIGhhdmUgYSBjaGFuY2UgdG8gZGV0ZXJtaW5lIHdoYXQg
YWN0dWFsbHkgaGFwcGVucyBoZXJlLiAgR29vZApsdWNrIHdpdGggdGhhdCEgIDopCgpBbHNvLCB0
aGVyZSdzIGJlZW4gdG9ucyBvZiByZXNlYXJjaCBpbiB0aGlzIGFyZWEgb3ZlciB0aGUgeWVhcnMs
IHBsZWFzZQpsb29rIGludG8gdGhhdCwgb2RkcyBhcmUgdGhlc2UgcHJvYmxlbXMgaGF2ZSBiZWVu
IHNvbHZlZCBhbHJlYWR5LiAgSQprbm93IG9mIHNldmVyYWwgY29tbWVyY2lhbCBkZXZpY2VzIHRo
YXQgYWxyZWFkeSBoYW5kbGUgdGhpcyBqdXN0IGZpbmUuCgpiZXN0IG9mIGx1Y2shCgpncmVnIGst
aApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxt
YW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
