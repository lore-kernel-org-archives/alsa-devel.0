From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: Re: [PATCH 1/6] ASoC: ab8500-codec: Add missing
 ad_to_slot definitions
Date: Wed, 8 May 2013 10:30:17 +0200
Message-ID: <20130508083017.GB1526@balto.lan>
References: <1367997261-32048-1-git-send-email-fabio.baltieri@linaro.org>
 <1367997261-32048-2-git-send-email-fabio.baltieri@linaro.org>
 <20130508075328.GF3102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f171.google.com (mail-we0-f171.google.com
 [74.125.82.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 77CD32616A3
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 10:30:28 +0200 (CEST)
Received: by mail-we0-f171.google.com with SMTP id u55so1532907wes.16
 for <alsa-devel@alsa-project.org>; Wed, 08 May 2013 01:30:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130508075328.GF3102@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBNYXkgMDgsIDIwMTMgYXQgMDg6NTM6MjhBTSArMDEwMCwgTGVlIEpvbmVzIHdyb3Rl
Ogo+IEknbSBzdXJlIHRoaXMgaXMganVzdCBtZSwgYnV0Ogo+IAo+ID4gICAgMCB0byAgNyBjb3Jy
ZXNwb25kcyB0byBBRF9PVVR4IHNsb3RzCj4gPiBjaGFyICogY29uc3QgZW51bV9hZF90b19zbG90
X21hcFtdID0geyJBRF9PVVQxIiwgICAgMAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDEuLjUgPz8/Cj4gPiAgCQkJCQkiQURfT1VUNyIsICAg
IDYKPiA+ICAJCQkJCSJBRF9PVVQ4IiwgICAgNwoKSSdtIGEgYml0IGNvbmZ1c2VkLi4uIHRoZSBm
aXJzdCBvbmUgd2FzIGZyb20gdGhlIGRpZmYgaGVhZGVyLCB3aGlsZSBPVVQ3IGFuZApPVVQ4IGFy
ZSBjb250ZXh0IGxpbmVzLCBzbyAxIHRvIDUgYXJlIGFscmVhZHkgdGhlcmUgYnV0IG5vdCBzaG93
biBpbiB0aGUKcGF0Y2guICBUaGUgZmluYWwgYXJyYXkgaXMgbGlrZToKCnN0YXRpYyBjb25zdCBj
aGFyICogY29uc3QgZW51bV9hZF90b19zbG90X21hcFtdID0geyJBRF9PVVQxIiwKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJBRF9PVVQyIiwKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICJBRF9PVVQzIiwKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICJBRF9PVVQ0IiwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJBRF9PVVQ1IiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICJBRF9PVVQ2IiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICJBRF9PVVQ3IiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJBRF9P
VVQ4IiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJ6ZXJvZXMiLAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInplcm9lcyIsCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiemVyb2VzIiwKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICJ6ZXJvZXMiLAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgInRyaXN0YXRlIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJ0cmlzdGF0ZSIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAidHJpc3RhdGUiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgInRyaXN0YXRlIn07CgpJcyBpdCBvaz8KCkZhYmlvCgo+ID4gICAgOCB0byAxMSBjb3JyZXNw
b25kcyB0byB6ZXJvIG91dHB1dAo+ID4gIAkJCQkJInplcm9lcyIsICAgICA4Cj4gPiArCQkJCQki
emVyb2VzIiwgICAgIDkKPiA+ICsJCQkJCSJ6ZXJvZXMiLCAgICAgMTAKPiA+ICsJCQkJCSJ6ZXJv
ZXMiLCAgICAgMTEKPiA+ICAgMTIgdG8gMTUgc2V0cyB0aGUgb3V0cHV0IGluIHRyaXN0YXRlIG1v
ZGUKPiA+ICsJCQkJCSJ0cmlzdGF0ZSIsICAgMTIKPiA+ICsJCQkJCSJ0cmlzdGF0ZSIsICAgMTMK
PiA+ICsJCQkJCSJ0cmlzdGF0ZSIsICAgMTQKPiA+ICAJCQkJCSJ0cmlzdGF0ZSJ9OyAgMTUKPiAK
PiAKPiAtLSAKPiBMZWUgSm9uZXMKPiBMaW5hcm8gU1QtRXJpY3Nzb24gTGFuZGluZyBUZWFtIExl
YWQKPiBMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKPiBG
b2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCgotLSAKRmFiaW8gQmFsdGll
cmkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
