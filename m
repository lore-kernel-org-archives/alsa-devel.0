From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Provide a more complete DMA driver
	stub
Date: Tue, 6 Dec 2011 13:32:21 +0000
Message-ID: <CABS+qY0HSAigOsfMUSo1F0sr7yFKYCWhq58KZ-CaQGiaRByVnQ@mail.gmail.com>
References: <1323118585-18216-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1323122570.8134.1.camel@odin>
	<20111205231946.GB21083@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71])
	by alsa0.perex.cz (Postfix) with ESMTP id C0EE4103BB9
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 14:32:23 +0100 (CET)
Received: by mail-vx0-f175.google.com with SMTP id fo13so4869285vcb.6
	for <alsa-devel@alsa-project.org>; Tue, 06 Dec 2011 05:32:21 -0800 (PST)
In-Reply-To: <20111205231946.GB21083@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

T24gNSBEZWNlbWJlciAyMDExIDIzOjE5LCBNYXJrIEJyb3duCjxicm9vbmllQG9wZW5zb3VyY2Uu
d29sZnNvbm1pY3JvLmNvbT4gd3JvdGU6Cj4gT24gTW9uLCBEZWMgMDUsIDIwMTEgYXQgMTA6MDI6
NTBQTSArMDAwMCwgTGlhbSBHaXJkd29vZCB3cm90ZToKPj4gT24gTW9uLCAyMDExLTEyLTA1IGF0
IDIwOjU2ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOgo+PiA+IEFsbG93IHVzZXJzcGFjZSBhcHBs
aWNhdGlvbnMgdG8gZG8gbW9yZSBwYXJhbWV0ZXIgc2V0dGluZyBieSBwcm92aWRpbmcgYQo+PiA+
IG1vcmUgY29tcGxldGUgc3R1YiBETUEgZHJpdmVyIHNwZWNpZnlpbmcgYSB3aWxkY2FyZCBzZXQg
b2YgZm9ybWF0cyBhbmQKPj4gPiBjaGFubmVscyBhbmQgZXNzZW50aWFsbHkgcmFuZG9tIHZhbHVl
cyBmb3IgdGhlIERNQSBwYXJhbWV0ZXJzLiBUaGlzIGlzCj4+ID4gcmVxdWlyZWQgZm9yIHVzZWZ1
bCBydW50aW1lIG9wZXJhdGlvbiBvZiB0aGUgZHVtbXkgRE1BIGRyaXZlciB1bnRpbCB3ZQo+PiA+
IGFyZSBhYmxlIHRvIGZpZ3VyZSBvdXQgaG93IHRvIHBvd2VyIHVwIGxpbmtzIGFuZCBkbyBod19w
YXJhbXMoKSBmcm9tIERBUE0uCj4KPj4gSXMgdGhpcyBhbHNvIGludGVuZGVkIHRvIGJlIHVzZWQg
Zm9yIGhvc3RsZXNzIERBSSBsaW5rcyBlLmcuCj4KPj4gTU9ERU0gPC0+IE1DQlNQIDwtPiBEU1AK
Pgo+IEl0J3MgZm9yIGFueSBzb3J0IG9mIGxpbmsgdGhhdCBkb2Vzbid0IGdvIHRocm91Z2ggYSBE
TUEgY29udHJvbGxlciB0aGUKPiBrZXJuZWwgY2FuIHNlZSAtIHRoaXMgaXMgdGhlIERNQSBkcml2
ZXIgdGhhdCBnZXRzIHN0dWJiZWQgaW4gd2hlbiB0aGUKPiBEQUkgZG9lc24ndCBoYXZlIGEgRE1B
IGRyaXZlci4gwqBJbiB0aGUgY2FzZSBhYm92ZSBJIGd1ZXNzIGl0IGRlcGVuZHMgb24KPiBpZiB0
aGUgRE1BIGNvbnRyb2xsZXIgaXMgaGlkZGVuIGJ5IHRoZSBEU1Agb3Igbm90LgoKT2ssIHRoYXQn
cyB3aGF0IEkgd2FzIHRoaW5raW5nLgoKQWNrZWQtYnk6IExpYW0gR2lyZHdvb2QgPGxyZ0B0aS5j
b20+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
