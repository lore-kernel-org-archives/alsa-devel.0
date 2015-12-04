From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH v2 04/14] ASoC: hdac_hdmi: Add hotplug notification and
 read eld
Date: Fri, 4 Dec 2015 15:46:59 +0530
Message-ID: <20151204101659.GB6256@subhransu-desktop>
References: <1449176538-3250-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449176942-3441-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449176942-3441-4-git-send-email-subhransu.s.prusty@intel.com>
 <s5hk2ovsf7a.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <s5hk2ovsf7a.wl-tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, broonie@kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBEZWMgMDMsIDIwMTUgYXQgMDQ6NTE6MzdQTSArMDEwMCwgVGFrYXNoaSBJd2FpIHdy
b3RlOgo+IE9uIFRodSwgMDMgRGVjIDIwMTUgMjI6MDg6NTIgKzAxMDAsCj4gU3ViaHJhbnN1IFMu
IFBydXN0eSB3cm90ZToKPiA+IAo+ID4gVGhpcyBwYXRjaCB1c2VzIGk5MTUgY29tcG9uZW50IGZy
YW1ld29yayB0byByZWdpc3RlciBmb3IgaG90cGx1Zwo+ID4gbm90aWZpY2F0aW9uLiBBbmQgb25j
ZSBpdCBpZGVudGlmaWVzIHZhbGlkIHBpbiBzZW5zZSBhbmQgdmFsaWQgZWxkLAo+ID4gcmVhZHMg
dGhlIGVsZCBpbnRvIHRoZSBjb3JyZXNwb25kaW5nIHBpbiBtYXAgYnVmZmVyLiBGb3Igbm93IGl0
Cj4gPiBkaXJlY3RseSBzZW5kcyB0aGUgdmVyYnMgYW5kIHJlYWRzIHRoZSBlbGQuIExhdGVyIHRo
aXMgd2lsbCB1c2UKPiA+IHRoZSBpOTE1IGZyYW1ld29yayB0byBwb3B1bGF0ZSBFTEQgYnVmZmVy
IG9uY2UgYXZhaWxhYmxlLgo+ID4gCj4gPiBUaGUgZWxkIHJlYWRpbmcgQVBJcyBpbiBsZWdhY3kg
aGRhIGFyZSByZXF1aXJlZCBmb3IgQVNvQyBza3lsYWtlCj4gPiBoZG1pIGRyaXZlciBhcyB3ZWxs
LiBTbyBrZWVwaW5nIGEgY29weSBoZXJlIGFuZCB3aWxsIHJlbW92ZSBvbmNlCj4gPiBjb21wb25l
bnQgb3BzIGZvciByZWFkaW5nIEVMRCBhcmUgbWVyZ2VkIGluIGhkYSBjb3JlLgo+ID4gCj4gPiBB
bHNvIHJlYWQgdGhlIG1vbml0b3IgcHJlc2VudCBzZW5zZSBkdXJpbmcgcmVzdW1lIGFuZCBpZ25v
cmUgdGhlCj4gPiBFTEQgbm90aWZ5IGZyb20gZ3JhcGhpY3MgZHVyaW5nIFBNIGFzIGlzIGRvbmUg
aW4gbGVnYWN5IGhkYS4KPiA+IFJlZmVyZW5jZSBjb21taXRzOgo+ID4gCj4gPiBnaXQ6IGdpdDov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90aXdhaS9zb3VuZC5naXQK
PiA+IAo+ID4gY29tbWl0IDMzZDU4ZjJiYjQ0NiAoIkFMU0E6IGhkYSAtIFNraXAgRUxEIG5vdGlm
aWNhdGlvbiBkdXJpbmcgUE0KPiA+IHByb2Nlc3MiKQo+IAo+IFRoaXMgb25lIGlzbid0IG1lcmdl
ZCB5ZXQsIHNvIHRoZSBjb21taXQgSUQgbWF5IGJlIHdyb25nLgo+IE1heWJlIEknbSBnb2luZyB0
byBtZXJnZSB0aGlzIG9uZSBhdCBmaXJzdCB0byBmb3ItbmV4dCBicmFuY2gsCj4gaXJyZWxldmFu
dCBmcm9tIHRlc3QvaGRtaS1qYWNrIGJyYW5jaC4gIFNvIGRyb3AgaXQgZnJvbSB0aGUKPiBkZXNj
cmlwdGlvbiBmb3Igbm93LgoKT2suCgo+IAo+ID4gY29tbWl0IDhhZTc0M2U4MmYwYiAoIkFMU0E6
IGhkYSAtIFNraXAgRUxEIG5vdGlmaWNhdGlvbiBkdXJpbmcKPiA+IHN5c3RlbSBzdXNwZW5kIikK
PiAKPiBUaGlzIG9uZSBpcyBhbHJlYWR5IHNvbGlkLgo+IAo+IAo+IFRha2FzaGkKCi0tIApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFp
bGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
