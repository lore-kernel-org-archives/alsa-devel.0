From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [alsa-devel] [PATCH 0/6 v4] Add ASoC support for AMD Stoney APUs
Date: Thu, 28 Sep 2017 19:21:07 +0000
Message-ID: <BN6PR12MB165217002EC43137E3F87F83F7790@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1505325475-22602-1-git-send-email-alexander.deucher@amd.com>
 <20170913181218.bb2br4zehzjoatyq@sirena.org.uk>
 <CADnq5_PdpjS448n6u6tPBqgKfEw278BENMTjVPiEQ4zQx313AA@mail.gmail.com>
 <20170914174228.esh6lvih3yjs46ur@sirena.org.uk>
 <20170928185936.zajc466sp6ttuh7v@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170928185936.zajc466sp6ttuh7v-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
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
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, rajeev kumar <rajeevkumar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Mukunda,
 Vijendar" <Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IE1hcmsgQnJvd24gW21haWx0bzpi
cm9vbmllQGtlcm5lbC5vcmddCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyOCwgMjAxNyAz
OjAwIFBNCj4gVG86IEFsZXggRGV1Y2hlcgo+IENjOiBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmc7IFRha2FzaGkgSXdhaTsgTGlhbSBHaXJkd29vZDsgTWFsaW5nIGxpc3QgLQo+IERSSSBkZXZl
bG9wZXJzOyByYWplZXYga3VtYXI7IGFtZC1nZnggbGlzdDsgTXVrdW5kYSwgVmlqZW5kYXI7IERl
dWNoZXIsCj4gQWxleGFuZGVyOyBEYXZlIEFpcmxpZQo+IFN1YmplY3Q6IFJlOiBbYWxzYS1kZXZl
bF0gW1BBVENIIDAvNiB2NF0gQWRkIEFTb0Mgc3VwcG9ydCBmb3IgQU1EIFN0b25leQo+IEFQVXMK
PiAKPiBPbiBUaHUsIFNlcCAxNCwgMjAxNyBhdCAxMDo0MjoyOEFNIC0wNzAwLCBNYXJrIEJyb3du
IHdyb3RlOgo+ID4gT24gV2VkLCBTZXAgMTMsIDIwMTcgYXQgMDI6NDk6MDhQTSAtMDQwMCwgQWxl
eCBEZXVjaGVyIHdyb3RlOgo+IAo+ID4gPiBJJ20gbm90IHF1aXRlIHN1cmUgd2hhdCB5b3UgbWVh
biBieSB0aGUgY3Jvc3MgbWVyZ2UuICBUaGVyZSBhcmUgbm8KPiA+ID4gZGVwZW5kZW5jaWVzIG91
dHNpZGUgdGhpcyBwYXRjaCBzZXQuICBUaGUgb25seSBwYXRjaGVzIHRoYXQgdG91Y2ggZHJtCj4g
PiA+IGFyZSBwYXRjaGVzIDEgYW5kIDIuICBQYXRjaCAxIHRvdWNoZXMgYm90aCBhdWRpbyBhbmQg
ZHJtLCBwYXRjaCAyIGp1c3QKPiA+ID4gdG91Y2hlcyBkcm0uICBEbyB5b3Ugd2FudCBtZSB0byBz
ZW5kIHlvdSBhIHB1bGwgcmVxdWVzdCBmb3IgcGF0Y2hlcyAxCj4gCj4gPiBJIGNhbid0IHNlZSBh
bnkgcmVhc29uIGZvciBwYXRjaCAxIHRvIGJlIGEgc2luZ2xlIHBhdGNoLCBqdXN0IGhhdmUgYSBE
Uk0KPiA+IHBhdGNoIHRoYXQgYWRkcyB0aGUgcHJvcGVydHkgYW5kIHRoZW4gYSBzZXBhcmF0ZSBh
dWRpbyBwYXRjaCB0aGF0IHVzZXMKPiA+IGl0LiAgU2VuZCBtZSBhIHB1bGwgcmVxdWVzdCBmb3Ig
dGhhdCBhbmQgcGF0Y2ggMiB0aGVuIEkgY2FuIGhhbmRsZSB0aGUKPiA+IGF1ZGlvIHN0dWZmLgo+
IAo+IEFueSB1cGRhdGVzIHdpdGggdGhlIHB1bGwgcmVxdWVzdHM/CgpTb3JyeSB0cmF2ZWxsaW5n
IGxhc3Qgd2VlayBhbmQgc3dhbXBlZCB0aGlzIHdlZWsuICBJJ20gZ29pbmcgdG8gdHJ5IGFuZCBn
ZXQgaXQgZG9uZSB0b21vcnJvdywgb3RoZXJ3aXNlLCBwcm9iYWJseSB0aGUgd2VlayBhZnRlci4K
CkFsZXgKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
