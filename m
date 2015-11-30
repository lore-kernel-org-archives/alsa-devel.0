From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/7] drm/i915: Add get_eld audio component
Date: Mon, 30 Nov 2015 16:34:22 +0100
Message-ID: <565C6C7E.4040902@canonical.com>
References: <1448890671-2983-1-git-send-email-tiwai@suse.de>
 <1448890671-2983-3-git-send-email-tiwai@suse.de>
 <20151130152441.GS4437@intel.com> <s5hlh9fy07e.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <s5hlh9fy07e.wl-tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Takashi Iwai <tiwai@suse.de>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Daniel Vetter <daniel.vetter@intel.com>, intel-gfx@lists.freedesktop.org, Mengdong Lin <mengdong.lin@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

CgpPbiAyMDE1LTExLTMwIDE2OjI5LCBUYWthc2hpIEl3YWkgd3JvdGU6Cj4gT24gTW9uLCAzMCBO
b3YgMjAxNSAxNjoyNDo0MSArMDEwMCwKPiBWaWxsZSBTeXJqw6Rsw6Qgd3JvdGU6Cj4+Cj4+IE9u
IE1vbiwgTm92IDMwLCAyMDE1IGF0IDAyOjM3OjQ2UE0gKzAxMDAsIFRha2FzaGkgSXdhaSB3cm90
ZToKPj4+IEltcGxlbWVudCBhIG5ldyBpOTE1X2F1ZGlvX2NvbXBvbmVudF9vcHMsIGdldF9lbGQo
KS4gIEl0J3MgY2FsbGVkIGJ5Cj4+PiB0aGUgYXVkaW8gZHJpdmVyIHRvIGZldGNoIHRoZSBjdXJy
ZW50IEVMRCBvZiB0aGUgZ2l2ZW4gSERNSS9EUCBwb3J0Lgo+Pj4gSXQgcmV0dXJucyB0aGUgc2l6
ZSBvZiBFTEQgYnl0ZXMgaWYgaXQncyB2YWxpZCwgb3IgemVybyBpZiB0aGUgYXVkaW8KPj4+IGlz
IGRpc2FibGVkIG9yIHVucGx1Z2dlZCwgb3IgYSBuZWdhdGl2ZSBlcnJvciBjb2RlLgo+Pgo+PiBX
aHkgZG8gd2UgbmVlZCB0aGlzPyBJc24ndCBpdCBzb21ldGhpbmcgdGhlIGVsZCBub3RpZnkgaG9v
ayBzaG91bGQKPj4gcGFzcyBmcm9tIGk5MTUgdG8gdGhlIGF1ZGlvIGRyaXZlcj8KPgo+IFdlIG5l
ZWQgdGhpcyBhdCBsZWFzdCBpbiB0d28gc2l0dWF0aW9uczoKPiAtIHdoZW4gdGhlIGF1ZGlvIGRy
aXZlciBpcyBwcm9iZWQKPiAtIHdoZW4gdGhlIGF1ZGlvIGRyaXZlciBpcyByZXN1bWVkCj4KPj4g
QXQgbGVhc3Qgd2l0aCB0aGUgbG9ja2luZyB5b3UgaGF2ZSBmb3IgdGhpcywgdGhlIGF1ZGlvIGRy
aXZlciBjYW4gbm90Cj4+IGNhbGwgdGhpcyBmcm9tIHRoZSBlbGQgbm90aWZ5IGhvb2sgc2luY2Ug
aXQgd291bGQgZGVhZGxvY2suCj4KPiBPSywgdGhlbiB3ZSBtYXkgY2hhbmdlIHRoZSBlbGRfbm90
aWZ5IHRvIHBhc3MgdGhlIHZhbHVlcyBpbiB0aGUKPiBhcmd1bWVudHMsIGFuZCBhbHNvIGFkZCB0
aGUgbmV3IG9wIHdpdGggYSBsb2NrIHRvIGJlIGNhbGxlZCBmcm9tIG90aGVyCj4gcGxhY2VzIGZy
b20gb3RoZXIgcGxhY2VzLgoKTWF5YmUgd2UgaGF2ZSB0byBtYWtlIGVsZF9ub3RpZnkgbm90IGRv
IGFueXRoaW5nIGV4Y2VwdCB0byBjYWxsIApzY2hlZHVsZV93b3JrIHRoZW4/IEFuZCB0aGF0IHdv
cmsgaW4gdHVybiB3aWxsIGFzayBmb3IgdXBkYXRlZCBlbGQgZnJvbSAKdGhlIGk5MTUgZHJpdmVy
LCBhbmQgaGFuZGxlIHRoZSByZXN1bHQuCgotLSAKRGF2aWQgSGVubmluZ3Nzb24sIENhbm9uaWNh
bCBMdGQuCmh0dHBzOi8vbGF1bmNocGFkLm5ldC9+ZGl3aWMKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9pbnRlbC1nZngK
