From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH] ASoC: fsl: select SND_SOC_FSL_SAI or
 SND_SOC_FSL_SSI depending on SoC type
Date: Fri, 29 Jan 2016 10:43:34 +0100
Message-ID: <20160129104334.28fb1643@ipc1.ka-ro>
References: <1453293038-16032-1-git-send-email-LW@KARO-electronics.de>
 <20160128223352.GB4130@sirena.org.uk>
 <20160129065938.6e89fc37@ipc1.ka-ro>
 <20160129063012.GB3370@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.karo-electronics.de (mail.karo-electronics.de
 [81.173.242.67])
 by alsa0.perex.cz (Postfix) with ESMTP id D4DB026047B
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2016 10:43:51 +0100 (CET)
In-Reply-To: <20160129063012.GB3370@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

SGksCgpPbiBUaHUsIDI4IEphbiAyMDE2IDIyOjMwOjEzIC0wODAwIE5pY29saW4gQ2hlbiB3cm90
ZToKPiBPbiBGcmksIEphbiAyOSwgMjAxNiBhdCAwNjo1OTozOEFNICswMTAwLCBMb3RoYXIgV2HD
n21hbm4gd3JvdGU6Cj4gPiBIaSwKPiA+IAo+ID4gT24gVGh1LCAyOCBKYW4gMjAxNiAyMzozMzo1
MiArMDEwMCBNYXJrIEJyb3duIHdyb3RlOgo+ID4gPiBPbiBXZWQsIEphbiAyMCwgMjAxNiBhdCAw
MTozMDozOFBNICswMTAwLCBMb3RoYXIgV2HDn21hbm4gd3JvdGU6Cj4gPiA+IAo+ID4gPiA+IC0J
c2VsZWN0IFNORF9TT0NfRlNMX1NTSQo+ID4gPiA+ICsJc2VsZWN0IFNORF9TT0NfRlNMX1NBSSBp
ZiBTT0NfSU1YNlVMCj4gPiA+ID4gKwlzZWxlY3QgU05EX1NPQ19GU0xfU1NJIGlmIFNPQ19JTVg2
USB8fCBTT0NfSU1YNlNMIHx8IFNPQ19JTVg2U1gKPiA+ID4gCj4gPiA+IERvZXMgdGhpcyBjYXJk
IG5vdCB3b3JrIGZvciBvbGRlciBpLk1YcyAod2hpY2ggaGFkIHRoZSBzYW1lIFNTSS9BVURNVVgK
PiA+ID4gY29tYmluYXRpb24gYXMgdGhlIG1ham9yaXR5IG9mIHRoZSBpLk1YNiBmYW1pbHkpIGFz
IHdlbGw/Cj4gPiA+Cj4gPiBPdXIgYmFzZWJvYXJkIGNvbnRhaW5zIGFuIFNHVEw1MDAwIGNvZGVj
IHdoaWNoIGlzIHdvcmtpbmcgd2l0aAo+ID4gaS5NWDI1LCBpLk1YMjcsIGkuTVg1LCBpLk1YNlEs
IGkuTVg2REwgd2l0aCB0aGUgZnNsX3NzaSBhbmQgaW14LXNndGw1MDAwCj4gPiArIGlteC1hdWRt
dXggZHJpdmVyLCBvbiBpLk1YMjggd2l0aCB0aGUgbXhzLXNhaWYgYW5kIG14cy1zZ3RsNTAwMCBk
cml2ZXIKPiA+IGFuZCBvbiBpLk1YNlVMIHdpdGggdGhlIGZzbF9zYWkgKyBzaW1wbGUtY2FyZCBk
cml2ZXIuCj4gCj4gSGF2ZSB5b3UgdHJpZWQgZnNsLWFzb2MtY2FyZCB0byBjb25uZWN0IFNTSS9T
QUkgd2l0aCBzZ3RsNTAwMD8gSWYgaXQKPiB3b3JrcyBmb3IgeW91IGRpcmVjdGx5LCBJIGJlbGll
dmUgdGhpbmdzIHNob3VsZCBiZSBlYXNpZXIgZm9yIHlvdQo+IGluc3RlYWQgb2YgZGVhbGluZyB3
aXRoIEtjb25maWcuCj4KTXkgcGF0Y2ggc2ltcGx5IHNlbGVjdHMgdGhlIEZTTF9TQUkgaW5zdGVh
ZCBvZiB0aGUgRlNMX1NTSSBpbnRlcmZhY2UgZm9yCmkuTVg2VUwgc2luY2UgdGhlIGxhdHRlciBp
cyBOT1QgQVZBSUxBQkxFIG9uIGkuTVg2VUwgYW5kIHRodXMgaXQgZG9lc24ndAptYWtlIGFueSBz
ZW5zZSB0byBzZWxlY3QgaXQgb24gdGhpcyBTb0MuCgpCdXQgbWF5YmUgdGhlIHNlbGVjdCBzdGF0
ZW1lbnRzIHNob3VsZCBiZSByZW1vdmVkIGFsdG9nZXRoZXIgc2luY2UgdGhleQphcmUgYSBjYXNl
IG9mIHRoZSBmcm93bmVkLXVwb24gInNlbGVjdCBmb3IgdXNlciB2aXNpYmxlIHN5bWJvbHMiLgoK
CkxvdGhhciBXYcOfbWFubgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
