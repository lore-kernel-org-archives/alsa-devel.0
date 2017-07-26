From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v4 0/9] add support for Sama5d2 audio PLLs
 and enable ClassD
Date: Wed, 26 Jul 2017 08:57:32 +0200
Message-ID: <20170726065732.zphp7zaug4ypcqzj@piout.net>
References: <cover.c8ce78c15296190b2aa5c452c0c4512528e28518.1500968090.git-series.quentin.schulz@free-electrons.com>
 <194d2fc6-4c88-bc3b-1127-b4c0bdb7c6a1@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id F04BA26648D
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 08:57:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <194d2fc6-4c88-bc3b-1127-b4c0bdb7c6a1@microchip.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: mark.rutland@arm.com, boris.brezillon@free-electrons.com, alsa-devel@alsa-project.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, tiwai@suse.com, sboyd@codeaurora.org, lgirdwood@gmail.com, linux@armlinux.org.uk, Quentin Schulz <quentin.schulz@free-electrons.com>, robh+dt@kernel.org, broonie@kernel.org, cyrille.pitchen@wedev4u.fr, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 25/07/2017 at 17:44:19 +0200, Nicolas Ferre wrote:
> On 25/07/2017 at 09:37, Quentin Schulz wrote:
> > This patch series adds support for the audio PLLs and enables ClassD that
> > can be found in ATMEL Sama5d2 SoC.
> > 
> > There are two audio PLLs (PMC and PAD) that shares the same parent (FRAC).
> > FRAC can output between 620 and 700MHz and only multiply the rate of its
> > parent. The two audio PLLs then divide the FRAC rate to best match the
> > asked rate.
> > 
> > I basically took an old patch series posted by Nicolas on December, 6th
> > 2016[1][2][3] and the comments Boris did on the first version[4] Nicolas
> > sent on July, 15th 2015.
> > 
> > I also fixed the function used to compute the divisors, removed useless
> > spinlocks and added a range to the audio frac PLL to stay within vendor's
> > supported range. Clocks that are children of gclk (generated-clk) are now
> > able to propagate rate to the audio PLL clocks when needed.
> > 
> > However, there are multiple children clocks that could technically
> > change the rate of audio_pll (via gck). With the rate locking introduced
> > in Jerome Brunet's patch series[5], the first consumer to enable the clock
> > will be the one definitely setting the rate of the clock. Without the rate
> > locking, the last consumer to set the rate will be able to mess with the
> > rate.
> > Since audio IPs are most likely to request the same rate, we enforce
> > that the only clks able to modify gck rate are those of audio IPs.
> > 
> > To remain consistent, we deny other clocks to be children of audio_pll.
> 
> Quentin,
> 
> Thanks for having revived this series. Everything's okay on my side for
> this v4. I think that my tag isn't missing from any patch of this
> series. Now we surely need to define which path it must take...
> 

I'll take the two dts patches now as the bindings have been acked.
Everything else should probably go through the clk tree.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
