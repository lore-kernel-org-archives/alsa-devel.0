From: =?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau@advansee.com>
Subject: Re: [PATCH] ASoC: dapm:
	Fix	snd_soc_dapm_put_volsw()	connect
Date: Fri, 29 Jun 2012 21:09:49 +0200 (CEST)
Message-ID: <2026346.354826.1340996989713.JavaMail.root@advansee.com>
References: <s5hzk7mulyz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zose-mta12.web4all.fr (zose-mta12.web4all.fr [178.33.204.89])
	by alsa0.perex.cz (Postfix) with ESMTP id CDC1211CFBD
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jun 2012 21:05:11 +0200 (CEST)
In-Reply-To: <s5hzk7mulyz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBKdW4gMjksIDIwMTIgYXQgMDY6MjI6MjhQTSArMDIwMCwgVGFrYXNoaSBJd2FpIHdy
b3RlOgo+IEF0IEZyaSwgMjkgSnVuIDIwMTIgMTg6MDk6MzUgKzAyMDAgKENFU1QpLAo+IEJlbm/D
rnQgVGjDqWJhdWRlYXUgd3JvdGU6Cj4gPiAKPiA+IE9uIEZyaSwgSnVuIDI5LCAyMDEyIGF0IDA1
OjQ0OjQxUE0gKzAyMDAsIFRha2FzaGkgSXdhaSB3cm90ZToKPiA+ID4gQlRXLCBsb29raW5nIGF0
IHNuZF9zb2NfZGFwbV92b2xfZ2V0c3coKSwgSSBmb3VuZCB0aGF0Cj4gPiA+IHNuZF9zb2NfZGFw
bV92b2xfcHV0c3coKSBkb2Vzbid0IGhhbmRsZSBhIHN0ZXJlbyBjYXNlLgo+ID4gPiBUaGlzIG5l
ZWRzIGEgZml4LCB0b28uLi4KPiA+IAo+ID4gSSBzYXcgdGhhdCB0b28uIElzIGl0IHRoZSBzdGVy
ZW8gY2FzZSB0aGF0IHNob3VsZCBiZSBhZGRlZCB0byBwdXQKPiA+IG9yIHJlbW92ZWQKPiA+IGZy
b20gZ2V0LCBpLmUuIGlzIGl0IHBvc3NpYmxlIHRvIGhhbmRsZSBhIHN0ZXJlbyBjYXNlIHdpdGgg
b25seSBvbmUKPiA+IGNvbm5lY3QKPiA+IGZsYWc/Cj4gCj4gSSB3b3VsZCBhc3N1bWUgdGhhdCBj
b25uZWN0IHNob3VsZCBiZSB1cCB3aGVuIGVpdGhlciBsZWZ0IG9yIHJpZ2h0IGlzCj4gb24uICBB
IHN0ZXJlbyB3aWRnZXQgZG9lc24ndCBtZWFuIG11bHRpcGxlIGNvbm5lY3Rpb25zLgoKSSBoYXZl
IHN0YXJ0ZWQgdG8gbG9vayBpbnRvIHRoYXQ6CiAtIEdpdmUgYSBjaG9pY2UgYmV0d2VlbiByZWcg
YW5kIHNoaWZ0IHN0ZXJlbyBmb3Igc25kX3NvY19kYXBtX2dldF92b2xzdygpLCBsaWtlCiAgIGlu
IHNuZF9zb2NfZ2V0X3ZvbHN3KCkuCiAtIEFkZCBzdGVyZW8gdG8gdGhlIGZpcnN0IGNhc2Ugb2Yg
ZGFwbV9zZXRfcGF0aF9zdGF0dXMoKS4KIC0gQWRkIHN0ZXJlbyB0byBkYXBtX3dpZGdldF91cGRh
dGUoKSBhbmQgc3RydWN0IHNuZF9zb2NfZGFwbV91cGRhdGUuCiAtIFRoZW4gY29tZXMgc25kX3Nv
Y19kYXBtX2dldF92b2xzdygpOiBXaGF0IHNob3VsZCB3ZSBkbyB3aXRoCiAgICJ3aWRnZXQtPnZh
bHVlID0gdmFsOyI/IEFkZCBhbiBydmFsdWUgdG8gc3RydWN0IHNuZF9zb2NfZGFwbV93aWRnZXQ/
IFRoaXMKICAgZmllbGQgZG9lcyBub3Qgc2VlbSB0byBiZSByZWFkIGFueXdoZXJlIGV4Y2VwdCBm
b3IgZW51bXMuIFRoZXJlIGlzIGFsc28KICAgc2F2ZWRfdmFsdWUgYW5kIG90aGVyIGZpZWxkcyB0
aGF0IGRvIG5vdCBzZWVtIHRvIGJlIHVzZWQgYW55d2hlcmUuCgpSZWdhcmRzLApCZW5vw650Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5h
bHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
