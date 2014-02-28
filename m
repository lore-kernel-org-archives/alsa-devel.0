From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: fsl: Separation of the main
 audio options and boards
Date: Fri, 28 Feb 2014 09:46:22 +0800
Message-ID: <20140228014620.GH13537@S2101-09.ap.freescale.net>
References: <1391621512-15064-1-git-send-email-shc_work@mail.ru>
 <20140210055357.GE9628@S2101-09.ap.freescale.net>
 <1392013743.262980234@f144.i.mail.ru>
 <1393520218.924957@f305.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D00F2658FC
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 02:45:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1393520218.924957@f305.i.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBGZWIgMjcsIDIwMTQgYXQgMDg6NTY6NThQTSArMDQwMCwgQWxleGFuZGVyIFNoaXlh
biB3cm90ZToKPiDQn9C+0L3QtdC00LXQu9GM0L3QuNC6LCAxMCDRhNC10LLRgNCw0LvRjyAyMDE0
LCAxMDoyOSArMDQ6MDAg0L7RgiBBbGV4YW5kZXIgU2hpeWFuIDxzaGNfd29ya0BtYWlsLnJ1PjoK
PiA+IEhlbGxvLgo+ID4gCj4gPiA+IE9uIFdlZCwgRmViIDA1LCAyMDE0IGF0IDA5OjMxOjUxUE0g
KzA0MDAsIEFsZXhhbmRlciBTaGl5YW4gd3JvdGU6Cj4gPiA+ID4gVGhpcyBwYXRjaCBwcm92aWRl
IHNlcGFyYXRpb24gb2YgdGhlIG1haW4gYXVkaW8gb3B0aW9ucyBhbmQgYm9hcmRzLgo+ID4gPiA+
IAo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBTaGl5YW4gPHNoY193b3JrQG1haWwu
cnU+Cj4gPiA+ID4gLS0tCj4gPiA+ID4gIHNvdW5kL3NvYy9mc2wvS2NvbmZpZyB8IDM2ICsrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MjIgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCj4gPiA+ID4gCj4gPiA+ID4gZGlmZiAt
LWdpdCBhL3NvdW5kL3NvYy9mc2wvS2NvbmZpZyBiL3NvdW5kL3NvYy9mc2wvS2NvbmZpZwo+ID4g
Li4uCj4gPiA+ID4gIGlmIFNORF9JTVhfU09DCj4gPiA+ID4gIAo+ID4gPiA+ICBjb25maWcgU05E
X1NPQ19JTVhfU1NJCj4gPiA+ID4gQEAgLTEyMiwxMiArMTMzLDcgQEAgY29uZmlnIFNORF9TT0Nf
SU1YX1BDTV9GSVEKPiA+ID4gPiAgCXRyaXN0YXRlCj4gPiA+ID4gIAlzZWxlY3QgRklRCj4gPiA+
IAo+ID4gPiBIbW0sIHdoeSBkbyB5b3UgY2hvb3NlIHRvIGhhdmUgU05EX1NPQ19JTVhfU1NJIGFu
ZCBTTkRfU09DX0lNWF9QQ01fRklRCj4gPiA+IHN0aWxsIHN0YXkgaW4gYm9hcmQgc2VjdGlvbj8K
PiA+IAo+ID4gU05EX1NPQ19JTVhfU1NJIGlzIHVzZWQgZm9yIEFUQUdTIGJvYXJkcyBvbmx5LCBh
bmQgc2VsZWN0ZWQgZm9yIGVhY2ggaW5kaXZpZHVhbAo+ID4gcGxhdGZvcm0gZHJpdmVyLCBzbyB0
aGVyZSBhcmUgbm8gbmVlZCB0byBzZWxlY3QgdGhpcyBvcHRpb24gZXNwZWNpYWxseS4KPiA+IAo+
ID4gRm9yIFNORF9TT0NfSU1YX1BDTV9GSVEgSSBqdXN0IG5vdCBpbWFnaW5lIHlldCBob3cgdG8g
ZGVzY3JpYmUgdGhpcyBvcHRpb24KPiA+IGluIEtjb25maWcgOykgSW4gYW55IGNhc2UsIGl0IGNh
biBiZSBkb25lIGxhdGVyIGlmIHRoZSB0b3RhbCBjaGFuZ2UgY29uY2VwdCBsb29rcyBnb29kLgo+
IAo+IFBpbmcuCgpJJ20gZmluZSB3aXRoIGl0LgoKU2hhd24KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
