From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: ASoC: ssm4567: Add driver for Analog Devices
	SSM4567 amplifier
Date: Wed, 1 Oct 2014 10:12:53 -0700
Message-ID: <CAOMFOmXOhDc=nwqcCUPqF6yFqMSvZwdE1gbATxZVhFpM40nvHQ@mail.gmail.com>
References: <20141001170257.GB11786@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f171.google.com (mail-vc0-f171.google.com
 [209.85.220.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A48D2604B6
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 19:12:54 +0200 (CEST)
Received: by mail-vc0-f171.google.com with SMTP id hy10so587459vcb.2
 for <alsa-devel@alsa-project.org>; Wed, 01 Oct 2014 10:12:53 -0700 (PDT)
In-Reply-To: <20141001170257.GB11786@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

On Wed, Oct 1, 2014 at 10:02 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Hello Anatol Pomozov,
>
> The patch 1ee44ce03011: "ASoC: ssm4567: Add driver for Analog Devices
> SSM4567 amplifier" from Sep 26, 2014, leads to the following static
> checker warning:

Thanks!

What static checker do you use and how can I run locally?

>         sound/soc/codecs/ssm4567.c:176 ssm4567_hw_params()
>         warn: we tested 'rate <= 96000' before and it was 'false'
>
> sound/soc/codecs/ssm4567.c
>    160  static int ssm4567_hw_params(struct snd_pcm_substream *substream,
>    161          struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
>    162  {
>    163          struct snd_soc_codec *codec = dai->codec;
>    164          struct ssm4567 *ssm4567 = snd_soc_codec_get_drvdata(codec);
>    165          unsigned int rate = params_rate(params);
>    166          unsigned int dacfs;
>    167
>    168          if (rate >= 8000 && rate <= 12000)
>    169                  dacfs = SSM4567_DAC_FS_8000_12000;
>    170          else if (rate >= 16000 && rate <= 24000)
>    171                  dacfs = SSM4567_DAC_FS_16000_24000;
>    172          else if (rate >= 32000 && rate <= 48000)
>    173                  dacfs = SSM4567_DAC_FS_32000_48000;
>    174          else if (rate >= 64000 && rate <= 96000)
>    175                  dacfs = SSM4567_DAC_FS_64000_96000;
>    176          else if (rate >= 64000 && rate <= 96000)
>    177                  dacfs = SSM4567_DAC_FS_64000_96000;
>
> These two lines are a cut and paste error.  The intent is not clear.

It is a copy/paste error. Will send a fix soon.

>
>    178          else if (rate >= 128000 && rate <= 192000)
>    179                  dacfs = SSM4567_DAC_FS_128000_192000;
>    180          else
>    181                  return -EINVAL;
>    182
>    183          return regmap_update_bits(ssm4567->regmap, SSM4567_REG_DAC_CTRL,
>    184                                  SSM4567_DAC_FS_MASK, dacfs);
>    185  }
>
> regards,
> dan carpenter
