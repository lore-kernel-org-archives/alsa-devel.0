From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 19/54 v2] ASoC: switch over to use
 snd_soc_register_component() on mpc5200 i2s
Date: Mon, 25 Mar 2013 11:11:08 +0800
Message-ID: <20130325031106.GC30232@S2101-09.ap.freescale.net>
References: <87txo96xiu.wl%kuninori.morimoto.gx@renesas.com>
 <8738vpf3qd.wl%kuninori.morimoto.gx@renesas.com>
 <87boaddox7.wl%kuninori.morimoto.gx@renesas.com>
 <514B3B07.4030309@wwwdotorg.org>
 <87620kfcy4.wl%kuninori.morimoto.gx@renesas.com>
 <514BE645.2050409@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 by alsa0.perex.cz (Postfix) with ESMTP id ADA782615EC
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2013 04:10:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <514BE645.2050409@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 21, 2013 at 11:04:05PM -0600, Stephen Warren wrote:
> However, I do see:
> 
> > ./mpc8610_hpcd.c:213:	machine_data->dai[0].cpu_dai_name = dev_name(&ssi_pdev->dev);
> > ./p1022_ds.c:223:	mdata->dai[0].cpu_dai_name = dev_name(&ssi_pdev->dev);
> > ./p1022_rdk.c:226:	mdata->dai[0].cpu_dai_name = dev_name(&ssi_pdev->dev);
> > ./imx-sgtl5000.c:151:	data->dai.cpu_dai_name = dev_name(&ssi_pdev->dev);
> 
> That's a bit icky; DT-based systems should use .cpu_of_node, not
> .cpu_dai_name...

Yea, I'm sending a patch to change imx-sgtl5000 driver.  Thanks,
Stephen.

Shawn
