From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RESEND][PATCH] ASoC: Update omap/ams-delta for
	TTY API change
Date: Fri, 3 Jun 2011 23:37:43 +0200
Message-ID: <201106032337.53347.jkrzyszt@tis.icnet.pl>
References: <201105121929.50301.jkrzyszt@tis.icnet.pl>
	<20110513070040.GA18783@opensource.wolfsonmicro.com>
	<4DCCF90C.7030301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 669EA24337
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 23:42:36 +0200 (CEST)
In-Reply-To: <4DCCF90C.7030301@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "Balbi,
	Felipe" <balbi@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

RG5pYSBwacSFdGVrIDEzIG1haiAyMDExIG8gMTE6MjU6MzIgTGlhbSBHaXJkd29vZCBuYXBpc2HF
gihhKToKPiBPbiAxMy8wNS8xMSAwODowMCwgTWFyayBCcm93biB3cm90ZToKPiA+IE9uIEZyaSwg
TWF5IDEzLCAyMDExIGF0IDEyOjM2OjA3QU0gKzAyMDAsIEphbnVzeiBLcnp5c3p0b2ZpayB3cm90
ZToKPiA+PiBGb2xsb3dpbmcgdGhlIHJlY2VpdmVfYnVmKCkgY2hhbmdlIHRvIHJldHVybiB0aGUg
bnVtYmVyIG9mIGJ5dGVzCj4gPj4gcmVjZWl2ZWQsIHRoZSBjeDIwNDQyIENPREVDIGRyaXZlciB3
YXMgdXBkYXRlZCB0byByZXBvcnQgdGhhdCB3ZQo+ID4+IGFjY2VwdGVkIGFsbCB0aGUgZGF0YSB0
aGF0IHdhcyBvZmZlcmVkIHRvIHVzLiBEbyB0aGUgc2FtZSB3aXRoIHRoZQo+ID4+IGNvcnJlc3Bv
bmRpbmcgQW1zdHJhZCBEZWx0YSBzb3VuZCBjYXJkIGxldmVsIHdyYXBwZXIgZnVuY3Rpb24sCj4g
Pj4gd2hpY2ggaXMgYWN0dWFsbHkgcmVnaXN0ZXJlZCBhcyB0aGUgdHR5IGxpbmUgZGlzY2lwbGlu
ZSBjYWxsYmFjawo+ID4+IGluc3RlYWQgb2YgdGhlIHRoZSBDT0RFQyBmdW5jdGlvbiwgd2hpY2gg
aXQgdGhlbiBjYWxscy4KPiA+PiAKPiA+PiBTaWduZWQtb2ZmLWJ5OiBKYW51c3ogS3J6eXN6dG9m
aWsgPGprcnp5c3p0QHRpcy5pY25ldC5wbD4KPiA+IAo+ID4gQWNrZWQtYnk6IE1hcmsgQnJvd24g
PGJyb29uaWVAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29tPgo+ID4gCj4gPiBidXQgYXMgdGhl
IFRUWSBBUEkgY2hhbmdlIGlzIGluIHRoZSBUVFkgdHJlZSBhdCB0aGUgbWludXRlIGFuZCBub3QK
PiA+IEFTb0MgeW91IHNob3VsZCBzZW5kIHRoaXMgdG8gR3JlZyBLLUggKGlkZWFsbHkgYWxzbyB3
aXRoIExpYW0ncwo+ID4gYWNrKSB1bmxlc3MgaXQncyBub3QgYmVlbiBhcHBsaWVkIGJ5IHRoZSB0
aW1lIHRoZSBtZXJnZSB3aW5kb3cKPiA+IGNvbWVzIHJvdW5kLgo+IAo+IEZpbmUgYnkgbWUgdG9v
Lgo+IAo+IEFja2VkLWJ5OiBMaWFtIEdpcmR3b29kIDxscmdAdGkuY29tPgoKSGksCkkgZmFpbGVk
IHRvIHNlbmQgdGhpcyBwYXRjaCB0byBHcmVnIGJlZm9yZSB0aGUgbWVyZ2Ugd2luZG93LCBzb3Jy
eS4gTm93IAp0aGF0IHdlIGFyZSBpbiB0aGUgcmMgY3ljbGUsIGNhbiBpdCBiZSBhcHBsaWVkIHRv
IHRoZSBzb3VuZCB0cmVlLCBvciAKc2hvdWxkIEkgcmVzZW5kIGl0PwoKVGhhbmtzLApKYW51c3oK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
