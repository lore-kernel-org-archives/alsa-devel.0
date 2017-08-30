From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 0/6 v3] Add ASoC support for AMD Stoney APUs
Date: Wed, 30 Aug 2017 15:46:02 +0000
Message-ID: <BN6PR12MB16520B3DEC6531D112440D58F79C0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1503079830-16072-1-git-send-email-alexander.deucher@amd.com>
 <CADnq5_NV0wmstpos9Hqc_dbTAOOOUozb=B_-6vd1PhD=zCMLhQ@mail.gmail.com>
 <20170830151913.6vknazyhh4se5524@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170830151913.6vknazyhh4se5524-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
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
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, rajeev kumar <rajeevkumar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Mukunda,
 Vijendar" <Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IE1hcmsgQnJvd24gW21haWx0bzpi
cm9vbmllQGtlcm5lbC5vcmddCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMzAsIDIwMTcgMTE6
MTkgQU0KPiBUbzogQWxleCBEZXVjaGVyCj4gQ2M6IGFtZC1nZnggbGlzdDsgTWFsaW5nIGxpc3Qg
LSBEUkkgZGV2ZWxvcGVyczsgRGF2ZSBBaXJsaWU7IGFsc2EtZGV2ZWxAYWxzYS0KPiBwcm9qZWN0
Lm9yZzsgTXVrdW5kYSwgVmlqZW5kYXI7IHJhamVldiBrdW1hcjsgcGVyZXhAcGVyZXguY3o7IExp
YW0KPiBHaXJkd29vZDsgVGFrYXNoaSBJd2FpOyBEZXVjaGVyLCBBbGV4YW5kZXIKPiBTdWJqZWN0
OiBSZTogW1BBVENIIDAvNiB2M10gQWRkIEFTb0Mgc3VwcG9ydCBmb3IgQU1EIFN0b25leSBBUFVz
Cj4gCj4gT24gV2VkLCBBdWcgMzAsIDIwMTcgYXQgMDk6MzM6MzVBTSAtMDQwMCwgQWxleCBEZXVj
aGVyIHdyb3RlOgo+IAo+ID4gQW55IGNvbW1lbnRzPyAgQ2FuIHRoaXMgcGF0Y2ggc2V0IGdvIGlu
PyAgVGhpcyBpcyB0aGUgc2Vjb25kIHRpbWUgSSd2ZQo+ID4gcmVzZW50IGl0IHNpbmNlIHRoZSBh
ZGRyZXNzaW5nIHRoZSBpbml0aWFsIGZlZWRiYWNrLiAgRG9lcyBhbnlvbmUgaGF2ZQo+ID4gYSBw
cmVmZXJlbmNlIG9uIHdoaWNoIHRyZWU/Cj4gCj4gWW91IG5lZWQgdG8gZ2V0IHNvbWVvbmUgZnJv
bSB0aGUgRFJNIHNpZGUgdG8gcGF5IGF0dGVudGlvbiB0byB0aGUgc2Vjb25kCj4gcGF0Y2ggYW5k
IHlvdSBuZWVkIHRvIHN0b3AgcmVzZW5kaW5nIHRoZSBmaXJzdCBwYXRjaCBzaW5jZSBhcyBoYXMg
YmVlbgo+IHBvaW50ZWQgb3V0IGEgZmV3IHRpbWVzIG5vdyB5b3UgbmVlZCB0byBzdG9wIHNlbmRp
bmcgdGhlIGZpcnN0IHBhdGNoCj4gd2hpY2ggaXMgYWxyZWFkeSBpbiBMaW51cycgdHJlZS4KCkkg
ZGlkbid0IHJlc2VudCBhbnkgcGF0Y2hlcyB0aGF0IGFyZSBhbHJlYWR5IHVwc3RyZWFtIGluIHYz
IG9mIHRoaXMgcGF0Y2ggc2V0LiAgVGhlIHJlc3Qgb2YgdGhlIHBhdGNoZXMgaGF2ZSBkZXBlbmRl
bmNpZXMgYmV0d2VlbiBkcm0gYW5kIGF1ZGlvLiAgSSdkIGxpa2UgdG8gZ2V0IHRoZW0gaW4gYWxs
IHRvZ2V0aGVyIHZpYSBvbmUgdHJlZSBvciB0aGUgb3RoZXIuCgpBbGV4CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
