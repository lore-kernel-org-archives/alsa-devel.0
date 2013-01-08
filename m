From: Vincent Blut <vincent.debian@free.fr>
Subject: Re: [3.6.9 -> 3.7.1 regression] sound: snd_hda_intel
 codec probing issue?
Date: Tue, 08 Jan 2013 10:48:25 +0100
Message-ID: <1357638505.3849.1.camel@lamella>
References: <1356704740.3953.26.camel@lamella>
 <s5hvcber5cz.wl%tiwai@suse.de> <50EBD772.3090008@gmail.com>
 <s5htxqsyt7g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B87926169D
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 10:48:45 +0100 (CET)
In-Reply-To: <s5htxqsyt7g.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Maurizio Avogadro <mavoga@gmail.com>
List-Id: alsa-devel@alsa-project.org

TGUgbWFyZGkgMDggamFudmllciAyMDEzIMOgIDA5OjI4ICswMTAwLCBUYWthc2hpIEl3YWkgYSDD
qWNyaXQgOgo+IEF0IFR1ZSwgMDggSmFuIDIwMTMgMDk6MjM6MTQgKzAxMDAsCj4gTWF1cml6aW8g
QXZvZ2Fkcm8gd3JvdGU6Cj4gPiAKPiA+IFRha2FzaGkgSXdhaSA8dGl3YWkgPGF0PiBzdXNlLmRl
PiB3cml0ZXM6Cj4gPiAKPiA+ID4gWy4uLl0KPiA+ID4KPiA+ID4gSWYgaXQncyBuZXcgaW4gMy43
LCB0aGlzIGNvdWxkIGJlIGEgcmVncmVzc2lvbiBieSBydW50aW1lIEQzLgo+ID4gPiBUcnkgdG8g
cGFzcyBwb3dlcl9zYXZlX2NvbnRyb2xsZXI9MCBvcHRpb24gdG8gc25kLWhkYS1pbnRlbCBtb2R1
bGUKPiA+ID4gKG9yIGNoYW5nZSBpdCB2aWEgc3lzZnMgZHluYW1pY2FsbHkpLgo+ID4gPgo+ID4g
PiB0aGFua3MsCj4gPiA+Cj4gPiA+IFRha2FzaGkKPiA+IAo+ID4gSGkgVGFrYXNoaQo+ID4gCj4g
PiBzYW1lIGNvZGVjIGhlcmUgKEFMQzI2OVZCIG9uIGEgQ2xldm8gVzE1MEhSTSksIHNhbWUga2Vy
bmVsLCBzYW1lIGlzc3VlLgo+ID4gRGlzYWJsaW5nIHBvd2VyX3NhdmVfY29udHJvbGxlciBzb2x2
ZXMgdGhlIGlzc3VlLCBidXQgSSBjb3VsZCBhY2hpZXZlCj4gPiB0aGUgc2FtZSByZXN1bHQgYnkg
c2V0dGluZyBlbmFibGVfbXNpPTAsIHdoaWNoIEkgY2hvc2UgaW4gdGhlIGhvcGUgdG8KPiA+IHBy
ZXNlcnZlIHBvd2VyIHNhdmluZyBjYXBhYmlsaXRpZXMuCj4gCj4gSW50ZXJlc3RpbmcuICBWaW5j
ZW50LCBkb2VzIGRpc2FibGluZyBNU0kgaGVscCBpbiB5b3VyIGNhc2UsIHRvbz8KPiAKPiBCVFcs
IHRoZSBwcm9ibGVtIGlzIHJlbGF0ZWQgcmF0aGVyIHdpdGggdGhlIGNvbnRyb2xsZXIgY2hpcCwg
bm90IHRoZQo+IGNvZGVjIGNoaXAuICBJbiBWaW5jZW50J3MgY2FzZSwgaXQncyA4MDg2OjFlMjAs
Cj4gICBJbnRlbCBDb3Jwb3JhdGlvbiA3IFNlcmllcy9DMjEwIFNlcmllcyBDaGlwc2V0IEZhbWls
eSBIaWdoCj4gICBEZWZpbml0aW9uIEF1ZGlvIENvbnRyb2xsZXIgKHJldiAwNCkKPiAKCkhpLAoK
V2lsbCB0ZXN0LCBJJ20gbm90IG9uIHRoaXMgc2lzdGVtIHJpZ2h0IG5vdywgc28gSSdsbCByZXBv
cnQgYmFjayB0aGlzCmFmdGVybm9vbi4KCj4gCj4gdGhhbmtzLAo+IAo+IFRha2FzaGkKCkNoZWVy
cywKVmluY2VudAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
