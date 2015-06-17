From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: SoC/Codecs/SGTL5000 - Non working MIC_BIAS Voltage
	settings
Date: Wed, 17 Jun 2015 08:32:59 +0100
Message-ID: <CAOf5uwm2x7K9C3DD7bo82JocHMxoD+pWrz-oJHW9x1Pa1Jjo4w@mail.gmail.com>
References: <557B0528.2060404@eurekelettronica.it>
 <55811FA6.4050408@eurekelettronica.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f172.google.com (mail-ig0-f172.google.com
 [209.85.213.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 562BF265AB3
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 09:33:00 +0200 (CEST)
Received: by igboe5 with SMTP id oe5so73437189igb.1
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 00:32:59 -0700 (PDT)
In-Reply-To: <55811FA6.4050408@eurekelettronica.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gianluca <gianlucarenzi@eurekelettronica.it>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Zeng Zhaoming <zengzm.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Gianluca

On Wed, Jun 17, 2015 at 8:20 AM, gianluca
<gianlucarenzi@eurekelettronica.it> wrote:
> Hello,
> I didn't receive any feedback about this posting...
>
> On 06/12/2015 06:13 PM, gianluca wrote:
>>
>> Hello,
>> in attachment there is a small patch to ensure the correct register
>> value for MIC BIAS Voltage.
>
>
> diff -Nru linux-4.0.5.orig/sound/soc/codecs/sgtl5000.c
> linux-4.0.5/sound/soc/codecs/sgtl5000.c
> --- linux-4.0.5.orig/sound/soc/codecs/sgtl5000.c        2015-06-06
> 17:21:22.000000000 +0200
> +++ linux-4.0.5/sound/soc/codecs/sgtl5000.c     2015-06-12
> 18:09:38.363381087 +0200
> @@ -1339,8 +1339,8 @@
>                         sgtl5000->micbias_resistor <<
> SGTL5000_BIAS_R_SHIFT);
>
>         snd_soc_update_bits(codec, SGTL5000_CHIP_MIC_CTRL,
> -                       SGTL5000_BIAS_R_MASK,
> -                       sgtl5000->micbias_voltage << SGTL5000_BIAS_R_SHIFT);
> +                       SGTL5000_BIAS_VOLT_MASK,
> +                       sgtl5000->micbias_voltage <<
> SGTL5000_BIAS_VOLT_SHIFT);
>         /*

According to what I see look fine. Fabio will comment on it. You
should adjust the subject like:
ASoC: sgtl5000: <description here>

Michael

>          * disable DAP
>          * TODO:
>
>
