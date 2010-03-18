From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 1/4] extend ad1938
	codec driver to ad193x supporting ad1936/7/8/9
Date: Thu, 18 Mar 2010 14:08:14 -0400
Message-ID: <8bd0f97a1003181108y3f7f5871t81c5cd5ba0c6312d@mail.gmail.com>
References: <1268900221-6833-1-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-2-git-send-email-21cnbao@gmail.com>
	<1268902095.3773.6.camel@odin>
	<3c17e3571003180208y34e4b5dekd2d23efa0723b641@mail.gmail.com>
	<20100318111848.GB3080@opensource.wolfsonmicro.com>
	<8bd0f97a1003180857vdd155e0o29684b50cbd5e34e@mail.gmail.com>
	<20100318162017.GA6142@rakim.wolfsonmicro.main>
	<8bd0f97a1003181017xba8e1a9oce2d40bf56818956@mail.gmail.com>
	<20100318180516.GF6142@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F11A103871
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 19:08:36 +0100 (CET)
Received: by gwb15 with SMTP id 15so608825gwb.38
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 11:08:34 -0700 (PDT)
In-Reply-To: <20100318180516.GF6142@rakim.wolfsonmicro.main>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Barry Song <21cnbao@gmail.com>, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBNYXIgMTgsIDIwMTAgYXQgMTQ6MDUsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gVGh1
LCBNYXIgMTgsIDIwMTAgYXQgMDE6MTc6MTFQTSAtMDQwMCwgTWlrZSBGcnlzaW5nZXIgd3JvdGU6
Cj4+ID4gVGhlIHN1YnN5c3RlbSBkZXBlbmRlbmN5IGhlcmUgY29tZSBmcm9tIHRoZSBmYWN0IHRo
YXQgQVNvQyBoYXMgbWFjaGluZQo+PiA+IGRyaXZlcnMgYW5kIHJlbGllcyBvbiB0aGVtIHNlbGVj
dGluZyB0aGUgQ09ERUMgZHJpdmVycyB0byBnZXQgdGhlbSBidWlsdAo+PiA+IGluIHRoZSBmaXJz
dCBwbGFjZSBzbyBpZiB5b3UncmUgdHJ5aW5nIHRvIGNoYW5nZSBzb21ldGhpbmcgbGlrZSB0aGlz
Cj4+ID4geW91J2xsIG1vc3QgbGlrZWx5IG5vdCBvbmx5IGhhdmUgdG8gcmVidWlsZCB5b3VyIGtl
cm5lbCBidXQgYWxzbyBoYXZlIHRvCj4+ID4gd3JpdGUgY29kZS4gwqBUaGlzIGlzbid0IHNvbWV0
aGluZyB0aGF0IHRoZSBpbnB1dCBsYXllciBoYXMgKGlucHV0IGxheWVyCj4+ID4gZHJpdmVycyBh
cmUgcHJldHR5IG11Y2ggc3RhbmRhbG9uZSwgdXN1YWxseSBvbmx5IG5lZWQgcGxhdGZvcm0gZGF0
YQo+PiA+IGZvciBhbnkgcGVyIG1hY2hpbmUgaG9va3VwIGFuZCBmb3IgSTJDIGFuZCBTUEkgY2Fu
IGV2ZW4gYmUgcmVnaXN0ZXJlZAo+PiA+IGZyb20gdXNlciBzcGFjZSBJSVJDKSBhbmQgaXQgY2hh
bmdlcyB0aGUgY29uc2lkZXJhdGlvbnMgbm90aWNhYmx5Lgo+Cj4+IHRoZSBtYWNoaW5lIGRyaXZl
ciBzZWxlY3RzIHRoZSBjb2RlYywgaXQgZG9lc250IHNlbGVjdCB0aGUgYnVzLiDCoHRoZQo+PiBj
b2RlYyB3b3JyaWVzIGFib3V0IHRoYXQuIMKgc28gaSBkb250IHF1aXRlIGZvbGxvdyB0aGUgbG9n
aWMgaGVyZS4KPgo+IFRoYXQncyBub3QgdGhlIGNhc2UsIENPREVDIGRyaXZlcnMgZG8gYWJzb2x1
dGVseSBub3RoaW5nIHRvIGVuc3VyZSB0aGF0Cj4gdGhleSBoYXZlIHRoZSBidXNlcyB0aGV5IG5l
ZWQuIMKgTXVsdGkgYnVzIENPREVDcyBzaG91bGQgYWxsIGJlIHBlcmZlY3RseQo+IGhhcHB5IHRv
IGJ1aWxkIHdpdGggbm8gYnVzIGF0IGFsbCwgdGhvdWdoIHNwYXJzZSBhbmQvb3IgR0NDIHdpbGwg
d2Fybi4KPgo+IEtjb25maWcgd2lsbCBjaGVlcmZ1bGx5IGlnbm9yZSBhbnkgZGVwZW5kZW5jaWVz
IG9mIHRoaW5ncyB0aGF0IGFyZQo+IHNlbGVjdGVkIC0gdW5sZXNzIGl0J3MgYmVlbiB1cGRhdGVk
IHJlY2VudGx5IGFsbCBhIHNlbGVjdCBkb2VzIGlzIGZvcmNlCj4gdGhlIHNlbGVjdGVkIHN5bWJv
bCBvbiwgaXQgZG9lc24ndCByZWN1cnNlIHRocm91Z2ggZGVwZW5kZW5jaWVzIGFuZAo+IHNlbGVj
dHMgb2YgdGhhdCBzeW1ib2wuIMKgQmVzaWRlcywgbXVsdGkgYnVzIENPREVDIGRyaXZlcnMgY2Fu
J3Qga25vdwo+IHdoaWNoIG9mIHRoZWlyIHBvc3NpYmxlIGJ1c2VzIGFyZSBhY3R1YWxseSBuZWVk
ZWQgb24gYSBnaXZlbiBzeXN0ZW0gLQo+IHRoZXkganVzdCBidWlsZCBzdXBwb3J0IGZvciBhbnkg
YnVzIHR5cGVzIHRoYXQgYXJlIGNvbmZpZ3VyZWQgYW5kIGxldAo+IHNvbWV0aGluZyBlbHNlIHdv
cnJ5IGFib3V0IHRoZSByZXN1bHRpbmcgY29uZmlndXJhdGlvbiBhY3R1YWxseSBiZWluZwo+IHVz
ZWZ1bC4KCnN1cmUsIG9uIHRoZSBLY29uZmlnIHNpZGUsIGkgY2FuIHNlZSB0aGF0LiAgaSB3YXMg
dGhpbmtpbmcgdGhlIHB1cmUgQwpkcml2ZXJzIHRob3VnaC4gIHRoYW5rcyBmb3IgdGhlIGNsYXJp
ZmljYXRpb24uCi1taWtlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9y
ZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1k
ZXZlbAo=
