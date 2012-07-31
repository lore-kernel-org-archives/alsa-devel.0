From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/6] ASoC: dapm: If one widget fails,
 do not force all subsequent widgets to fail too
Date: Tue, 31 Jul 2012 16:15:23 +0100
Message-ID: <5017F68B.3060400@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-3-git-send-email-lee.jones@linaro.org>
 <20120731134214.GK4468@opensource.wolfsonmicro.com>
 <5017EAC3.3080504@linaro.org>
 <20120731142820.GW4468@opensource.wolfsonmicro.com>
 <5017EDCA.4020601@linaro.org>
 <20120731145443.GY4468@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id F142A265D2A
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 17:15:22 +0200 (CEST)
Received: by eeke50 with SMTP id e50so1354555eek.38
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 08:15:25 -0700 (PDT)
In-Reply-To: <20120731145443.GY4468@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, olalilja@yahoo.se, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gMzEvMDcvMTIgMTU6NTQsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gVHVlLCBKdWwgMzEsIDIw
MTIgYXQgMDM6Mzg6MDJQTSArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOgo+Cj4+IE5laXRoZXIgb2Yg
dGhvc2UgYXJlIGluIG15IEluYm94LiBCbGFtZSBNb3ppbGxhLiA6KQo+Cj4gWW91IG1pZ2h0IHdh
bnQgdG8gbG9vayBhdCBhIGJldHRlciBtYWlsIHByb2dyYW0uCgpXaWxsaW5nbHkuIEFueSBnb29k
IHN1Z2dlc3Rpb25zPwoKPj4gSXQncyBiZXR0ZXIgYmVjYXVzZSB0aGUgd2hvbGUgYXVkaW8gc3lz
dGVtIGRvZXNuJ3QgZmFpbCBpbiB0aGUgY2FzZQo+PiBvZiBtaW5vciBmYWlsdXJlLiBJdCdkIGJl
IGxpa2UgY2FsbGluZyBvZmYgYSBmb290YmFsbCBnYW1lIChvcgo+PiB3aGF0ZXZlciB5b3UncmUg
aW50bykgYmVjYXVzZSBvbmUgb2YgdGhlIHN1YnN0aXR1dGVzIHJ1cHR1cmVkIGFuCj4+IGV5ZWxh
c2guCj4KPiBJdCBzaG91bGRuJ3QgbWFrZSBhbnkgZGlmZmVyZW5jZSB0byBzdGFydHVwIC0gd2Ug
c2hvdWxkIHN0aWxsIGJlCj4gY2hlY2tpbmcgZXJyb3JzIGFuZCBmYWlsaW5nIHRoZSBpbml0IGlm
IHdlJ3JlIGZhaWxpbmcgdG8gYWRkIGxpbmtzLAo+IHRoaXMgaXNuJ3Qgc29tZXRoaW5nIHRoYXQn
cyBsaWtlbHkgdG8gcmFuZG9tbHkgYnJlYWsgb24gYSBwYXJ0aWN1bGFyCj4gYm9vdCwgaXQncyBt
b3JlIHNvbWV0aGluZyB0aGF0IGluZGljYXRlcyBub2JvZHkgYm90aGVyZWQgdGVzdGluZy4KPgo+
IEl0J3MgY2VydGFpbmx5IHRvdGFsbHkgaW5hcHByb3ByaWF0ZSBmb3IgYW4gInVyZ2VudCIgYnVn
Zml4LgoKV2VsbCBpdCBqdXN0IG1lYW5zIHRoYXQgYXVkaW8gd29uJ3Qgd29yayBmb3IgdGhlIHV4
NTAwIGZvciB0aGlzIGtlcm5lbCAKcmVsZWFzZSwgYnV0IGFzIHdlJ3JlIHdhaXRpbmcgb24gY2xv
Y2tzLCB0aGlzIGlzbid0IGEgYmlnIGlzc3VlIGZvciB1cy4gCklmIHlvdSBkbyB0YWtlIGl0ICh3
aXRoIG9yIHdpdGhvdXQgdGhlIHJldHVybiBjb2RlKSwgZmVlbCBmcmVlIHRvIGFkZCBpdCAKdG8g
Zm9yLW5leHQgaW5zdGVhZCBvZiB0aGUgLXJjOnMKCj4+IER1cmluZyBzdGFydC11cCB0aGUgdXg1
MDAgaGFzIGEgY291cGxlIG9mIHZlcnkgdW5pbXBvcnRhbnQgd2lkZ2V0cwo+PiBmYWlsLiBJdCdz
IHRoZSB3cm9uZyBiZWhhdmlvciB0byBmb3JjZSBmYWlsdXJlIG9uIHRoZSBldmVyeXRoaW5nCj4+
IGF1ZGlvIGp1c3QgYmVjYXVzZSBvZiB0aGF0Lgo+Cj4gRml4ZXMgZm9yIHRob3NlIGVycm9ycywg
aG93ZXZlci4uLgoKSSdsbCBsZWF2ZSB0aGF0IHRvIHRoZSBhdWRpbyBleHBlcnQuIEknZCBsaWtl
IHRvIG1vdmUgdG8gdG8gc29tZXRoaW5nIAplbHNlICh0aGF0IHlvdSBtYWludGFpbiAtIHBlcmhh
cHMgSSdsbCBnbyBhbmQgbWVzcy11cCByZWd1bGF0b3JzIG5leHQpLiA6KQoKLS0gCkxlZSBKb25l
cwpMaW5hcm8gU1QtRXJpY3Nzb24gTGFuZGluZyBUZWFtIExlYWQKTGluYXJvLm9yZyDilIIgT3Bl
biBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwg
VHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn
Cmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRl
dmVsCg==
