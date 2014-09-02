From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCHv2 1/4] ASoC: simple-card: add
 asoc_simple_card_fmt_master() to simplify the code.
Date: Tue, 2 Sep 2014 12:38:48 +0200
Message-ID: <20140902123848.78c4c62a@armhf>
References: <1409649969-15759-1-git-send-email-Li.Xiubo@freescale.com>
 <1409649969-15759-2-git-send-email-Li.Xiubo@freescale.com>
 <54059A35.3020303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
 by alsa0.perex.cz (Postfix) with ESMTP id D30D2262629
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 12:37:36 +0200 (CEST)
In-Reply-To: <54059A35.3020303@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: mark.rutland@arm.com, andrew@lunn.ch, alsa-devel@alsa-project.org, pawel.moll@arm.com, kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org, tiwai@suse.de, Xiubo Li <Li.Xiubo@freescale.com>, ijc+devicetree@hellion.org.uk, lgirdwood@gmail.com, jsarha@ti.com, robh+dt@kernel.org, broonie@kernel.org, galak@codeaurora.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCAwMiBTZXAgMjAxNCAxNTo1MTo0MSArMDUzMApWYXJrYSBCaGFkcmFtIDx2YXJrYWJo
YWRyYW1AZ21haWwuY29tPiB3cm90ZToKCj4gPiArCXN3aXRjaCAoKChucCA9PSBiaXRjbGttYXN0
ZXIpIDw8IDQpIHwgKG5wID09IGZyYW1lbWFzdGVyKSkgewo+ID4gKwljYXNlIDB4MTE6Cj4gPiAr
CQlyZXR1cm4gU05EX1NPQ19EQUlGTVRfQ0JTX0NGUzsKPiA+ICsJY2FzZSAweDEwOgo+ID4gKwkJ
cmV0dXJuIFNORF9TT0NfREFJRk1UX0NCU19DRk07Cj4gPiArCWNhc2UgMHgwMToKPiA+ICsJCXJl
dHVybiBTTkRfU09DX0RBSUZNVF9DQk1fQ0ZTOwo+ID4gKwlkZWZhdWx0Ogo+ID4gKwkJcmV0dXJu
IFNORF9TT0NfREFJRk1UX0NCTV9DRk07Cj4gPiArCX0KPiA+ICsKPiA+ICsJLyogU2hvdWxkbid0
IGJlIGhlcmUgKi8KPiA+ICsJcmV0dXJuIC1FSU5WQUw7Cj4gPiArfSAgCj4gCj4gSXQgd2lsbCBi
ZSBuaWNlIGlmIHdlIGRlY2xhcmUgdGhlIHN3aXRjaCBjYXNlIG51bWJlcnMgYXMgbWFjcm9zIChz
cGVjaWZpYyBuYW1lKS4uLgoKSSBkb24ndCBzZWUgd2hpY2ggbWFjcm9zOiB0aGUgdmFsdWVzIGFy
ZSBqdXN0IDIgYm9vbGVhbnMuCgotLSAKS2VuIGFyIGMnaGVudGHDsQl8CSAgICAgICoqIEJyZWl6
aCBoYSBMaW51eCBhdGF2ISAqKgpKZWYJCXwJCWh0dHA6Ly9tb2luZWpmLmZyZWUuZnIvCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
