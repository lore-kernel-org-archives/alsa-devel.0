From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ASoC: amd: fix report accurate hw_ptr during dma
Date: Wed, 8 Nov 2017 15:01:04 -0500
Message-ID: <CADnq5_PT5Gerz-gDUFw5VGZvcucHP3Ng-_SFTpBHxQXT9QezEA@mail.gmail.com>
References: <20171108181841.29332-1-alexander.deucher@amd.com>
 <20171108182214.bwdvt5wwwz7wqf32@sirena.co.uk>
 <CADnq5_PM=C9OjseqvV8M5ohm7Mo18foHGPUkFZSnVNpVruut8Q@mail.gmail.com>
 <20171108184752.wff6qn6ssguaegkq@sirena.co.uk>
 <CABXOdTd6ptUM3E0V6B_hg9unh+na_XHK6AbyfREx5WiYwdckkA@mail.gmail.com>
 <20171108194948.bq46lwurlzf45tzm@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171108194948.bq46lwurlzf45tzm-7j8lgAiuQgnQXOPxS62xeg@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Guenter Roeck <groeck-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Vijendar Mukunda <Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBOb3YgOCwgMjAxNyBhdCAyOjQ5IFBNLCBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5l
bC5vcmc+IHdyb3RlOgo+IE9uIFdlZCwgTm92IDA4LCAyMDE3IGF0IDExOjEzOjUwQU0gLTA4MDAs
IEd1ZW50ZXIgUm9lY2sgd3JvdGU6Cj4+IE9uIFdlZCwgTm92IDgsIDIwMTcgYXQgMTA6NDcgQU0s
IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4gd3JvdGU6Cj4KPj4gPiBJcyB0aGlzIGRp
ZmZlcmVudCB0byAiQVNvQzogYW1kOiBSZXBvcnQgYWNjdXJhdGUgaHdfcHRyIGR1cmluZyBkbWEi
Cj4+ID4gd2hpY2ggd2FzIGFwcGxpZWQgYXQgMTY6MDc/Cj4KPj4gSSBzdXNwZWN0IHdlIG1heSBi
ZSBnZXR0aW5nIGhpdCBieSBjaHJvbWVvcy1pc21zIGFnYWluLiBJbiBDaHJvbWUgT1MsIHdlCj4+
IGRvbid0IHVzZSBGaXhlczogdGFncyBidXQgIkZJWFVQOiA8b3JpZ2luYWwgZGVzY3JpcHRpb24+
IiBpbiB0aGUgc3ViamVjdAo+PiAobm90IHRoYXQgSSBsaWtlIGl0LCBidXQgaXQgaXMgd2hhdCBp
dCBpcykuCj4KPiBTbyBpdCBwcm9iYWJseSBpcyB0aGUgc2FtZSBwYXRjaCB0aGF0IHdhcyBqdXN0
IHJlc2VudCB3aXRoIGEgc2xpZ2h0bHkKPiBtb2RpZmllZCBzdWJqZWN0IGxpbmU/ICBUaGF0J3Mg
d2hhdCBpdCBsb29rZWQgbGlrZSBpbml0aWFsbHkuCgpUaGUgb3JpZ2luYWwgcGF0Y2ggd2hpY2gg
d2FzIGFwcGxpZWQgdG8geW91ciB0cmVlIGFscmVhZHk6Cmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2Jyb29uaWUvc291bmQuZ2l0L2NvbW1pdC8/aD1mb3It
bmV4dCZpZD02MWFkZDgxNDc5NDJkMjM1MTliOTFmMGVkYzMwOTgwZDdjMTQ0ODJjClRoYXQgcGF0
Y2ggYXMgYSA2NCBiaXQgZGl2aWRlIGluIGl0IHdoaWNoIHdhcyBmaXhlZCBieSB0aGlzIHBhdGNo
IGZyb20gR3VlbnRlcjoKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvYXJjaGl2ZXMvZHJp
LWRldmVsLzIwMTctTm92ZW1iZXIvMTU3MDYzLmh0bWwKd2hpY2ggY29udGFpbmVkIGEgYnVuY2gg
b2YgQ2hyb21lIHRhZ3MuICBJIHJlbW92ZWQgdGhlIHRhZ3MgYW5kCnVwZGF0ZWQgdGhlIHN1Ympl
Y3QgYW5kIGFkZGVkIGEgZml4ZXMgbGluZSBhbmQgcmVzZW50IGl0IGFzIHRoaXMgcGF0Y2gKKHN1
YmplY3Qgb2YgdGhpcyB0aHJlYWQpOgpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9hcmNo
aXZlcy9kcmktZGV2ZWwvMjAxNy1Ob3ZlbWJlci8xNTcwNzYuaHRtbApQbGVhc2UgYXBwbHkuICBT
b3JyeSBmb3IgdGhlIGNvbmZ1c2lvbi4KCkFsZXgKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
