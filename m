From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/2] ASoC: codec: wm8960: Relax bit
	clock computation
Date: Tue, 21 Mar 2017 12:52:07 +0000
Message-ID: <20170321125207.GX6986@localhost.localdomain>
References: <1490090976-25877-1-git-send-email-daniel.baluta@nxp.com>
 <1490090976-25877-3-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 461352671BA
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 13:51:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1490090976-25877-3-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: alsa-devel@alsa-project.org, shengjiu.wang@freescale.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, broonie@kernel.org, viorel.suman@nxp.com, mihai.serban@nxp.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 21, 2017 at 12:09:36PM +0200, Daniel Baluta wrote:
> WM8960 derives bit clock from sysclock using BCLKDIV[3:0] of R8
> clocking register (See WM8960 datasheet, page 71).
> 
> There are use cases, like this:
> aplay -Dhw:0,0 -r 48000 -c 1 -f S20_3LE -t raw audio48k20b_3LE1c.pcm
> 
> where no BCLKDIV applied to sysclock can give us the exact requested
> bitclk, so driver fails to configure clocking and aplay fails to run.
> 
> Fix this by relaxing bitclk computation, so that when no exact value
> can be derived from sysclk pick the closest value greater than
> expected bitclk.
> 
> Suggested-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
> Changes since v1:
> 	* use a marker to check if a match is found
> 	* didn't removed PLL as Charles suggested because there is
> 	a special PLL mode which explictly uses PLL. We could start
> 	a discussion on not using PLL when deriving bitclk, but this
> 	is to be done in another patch.
> 

Could you elaborate on this a little more am I not sure I follow
100%? There is a mode which explictly requires the PLL to be used
(WM8960_SYSCLK_PLL) but in that case your wm8960_configure_sysclk
code will not be called so I don't see what is causing that to have
an effect on this patch?

Thanks,
Charles
