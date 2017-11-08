From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ASoC: amd: fix report accurate hw_ptr during dma
Date: Wed, 8 Nov 2017 13:40:32 -0500
Message-ID: <CADnq5_PM=C9OjseqvV8M5ohm7Mo18foHGPUkFZSnVNpVruut8Q@mail.gmail.com>
References: <20171108181841.29332-1-alexander.deucher@amd.com>
 <20171108182214.bwdvt5wwwz7wqf32@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171108182214.bwdvt5wwwz7wqf32-7j8lgAiuQgnQXOPxS62xeg@public.gmane.org>
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
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Vijendar Mukunda <Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBOb3YgOCwgMjAxNyBhdCAxOjIyIFBNLCBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5l
bC5vcmc+IHdyb3RlOgo+IE9uIFdlZCwgTm92IDA4LCAyMDE3IGF0IDAxOjE4OjQxUE0gLTA1MDAs
IEFsZXggRGV1Y2hlciB3cm90ZToKPj4gRnJvbTogR3VlbnRlciBSb2VjayA8Z3JvZWNrQGNocm9t
aXVtLm9yZz4KPj4KPj4gRVJST1I6ICJfX2FlYWJpX3VsZGl2bW9kIiBbc291bmQvc29jL2FtZC9z
bmQtc29jLWFjcC1wY20ua29dIHVuZGVmaW5lZCEKPj4KPj4gNjQtYml0IGRpdmlkZXMgcmVxdWly
ZSBzcGVjaWFsIG9wZXJhdGlvbnMgdG8gYXZvaWQgYnVpbGQgZXJyb3JzIG9uIDMyLWJpdAo+PiBz
eXN0ZW1zLgo+Cj4gTGlrZSBJIHNhaWQgaW4gcmVwbHkgdG8geW91ciBvdGhlciBtYWlsIHBsZWFz
ZSBkb24ndCByZXN1Ym1pdCBhbHJlYWR5Cj4gYXBwbGllZCBwYXRjaGVzLiAgVGhlIGN1cnJlbnQg
dGlwIG9mIG15IHRvcGljL2FtZCBicmFuY2ggYXBwZWFycyB0byBiZQo+IHRoaXMgdmVyeSBwYXRj
aCwgaWYgdGhlcmUncyBhbnl0aGluZyBuZWVkcyBjaGFuZ2luZyBwbGVhc2Ugc2VuZCBhbgo+IGlu
Y3JlbWVudGFsIHBhdGNoLgoKSSdtIG5vdCBzZWVpbmcgdGhpcyBvbmUgaW4geW91ciB0cmVlIGVp
dGhlci4gIFRoaXMgaXMganVzdCBhIHJlc2VuZCBvZgpHdWVudGVyJ3MgcGF0Y2ggZnJvbSBhbiBo
b3VyIGFnbyB3aXRoIHRoZSBjaHJvbWl1bSBzdHVmZiByZW1vdmVkLgpNYXliZSB5b3UgYWxyZWFk
eSBhcHBsaWVkIGl0IGluIHRoZSBpbnRlcmltPwoKQWxleApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
