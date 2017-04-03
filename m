From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: wm8960: Let wm8960 driver
 configure its bit clock and frame clock
Date: Mon, 3 Apr 2017 16:16:23 +0300
Message-ID: <CAEnQRZD0LuUiULNrv6RJQsr8ZZE+v2-qNC1Za9vXk5+TtB0dOw@mail.gmail.com>
References: <1420615905-4078-1-git-send-email-zidan.wang@freescale.com>
 <1420615905-4078-2-git-send-email-zidan.wang@freescale.com>
 <20150114192703.GH3043@sirena.org.uk> <20150115133439.GA29323@b50113>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
 [209.85.214.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 186D92669D7
 for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2017 15:16:24 +0200 (CEST)
Received: by mail-it0-f66.google.com with SMTP id e75so8090960itd.1
 for <alsa-devel@alsa-project.org>; Mon, 03 Apr 2017 06:16:24 -0700 (PDT)
In-Reply-To: <20150115133439.GA29323@b50113>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <b50113@freescale.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Zidan Wang <zidan.wang@freescale.com>, tiwai@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, shengjiu.wang@nxp.com, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, viorel.suman@nxp.com, mihai.serban@nxp.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 15, 2015 at 3:34 PM, Zidan Wang <b50113@freescale.com> wrote:
> On Wed, Jan 14, 2015 at 07:27:03PM +0000, Mark Brown wrote:
>> On Wed, Jan 07, 2015 at 03:31:45PM +0800, Zidan Wang wrote:
>>
>> > +   for (i = 0; i < ARRAY_SIZE(dac_divs); ++i) {
>> > +           if (wm8960->sysclk == lrclk * dac_divs[i]) {
>> > +                   for (j = 0; j < ARRAY_SIZE(bclk_divs); ++j) {
>> > +                           if (wm8960->sysclk ==  wm8960->bclk *
>> > +                                           bclk_divs[j] / 10) {
>> > +                                   goto config_clock;
>> > +                           }
>> > +                   }
>> > +           }
>> > +   }
>> > +
>> > +   dev_err(codec->dev, "Unsupported sysclk %d\n", wm8960->sysclk);
>> > +   return;
>>
>> It's a bit awkward using the goto like this.  A more common way of
>> writing this is to change the above block to be
>>
>>       if (i == ARRAY_SIZE(dac_divs))
>>               /* return error */
>>
>> rather than skipping over the error.  Otherwise this looks good.
>
> Hi Mark,
>
> I found it can't generate bclk for S20_3LE data format.
>
> For 2 channel S20_3LE data format:
>
> bclk = fs * 20 * 2
> Sysclk = BCLKDIV * bclk = BCLKDIV * fs * 40
> Sysclk = DACDIV * fs * 256
>
> BCLKDIV/DACDIV = 256/40 = 32/5
>
> But BCLKDIV/DACDIV can't be 32/5. So I want to support tdm slot.
>
> bclk = fs * slot_width * slots * channal.
>
> Do you think it make sense, or any other ideas?

Reviving this question after two years :).

After "ASoC: codec: wm8960: Relax bit clock computation" patch

https://patchwork.kernel.org/patch/9636769/

we can now support S20_3LE for round rates like 8000, 16000,
32000 and 48000.

But not for 11025, 22050, 441000. Do you think it's worth exploring
"tdm slot" idea? I don't know exactly what it implies.

Another idea, is to completely remove support for S20_3LE since it
is not trivial to derive bitclk from sysclk.

What do you guys think?

Daniel.
