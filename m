From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: wm8960: Let wm8960 driver
 configure its bit clock and frame clock
Date: Tue, 4 Apr 2017 10:55:00 +0300
Message-ID: <CAEnQRZDoiygL+rN1sF3JnTARKWsHzjPp-PB2uK1J3dtHBCsy=A@mail.gmail.com>
References: <1420615905-4078-1-git-send-email-zidan.wang@freescale.com>
 <1420615905-4078-2-git-send-email-zidan.wang@freescale.com>
 <20150114192703.GH3043@sirena.org.uk> <20150115133439.GA29323@b50113>
 <CAEnQRZD0LuUiULNrv6RJQsr8ZZE+v2-qNC1Za9vXk5+TtB0dOw@mail.gmail.com>
 <20170403133434.GU6986@localhost.localdomain>
 <CAEnQRZA_BzqY5ywkik0-+dCXj1C7ORzjh3Fnt_AM_e=HnaOKMg@mail.gmail.com>
 <20170403135436.GV6986@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f193.google.com (mail-io0-f193.google.com
 [209.85.223.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EE2FB2668F6
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 09:55:02 +0200 (CEST)
Received: by mail-io0-f193.google.com with SMTP id f84so14389323ioj.0
 for <alsa-devel@alsa-project.org>; Tue, 04 Apr 2017 00:55:02 -0700 (PDT)
In-Reply-To: <20170403135436.GV6986@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, tiwai@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, shengjiu.wang@nxp.com, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, viorel.suman@nxp.com, mihai.serban@nxp.com
List-Id: alsa-devel@alsa-project.org

<Removing Zidan from thread because the address no longer exists>

On Mon, Apr 3, 2017 at 4:54 PM, Charles Keepax
<ckeepax@opensource.wolfsonmicro.com> wrote:
> On Mon, Apr 03, 2017 at 04:39:40PM +0300, Daniel Baluta wrote:
>> On Mon, Apr 3, 2017 at 4:34 PM, Charles Keepax
>> <ckeepax@opensource.wolfsonmicro.com> wrote:
>> > On Mon, Apr 03, 2017 at 04:16:23PM +0300, Daniel Baluta wrote:
>> > Does this problem still remain after the relaxed clock
>> > computation? The maths you quote depends on the derived BCLK
>> > being exactly the correct speed for the audio, that is no longer
>> > the case anymore.
>> >
>> > I would have thought the patch would cover both situations, as in
>> > if we can produce a suitable LRCLK, then we just pick a BCLK we
>>
>> That!
>>
>> The problem for remaining rates is that we cannot derive the LRCLK
>>
>> <snip>
>> + for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
>> + if (sysclk != dac_divs[j] * lrclk)
>> + continue;
>> </snip>
>>
>
> If you can't generate the LRCLK you either need a different
> source clock or to use the PLL. You don't want to be trying to
> pull 44.1k audio over a link that is clocked on a 48k based
> clock.

Yup, this makes sense to me.

>
> Is the problem here that the PLL part of the code is making the
> same assumption as the direct part of the code was, that the bclk
> should be exact?

Yes.


After wm8960_configure_sysclk fails to find a LRCLK, we try to use the
PLL.

Anyhow, here we don't even reach to check if the PLL can be used because
there is no solution for the following system:

freq_out = sysclk * sysclk_divs[i];
sysclk = lrclk * dac_divs[j];
sysclk == bclk * bclk_divs[k]


Perhaps, we can also try here to relax bitclk computation like we did for when
sysclk was directly derived from mclk.

thanks,
Daniel.
