From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: msm8916-wcd-analog: fix
	micbias level
Date: Mon, 2 Oct 2017 10:52:00 +0100
Message-ID: <d1f9b0de-9972-b5e5-128c-2450f6345e5c@linaro.org>
References: <1506716384-4700-1-git-send-email-jean-francois.tetu@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f42.google.com (mail-lf0-f42.google.com
 [209.85.215.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D594267105
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 11:52:02 +0200 (CEST)
Received: by mail-lf0-f42.google.com with SMTP id d4so5416881lfj.7
 for <alsa-devel@alsa-project.org>; Mon, 02 Oct 2017 02:52:02 -0700 (PDT)
In-Reply-To: <1506716384-4700-1-git-send-email-jean-francois.tetu@savoirfairelinux.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Jean-Fran=c3=a7ois_T=c3=aatu?= <jean-francois.tetu@savoirfairelinux.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

VGhhbmtzIGZvciB0aGUgcGF0Y2guCgpPbiAyOS8wOS8xNyAyMToxOSwgSmVhbi1GcmFuw6dvaXMg
VMOqdHUgd3JvdGU6Cj4gVGhlIG1hY3JvIHVzZWQgdG8gc2V0IHRoZSBtaWNyb3Bob25lIGJpYXMg
bGV2ZWwgY2F1c2VzIHRoZQo+IHNuZF9zb2Nfd3JpdGUoKSBjYWxsIHRvIG92ZXJ3cml0ZSBvdGhl
ciBmaWVsZHMgaW4gdGhlIENEQ19BX01JQ0JfMV9WQUwKPiByZWdpc3Rlci4gVGhlIG1hY3JvIGFs
c28gZG9lcyBub3QgcmV0dXJuIHRoZSBwcm9wZXIgbGV2ZWwgdmFsdWUKPiB0byB1c2UuIFRoaXMg
Zml4ZXMgdGhpcyBieSBwcmVzZXJ2aW5nIGFsbCBiaXRzIGZyb20gdGhlIHJlZ2lzdGVyCj4gdGhh
dCBhcmUgbm90IHRoZSBsZXZlbCB3aGlsZSBzZXR0aW5nIHRoZSBsZXZlbC4KPiAKPiBTaWduZWQt
b2ZmLWJ5OiBKZWFuLUZyYW7Dp29pcyBUw6p0dSA8amVhbi1mcmFuY29pcy50ZXR1QHNhdm9pcmZh
aXJlbGludXguY29tPgo+IC0tLQoKQWNrZWQtYnk6IFNyaW5pdmFzIEthbmRhZ2F0bGEgPHNyaW5p
dmFzLmthbmRhZ2F0bGFAbGluYXJvLm9yZz4KCgo+ICAgc291bmQvc29jL2NvZGVjcy9tc204OTE2
LXdjZC1hbmFsb2cuYyB8IDcgKysrKy0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy9t
c204OTE2LXdjZC1hbmFsb2cuYyBiL3NvdW5kL3NvYy9jb2RlY3MvbXNtODkxNi13Y2QtYW5hbG9n
LmMKPiBpbmRleCBmNTYyZjJkLi5lMTUzNGZlIDEwMDY0NAo+IC0tLSBhL3NvdW5kL3NvYy9jb2Rl
Y3MvbXNtODkxNi13Y2QtYW5hbG9nLmMKPiArKysgYi9zb3VuZC9zb2MvY29kZWNzL21zbTg5MTYt
d2NkLWFuYWxvZy5jCj4gQEAgLTEwNCw3ICsxMDQsNyBAQAo+ICAgI2RlZmluZSBDRENfQV9NSUNC
XzFfVkFMCQkoMHhmMTQxKQo+ICAgI2RlZmluZSBNSUNCX01JTl9WQUwgMTYwMAo+ICAgI2RlZmlu
ZSBNSUNCX1NURVBfU0laRSA1MAo+IC0jZGVmaW5lIE1JQ0JfVk9MVEFHRV9SRUdWQUwodikJCSgo
diAtIE1JQ0JfTUlOX1ZBTCkvTUlDQl9TVEVQX1NJWkUpCj4gKyNkZWZpbmUgTUlDQl9WT0xUQUdF
X1JFR1ZBTCh2KQkJKCgodiAtIE1JQ0JfTUlOX1ZBTCkvTUlDQl9TVEVQX1NJWkUpIDw8IDMpCj4g
ICAjZGVmaW5lIE1JQ0JfMV9WQUxfTUlDQl9PVVRfVkFMX01BU0sJR0VOTUFTSyg3LCAzKQo+ICAg
I2RlZmluZSBNSUNCXzFfVkFMX01JQ0JfT1VUX1ZBTF9WMlA3MFYJKCgweDE2KSAgPDwgMykKPiAg
ICNkZWZpbmUgTUlDQl8xX1ZBTF9NSUNCX09VVF9WQUxfVjFQODBWCSgoMHg0KSAgPDwgMykKPiBA
QCAtMzQ5LDggKzM0OSw5IEBAIHN0YXRpYyB2b2lkIHBtODkxNl93Y2RfYW5hbG9nX21pY2JpYXNf
ZW5hYmxlKHN0cnVjdCBzbmRfc29jX2NvZGVjICpjb2RlYykKPiAgIAkJCSAgICB8IE1JQ0JfMV9D
VExfRVhUX1BSRUNIQVJHX0VOX0VOQUJMRSk7Cj4gICAKPiAgIAlpZiAod2NkLT5taWNiaWFzX212
KSB7Cj4gLQkJc25kX3NvY193cml0ZShjb2RlYywgQ0RDX0FfTUlDQl8xX1ZBTCwKPiAtCQkJICAg
ICAgTUlDQl9WT0xUQUdFX1JFR1ZBTCh3Y2QtPm1pY2JpYXNfbXYpKTsKPiArCQlzbmRfc29jX3Vw
ZGF0ZV9iaXRzKGNvZGVjLCBDRENfQV9NSUNCXzFfVkFMLAo+ICsJCQkJICAgIE1JQ0JfMV9WQUxf
TUlDQl9PVVRfVkFMX01BU0ssCj4gKwkJCQkgICAgTUlDQl9WT0xUQUdFX1JFR1ZBTCh3Y2QtPm1p
Y2JpYXNfbXYpKTsKPiAgIAkJLyoKPiAgIAkJICogU3BlY2lhbCBoZWFkc2V0IG5lZWRzIE1JQ0JJ
QVMgYXMgMi43ViBzbyB3YWl0IGZvcgo+ICAgCQkgKiA1MCBtc2VjIGZvciB0aGUgTUlDQklBUyB0
byByZWFjaCAyLjcgdm9sdHMuCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9q
ZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8v
YWxzYS1kZXZlbAo=
