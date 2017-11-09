From: "Agrawal, Akshu" <Akshu.Agrawal-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 2/3] ASoC: rt5645: Wait for 400msec before concluding
 on value of RT5645_VENDOR_ID2
Date: Thu, 9 Nov 2017 14:44:59 +0530
Message-ID: <042f85a6-2fa8-2a2f-1733-fd57f807722b@amd.com>
References: <20171108172404.19118-1-alexander.deucher@amd.com>
 <20171108172404.19118-3-alexander.deucher@amd.com>
 <20171108180957.ddcdyzu2fschypbx@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171108180957.ddcdyzu2fschypbx-7j8lgAiuQgnQXOPxS62xeg@public.gmane.org>
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
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Bard Liao <bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

CgpPbiAxMS84LzIwMTcgMTE6MzkgUE0sIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gV2VkLCBOb3Yg
MDgsIDIwMTcgYXQgMTI6MjQ6MDNQTSAtMDUwMCwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IAo+PiAg
IAlyZWdtYXBfcmVhZChyZWdtYXAsIFJUNTY0NV9WRU5ET1JfSUQyLCAmdmFsKTsKPj4gICAKPj4g
KwkvKgo+PiArCSAqIFJlYWQgYWZ0ZXIgNDAwbXNlYywgYXMgaXQgaXMgdGhlIGludGVydmFsIHJl
cXVpcmVkIGJldHdlZW4KPj4gKwkgKiByZWFkIGFuZCBwb3dlciBPbi4KPj4gKwkgKi8KPj4gKwlt
c2xlZXAoVElNRV9UT19QT1dFUl9NUyk7Cj4+ICsJcmVnbWFwX3JlYWQocmVnbWFwLCBSVDU2NDVf
VkVORE9SX0lEMiwgJnZhbCk7Cj4+ICsKPiAKPiBUaGlzIGxlYXZlcyB0aGUgb3JpZ2luYWwgcmVh
ZCBpbiB0aGVyZSBzbyB3ZSd2ZSBib3RoIGdvdCB0aGUgZWFybHkgcmVhZAo+ICh3aGljaCBtaWdo
dCB1cHNldCB0aGluZ3MgcG90ZW50aWFsbHkpIGFuZCB0aGUgZGVsYXllZCByZWFkLiAgU2hvdWxk
bid0Cj4gd2UganVzdCBiZSBhZGRpbmcgYSBtc2xlZXAoKSBiZWZvcmUgdGhlIGV4aXN0aW5nIHJl
YWQ/Cj4gCgpNeSBiYWQsIEkgc2hvdWxkIGhhdmUgcmVtb3ZlZCB0aGUgYWRkaXRpb24gb2YgcmVn
aXN0ZXIgcmVhZCBmcm9tIHRoZSBwYXRjaC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
