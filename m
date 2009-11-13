From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] soc-core: let suspend/resume not called if
	the card is not instantiated
Date: Fri, 13 Nov 2009 22:56:13 +0800
Message-ID: <3c17e3570911130656v662dccej7d6c67e7eaa65b65@mail.gmail.com>
References: <1258087878-18679-1-git-send-email-21cnbao@gmail.com>
	<20091113133824.GD21516@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f210.google.com (mail-gx0-f210.google.com
	[209.85.217.210])
	by alsa0.perex.cz (Postfix) with ESMTP id 287BA24356
	for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2009 15:56:40 +0100 (CET)
Received: by gxk2 with SMTP id 2so3061235gxk.4
	for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2009 06:56:38 -0800 (PST)
In-Reply-To: <20091113133824.GD21516@rakim.wolfsonmicro.main>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBOb3YgMTMsIDIwMDkgYXQgOTozOCBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIEZyaSwgTm92IDEzLCAyMDA5IGF0
IDEyOjUxOjE4UE0gKzA4MDAsIEJhcnJ5IFNvbmcgd3JvdGU6Cj4+IEl0IGRvZXNuJ3QgbWFrZSBz
ZW5zZSB0byBjYWxsIHN1c3BlbmQvcmVzdW1lIG9mIGFsbCBjcHUvY29kZWMgZGFpcyBldmVuCj4+
IHRoZXkgYXJlIG5vdCBpbml0aWFsaXplZCBhbmQgcmVnaXN0ZXJlZC4gVGhpcyB3aWxsIGNhdXNl
IG1hbnkgcHJvYmxlbXMKPj4gZm9yYXVkaW8gUE0uCj4+IFRoZSBjb25kaXRpb24gY2FyZCBpcyBu
b3QgaW5zdGFudGlhdGVkIGNvdmVycyBjb2RlYyBpcyBudWxsLCBzbyBkZWxldGUKPj4gdGhlIGNo
ZWNrIHRoYXQgY29kZWMgaXMgbnVsbC4KPgo+IEhybS4gwqBJdCdzIG5vdCBjbGVhciB0aGF0IHRo
aXMgaXMgdGhlIGJlc3QgYXBwcm9hY2ggaGVyZSAtIGl0J2QgbWVhbgo+IHRoYXQgdGhpbmdzIGxp
a2UgdGhlIENPREVDIGRyaXZlcnMgd291bGQgbmVlZCB0byBoYXZlIHR3byBzdXNwZW5kIGFuZAo+
IHJlc3VtZSBwYXRocywgb25lIGZvciB1c2UgYmVmb3JlIHRoZSBjYXJkIGNvbWVzIHVwIGFuZCBv
bmUgZm9yIHVzZQo+IGFmdGVyd2FyZHMuIMKgQXMgdGhpbmdzIHN0YW5kIHRoaXMgd2lsbCBmaXgg
d2hhdGV2ZXIgcHJvYmxlbSB5b3UgYXJlCj4gc2VlaW5nIGJ1dCB3aWxsIGNyZWF0ZSBwcm9ibGVt
cyBmb3Igb3RoZXIgc3lzdGVtcyB3aGVyZSB3ZSdsbCBzdG9wCj4gc3VzcGVuZGluZyBkZXZpY2Vz
IHRoYXQgbmVlZCBpdC4KPgo+IEFzIHdpdGggeW91ciBURE0gcG9ydCBpc3N1ZSBwbV9saW5rIGlz
IGdvaW5nIHRvIGJlIHJlYWxseSBoZWxwZnVsIGhlcmUKPiBvbmNlIGl0IGhpdHMgbWFpbmxpbmUu
IMKgTGV0IG1lIGhhdmUgYSB0aGluayBhYm91dCB3aGF0IChpZiBhbnl0aGluZykgd2UKPiBjYW4g
ZG8gaW4gdGhlIG1lYW50aW1lLCB0aGlzIGFyZWEgaXMgYSBsaXR0bGUgZnJhZ2lsZS4KPgpNYXJr
LApZb3UgbWlzdW5kZXJzdGFuZCBteSBwYXRjaDotKQpUaGlzIHBhdGNoIGlzIHRvIHNvbHZlIGEg
Y29tcGxldGVseSBkaWZmZXJlbnQgcHJvYmxlbSB3aXRoIHRoZSBsYXN0Cm9uZSBJIHNlbnQuIEl0
cyBtZWFuaW5nIGlzIHZlcnkgc2ltcGxlIGFjdHVhbGx5LiAgV2hpbGUKY2FyZC0+aW5zdGFudGlh
dGVkIGlzIG5vdCAxLCBpdCBtZWFucyB0aGUgY2FyZChjcHUgZGFpL2NvZGVjIGRhaSBhbmQKcmVs
YXRlZCBzdHVmZikgYW5kIHRoZSB3aG9sZSBsaW5rcyBhcmUgbm90IGJ1aWx0IHN1Y2Nlc3NmdWxs
eSBhdCBhbGwuClNvIGRldmljZXMgYXJlIG5vdCBldmVuIGluaXRpYWxpemVkIGF0IGFsbC4gQW5k
IHRoZSBhdWRpbyBzeXN0ZW0KZG9lc24ndCBzdGFydCB0byB3b3JrLiBTaW5jZSBzbywgc3VzcGVu
ZC9yZXN1bWUgc2hvdWxkIGJlIG5vdCBuZWVkZWQKZm9yIHRoZSB3aG9sZSBzeXN0ZW0uClRoYW5r
cwpCYXJyeQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
