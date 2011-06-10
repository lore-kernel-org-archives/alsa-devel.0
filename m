From: =?iso-8859-1?q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Do not attempt to change
	DAI sysclk if stream is active
Date: Fri, 10 Jun 2011 14:36:52 +0300
Message-ID: <201106101436.53099.peter.ujfalusi@ti.com>
References: <1307705335-2836-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id AB84A243C8
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 13:36:56 +0200 (CEST)
In-Reply-To: <1307705335-2836-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Girdwood,
	Liam" <lrg@ti.com>, "stable@kernel.org" <stable@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Friday 10 June 2011 14:28:55 Jarkko Nikula wrote:
> Attempt to change McBSP CLKS source while another stream is active is not
> safe after commit d135865 ("OMAP: McBSP: implement functional clock
> switching via clock framework") in 2.6.37.
> 
> CLKS parent clock switching using clock framework have to idle the McBSP
> before switching and then activate it again. This short break can cause a
> DMA transaction error to already running stream which halts and recovers
> only by closing and restarting the stream.
> 
> This goes more fatal after commit e2fa61d ("OMAP3: l3: Introduce
> l3-interconnect error handling driver") in 2.6.39 where l3 driver detects a
> severe timeout error and does BUG_ON().
> 
> Fix this by checking is the McBSP active in omap_mcbsp_dai_set_dai_sysclk
> before attempting to change any clocking configuration. This test should
> have been here just from the beginning anyway.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: stable@kernel.org

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
