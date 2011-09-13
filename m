From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2]ASoC:blackfin:add ad73311 card driver
	name
Date: Tue, 13 Sep 2011 11:53:28 +0100
Message-ID: <20110913105328.GA11214@opensource.wolfsonmicro.com>
References: <1315940366-20515-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F0C4024375
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Sep 2011 12:53:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1315940366-20515-1-git-send-email-scott.jiang.linux@gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 13, 2011 at 02:59:26PM -0400, Scott Jiang wrote:

> Add driver_name in snd_soc_card, asoc will copy this name to driver field of snd_card.
> ALSA lib need this info to load the proper card config.

>  static struct snd_soc_card bf5xx_ad73311 = {
>  	.name = "bfin-ad73311",
> +	.driver_name = "AD73311",

All my comments about the previous revision of the patch continue to
apply here.  The changlog doesn't explain the issue well (the driver
should already end up with a unique name) and the name you've picked
is less distinctive than the existing name.
