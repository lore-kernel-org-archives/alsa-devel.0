From: Bo Shen <voice.shen@atmel.com>
Subject: Re: Question about move atmel audio part to DT support
Date: Fri, 19 Oct 2012 16:18:16 +0800
Message-ID: <50810CC8.4050009@atmel.com>
References: <5080F54F.4000600@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EBD9261669
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 10:18:42 +0200 (CEST)
In-Reply-To: <5080F54F.4000600@atmel.com>
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
Cc: alsa-devel@alsa-project.org, "Lin, JM" <JM.Lin@atmel.com>, "Ferre,
 Nicolas" <Nicolas.FERRE@atmel.com>, linux-sound@vger.kernel.org, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Cc:
    linux-arm-kernel mailing list
    devicetree-discuss mailing list
    alsa-devel mailing list
    linux-sound mailing list


On 10/19/2012 14:38, Bo Shen wrote:
> Hi Mark Brown,
>    Now, I am trying to move atmel audio part to DT support. I meet the
> following issue.
>
>    Atmel audio part has three platform device:
>      -> atmel ssc: ssc library (different SOC has different number)
>      -> atmel ssc dai: dai for audio
>      -> atmel pcm: for pdc or dma transfer (now only support pdc, dma
> support will add soon)
>
>   In DT support kernel, I don't find any similar case. So, if I want to
> keep ssc as library, and use dai to register pcm. Then the dts file will
> like:
> ---<8---
> ssc0: ssc@fffbc000 {
>                  status = "okay";
> };
>
> dai0: dai {
>                  compatible = "atmel,atmel-ssc-dai";
>          };
>
> sound {
>                  compatible = "atmel,at91sam9g20-audio";
>                  atmel,model = "wm8731 @ sam9g20ek";
>
>                  atmel,audio-routing =
>                          "Ext Spk", "LHPOUT",
>                          "Int Mic", "MICIN";
>
>                  atmel,audio-codec = <&wm8731>;
>                  atmel,dai = <&dai>;
> };
> --->8---
>
>    Would this be OK?
>    If not, may I add some code for ssc which dedicate for audio into
> sound/soc/atmel (using audio-ssc and ssc to distiguish which dedicate
> for audio, which used for ssc library)? This will broken the exist code
> for audio (only sam9g20-wm8731).
>    Any suggestion?
