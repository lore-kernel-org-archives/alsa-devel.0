From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH] ASoC: dwc: disallow building
	designware_pcm as a module
Date: Tue, 18 Apr 2017 18:13:30 +0200
Message-ID: <1492532010.28092.12.camel@v3.sk>
References: <20170418105954.23368-1-lkundrak@v3.sk>
 <20170418151834.c7e5fivmgn73sbwd@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from shell.v3.sk (shell.v3.sk [92.60.52.57])
 by alsa0.perex.cz (Postfix) with ESMTP id 34126266A99
 for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2017 18:13:35 +0200 (CEST)
In-Reply-To: <20170418151834.c7e5fivmgn73sbwd@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCAyMDE3LTA0LTE4IGF0IDE2OjE4ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOgo+IE9u
IFR1ZSwgQXByIDE4LCAyMDE3IGF0IDEyOjU5OjU0UE0gKzAyMDAsIEx1Ym9taXIgUmludGVsIHdy
b3RlOgo+ID4gSXQgbWFrZXMgbm90IHNlbnNlOiB0aGUgd2hldGhlciB0aGUgUElPIFBDTSBleHRl
bnNpb24gaXMgdXNlZCBpcwo+ID4gaGFyZGNvZGVkIHRvIHRoZSBkZXNpZ253YXJlX2kycyBkcml2
ZXIgYW5kIGRlc2lnbndhcmVfcGNtIGRvZXNuJ3QKPiA+IGhhdmUgYW55IG1vZHVsZSBtZXRhZGF0
YSwgY2F1c2luZyBhIGtlcm5lbCB0YWludDoKPiA+IAo+ID4gwqAgW8KgwqDCoDQ0LjI4NzAwMF0g
ZGVzaWdud2FyZV9wY206IG1vZHVsZSBsaWNlbnNlICd1bnNwZWNpZmllZCcgdGFpbnRzIGtlcm5l
bC4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogTHVib21pciBSaW50ZWwgPGxrdW5kcmFrQHYzLnNr
Pgo+IAo+IFRoaXMgaXMgbm90IGEgYSBnb29kIGFwcHJvYWNoLCB0aGVyZSBpcyBubyB0ZWNobmlj
YWwgcmVhc29uIHRvIGZvcmNlIHRoZQo+IGRyaXZlciB0byBiZSBidWlsdCBpbi7CoMKgSWYgeW91
IG5lZWQgYSBsaWNlbnNlIHRhZyBpbiB0aGUgbW9kdWxlIHRoZW4gYWRkCj4gdGhhdC4KCkkgZG9u
J3QgdGhpbmsgZGVzaWdud2FyZV9wY20gaXMgYSBzZXBhcmF0ZSBkcml2ZXIuIEl0IGxvb2tzIHRp
Z2h0bHkKY291cGxlZCB3aXRoIGRlc2lnbndhcmVfaTJzOiB5b3UgY2FuIGVpdGhlciBkaXNhYmxl
IGRlc2lnbndhcmVfcGNtCmFsdG9nZXRoZXIgYXQgYnVpbGQgdGltZSBvciBhbHdheXMgbG9hZCBp
dCB0b2dldGhlciB3aXRoCmRlc2lnbndhcmVfaTJzLgoKU2VlIHNvdW5kL3NvYy9kd2MvbG9jYWwu
aDoKCiAgI2lmIElTX0VOQUJMRUQoQ09ORklHX1NORF9ERVNJR05XQVJFX1BDTSkKICB2b2lkIGR3
X3BjbV9wdXNoX3R4KHN0cnVjdCBkd19pMnNfZGV2ICpkZXYpOwogIGludCBkd19wY21fcmVnaXN0
ZXIoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldik7CiAgI2Vsc2UKICB2b2lkIGR3X3BjbV9w
dXNoX3R4KHN0cnVjdCBkd19pMnNfZGV2ICpkZXYpIHsgfQogIGludCBkd19wY21fcmVnaXN0ZXIo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKICB7CiAgwqDCoMKgwqDCoMKgwqDCoHJldHVy
biAtRUlOVkFMOwogIH0KICAjZW5kaWYKCkx1Ym8KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCg==
