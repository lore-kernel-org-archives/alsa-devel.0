From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/2] ASoC: wm8960: Let wm8960 driver
 configure its bit clock and frame clock
Date: Mon, 3 Apr 2017 14:54:36 +0100
Message-ID: <20170403135436.GV6986@localhost.localdomain>
References: <1420615905-4078-1-git-send-email-zidan.wang@freescale.com>
 <1420615905-4078-2-git-send-email-zidan.wang@freescale.com>
 <20150114192703.GH3043@sirena.org.uk>
 <20150115133439.GA29323@b50113>
 <CAEnQRZD0LuUiULNrv6RJQsr8ZZE+v2-qNC1Za9vXk5+TtB0dOw@mail.gmail.com>
 <20170403133434.GU6986@localhost.localdomain>
 <CAEnQRZA_BzqY5ywkik0-+dCXj1C7ORzjh3Fnt_AM_e=HnaOKMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B4F82669D7
 for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2017 15:53:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAEnQRZA_BzqY5ywkik0-+dCXj1C7ORzjh3Fnt_AM_e=HnaOKMg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: alsa-devel@alsa-project.org, Zidan Wang <b50113@freescale.com>, Lars-Peter Clausen <lars@metafoo.de>, Zidan Wang <zidan.wang@freescale.com>, tiwai@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, shengjiu.wang@nxp.com, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, viorel.suman@nxp.com, mihai.serban@nxp.com
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 03, 2017 at 04:39:40PM +0300, Daniel Baluta wrote:
> On Mon, Apr 3, 2017 at 4:34 PM, Charles Keepax
> <ckeepax@opensource.wolfsonmicro.com> wrote:
> > On Mon, Apr 03, 2017 at 04:16:23PM +0300, Daniel Baluta wrote:
> > Does this problem still remain after the relaxed clock
> > computation? The maths you quote depends on the derived BCLK
> > being exactly the correct speed for the audio, that is no longer
> > the case anymore.
> >
> > I would have thought the patch would cover both situations, as in
> > if we can produce a suitable LRCLK, then we just pick a BCLK we
> 
> That!
> 
> The problem for remaining rates is that we cannot derive the LRCLK
> 
> <snip>
> + for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
> + if (sysclk != dac_divs[j] * lrclk)
> + continue;
> </snip>
> 

If you can't generate the LRCLK you either need a different
source clock or to use the PLL. You don't want to be trying to
pull 44.1k audio over a link that is clocked on a 48k based
clock.

Is the problem here that the PLL part of the code is making the
same assumption as the direct part of the code was, that the bclk
should be exact?

Thanks,
Charles
