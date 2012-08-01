From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/6] ASoC: dapm: If one widget fails,
 do not force all subsequent widgets to fail too
Date: Wed, 01 Aug 2012 08:19:28 +0100
Message-ID: <5018D880.5090306@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-3-git-send-email-lee.jones@linaro.org>
 <20120731134214.GK4468@opensource.wolfsonmicro.com>
 <5017EAC3.3080504@linaro.org>
 <20120731142820.GW4468@opensource.wolfsonmicro.com>
 <5017EDCA.4020601@linaro.org>
 <20120731145443.GY4468@opensource.wolfsonmicro.com>
 <5017F68B.3060400@linaro.org>
 <20120731151819.GC4468@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 66BC7265357
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 09:19:30 +0200 (CEST)
Received: by eaaa13 with SMTP id a13so1298660eaa.38
 for <alsa-devel@alsa-project.org>; Wed, 01 Aug 2012 00:19:31 -0700 (PDT)
In-Reply-To: <20120731151819.GC4468@opensource.wolfsonmicro.com>
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

T24gMzEvMDcvMTIgMTY6MTgsIE1hcmsgQnJvd24gd3JvdGU6Cj4+PiBJdCdzIGNlcnRhaW5seSB0
b3RhbGx5IGluYXBwcm9wcmlhdGUgZm9yIGFuICJ1cmdlbnQiIGJ1Z2ZpeC4KPgo+PiBXZWxsIGl0
IGp1c3QgbWVhbnMgdGhhdCBhdWRpbyB3b24ndCB3b3JrIGZvciB0aGUgdXg1MDAgZm9yIHRoaXMK
Pj4ga2VybmVsIHJlbGVhc2UsIGJ1dCBhcyB3ZSdyZSB3YWl0aW5nIG9uIGNsb2NrcywgdGhpcyBp
c24ndCBhIGJpZwo+PiBpc3N1ZSBmb3IgdXMuIElmIHlvdSBkbyB0YWtlIGl0ICh3aXRoIG9yIHdp
dGhvdXQgdGhlIHJldHVybiBjb2RlKSwKPj4gZmVlbCBmcmVlIHRvIGFkZCBpdCB0byBmb3ItbmV4
dCBpbnN0ZWFkIG9mIHRoZSAtcmM6cwo+Cj4gSSdtIG5vdCBnb2luZyB0byBhcHBseSB0aGlzIHBh
dGNoLiAgVGhpcyBpc24ndCBhIHZlbmRvciBCU1AsIHdlCj4gc2hvdWxkbid0IGJlIHB1dHRpbmcg
cmFuZG9tIGhhY2tzIGxpa2UgdGhpcyBpbiBjb3JlIGNvZGUuCgpCU1Aga2VybmVsIG9yIG90aGVy
d2lzZSwgaXQgc3RpbGwgc2VlbXMgd3JvbmcgdG8gbWUgdG8gZmFpbCBhbmQgZW50aXJlIAphdWRp
byBkcml2ZXIganVzdCBiZWNhdXNlIG9mIGEgYnJva2VuIGxpbmsuCgotLSAKTGVlIEpvbmVzCkxp
bmFybyBTVC1Fcmljc3NvbiBMYW5kaW5nIFRlYW0gTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNv
dXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0
dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0
cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
