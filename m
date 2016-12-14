From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 5/7] ALSA: x86: hdmi: Improve
 position reporting
Date: Wed, 14 Dec 2016 17:39:20 -0600
Message-ID: <9391a916-431e-71a5-04e3-9e73b431e232@linux.intel.com>
References: <20161212181043.12512-1-jerome.anand@intel.com>
 <20161212181043.12512-6-jerome.anand@intel.com>
 <s5hr35aekim.wl-tiwai@suse.de>
 <5d237318-61b3-fb22-be28-dfcc88554d20@linux.intel.com>
 <s5hy3zid1d7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <s5hy3zid1d7.wl-tiwai@suse.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, intel-gfx@lists.freedesktop.org, broonie@kernel.org, rakesh.a.ughreja@intel.com
List-Id: alsa-devel@alsa-project.org

T24gMTIvMTQvMTYgODozNiBBTSwgVGFrYXNoaSBJd2FpIHdyb3RlOgo+IE9uIFdlZCwgMTQgRGVj
IDIwMTYgMTU6MDk6MjAgKzAxMDAsCj4gUGllcnJlLUxvdWlzIEJvc3NhcnQgd3JvdGU6Cj4+Cj4+
IE9uIDEyLzE0LzE2IDY6NTcgQU0sIFRha2FzaGkgSXdhaSB3cm90ZToKPj4+IE9uIE1vbiwgMTIg
RGVjIDIwMTYgMTk6MTA6NDEgKzAxMDAsCj4+PiBKZXJvbWUgQW5hbmQgd3JvdGU6Cj4+Pj4KPj4+
PiBVc2UgYSBodyByZWdpc3RlciB0byBjYWxjdWxhdGUgc3ViLXBlcmlvZCBwb3NpdGlvbiByZXBv
cnRzLgo+Pj4+IFRoaXMgbWFrZXMgUHVsc2VBdWRpbyBoYXBwaWVyLgo+Pj4+Cj4+Pj4gU2lnbmVk
LW9mZi1ieTogRGF2aWQgSGVubmluZ3Nzb24gPGRhdmlkLmhlbm5pbmdzc29uQGNhbm9uaWNhbC5j
b20+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogUGllcnJlLUxvdWlzIEJvc3NhcnQgPHBpZXJyZS1sb3Vp
cy5ib3NzYXJ0QGxpbnV4LmludGVsLmNvbT4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBKZXJvbWUgQW5h
bmQgPGplcm9tZS5hbmFuZEBpbnRlbC5jb20+Cj4+Pgo+Pj4gVGhlcmUgaXMgbm8gYmlnIG1lcml0
IHRvIGtlZXAgdGhpcyBhIHNlcGFyYXRlIHBhdGNoLgo+Pj4gUGxlYXNlIGZvbGQgaW50byB0aGUg
bWFpbiBwYXRjaC4KPj4+IFlvdSBjYW4gcHV0IHNvbWUgY29tbWVudCBpbiB0aGUgY29kZSBmb3Ig
ZXhwbGFuYXRpb24uCj4+Cj4+IFRoZSByZWFzb24gd2Uga2VwdCB0aGlzIHBhdGNoIGFuZCB0aGUg
bmV4dCBzZXBhcmF0ZSBpcyBwdXJlbHkKPj4gcHJvY2VkdXJhbDogdGhleSB3ZXJlIGNvbnRyaWJ1
dGVkIGJ5IENhbm9uaWNhbCBpbiB0aGVpciBCYXl0cmFpbAo+PiBDb21wdXRlIFN0aWNrIGtlcm5l
bCwgYW5kIHdlIGRpZG4ndCB3YW50IHRvIHNxdWFzaCB0aGlzIGJsaW5kbHksCj4+IGVzcGVjaWFs
bHkgc2luY2UgRGF2aWQgaGFzIGdvbmUgc2lsZW50Lgo+PiBJIGRvbid0IG1pbmQgZm9sZGluZyB0
aGlzIGNvZGUgaW50byB0aGUgSW50ZWwgcGF0Y2hlcyBidXQgSSB3YXNuJ3QKPj4gc3VyZSB0aGlz
IHdhcyBhcHByb3ByaWF0ZSBvciBldmVuIGFsbG93ZWQuCj4KPiBNZXJnaW5nIHRoZSBjb2RlIG11
c3QgYmUgT0ssIHRoYXQncyB0aGUgcG9pbnQgb2YgdGhlIG9yaWdpbmFsIHBhdGNoCj4gaGF2aW5n
IERhdmlkJ3Mgc2lnbi1vZmYuICAoSWYgdGhlIGNvZGUgbWVyZ2UgaXNuJ3QgYWxsb3dlZCwgaG93
IGNhbiB3ZQo+IHdvcmsgb24gdGhlIGtlcm5lbCB0cmVlIGF0IGFsbD8gOykKPiBJdCdkIGJlIGJl
dHRlciwgdGhvdWdoLCB0byBtZW50aW9uIGFib3V0IHRoZSBtZXJnZWQgY29kZSBhbmQgaGlzCj4g
c2lnbi1vZmYgcG9ydGlvbiBpbiB0aGUgY29tbWl0IGxvZy4KCm9rLCB0aGF0J3MgZmluZS4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1h
aWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
