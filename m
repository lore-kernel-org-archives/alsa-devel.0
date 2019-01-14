From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 3/3] snd/hda: Protect concurrent
 display_power_status with a mutex
Date: Mon, 14 Jan 2019 17:51:31 +0000
Message-ID: <154748829141.28151.408499449340104231@skylake-alporthouse-com>
References: <20190114173753.472-1-chris@chris-wilson.co.uk>
 <20190114173753.472-3-chris@chris-wilson.co.uk>
 <s5hd0ozi12m.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <s5hd0ozi12m.wl-tiwai@suse.de>
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
Cc: Jani Nikula <jani.nikula@intel.com>, intel-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

UXVvdGluZyBUYWthc2hpIEl3YWkgKDIwMTktMDEtMTQgMTc6NDY6NTcpCj4gT24gTW9uLCAxNCBK
YW4gMjAxOSAxODozNzo1MyArMDEwMCwKPiBDaHJpcyBXaWxzb24gd3JvdGU6Cj4gPiAKPiA+IEp1
c3QgaW4gY2FzZSB0aGUgYXVkaW8gbGlua2FnZSBpcyBzd2FwcGVkIGJldHdlZW4gY29tcG9uZW50
cyBkdXJpbmcgdGhlCj4gPiBydW50aW1lIHBtIHNlcXVlbmNlLCB3ZSBuZWVkIHRvIHByb3RlY3Qg
dGhlIHJwbSB0cmFja2luZyB3aXRoIGEgbXV0ZXguCj4gCj4gSXQncyBub3QgY2xlYXIgdG8gbWUg
aG93IGRvZXMgdGhpcyBoYXBwZW5zLgo+IENvdWxkIHlvdSBlbGFib3JhdGUgYSBiaXQgbW9yZSB0
aGUgc2NlbmFyaW8/CgpUaGUgY29kZSBpcyB3cml0dGVuIHN1Y2ggdGhhdCBtdWx0aXBsZSBiaXRz
IHdpdGhpbiBkaXNwbGF5X3Bvd2VyX3N0YXR1cwpjYW4gYmUgc2V0IGFuZCBjbGVhcmVkIHNpbXVs
dGFuZW91c2x5LiBUaGVyZSB3YXMgbm8gc2VyaWFsaXNhdGlvbgptZW50aW9uZWQgaW4gdGhlIHJv
dXRpbmUsIHNvIEkgd2FzIGZlYXJmdWwgdGhhdCB0aGUgZGlzcGxheV9wb3dlcl9hY3RpdmUKaGVy
ZSB3YXMgYmVpbmcgYWNjZXNzZWQgY29uY3VycmVudGx5IC0tIGFuZCBpZiB0aGF0IHdhcyBleHBs
YWluaW5nIHdoeQpzbmQvaGRhIGFwcGVhcnMgdG8gYmUgbGVha2luZyB0aGUgcnVudGltZSBwbSAo
b3IgYXQgbGVhc3QgaXMgaG9sZGluZyBvbgp0byB0aGUgd2FrZXJlZiBsb25nZXIgdGhhbiBpZ3Qg
ZXhwZWN0cywgPiAxMHMpLgotQ2hyaXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW50ZWwtZ2Z4Cg==
