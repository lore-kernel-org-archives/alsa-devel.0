From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Allow the codec to work in
	slave mode
Date: Mon, 29 Sep 2014 10:17:57 -0300
Message-ID: <CAOMZO5BUvZDgY+-VUVENWEoXZS4qFDBKA7ZZLAOzDt-Oawm9tA@mail.gmail.com>
References: <1411082245-25679-1-git-send-email-festevam@gmail.com>
 <20140923015448.GF27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f46.google.com (mail-la0-f46.google.com
 [209.85.215.46])
 by alsa0.perex.cz (Postfix) with ESMTP id B796C2606B6
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 15:17:57 +0200 (CEST)
Received: by mail-la0-f46.google.com with SMTP id gi9so7701580lab.33
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 06:17:57 -0700 (PDT)
In-Reply-To: <20140923015448.GF27755@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Mon, Sep 22, 2014 at 10:54 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Sep 18, 2014 at 08:17:25PM -0300, Fabio Estevam wrote:
>
>>       default:
>> -             /* if mclk not satisify the divider, use pll */
>> +             /* if mclk not satisfy the divider, use pll */
>>               if (sgtl5000->master) {
>>                       clk_ctl |= SGTL5000_MCLK_FREQ_PLL <<
>>                               SGTL5000_MCLK_FREQ_SHIFT;
>> -             } else {
>> -                     dev_err(codec->dev,
>> -                             "PLL not supported in slave mode\n");
>> -                     return -EINVAL;
>>               }
>>       }
>
> Are you sure that the configuration that results is valid?  Typically
> the requirements for MCLK to other clock ratios are very similar for
> master and slave modes, it's just that it tends to be a lot more obvious
> when things go wrong in master mode since directly visible clocks tend
> to go wrong as opposed to performance problems.  Are the dividers that
> we can't get configuration for purely for generating BCLK/LRCLK in
> master mode or are they for other things?

Tested sgtl5000 slave mode with different sampling rates and it plays well.

Any particular register I should monitor?

Sorry, but I guess I did not understand your last question.
