From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 3/3] gpiolib-acpi: Move
 acpi_dev_add_driver_gpios() et al to consumer.h
Date: Wed, 31 Jul 2019 01:02:14 +0200
Message-ID: <CACRpkdZXTRENogogOxrB6F5aXQSd5qehXFP1R3ax0um1XU93Aw@mail.gmail.com>
References: <20190730104337.21235-1-andriy.shevchenko@linux.intel.com>
 <20190730104337.21235-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E099FF80214
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2019 01:02:27 +0200 (CEST)
Received: by mail-lf1-x141.google.com with SMTP id c9so45899411lfh.4
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2019 16:02:27 -0700 (PDT)
In-Reply-To: <20190730104337.21235-3-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jie Yang <yang.jie@linux.intel.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBKdWwgMzAsIDIwMTkgYXQgMTI6NDMgUE0gQW5keSBTaGV2Y2hlbmtvCjxhbmRyaXku
c2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+IHdyb3RlOgoKPiBUaGUgQVBJLCB3aGljaCBiZWxv
bmdzIHRvIEdQSU8gbGlicmFyeSwgaXMgZm9yZWlnbiB0byBBQ1BJIGhlYWRlcnMuIEVhcmxpZXIK
PiB3ZSBtb3ZlZCBvdXQgScKyQyBvdXQgb2YgdGhlIGxhdHRlciwgYW5kIG5vdyBpdCdzIHRpbWUg
Zm9yCj4gYWNwaV9kZXZfYWRkX2RyaXZlcl9ncGlvcygpIGV0IGFsLgo+Cj4gRm9yIHRpbWUgYmVp
bmcgdGhlIGFjcGlfZ3Bpb19nZXRfaXJxX3Jlc291cmNlKCkgYW5kIGFjcGlfZGV2X2dwaW9faXJx
X2dldCgpCj4gYXJlIGxlZnQgdW50b3VjaGVkIGFzIHRoZXkgbmVlZCBtb3JlIHRob3VnaHQgYWJv
dXQuCj4KPiBOb3RlLCBpdCByZXF1aXJlcyB1bmlubGluZSBhY3BpX2Rldl9yZW1vdmVfZHJpdmVy
X2dwaW9zKCkgdG8ga2VlcCBwdXJpdHkgb2YKPiBjb25zdW1lci5oLgo+Cj4gQ2M6IFBpZXJyZS1M
b3VpcyBCb3NzYXJ0IDxwaWVycmUtbG91aXMuYm9zc2FydEBsaW51eC5pbnRlbC5jb20+Cj4gQ2M6
IExpYW0gR2lyZHdvb2QgPGxpYW0uci5naXJkd29vZEBsaW51eC5pbnRlbC5jb20+Cj4gQ2M6IEpp
ZSBZYW5nIDx5YW5nLmppZUBsaW51eC5pbnRlbC5jb20+Cj4gQ2M6IE1hcmsgQnJvd24gPGJyb29u
aWVAa2VybmVsLm9yZz4KPiBDYzogYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnIChtb2RlcmF0
ZWQgbGlzdDpJTlRFTCBBU29DIERSSVZFUlMpCj4gU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hl
bmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+CgpQYXRjaCBhcHBsaWVkIQoK
SnVzdCBhIGJpdCB3b3JyaWVkIHRoYXQgdGhpcyB3aWxsIGNvbGxpZGUgd2l0aCBNYXNhaGlybydz
ICNpZmRlZi1yZWR1Y3Rpb24sCmJ1dCBJIHdhbnRlZCB0byBrZWVwIHlvdXIgc2VyaWVzIHRvZ2V0
aGVyLgoKWW91cnMsCkxpbnVzIFdhbGxlaWoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHBzOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlz
dGluZm8vYWxzYS1kZXZlbAo=
