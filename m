From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [PATCH]ASoC:blackfin:add ad73311
	card	driver name
Date: Tue, 6 Sep 2011 16:19:48 +0100
Message-ID: <20110906151948.GB18090@opensource.wolfsonmicro.com>
References: <1315338369-4251-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8859F10381B
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 17:19:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1315338369-4251-1-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 06, 2011 at 03:46:09PM -0400, Scott Jiang wrote:
> ASoC doesn't copy codec name to card driver now.
> ALSA lib need this info to find the proper card config.
> So add card name in snd_soc_card, asoc will copy this name to snd_card.

Your changelog doesn't correspond to your code:

>  static struct snd_soc_card bf5xx_ad73311 = {
>  	.name = "bfin-ad73311",
> +	.driver_name = "AD73311",

You're not adding a card name, you're adding a driver name, and the
existing card name already contains the name of the CODEC.  There
should already be enough information available to userspace to identify
that the card is a Blackfin card with ad73311.  Since the driver_name
you're setting only contains the name of the CODEC it looks likely to
cause more collisions anyway as other systems may use the same CODEC.
