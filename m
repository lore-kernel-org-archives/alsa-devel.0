From: Liam Girdwood <lrg@ti.com>
Subject: Re: [RESEND][PATCH] ASoC: Update omap/ams-delta for
 TTY API change
Date: Mon, 6 Jun 2011 10:53:49 +0100
Message-ID: <4DECA3AD.2000100@ti.com>
References: <201105121929.50301.jkrzyszt@tis.icnet.pl>
	<20110513070040.GA18783@opensource.wolfsonmicro.com>
	<4DCCF90C.7030301@ti.com>
	<201106032337.53347.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 990141039B8
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 11:53:58 +0200 (CEST)
In-Reply-To: <201106032337.53347.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "Balbi,
	Felipe" <balbi@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gMDMvMDYvMTEgMjI6MzcsIEphbnVzeiBLcnp5c3p0b2ZpayB3cm90ZToKPiBEbmlhIHBpxIV0
ZWsgMTMgbWFqIDIwMTEgbyAxMToyNTozMiBMaWFtIEdpcmR3b29kIG5hcGlzYcWCKGEpOgo+PiBP
biAxMy8wNS8xMSAwODowMCwgTWFyayBCcm93biB3cm90ZToKPj4+IE9uIEZyaSwgTWF5IDEzLCAy
MDExIGF0IDEyOjM2OjA3QU0gKzAyMDAsIEphbnVzeiBLcnp5c3p0b2ZpayB3cm90ZToKPj4+PiBG
b2xsb3dpbmcgdGhlIHJlY2VpdmVfYnVmKCkgY2hhbmdlIHRvIHJldHVybiB0aGUgbnVtYmVyIG9m
IGJ5dGVzCj4+Pj4gcmVjZWl2ZWQsIHRoZSBjeDIwNDQyIENPREVDIGRyaXZlciB3YXMgdXBkYXRl
ZCB0byByZXBvcnQgdGhhdCB3ZQo+Pj4+IGFjY2VwdGVkIGFsbCB0aGUgZGF0YSB0aGF0IHdhcyBv
ZmZlcmVkIHRvIHVzLiBEbyB0aGUgc2FtZSB3aXRoIHRoZQo+Pj4+IGNvcnJlc3BvbmRpbmcgQW1z
dHJhZCBEZWx0YSBzb3VuZCBjYXJkIGxldmVsIHdyYXBwZXIgZnVuY3Rpb24sCj4+Pj4gd2hpY2gg
aXMgYWN0dWFsbHkgcmVnaXN0ZXJlZCBhcyB0aGUgdHR5IGxpbmUgZGlzY2lwbGluZSBjYWxsYmFj
awo+Pj4+IGluc3RlYWQgb2YgdGhlIHRoZSBDT0RFQyBmdW5jdGlvbiwgd2hpY2ggaXQgdGhlbiBj
YWxscy4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEphbnVzeiBLcnp5c3p0b2ZpayA8amtyenlz
enRAdGlzLmljbmV0LnBsPgo+Pj4KPj4+IEFja2VkLWJ5OiBNYXJrIEJyb3duIDxicm9vbmllQG9w
ZW5zb3VyY2Uud29sZnNvbm1pY3JvLmNvbT4KPj4+Cj4+PiBidXQgYXMgdGhlIFRUWSBBUEkgY2hh
bmdlIGlzIGluIHRoZSBUVFkgdHJlZSBhdCB0aGUgbWludXRlIGFuZCBub3QKPj4+IEFTb0MgeW91
IHNob3VsZCBzZW5kIHRoaXMgdG8gR3JlZyBLLUggKGlkZWFsbHkgYWxzbyB3aXRoIExpYW0ncwo+
Pj4gYWNrKSB1bmxlc3MgaXQncyBub3QgYmVlbiBhcHBsaWVkIGJ5IHRoZSB0aW1lIHRoZSBtZXJn
ZSB3aW5kb3cKPj4+IGNvbWVzIHJvdW5kLgo+Pgo+PiBGaW5lIGJ5IG1lIHRvby4KPj4KPj4gQWNr
ZWQtYnk6IExpYW0gR2lyZHdvb2QgPGxyZ0B0aS5jb20+Cj4gCj4gSGksCj4gSSBmYWlsZWQgdG8g
c2VuZCB0aGlzIHBhdGNoIHRvIEdyZWcgYmVmb3JlIHRoZSBtZXJnZSB3aW5kb3csIHNvcnJ5LiBO
b3cgCj4gdGhhdCB3ZSBhcmUgaW4gdGhlIHJjIGN5Y2xlLCBjYW4gaXQgYmUgYXBwbGllZCB0byB0
aGUgc291bmQgdHJlZSwgb3IgCj4gc2hvdWxkIEkgcmVzZW5kIGl0Pwo+IAoKQmVzdCB0byByZXNl
bmQgd2l0aCBBY2sncy4KClRoYW5rcwoKTGlhbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
