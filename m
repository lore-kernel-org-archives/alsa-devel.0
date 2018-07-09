From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: Re: [alsa-devel] ??????: [PATCH] vgaswitchroo: set audio client id
 according to bound gpu client id
Date: Mon, 9 Jul 2018 18:06:44 +0200
Message-ID: <20180709160644.GB1490@wunner.de>
References: <20180629092138.GA11849@wunner.de>
 <DM3PR12MB08732DAAAA57739DCE431D66994E0@DM3PR12MB0873.namprd12.prod.outlook.com>
 <20180629111108.GA11609@wunner.de>
 <DM3PR12MB0873FEC702770190057B49F799440@DM3PR12MB0873.namprd12.prod.outlook.com>
 <20180709092759.GA3649@wunner.de>
 <DM3PR12MB087309CBC2CD3A934327EBCE99440@DM3PR12MB0873.namprd12.prod.outlook.com>
 <CADnq5_OpZz=AgNomX7+5BzeN77CRZT7mXDT7kn620TE-OjqS0w@mail.gmail.com>
 <s5hr2kco3gp.wl-tiwai@suse.de> <20180709154734.GA30496@wunner.de>
 <s5hsh4scsoe.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s5hsh4scsoe.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Qu,
 Jim" <Jim.Qu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBKdWwgMDksIDIwMTggYXQgMDU6NTI6NDlQTSArMDIwMCwgVGFrYXNoaSBJd2FpIHdy
b3RlOgo+IE9uIE1vbiwgMDkgSnVsIDIwMTggMTc6NDc6MzQgKzAyMDAsIEx1a2FzIFd1bm5lciB3
cm90ZToKPiA+IFNpbmNlIHY0LjE3LCBldmVyeSB0aW1lIHRoZSBHUFUgaXMgcG93ZXJlZCB1cCwg
dGhlIEhEQSBjb250cm9sbGVyIGlzCj4gPiBydW50aW1lIHJlc3VtZWQgdG8gUENJX0QwLiAgKFNl
ZSB0aGUgY2FsbCB0byBwY2lfd2FrZXVwX2J1cygpIGluCj4gPiB2Z2Ffc3dpdGNoZXJvb19ydW50
aW1lX3Jlc3VtZSgpIGFkZGVkIGJ5IGRjYWM4NmI3ZDAuKQo+ID4gCj4gPiBJZiB0aGUgSERBIGNv
bnRyb2xsZXIgY2FuJ3QgZGV0ZWN0IHByZXNlbmNlIG9mIGFuIEhETUkgZGlzcGxheSBldmVuCj4g
PiBpZiBpdCdzIGluIFBDSV9EMCwgdGhlbiBJIHN1cHBvc2UgdGhhdCBuZWVkcyB0byBiZSBhZHJl
c3NlZCBpbiB0aGUgSERBCj4gPiBkcml2ZXIuICBUaHVzIHNvIGZhciBJIGRvbid0IHNlZSB0aGUg
bmVlZCB0byBjYWxsIGZyb20gYW1kZ3B1IGludG8gdGhlCj4gPiBIREEgZHJpdmVyLgo+IAo+IEl0
J3Mgbm90IGFib3V0IHRoZSBQQ0kgcG93ZXIgc3RhdGUsIGJ1dCB0aGUgcHJvYmxlbSBpcyB0aGF0
IHRoZQo+IGRldGVjdGlvbiBvZiB0aGUgSERNSSBhbmQgaXRzIEVMRCByZWFkIGlzIHNvbWV3aGF0
IGFzeW5jaHJvbm91cy4KPiBCYXNpY2FsbHkgaXQncyBoYW5kbGVkIHZpYSB0aGUgaGFyZHdhcmUg
dW5zb2xpY2l0ZWQgZXZlbnQgZW1pdHRlZCBvdmVyCj4gSEQtYXVkaW8gYnVzLCB3aGljaCB3YXMg
b3JpZ2luYWxseSBnZW5lcmF0ZWQgYnkgR1BVIGF0IGRlYWxpbmcgd2l0aAo+IHRoZSBob3RwbHVn
L3VucGx1Zy4gIFNvLCB0aGlzIHBhcnQgaXMgcmFjeSBhbmQgbm90IDEwMCUgcmVsaWFibGUgLS0K
PiBhbHRob3VnaCB1c3VhbGx5IGl0IHNob3VsZG4ndCBiZSBhIGJpZyBwcm9ibGVtLgo+IAo+IFRo
YXQgc2FpZCwgaXQncyBub3QgdGhlIGV4YWN0ICJuZWVkIiBidXQgaXQgd291bGQgbWFrZSB0aGlu
Z3MgbW9yZQo+IHJlbGlhYmxlIGFuZCBhY2N1cmF0ZSAoZXZlbiBjb25zdW1lcyBsZXNzIHBvd2Vy
IGFzIHdlIGRvbid0IG5lZWQgdG8KPiBwb3dlciB1cC9kb3duIGp1c3QgZm9yIHRoZSBIRE1JIGRl
dGVjdGlvbikuCgpPa2F5LiAgSWYgYW1kZ3B1IHRyaWdnZXJzIHRoZSBldmVudCBvbiB0aGUgSERB
IGJ1cywgaXQgc2hvdWxkIGNhbGwKcG1fcnVudGltZV9nZXRfc3luYygpIG9uIHRoZSBIREEgZGV2
aWNlIGJlZm9yZWhhbmQuICBXaGljaCBkZXZpY2UKbmVlZHMgdG8gYmUgcmVzdW1lZCBleGFjdGx5
IHRvIGVuc3VyZSBFTEQgcmVjZXB0aW9uLCB0aGUgUENJIG9uZQpvciB0aGUgY29kZWM/CgpUaGFu
a3MsCgpMdWthcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
