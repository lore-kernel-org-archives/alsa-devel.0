From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 05/18] ASoC: Ux500: Enable ux500 MSP driver
 for Device Tree
Date: Mon, 30 Jul 2012 14:57:12 +0100
Message-ID: <501692B8.6050102@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-6-git-send-email-lee.jones@linaro.org>
 <20120729204218.GI4384@opensource.wolfsonmicro.com>
 <50162F70.2050900@linaro.org>
 <20120730133930.GB4468@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 005922652FA
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 15:57:12 +0200 (CEST)
Received: by eeke50 with SMTP id e50so1044172eek.38
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 06:57:15 -0700 (PDT)
In-Reply-To: <20120730133930.GB4468@opensource.wolfsonmicro.com>
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

T24gMzAvMDcvMTIgMTQ6MzksIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gTW9uLCBKdWwgMzAsIDIw
MTIgYXQgMDc6NTM6MzZBTSArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOgo+PiBPbiAyOS8wNy8xMiAy
MTo0MiwgTWFyayBCcm93biB3cm90ZToKPgo+Pj4+ICsJaWYgKG9mX2dldF9wcm9wZXJ0eShucCwg
InN0ZXJpY3Nzb24sdXNlLXBpbmN0cmwiLCBOVUxMKSkKPgo+Pj4gVGhpcyBkb2Vzbid0IHNlZW0g
cGFydGljdWxhcmx5IHNhbmUuLi4gIHdoeSBpcyB0aGlzIGNvbmRpdGlvbmFsPwo+Cj4+IEl0J3Mg
Y29uZGl0aW9uYWwgYmVjYXVzZSBvbmx5IE1TUDEgYW5kIE1TUDMgaGF2ZSBwaW5jdHJsIHN1cHBv
cnQuCj4KPiBXaHkgZG9lcyB0aGUgZHJpdmVyIGNhcmUgLSBkb2Vzbid0IHRoZSBwaW5jdHJsIGFi
c3RyYWN0aW9uIGFuZC9vcgo+IGJpbmRpbmdzIGhhbmRsZSB0aGlzIHNlbnNpYmx5PwoKTm90IHdo
ZW4gSSB0ZXN0ZWQgaXQuIHBpbmN0cmxfZ2V0KCkgY2FtZSBiYWNrICFJU19FUlIoKSBmb3IgTVNQ
MCwgTVNQMiAmIApNU1AzLCB0aGVuIHdoZW4gaXQgd2VudCBvbiB0byBwaW5jdHJsX2xvb2t1cF9z
dGF0ZSgpLCBvbmx5IHRoZW4gZGlkIGl0IApmYWlsLiBXb3VsZCBpdCBiZSBtb3JlIHNhbmUgdG8g
cmV0cmFjdCB0aGUgZXJyb3IgbWVzc2FnZXMgYW5kIGp1c3QgbGV0IAppdCBmYWlsIHNpbGVudGx5
PyBJdCdzIGVpdGhlciB0aGF0IG9yIGhhdmUgbG90cyBvZiAiY291bGQgbm90IGdldCBNU1AgCmRl
ZnN0YXRlIiBjbG9nZ2luZyB1cCB0aGUgbG9nLgoKLS0gCkxlZSBKb25lcwpMaW5hcm8gU1QtRXJp
Y3Nzb24gTGFuZGluZyBUZWFtIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdh
cmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
