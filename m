From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 1/3] new ad1836 codec driver based on asoc
Date: Thu, 13 Aug 2009 17:37:09 +0800
Message-ID: <3c17e3570908130237g34f34228v1d57d872dfba20ea@mail.gmail.com>
References: <1250051574-25119-1-git-send-email-21cnbao@gmail.com>
	<1250051574-25119-2-git-send-email-21cnbao@gmail.com>
	<20090812134645.GC11898@rakim.wolfsonmicro.main>
	<3c17e3570908122041m29a1843agd0f9fd0e415181c3@mail.gmail.com>
	<20090813090801.GA31504@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f176.google.com (mail-yx0-f176.google.com
	[209.85.210.176])
	by alsa0.perex.cz (Postfix) with ESMTP id D137F243ED
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 11:37:31 +0200 (CEST)
Received: by yxe6 with SMTP id 6so809536yxe.16
	for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2009 02:37:31 -0700 (PDT)
In-Reply-To: <20090813090801.GA31504@sirena.org.uk>
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

T24gVGh1LCBBdWcgMTMsIDIwMDkgYXQgNTowOCBQTSwgTWFyawpCcm93bjxicm9vbmllQG9wZW5z
b3VyY2Uud29sZnNvbm1pY3JvLmNvbT4gd3JvdGU6Cj4gT24gVGh1LCBBdWcgMTMsIDIwMDkgYXQg
MTE6NDE6MTNBTSArMDgwMCwgQmFycnkgU29uZyB3cm90ZToKPj4gT24gV2VkLCBBdWcgMTIsIDIw
MDkgYXQgOTo0NiBQTSwgTWFyawo+PiBCcm93bjxicm9vbmllQG9wZW5zb3VyY2Uud29sZnNvbm1p
Y3JvLmNvbT4gd3JvdGU6Cj4KPj4gPiBKdXN0ICJhZDE4MzYiIC0gdGhlIGZhY3QgdGhhdCBpdCdz
IGNvbnRyb2xsZWQgdmlhIFNQSSBpcyBjbGVhciBmcm9tIHRoZQo+PiA+IGZhY3QgdGhhdCB0aGlz
IGlzIGEgc3RydWN0IHNwaV9kcml2ZXIuCj4KPj4gSSBhZ3JlZSB0aGUgc3BpIHN0cnVjdHVyZSBp
bXBsaWVzIHRoZSBtZWFuaW5nIG9mIHNwaS4gwqBCdXQgZmlsZXMgaW4KPj4gYXJjaC9ibGFja2Zp
bi9tYWNoLi4uIGFyZSB1c2luZyBuYW1lcyBsaWtlICJ4eHgtc3BpIiBmb3IgYWxtb3N0IGFsbAo+
PiBzcGkgZGV2aWNlcy4gSG93IGFib3V0IGtlZXBpbmcgdGhlIGNvaGVyZW5jZT8KPgo+IE9oIGRl
YXIuIMKgTG9va3MgbGlrZSB5b3UndmUgZXNzZW50aWFsbHkgZ290IGEgY2hvaWNlIGJldHdlZW4g
YmVpbmcKPiBjb25zaXN0ZW50IHdpdGggdGhlIHJlc3Qgb2YgdGhlIHdvcmxkIGFuZCBiZWluZyBj
b25zaXN0ZW50IHdpdGggd2hhdCB0aGUKPiBibGFja2ZpbiBzdHVmZiBpcyBkb2luZy4KTG9va3Mg
bGlrZSB0aGUgcmVzdCB3b3JsZCByZWFsbHkgZG9lc24ndCBkZWZpbmUgYSBzcGkgZGV2aWNlIHdp
dGgKbW9kYWxpYXMgInh4eC1zcGkiIGJ1dCBqdXN0ICJ4eHgiIGluIGFyY2guIFNvIEkgYWdyZWUg
d2UgY2FuIGNoYW5nZQpibGFja2ZpbiBzdHVmZiBhcyBNaWtlLgoKPgo+PiA+IFRoZSBwb3dlciBj
b250cm9sIHdpbGwgYmUgaGFuZGxlZCBieSBEQVBNIGJ1dCB5b3VyIGRyaXZlciBzdGlsbCBuZWVk
cyB0bwo+PiA+IHJlc3RvcmUgdGhpbmdzIGxpa2UgdGhlIHZvbHVtZSBzZXR0aW5ncyAtIHdoZW4g
dGhlIGRyaXZlciBpcyBwb3dlcmVkIG9mZgo+PiA+IHRoZSByZWdpc3RlciBzZXR0aW5ncyB3aWxs
IGJlIGZvcmdvdHRlbi4KPgo+PiBNeSB0ZXN0IHNob3dzIHJlZ2lzdGVycyBzZXR0aW5nIGRvZXNu
J3QgbG9zZSBhZnRlciBkYWMvYWRjIHNodXRkb3duIDotKQo+Cj4gUHJvYmFibHkgeW91ciBib2Fy
ZCBpcyBtYWludGFpbmluZyBwb3dlciB0byB0aGUgY2hpcCBldmVuIGR1cmluZwo+IHN1c3BlbmQu
Cj4KSWYgc28sIGFsbCBjb2RlYyBkcml2ZXJzIG5lZWQgdG8gc2F2ZSBzZXR0aW5nIHRoZW4gcmVz
dG9yZSB0aGVtIHdoZW4KcmVzdW1lLiBUaGUgcGh5c2ljYWwgc2h1dGRvd24gZGVwZW5kcyBvbiBi
b2FyZHMgZ3JlYXQuIElmIHdlIGdldCBhbgppbmRpdmlkdWFsIHByb2dyYW1tYWJsZSBQTVUvTERP
IHRvIGNvbnRyb2wgdGhlIHZvbHRhZ2UgaW5wdXQgdG8gdGhpcwpjaGlwLCBJIGNhbiBzaHV0ZG93
biBwb3dlci1pbnB1dCB0byBjb2RlYyBwaHlzaWNhbGx5IGFuZCBzYXZlIHRoZQpyZWdpc3RlcnMg
d2hlbiBzdXNwZW5kLCAgdGhlbiByZXN0b3JlIHRoZW0gd2hlbiByZXN1bWUuIElmIG5vIHRoaXMK
dW5pdCwgc2hvdWxkIGV2ZXJ5IGNvZGVjIGRyaXZlciBoYW5kbGUgdGhpcyBjYXNlPwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
