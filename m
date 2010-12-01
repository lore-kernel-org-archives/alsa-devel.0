From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ASoC: omap: N810: Don't select
 CONFIG_OMAP_MUX but make it as dependency
Date: Wed, 1 Dec 2010 07:49:34 -0800
Message-ID: <20101201154933.GF17222@atomide.com>
References: <1291194080-8101-1-git-send-email-jhnikula@gmail.com>
	<20101201112853.GF24176@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mho-02-ewr.mailhop.org (mho-02-ewr.mailhop.org [204.13.248.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 546DA245FA
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2010 16:49:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101201112853.GF24176@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [101201 03:19]:
> On Wed, Dec 01, 2010 at 11:01:20AM +0200, Jarkko Nikula wrote:
> > Not all omap boards use kernel based pin multiplexing so
> > CONFIG_SND_OMAP_SOC_N810 should not select it by default as it can make
> > harm to other boards in multi-board kernels.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Jarkko thanks for fixing this:

Acked-by: Tony Lindgren <tony@atomide.com>
