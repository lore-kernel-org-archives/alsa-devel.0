From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/2] ASoC: codec: wm8960: Relax bit
 clock computation
Date: Tue, 21 Mar 2017 14:31:17 +0000
Message-ID: <20170321143117.GZ6986@localhost.localdomain>
References: <1490090976-25877-1-git-send-email-daniel.baluta@nxp.com>
 <1490090976-25877-3-git-send-email-daniel.baluta@nxp.com>
 <20170321125207.GX6986@localhost.localdomain>
 <CAEnQRZA+bC3wh2HzOJgA387zEe41CbJ_LVEHujNLmta2QzTPKA@mail.gmail.com>
 <20170321142018.GY6986@localhost.localdomain>
 <CAEnQRZC1d5M_Sh5Q7k3FHn-634_7psR-8XZp9-tfhEcyNM26tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 287DF266718
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 15:30:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAEnQRZC1d5M_Sh5Q7k3FHn-634_7psR-8XZp9-tfhEcyNM26tw@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, shengjiu.wang@freescale.com, patches@opensource.wolfsonmicro.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, viorel.suman@nxp.com, mihai.serban@nxp.com, Takashi Iwai <tiwai@suse.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 21, 2017 at 04:25:40PM +0200, Daniel Baluta wrote:
> On Tue, Mar 21, 2017 at 4:20 PM, Charles Keepax
> <ckeepax@opensource.wolfsonmicro.com> wrote:
> > On Tue, Mar 21, 2017 at 04:05:15PM +0200, Daniel Baluta wrote:
> >> On Tue, Mar 21, 2017 at 2:52 PM, Charles Keepax
> >> <ckeepax@opensource.wolfsonmicro.com> wrote:
> >> > On Tue, Mar 21, 2017 at 12:09:36PM +0200, Daniel Baluta wrote:
> >> >>       * use a marker to check if a match is found
> >> >>       * didn't removed PLL as Charles suggested because there is
> >> >>       a special PLL mode which explictly uses PLL. We could start
> >> >>       a discussion on not using PLL when deriving bitclk, but this
> >> >>       is to be done in another patch.
> >> >>
> >> >
> >> > Could you elaborate on this a little more am I not sure I follow
> >> > 100%? There is a mode which explictly requires the PLL to be used
> >> > (WM8960_SYSCLK_PLL) but in that case your wm8960_configure_sysclk
> >> > code will not be called so I don't see what is causing that to have
> >> > an effect on this patch?
> >>
> >> My doubt is, what happens if wm8960_configure_clocking is called with
> >> wm8960->clk_id = WM8960_SYSCLK_PLL and we remove the PLL
> >> as suggested.
> >
> > I wasn't suggesting removing the PLL just that if we find a
> > "relaxed match" we don't need to then check the PLL for a better
> > match, as I suspect that a slightly higher than needed bit clock
> > has less power/performance impact than firing up the PLL.
> >
> > Which removes the need to differenciate between a relaxed and
> > bang on match in wm8960_configure_sysclk and means you don't have
> > to do the caching the values across the PLL code that you do now.
> 
> Oh, I see. So we still use the PLL when no exact or relaxed match
> is found.

Yeah exactly or in the case that it is requested directly.

Thanks,
Charles
