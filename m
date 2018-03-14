From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 0/7] Modernize vga_switcheroo by using device link for
 HDA
Date: Wed, 14 Mar 2018 07:07:20 +0100
Message-ID: <20180314060720.GA24283@wunner.de>
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
To: Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Sean Paul <seanpaul@chromium.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Gustavo Padovan <gustavo@padovan.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: alsa-devel@alsa-project.org, Martin Lopatar <lopin@dataplex.cz>, nouveau@lists.freedesktop.org, Maik Freudenberg <hhfeuer@gmx.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Denis Lisov <dennis.lissov@gmail.com>, dri-devel@lists.freedesktop.org, Daniel Drake <dan@reactivated.net>, Hans de Goede <hdegoede@redhat.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Peter Wu <peter@lekensteyn.nl>, linux-pci@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

T24gU3VuLCBNYXIgMTEsIDIwMTggYXQgMDQ6NTU6NDlQTSArMDEwMCwgTHVrYXMgV3VubmVyIHdy
b3RlOgo+ID4gT24gU2F0LCBNYXIgMDMsIDIwMTggYXQgMTA6NTM6MjRBTSArMDEwMCwgTHVrYXMg
V3VubmVyIHdyb3RlOgo+ID4gPiBNb2Rlcm5pemUgdmdhX3N3aXRjaGVyb28gYnkgdXNpbmcgYSBk
ZXZpY2UgbGluayB0byBlbmZvcmNlIGEgcnVudGltZSBQTQo+ID4gPiBkZXBlbmRlbmN5IGZyb20g
YW4gSERBIGNvbnRyb2xsZXIgdG8gdGhlIEdQVSBpdCdzIGludGVncmF0ZWQgaW50bywgdjIuCj4g
PiA+IAo+ID4gPiBodHRwczovL2dpdGh1Yi5jb20vbDFrL2xpbnV4L2NvbW1pdHMvc3dpdGNoZXJv
b19kZXZsaW5rX3YyCj4gCj4gSWYgdGhlcmUgYXJlIG5vIG9iamVjdGlvbnMsIEkgcGxhbiB0byBw
dXNoIHRoZSBzZXJpZXMgdG8KPiBkcm0tbWlzYy1uZXh0IGJ5IHRoZSBtaWRkbGUgb2YgdGhlIGNv
bWluZyB3ZWVrIHNvIHRoYXQgaXQKPiB3b3VsZCBzdGlsbCBjYXRjaCB0aGUgbGFzdCB0cmFpbiB0
byA0LjE3LgoKUHVzaGVkIHRvIGRybS1taXNjLW5leHQgbm93IHdpdGggQmpvcm4ncyBjaGFuZ2Vs
b2cgdHdlYWsgYW5kIGFjayBmb3IKcGF0Y2ggWzEvMV0uCgpUaGFua3MgYSBsb3QgZXZlcnlvbmUg
Zm9yIHRoZSByZXZpZXdzLCBhY2tzLCB0ZXN0aW5nICYgY29tbWVudHMuCgpMdWthcwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGlu
ZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
