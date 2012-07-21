From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 3/4] ASoC: sgtl5000: remove unneeded
 snd_soc_dapm_new_widgets in probe
Date: Sat, 21 Jul 2012 16:37:09 +0800
Message-ID: <20120721083707.GD923@S2101-09.ap.freescale.net>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <1342776027-31758-4-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 by alsa0.perex.cz (Postfix) with ESMTP id AA502264F04
 for <alsa-devel@alsa-project.org>; Sat, 21 Jul 2012 10:37:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1342776027-31758-4-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, w.sang@pengutronix.de, linux-arm-kernel@lists.infradead.org, lrg@ti.com, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 20, 2012 at 05:20:26PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> There's a driver bug that sgtl5000 dapm widget kcontrols do not work.
> e.g. can not select capture mux with amixer tool(no error info prompted).
> 
> The root cause is that we still call snd_soc_dapm_new_widgets in
> codec driver probe function afer converting to table based widgets.
> This will cause the card dapm widgets are instantiated before the
> dapm_routes are registered.
> Then, no available dapm widget pathes can be found during instantiation
> which finally will cause soc_dapm_mux_update_power to fail(can not find
> correct path with kcontrol) in snd_soc_dapm_put_enum_double function.
> 
> Here we remove the unneeded snd_soc_dapm_new_widgets in codec probe
> and let the soc core to handle the register sequence properly.
> Then we can fix above issue.
> 
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

On imx53-qsb board:

Tested-by: Shawn Guo <shawn.guo@linaro.org>
