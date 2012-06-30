From: =?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau@advansee.com>
Subject: Re: [PATCH] ASoC: dapm: Fix snd_soc_dapm_put_volsw()
 connect
Date: Sat, 30 Jun 2012 15:03:09 +0200 (CEST)
Message-ID: <1228563845.386649.1341061389052.JavaMail.root@advansee.com>
References: <20120630113949.GT28922@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zose-mta12.web4all.fr (zose-mta12.web4all.fr [178.33.204.89])
	by alsa0.perex.cz (Postfix) with ESMTP id 7594B103FDA
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Jun 2012 14:58:29 +0200 (CEST)
In-Reply-To: <20120630113949.GT28922@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCBKdW4gMzAsIDIwMTIgYXQgMDE6Mzk6NTBQTSArMDIwMCwgTWFyayBCcm93biB3cm90
ZToKPiBPbiBGcmksIEp1biAyOSwgMjAxMiBhdCAxMDoxODowN1BNICswMjAwLCBCZW5vw650IFRo
w6liYXVkZWF1IHdyb3RlOgo+IAo+ID4gSSd2ZSBmaW5pc2hlZC4gVGhlIGZvbGxvd2luZyBwYXRj
aCBzaG91bGQgYmUgYXBwbGllZCBhZnRlciBteSBwYXRjaAo+ID4gIkFTb0M6IGRhcG06IEZpeCBk
YXBtX3NldF9wYXRoX3N0YXR1cygpIGNvbm5lY3QiLgo+IAo+IERvbid0IHN1Ym1pdCBwYXRjaGVz
IGluIHRoZSBtaWRkbGUgb2YgZGlzY3Vzc2lvbnMsIGJ1dCBwbGVhc2UgYmVhciBpbgo+IG1pbmQg
d2hhdCBJIGp1c3Qgc2FpZCBhYm91dCBub3QgZG9pbmcgc3RlcmVvLgoKPiBBY3R1YWxseSBJJ2Qg
cmVhbGx5IGV4cGVjdCBpdCB0byBtZWFuIGV4YWN0bHkgdGhhdC4gIERBUE0gaXMgZmFpcmx5Cj4g
ZnVuZGFtZW50YWxseSBkZWFsaW5nIHdpdGggc2luZ2xlIGNoYW5uZWwgYXVkaW8gc3RyZWFtcyBh
bmQgSSdkIGV4cGVjdAo+IHRoYXQgaWYgd2UgZGlkIGltcGxlbWVudCBzdGVyZW8gY29udHJvbHMg
dGhleSdkIGFsbG93IHRoZXNlIHN0cmVhbXMgdG8KPiBwYXNzIHRocm91Z2ggd2l0aG91dCBnZXR0
aW5nIG1lcmdlZC4gIFRoZXJlJ3MgYSBjb3VwbGUgb2YgdGhpbmdzIHRoYXQKPiBzdG9wIHVzIGRv
aW5nIHRoYXQgcmlnaHQgbm93IGJ1dCBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBhZGQgc3RlcmVv
Cj4gY29udHJvbHMgdGhhdCBkb24ndCBkbyB0aGF0LgoKQ2FuIHlvdSBiZSBtb3JlIHNwZWNpZmlj
IGFib3V0IHdoYXQgc3RvcHMgdXMgZG9pbmcgdGhhdCByaWdodCBub3c/CgpTaG91bGQgd2UgZHJv
cCB0aGlzIGlkZWEgZm9yIG5vdyBhbmQgc2ltcGx5IHJlbW92ZSBzdGVyZW8gZnJvbQpzbmRfc29j
X2RhcG1fZ2V0X3ZvbHN3KCk/CgpSZWdhcmRzLApCZW5vw650Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
