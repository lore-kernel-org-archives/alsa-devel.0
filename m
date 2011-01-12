From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: sh: fsi: Add snd_soc_dai_set_fmt
	support
Date: Wed, 12 Jan 2011 14:53:02 +0000
Message-ID: <20110112145302.GA14870@opensource.wolfsonmicro.com>
References: <w3pk4iay72i.wl%kuninori.morimoto.gx@renesas.com>
	<w3pei8iy6z6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7E2A4103803
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 15:52:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <w3pei8iy6z6.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Paul Mundt <lethal@linux-sh.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 12, 2011 at 03:24:45PM +0900, Kuninori Morimoto wrote:
> This patch add snd_soc_dai_ops :: set_fmt to FSI driver and
> select master/slave clock mode by snd_soc_dai_set_fmt on
> fsi-xxx.c instead of platform infomation code.
> This patch remove fsi_is_master function which is no longer needed.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/board-ap4evb.c   |    2 -
>  arch/arm/mach-shmobile/board-mackerel.c |    2 -

This doesn't apply, board-mackarel is only going into mainline during
the merge window so it's not yet merged into the ASoC tree.  Please
resubmit after the merge window is over, including Liam's ack if there
are no code changes when you do so.
