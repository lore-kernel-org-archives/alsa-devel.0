From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [alsa-devel] [PATCH v7 1/3] ASoC: da7210: Add support for DAPM
Date: Thu, 20 Oct 2011 17:58:36 +0100
Message-ID: <CABS+qY3Fb6Ou+j-TE8Qit-HDx+SRafBoaZfgPs1CegidX2Dv0g@mail.gmail.com>
References: <1319119369.24621.84.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1319119369.24621.84.camel@matrix>
Sender: linux-kernel-owner@vger.kernel.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, David Dajun Chen <david.chen@diasemi.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 20 October 2011 15:02, Ashish Chavan <ashish.chavan@kpitcummins.com>=
 wrote:
> This patch adds support for DAPM covering all inputs and outputs
> as well as ADC and DAC.
>
> Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
> Signed-off-by: David Dajun Chen <dchen@diasemi.com>
> ---
> Changes since v3:
> - Added missing routes for In-mixer left and right
> - Added comment explaining rational behind use of STANDBY registers
>
> Changes since v1:
> - used supply widget for mic bias
> - removed mic bias hookup
> - assigned dapm widgets and routes in card struct
> - removed explicit setting of default mixer settings
> - removed explicit setting of ios to standby mode
> ---
> =C2=A0sound/soc/codecs/da7210.c | =C2=A0240 +++++++++++++++++++++++++=
+++++++++++++++-----
> =C2=A01 files changed, 216 insertions(+), 24 deletions(-)
>

Acked-by: Liam Girdwood <lrg@ti.com>
