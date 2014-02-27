From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Subject: Re:
 =?utf-8?q?=5BPATCH_1/2=5D_ASoC=3A_fsl=3A_Separation_?=
 =?utf-8?q?of_the_main_audio_options_and_boards?=
Date: Thu, 27 Feb 2014 20:56:58 +0400
Message-ID: <1393520218.924957@f305.i.mail.ru>
References: <1391621512-15064-1-git-send-email-shc_work@mail.ru>
 <20140210055357.GE9628@S2101-09.ap.freescale.net>
 <1392013743.262980234@f144.i.mail.ru>
Reply-To: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f305.i.mail.ru (f305.i.mail.ru [128.140.169.169])
 by alsa0.perex.cz (Postfix) with ESMTP id DE181265703
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 17:57:00 +0100 (CET)
In-Reply-To: <1392013743.262980234@f144.i.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?U2hhd24gR3Vv?= <shawn.guo@linaro.org>
Cc: =?UTF-8?B?RmFiaW8gRXN0ZXZhbQ==?= <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, =?UTF-8?B?VGFrYXNoaSBJd2Fp?= <tiwai@suse.de>, =?UTF-8?B?TGlhbSBHaXJkd29vZA==?= <lgirdwood@gmail.com>, =?UTF-8?B?TWFyayBCcm93bg==?= <broonie@kernel.org>, =?UTF-8?B?Tmljb2xpbiBDaGVu?= <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

0J/QvtC90LXQtNC10LvRjNC90LjQuiwgMTAg0YTQtdCy0YDQsNC70Y8gMjAxNCwgMTA6MjkgKzA0
OjAwINC+0YIgQWxleGFuZGVyIFNoaXlhbiA8c2hjX3dvcmtAbWFpbC5ydT46Cj4gSGVsbG8uCj4g
Cj4gPiBPbiBXZWQsIEZlYiAwNSwgMjAxNCBhdCAwOTozMTo1MVBNICswNDAwLCBBbGV4YW5kZXIg
U2hpeWFuIHdyb3RlOgo+ID4gPiBUaGlzIHBhdGNoIHByb3ZpZGUgc2VwYXJhdGlvbiBvZiB0aGUg
bWFpbiBhdWRpbyBvcHRpb25zIGFuZCBib2FyZHMuCj4gPiA+IAo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBBbGV4YW5kZXIgU2hpeWFuIDxzaGNfd29ya0BtYWlsLnJ1Pgo+ID4gPiAtLS0KPiA+ID4gIHNv
dW5kL3NvYy9mc2wvS2NvbmZpZyB8IDM2ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9u
cygtKQo+ID4gPiAKPiA+ID4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9mc2wvS2NvbmZpZyBiL3Nv
dW5kL3NvYy9mc2wvS2NvbmZpZwo+IC4uLgo+ID4gPiAgaWYgU05EX0lNWF9TT0MKPiA+ID4gIAo+
ID4gPiAgY29uZmlnIFNORF9TT0NfSU1YX1NTSQo+ID4gPiBAQCAtMTIyLDEyICsxMzMsNyBAQCBj
b25maWcgU05EX1NPQ19JTVhfUENNX0ZJUQo+ID4gPiAgCXRyaXN0YXRlCj4gPiA+ICAJc2VsZWN0
IEZJUQo+ID4gCj4gPiBIbW0sIHdoeSBkbyB5b3UgY2hvb3NlIHRvIGhhdmUgU05EX1NPQ19JTVhf
U1NJIGFuZCBTTkRfU09DX0lNWF9QQ01fRklRCj4gPiBzdGlsbCBzdGF5IGluIGJvYXJkIHNlY3Rp
b24/Cj4gCj4gU05EX1NPQ19JTVhfU1NJIGlzIHVzZWQgZm9yIEFUQUdTIGJvYXJkcyBvbmx5LCBh
bmQgc2VsZWN0ZWQgZm9yIGVhY2ggaW5kaXZpZHVhbAo+IHBsYXRmb3JtIGRyaXZlciwgc28gdGhl
cmUgYXJlIG5vIG5lZWQgdG8gc2VsZWN0IHRoaXMgb3B0aW9uIGVzcGVjaWFsbHkuCj4gCj4gRm9y
IFNORF9TT0NfSU1YX1BDTV9GSVEgSSBqdXN0IG5vdCBpbWFnaW5lIHlldCBob3cgdG8gZGVzY3Jp
YmUgdGhpcyBvcHRpb24KPiBpbiBLY29uZmlnIDspIEluIGFueSBjYXNlLCBpdCBjYW4gYmUgZG9u
ZSBsYXRlciBpZiB0aGUgdG90YWwgY2hhbmdlIGNvbmNlcHQgbG9va3MgZ29vZC4KClBpbmcuCgot
LS0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
