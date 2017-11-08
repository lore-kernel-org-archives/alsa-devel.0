From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] ASoC: amd: fix report accurate hw_ptr during dma
Date: Wed, 8 Nov 2017 19:18:06 +0000
Message-ID: <BN6PR12MB1652F8671D062FDE91D42951F7560@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <20171108181841.29332-1-alexander.deucher@amd.com>
 <20171108182214.bwdvt5wwwz7wqf32@sirena.co.uk>
 <CADnq5_PM=C9OjseqvV8M5ohm7Mo18foHGPUkFZSnVNpVruut8Q@mail.gmail.com>
 <20171108184752.wff6qn6ssguaegkq@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171108184752.wff6qn6ssguaegkq-7j8lgAiuQgnQXOPxS62xeg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Mukunda,
 Vijendar" <Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IE1hcmsgQnJvd24gW21haWx0bzpi
cm9vbmllQGtlcm5lbC5vcmddCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAwOCwgMjAxNyAx
OjQ4IFBNCj4gVG86IEFsZXggRGV1Y2hlcgo+IENjOiBhbWQtZ2Z4IGxpc3Q7IGFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZzsgTWFsaW5nIGxpc3QgLSBEUkkgZGV2ZWxvcGVyczsKPiBNdWt1bmRh
LCBWaWplbmRhcjsgTGlhbSBHaXJkd29vZDsgVGFrYXNoaSBJd2FpOyBHdWVudGVyIFJvZWNrOyBE
ZXVjaGVyLAo+IEFsZXhhbmRlcgo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIEFTb0M6IGFtZDogZml4
IHJlcG9ydCBhY2N1cmF0ZSBod19wdHIgZHVyaW5nIGRtYQo+IAo+IE9uIFdlZCwgTm92IDA4LCAy
MDE3IGF0IDAxOjQwOjMyUE0gLTA1MDAsIEFsZXggRGV1Y2hlciB3cm90ZToKPiA+IE9uIFdlZCwg
Tm92IDgsIDIwMTcgYXQgMToyMiBQTSwgTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPgo+
IHdyb3RlOgo+IAo+ID4gPiBMaWtlIEkgc2FpZCBpbiByZXBseSB0byB5b3VyIG90aGVyIG1haWwg
cGxlYXNlIGRvbid0IHJlc3VibWl0IGFscmVhZHkKPiA+ID4gYXBwbGllZCBwYXRjaGVzLiAgVGhl
IGN1cnJlbnQgdGlwIG9mIG15IHRvcGljL2FtZCBicmFuY2ggYXBwZWFycyB0byBiZQo+ID4gPiB0
aGlzIHZlcnkgcGF0Y2gsIGlmIHRoZXJlJ3MgYW55dGhpbmcgbmVlZHMgY2hhbmdpbmcgcGxlYXNl
IHNlbmQgYW4KPiA+ID4gaW5jcmVtZW50YWwgcGF0Y2guCj4gCj4gPiBJJ20gbm90IHNlZWluZyB0
aGlzIG9uZSBpbiB5b3VyIHRyZWUgZWl0aGVyLiAgVGhpcyBpcyBqdXN0IGEgcmVzZW5kIG9mCj4g
PiBHdWVudGVyJ3MgcGF0Y2ggZnJvbSBhbiBob3VyIGFnbyB3aXRoIHRoZSBjaHJvbWl1bSBzdHVm
ZiByZW1vdmVkLgo+ID4gTWF5YmUgeW91IGFscmVhZHkgYXBwbGllZCBpdCBpbiB0aGUgaW50ZXJp
bT8KPiAKPiBJcyB0aGlzIGRpZmZlcmVudCB0byAiQVNvQzogYW1kOiBSZXBvcnQgYWNjdXJhdGUg
aHdfcHRyIGR1cmluZyBkbWEiCj4gd2hpY2ggd2FzIGFwcGxpZWQgYXQgMTY6MDc/CgpZZXMsIHRo
aXMgaXMgYSBmaXggZm9yIHRoYXQgcGF0Y2guICBJdCBmaXhlcyBhIDY0IGJpdCBkaXZpc2lvbiB0
aGF0IHdhc24ndCBwcm9wZXJseSBoYW5kbGVkLgoKQWxleAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
