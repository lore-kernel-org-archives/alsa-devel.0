From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: ASoC: Defining "signed integer" mixer controls?
Date: Thu, 3 Jun 2010 16:52:24 +0100
Message-ID: <AANLkTikpOHdDDl3zCo5J1ItU8NknwVLTlyKYQF4yImDz@mail.gmail.com>
References: <hu6v9i$v43$1@dough.gmane.org> <4C0766EC.3090708@ladisch.de>
	<20100603103322.GB3662@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id AE19C1037F8
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 17:52:25 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 19so1578497fgg.2
	for <alsa-devel@alsa-project.org>; Thu, 03 Jun 2010 08:52:25 -0700 (PDT)
In-Reply-To: <20100603103322.GB3662@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

T24gMyBKdW5lIDIwMTAgMTE6MzMsIFN0dWFydCBMb25nbGFuZCA8cmVkaGF0dGVyQGdlbnRvby5v
cmc+IHdyb3RlOgo+IE9uIFRodSwgSnVuIDAzLCAyMDEwIGF0IDEwOjI1OjE2QU0gKzAyMDAsIENs
ZW1lbnMgTGFkaXNjaCB3cm90ZToKPj4gU3R1YXJ0IExvbmdsYW5kIHdyb3RlOgo+Pgo+PiA+IMKg
IMKgIFNPQ19ET1VCTEVfUl9UTFYoIlBDTSBQbGF5YmFjayBWb2x1bWUiLAo+PiA+IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQUlDMzIwNF9MREFDVk9MLCBBSUMzMjA0X1JEQUNWT0ws
Cj4+ID4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAwLCAxMjcsIDAsIGRhY190bHYp
LAo+PiA+Cj4+ID4gSG93ZXZlcjsgaXQgdHJlYXRzIHRoZSBiaXRmaWVsZCBhcyB1bnNpZ25lZCwg
d2hpY2ggaXMgd3JvbmcgaW4gdGhpcwo+PiA+IGNhc2UuIMKgVGhlIGJpdGZpZWxkIGlzIGEgc2ln
bmVkIGludGVnZXIgaW4gdHdvJ3MgY29tcGxlbWVudCBmb3JtYXQuIMKgSG93Cj4+ID4gZG8gSSBj
b252aW5jZSBBTFNBIHRoYXQgdGhlc2UgaW50ZWdlcnMgaGF2ZSBhIHNpZ24gYml0Pwo+Pgo+PiBB
TFNBJ3MgY29udHJvbHMgdXNlIHNpZ25lZCB2YWx1ZXMsIGl0J3MgdGhlIFNPQ18gbWFjcm9zIHRo
YXQgYXNzdW1lCj4+IGJpdGZpZWxkcy4gwqBZb3Ugc2hvdWxkIGJlIGFibGUgdG8gZGVmaW5lIGEg
Y29udHJvbCB3aXRoIHlvdXIgb3duCj4+IGNhbGxiYWNrcyBsaWtlIGluIGEgbm9uLUFTb0MgZHJp
dmVyLgo+Cj4gQWhoIG9rYXkuLi4gbWFrZXMgc2Vuc2UuLi4gSSdsbCBoYXZlIGEgY2xvc2VyIGxv
b2s7IHBlcmhhcHMgc29tZQo+IGFkZGl0aW9uYWwgbWFjcm9zIGNvdWxkIGJlIHdyaXR0ZW4gdG8g
YWxsb3cgdXNlIG9mIHNpZ25lZCBpbnRlZ2VyCj4gYml0ZmllbGRzIGFzIHdlbGwuIMKgSSdtIHN1
cmUgdGhlIFRMVjMyMEFJQzMyMDQgaXMgbm90IHRoZSBvbmx5IENPREVDCj4gdGhhdCB1c2VzIHN1
Y2ggYmVhc3RzLgoKSSBhbSBub3QgYXdhcmUgb2YgYW55IGNvZGVjIHRoYXQgdXNlcyBzaWduZWQg
Yml0ZmllbGRzLiAoTXkgZXhwZXJpZW5jZQppcyB3aXRoIEFDOTcsIEhELUF1ZGlvLCBEU1BzIGFu
ZCB2YXJpb3VzIEFEQyBhbmQgREFDcy4pCllvdXIgVExWMzIwQUlDMzIwNCBtaWdodCBiZSB0aGUg
Zmlyc3QhISEKCktpbmQgUmVnYXJkcwoKSmFtZXMKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCg==
