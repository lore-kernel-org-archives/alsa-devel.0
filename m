From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH - hwmixvolume 1/9] hwmixvolume: replace
 PyGTK with gobject-introspection
Date: Tue, 14 Aug 2018 13:24:14 +0900
Message-ID: <da2d48c2-a006-96c1-4f96-bd2a98ab6d83@sakamocchi.jp>
References: <20180808155637.5592-1-linkmauve@jabberfr.org>
 <20180808155637.5592-2-linkmauve@jabberfr.org> <s5h36vm2rtc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id E425B2677AE
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2018 06:24:18 +0200 (CEST)
In-Reply-To: <s5h36vm2rtc.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Emmanuel Gil Peyrot <linkmauve@jabberfr.org>
Cc: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGksCgpPbiBBdWcgMTAgMjAxOCAyMzo1NiwgVGFrYXNoaSBJd2FpIHdyb3RlOgo+IE9uIFdlZCwg
MDggQXVnIDIwMTggMTc6NTY6MjkgKzAyMDAsCj4gRW1tYW51ZWwgR2lsIFBleXJvdCB3cm90ZToK
Pj4KPj4gVGhpcyBkb2VzbuKAmXQgd29yayB5ZXQsIHdlIHJlcXVpcmUgR3RrwqAzLjAgcmF0aGVy
IHRoYW4gMi4wIGFuZCB0aGUgQVBJCj4+IGNoYW5nZWQgcXVpdGUgYSBsb3QuCj4+Cj4+IFNpZ25l
ZC1vZmYtYnk6IEVtbWFudWVsIEdpbCBQZXlyb3QgPGxpbmttYXV2ZUBsaW5rbWF1dmUuZnI+Cj4g
Cj4gVGhhbmtzIGZvciB0aGUgcGF0Y2hlcy4gIE1vc3Qgb2YgY2hhbmdlcyBsb29rIGdvb2QsIGJ1
dCBhbHNvIG1vc3Qgb2YKPiBwYXRjaGVzIGhhdmUgbm8gY2hhbmdlIGxvZyBhdCBhbGwuICBUaGF0
J3MgYWxyZWFkeSBhIGJhZCBzaWduLgo+IAo+IENvdWxkIHlvdSBnaXZlIHNvbWUgZGV0YWlscywg
ZXNwZWNpYWxseSB3aHkgdGhlIGNoYW5nZSBpcyBuZWVkZWQsIGluCj4gZWFjaCBwYXRjaCBhbmQg
cmVzdWJtaXQgYXMgYSBwYXRjaHNldD8gIEF0IGJlc3QsIHNlbmQgd2l0aCBhIGNvdmVyCj4gbGV0
dGVyIGFuZCBhIHRocmVhZCBhcyBhIHBhdGNoIHNldCBhdCB0aGUgbmV4dCB0aW1lIChnaXQtc2Vu
ZC1lbWFpbAo+IGNhbiBtYW5hZ2UgaXQgd2VsbCkuCgpJbiBteSBvcGluaW9uLCB0aGUgYWltIG9m
IHRoaXMgcGF0Y2hzZXQgaXMgcG9ydGluZyBmcm9tIEd0aysyLjAgdG8gCkd0ayszLjAsIGFjY29y
ZGluZyB0byBFT0wgb2YgcHl0aG9uIGJpbmRpbmdzLiBPcmlnaW5hbCBzY3JpcHQgdXNlcyAKUHlH
dGtbMV0sIHdoaWNoIGlzIGFuIGFwcGxpY2F0aW9uIG9mIEd0aysyLjAsIGJ1dCBQeUd0ayBpcyBh
bHJlYWR5IGF0IAp0aGUgZW5kIG9mIGxpZmUgYW5kIHVzYWdlIG9mIFB5R09iamVjdFsyXSB0byBh
Y2Nlc3MgdG8gbWV0YWRhdGEgb2YgCkd0ayszLjAgaXMgYSBmcmVzaCB3YXkgaW5zdGVhZC4gSW4g
dGhpcyBwb2ludCwgRW1tYW51ZWwncyBwcm9wb3NhbCBpcyAKcHJlZmVyYWJsZSBpbiAyMDE4LgoK
QW55d2F5LCBJIGVuY291cmFnZSBFbW1hbnVlbCB0byByZS1wb3N0IHRoaXMgcGF0Y2hzZXQgd2l0
aCBlbm91Z2ggCmNvbW1lbnQgYWNjb3JkaW5nIHRvIG1haW50YWluZXIncyBhZHZpY2UuIEknbGwg
cmV2aWV3IGhpcyBuZXh0IHBvc3QgZm9yIAptZXJnaW5nLgoKWzFdIGh0dHBzOi8vZ2l0aHViLmNv
bS9HTk9NRS9weWd0awpbMl0gaHR0cHM6Ly9naXRsYWIuZ25vbWUub3JnL0dOT01FL3B5Z29iamVj
dAoKClRoYW5rcwoKVGFrYXNoaSBTYWthbW90bwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
