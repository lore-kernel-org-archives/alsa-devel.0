From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 0/7] Modernize vga_switcheroo by using device link for
 HDA
Date: Sun, 11 Mar 2018 16:55:49 +0100
Message-ID: <20180311155549.GA11806@wunner.de>
References: <cover.1520068884.git.lukas@wunner.de>
 <20180306102940.GG22212@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20180306102940.GG22212@phenom.ffwll.local>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Sean Paul <seanpaul@chromium.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Gustavo Padovan <gustavo@padovan.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: alsa-devel@alsa-project.org, Martin Lopatar <lopin@dataplex.cz>, nouveau@lists.freedesktop.org, Maik Freudenberg <hhfeuer@gmx.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Denis Lisov <dennis.lissov@gmail.com>, dri-devel@lists.freedesktop.org, Daniel Drake <dan@reactivated.net>, Hans de Goede <hdegoede@redhat.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Peter Wu <peter@lekensteyn.nl>, linux-pci@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBNYXIgMDYsIDIwMTggYXQgMTE6Mjk6NDBBTSArMDEwMCwgRGFuaWVsIFZldHRlciB3
cm90ZToKPiBPbiBTYXQsIE1hciAwMywgMjAxOCBhdCAxMDo1MzoyNEFNICswMTAwLCBMdWthcyBX
dW5uZXIgd3JvdGU6Cj4gPiBNb2Rlcm5pemUgdmdhX3N3aXRjaGVyb28gYnkgdXNpbmcgYSBkZXZp
Y2UgbGluayB0byBlbmZvcmNlIGEgcnVudGltZSBQTQo+ID4gZGVwZW5kZW5jeSBmcm9tIGFuIEhE
QSBjb250cm9sbGVyIHRvIHRoZSBHUFUgaXQncyBpbnRlZ3JhdGVkIGludG8sIHYyLgo+ID4gCj4g
PiBodHRwczovL2dpdGh1Yi5jb20vbDFrL2xpbnV4L2NvbW1pdHMvc3dpdGNoZXJvb19kZXZsaW5r
X3YyCj4gCj4gVGhpcyBhbGwgbG9va3MgcmVhbGx5IHJlYXNvbmFibGUgYW5kIGxpa2UgYSBnb29k
IGNsZWFudXAsIGJ1dCBpdCdzIGEgYml0Cj4gdG9vIG11Y2ggZGV0YWlsIHNvIEknbGwgcHVudCBy
ZXZpZXcgdG8gc29tZW9uZSBlbHNlIHdpdGggbW9yZSBjbHVlLgoKUGF0Y2hlcyBbMy83XSB0byBb
Ny83XSB3ZXJlIHJldmlld2VkIGJ5IFBldGVyIFd1LCB0aGUgSERBIGJpdHMgaW4KcGF0Y2ggWzUv
N10gYWRkaXRpb25hbGx5IGJ5IFRha2FzaGkuCgpQYXRjaCBbMi83XSB3YXMgYWNrZWQgYnkgQmpv
cm4uICBUaGVyZSB3YXMgbm8gYWNrIGZvciBwYXRjaCBbMS83XQooYXV0aG9yZWQgYnkgUmFmYWVs
KSwgYnV0IGl0IGFkcmVzc2VkIHRoZSBvYmplY3Rpb24gQmpvcm4gcmFpc2VkCmFnYWluc3QgbXkg
b3JpZ2luYWwgcGF0Y2gsIHNvIEknbSBhc3N1bWluZyBCam9ybiBpcyBva2F5IHdpdGggaXQuCihC
am9ybiwgcGxlYXNlIGxldCBtZSBrbm93IGlmIHRoYXQgaXNuJ3QgdGhlIGNhc2UuKQoKVGhlIHNl
cmllcyBoYXMgYmVlbiB0ZXN0ZWQgb24gNSBzeXN0ZW1zLCB3aGljaCByYWlzZXMgdGhlIGNvbmZp
ZGVuY2U6CjJ4IEFNRCBQb3dlclhwcmVzcyAoTWlrZSBMb3RoaWFuLCBLYWkgSGVuZyBGZW5nKQoy
eCBOdmlkaWEgT3B0aW11cyAoRGVuaXMgTGlzb3YsIFBldGVyIFd1KQoxeCBNYWNCb29rIFBybwoK
VGhlIGlzc3VlcyBmb3VuZCBkdXJpbmcgUGV0ZXIgV3UncyB0aG9yb3VnaCB0ZXN0aW5nIGFwcGVh
ciB0byBhbGwKYmUgdW5yZWxhdGVkIHRvIHRoaXMgc2VyaWVzLCBhcyBwZXIgbXkgZS1tYWlsIHll
c3RlcmRheS4KCklmIHRoZXJlIGFyZSBubyBvYmplY3Rpb25zLCBJIHBsYW4gdG8gcHVzaCB0aGUg
c2VyaWVzIHRvCmRybS1taXNjLW5leHQgYnkgdGhlIG1pZGRsZSBvZiB0aGUgY29taW5nIHdlZWsg
c28gdGhhdCBpdAp3b3VsZCBzdGlsbCBjYXRjaCB0aGUgbGFzdCB0cmFpbiB0byA0LjE3LgoKVGhh
bmtzLAoKTHVrYXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
Cg==
