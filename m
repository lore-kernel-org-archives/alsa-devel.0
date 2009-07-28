From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 2/4] Allow passing platform_data for
	pxa2xx-ac97
Date: Tue, 28 Jul 2009 07:28:20 +0200
Message-ID: <200907280728.21372.marek.vasut@gmail.com>
References: <200907211633.14388.marek.vasut@gmail.com>
	<200907231616.13101.marek.vasut@gmail.com>
	<200907232039.37952.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FC17244FA
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jul 2009 07:28:37 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e21so947594fga.21
	for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2009 22:28:36 -0700 (PDT)
In-Reply-To: <200907232039.37952.marek.vasut@gmail.com>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, Robert Jarzmik <robert.jarzmik@free.fr>, cbou@mail.ru, Eric Miao <eric.y.miao@gmail.com>, avorontsov@ru.mvista.com, dwmw2@infradead.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

RG5lIMSMdCAyMy4gxI1lcnZlbmNlIDIwMDkgMjA6Mzk6MzcgTWFyZWsgVmFzdXQgbmFwc2FsKGEp
Ogo+IERuZSDEjHQgMjMuIMSNZXJ2ZW5jZSAyMDA5IDE2OjE2OjEyIE1hcmVrIFZhc3V0IG5hcHNh
bChhKToKPiA+IERuZSDEjHQgMjMuIMSNZXJ2ZW5jZSAyMDA5IDEyOjI3OjQxIE1hcmsgQnJvd24g
bmFwc2FsKGEpOgo+ID4gPiBPbiBXZWQsIEp1bCAyMiwgMjAwOSBhdCAwMTowMjo0MFBNICswMjAw
LCBNYXJlayBWYXN1dCB3cm90ZToKPiA+ID4gPiAgCXN0cnVjdCBzbmRfYWM5N19idXMgKmFjOTdf
YnVzOwo+ID4gPiA+ICAJc3RydWN0IHNuZF9hYzk3X3RlbXBsYXRlIGFjOTdfdGVtcGxhdGU7Cj4g
PiA+ID4gIAlpbnQgcmV0Owo+ID4gPiA+ICsJcHhhMnh4X2F1ZGlvX29wc190ICpwZGF0YSA9IGRl
di0+ZGV2LnBsYXRmb3JtX2RhdGE7Cj4gPiA+ID4gKwlpbnQgaWQgPSBkZXYtPmlkIDwgMCA/IDAg
OiBkZXYtPmlkOwo+ID4gPgo+ID4gPiBkZXYgaGVyZSBpcyB0aGUgQUM5NyBjb250cm9sbGVyIGRl
dmljZSAtIGlmIHRoZXJlJ3MgbW9yZSB0aGFuIG9uZSBBQzk3Cj4gPiA+IGNvbnRyb2xsZXIgaW4g
dGhlIHN5c3RlbSB0aGV5IGNhbiBlYWNoIGhhdmUgdGhlIGZvdXIgY2hpbGQgZGV2aWNlcy4gIE9u
Cj4gPiA+IHRoZSBvdGhlciBoYW5kLCBJIGRvbid0IHRoaW5rIGFueSBvZiB0aGUgUFhBIHByb2Nl
c3NvcnMgaGF2ZSBtb3JlIHRoYW4KPiA+ID4gb25lIEFDOTcgY29udHJvbGxlciBzbyBpdCdsbCBu
ZXZlciBhY3R1YWxseSBoYXZlIGFueSBpbXBhY3QuCj4gPiA+Cj4gPiA+IEkgdGhpbmsgdGhlIGJl
c3QgdGhpbmcgZm9yIG5vdyBpcyB0byBlaXRoZXIgd2FybiBpZiBhbnl0aGluZyBleGNlcHQgdGhl
Cj4gPiA+IHByaW1hcnkgY29kZWMgaGFzIHBsYXRmb3JtIGRhdGEgb3IgY2hhbmdlIHRoZSBwbGF0
Zm9ybSBkYXRhIHRvIGhhdmUgYQo+ID4gPiB2YXJpYWJsZSBzb21ldGhpbmcgbGlrZSBwcmltYXJ5
X2F1ZGlvX3BkYXRhLiAgVGhlIGRyaXZlciBkb2Vzbid0IGFwcGVhcgo+ID4gPiB0byBzdXBwb3J0
IHNlY29uZGFyeSBjb2RlY3MgYW55d2F5Lgo+ID4KPiA+IE9rLCBoZXJlJ3MgYSBmaXhlZCBwYXRj
aC4KPgo+IEFyZ2gsIG9uZSBtb3JlIGl0ZXJhdGlvbiBoZXJlLiBUaGVyZSB3YXMgYSB0eXBvIGlu
IHRoZSBwcmV2aW91cyBwYXRjaC4KPiBTb3JyeS4KCkhpLCB3ZWxsIC4uLiBhbnkgdXBkYXRlcyA/
IEVyaWMsIGlzIHRoaXMgcGF0Y2ggb2sgd2l0aCB5b3UgPwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
