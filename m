From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC] ASoC: sgtl5000: Remove cache support
Date: Sat, 4 May 2013 15:47:42 -0300
Message-ID: <CAOMZO5B84e0YdcJLa27e4KZv459CGL=msU0fqe4LyFZfM-t1+A@mail.gmail.com>
References: <1367610549-25542-1-git-send-email-festevam@gmail.com>
 <20130503223613.GR4945@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f46.google.com (mail-vb0-f46.google.com
 [209.85.212.46])
 by alsa0.perex.cz (Postfix) with ESMTP id EEA01261692
 for <alsa-devel@alsa-project.org>; Sat,  4 May 2013 20:47:42 +0200 (CEST)
Received: by mail-vb0-f46.google.com with SMTP id 10so2140282vbe.33
 for <alsa-devel@alsa-project.org>; Sat, 04 May 2013 11:47:42 -0700 (PDT)
In-Reply-To: <20130503223613.GR4945@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, matt@genesi-usa.com, alsa-devel@alsa-project.org, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Fri, May 3, 2013 at 7:36 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Fri, May 03, 2013 at 04:49:09PM -0300, Fabio Estevam wrote:
>
>>       .set_bias_level = sgtl5000_set_bias_level,
>> -     .reg_cache_size = ARRAY_SIZE(sgtl5000_regs),
>> -     .reg_word_size = sizeof(u16),
>> -     .reg_cache_step = 2,
>> -     .reg_cache_default = sgtl5000_regs,
>
> So, the most obvious thing here is to convert the driver to regmap.  It
> has a much more baked in idea of sparse register maps which should help
> if nothing else, and will allow the device initialisation to be moved to
> the normal device probe which is better practice.

Thanks for your suggestion.

I have just sent a patch converting sgtl5000 to use regmap.

Unfortunately the result is the same: the codec cannot probe after a reset.

> Otherwise the normal issue with this sort of thing is a failure to power
> down the device properly, the LDO workaround looks suspicous here as
> does the fact that the driver doesn't restore the register cache when
> powering on the device in resume (nor does it makr the device as cache
> only).

I will try to investigate the power down and LDO workaround as suggested.

Thanks,

Fabio Estevam
