From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: what is the difference between
 SNDRV_PCM_FMTBIT_S24_LE and SNDRV_PCM_FMTBIT_S24_3LE
Date: Thu, 11 Apr 2013 08:27:21 -0700
Message-ID: <5166D659.90505@gmail.com>
References: <6B947C8AC4195040A8C6876A496C644A082F1EB2@BJ-MAIL-04.vimicro.com>
 <51667BBC.3070609@ladisch.de>
 <6B947C8AC4195040A8C6876A496C644A082F1EEE@BJ-MAIL-04.vimicro.com>
 <516683FD.4000804@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f47.google.com (mail-pb0-f47.google.com
 [209.85.160.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BA562610AD
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 17:27:36 +0200 (CEST)
Received: by mail-pb0-f47.google.com with SMTP id rq13so915731pbb.20
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 08:27:35 -0700 (PDT)
In-Reply-To: <516683FD.4000804@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Zhang wei <zhangwei@vimicro.com>
List-Id: alsa-devel@alsa-project.org

On 04/11/2013 02:35 AM, Clemens Ladisch wrote:
> (please do not drop the mailing list from replies.)
>
> Zhang wei wrote:
>> I do not really understand. For example,an codec is wm8985 ...
>
> The SNDRV_PCM_* symbols specify the format in which samples are
> stored in memory.
>
> I do not know how ASoC maps these symbols to on-the-wire formats.

The SNDRV_PCM_* symbol specifies the format of the audio in RAM, and 
transfers that audio to the digital audio interface (DAI) on the CPU 
side.  (E.g. the OMAP McBSP.)

The on-the-wire format is set up by the ASoC machine driver (i.e. "sound 
card.")  It will configure the CPU DAI (e.g. the OMAP McBSP) and the 
codec (e.g. wm8985) to expect the same "on-the-wire" format.  For 
example, in sound/soc/omap/omap-twl4030.c (beagleboard's machine driver) 
the on-the-wire format is done in omap_twl4030_hw_params() like this 
(edited for brevity):

         fmt =   SND_SOC_DAIFMT_I2S |
                 SND_SOC_DAIFMT_NB_NF |
                 SND_SOC_DAIFMT_CBM_CFM;

         /* Set codec DAI configuration */
         ret = snd_soc_dai_set_fmt(codec_dai, fmt);

         /* Set cpu DAI configuration */
         ret = snd_soc_dai_set_fmt(cpu_dai, fmt);

The CPU DAI is responsible for converting the SNDRV_PCM_* format into 
the serial format.  Therefore, the conversions that it supports is 
totally hardware-dependent.

-gabriel
