From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 0/7] Modernize vga_switcheroo by using device link for
 HDA
Date: Tue, 13 Mar 2018 12:36:34 -0500
Message-ID: <20180313173634.GB202215@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1520068884.git.lukas@wunner.de>
 <20180306102940.GG22212@phenom.ffwll.local>
 <20180311155549.GA11806@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20180311155549.GA11806@wunner.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, alsa-devel@alsa-project.org, Martin Lopatar <lopin@dataplex.cz>, Hans de Goede <hdegoede@redhat.com>, linux-pci@vger.kernel.org, Maik Freudenberg <hhfeuer@gmx.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Drake <dan@reactivated.net>, dri-devel@lists.freedesktop.org, Denis Lisov <dennis.lissov@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Peter Wu <peter@lekensteyn.nl>, nouveau@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

T24gU3VuLCBNYXIgMTEsIDIwMTggYXQgMDQ6NTU6NDlQTSArMDEwMCwgTHVrYXMgV3VubmVyIHdy
b3RlOgo+IE9uIFR1ZSwgTWFyIDA2LCAyMDE4IGF0IDExOjI5OjQwQU0gKzAxMDAsIERhbmllbCBW
ZXR0ZXIgd3JvdGU6Cj4gPiBPbiBTYXQsIE1hciAwMywgMjAxOCBhdCAxMDo1MzoyNEFNICswMTAw
LCBMdWthcyBXdW5uZXIgd3JvdGU6Cj4gPiA+IE1vZGVybml6ZSB2Z2Ffc3dpdGNoZXJvbyBieSB1
c2luZyBhIGRldmljZSBsaW5rIHRvIGVuZm9yY2UgYSBydW50aW1lIFBNCj4gPiA+IGRlcGVuZGVu
Y3kgZnJvbSBhbiBIREEgY29udHJvbGxlciB0byB0aGUgR1BVIGl0J3MgaW50ZWdyYXRlZCBpbnRv
LCB2Mi4KPiA+ID4gCj4gPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9sMWsvbGludXgvY29tbWl0cy9z
d2l0Y2hlcm9vX2RldmxpbmtfdjIKPiA+IAo+ID4gVGhpcyBhbGwgbG9va3MgcmVhbGx5IHJlYXNv
bmFibGUgYW5kIGxpa2UgYSBnb29kIGNsZWFudXAsIGJ1dCBpdCdzIGEgYml0Cj4gPiB0b28gbXVj
aCBkZXRhaWwgc28gSSdsbCBwdW50IHJldmlldyB0byBzb21lb25lIGVsc2Ugd2l0aCBtb3JlIGNs
dWUuCj4gCj4gUGF0Y2hlcyBbMy83XSB0byBbNy83XSB3ZXJlIHJldmlld2VkIGJ5IFBldGVyIFd1
LCB0aGUgSERBIGJpdHMgaW4KPiBwYXRjaCBbNS83XSBhZGRpdGlvbmFsbHkgYnkgVGFrYXNoaS4K
PiAKPiBQYXRjaCBbMi83XSB3YXMgYWNrZWQgYnkgQmpvcm4uICBUaGVyZSB3YXMgbm8gYWNrIGZv
ciBwYXRjaCBbMS83XQo+IChhdXRob3JlZCBieSBSYWZhZWwpLCBidXQgaXQgYWRyZXNzZWQgdGhl
IG9iamVjdGlvbiBCam9ybiByYWlzZWQKPiBhZ2FpbnN0IG15IG9yaWdpbmFsIHBhdGNoLCBzbyBJ
J20gYXNzdW1pbmcgQmpvcm4gaXMgb2theSB3aXRoIGl0Lgo+IChCam9ybiwgcGxlYXNlIGxldCBt
ZSBrbm93IGlmIHRoYXQgaXNuJ3QgdGhlIGNhc2UuKQoKSSBhbSBPSyB3aXRoIGl0LiAgSSBzZW50
IGFuIGFjayBhbmQgcG9zc2libGUgbWlub3IgY2hhbmdlbG9nIHR3ZWFrLgoKSSBleHBlY3QgdGhh
dCB5b3UnbGwgbWVyZ2UgdGhlIHdob2xlIHNlcmllcyB2aWEgZHJtLW1pc2MuCgo+IFRoZSBzZXJp
ZXMgaGFzIGJlZW4gdGVzdGVkIG9uIDUgc3lzdGVtcywgd2hpY2ggcmFpc2VzIHRoZSBjb25maWRl
bmNlOgo+IDJ4IEFNRCBQb3dlclhwcmVzcyAoTWlrZSBMb3RoaWFuLCBLYWkgSGVuZyBGZW5nKQo+
IDJ4IE52aWRpYSBPcHRpbXVzIChEZW5pcyBMaXNvdiwgUGV0ZXIgV3UpCj4gMXggTWFjQm9vayBQ
cm8KPiAKPiBUaGUgaXNzdWVzIGZvdW5kIGR1cmluZyBQZXRlciBXdSdzIHRob3JvdWdoIHRlc3Rp
bmcgYXBwZWFyIHRvIGFsbAo+IGJlIHVucmVsYXRlZCB0byB0aGlzIHNlcmllcywgYXMgcGVyIG15
IGUtbWFpbCB5ZXN0ZXJkYXkuCj4gCj4gSWYgdGhlcmUgYXJlIG5vIG9iamVjdGlvbnMsIEkgcGxh
biB0byBwdXNoIHRoZSBzZXJpZXMgdG8KPiBkcm0tbWlzYy1uZXh0IGJ5IHRoZSBtaWRkbGUgb2Yg
dGhlIGNvbWluZyB3ZWVrIHNvIHRoYXQgaXQKPiB3b3VsZCBzdGlsbCBjYXRjaCB0aGUgbGFzdCB0
cmFpbiB0byA0LjE3Lgo+IAo+IFRoYW5rcywKPiAKPiBMdWthcwpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
