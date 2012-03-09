From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: Remove CONFIG_OMAP_MCBSP references
Date: Fri, 9 Mar 2012 10:33:44 -0800
Message-ID: <20120309183344.GI12083@atomide.com>
References: <1331283078-14846-1-git-send-email-peter.ujfalusi@ti.com>
 <1331283078-14846-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1331283078-14846-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120309 00:54]:
> The McBSP driver stack has been moved to ASoC. The CONFIG_OMAP_MCBSP will
> be removed since the CONFIG_SND_OMAP_SOC_MCBSP will trigger to build the
> McBSP (audio) drivers.

Great, glad to see this! Thanks for working on this:

Acked-by: Tony Lindgren <tony@atomide.com>
