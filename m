From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core - add platform DAPM debugfs
	support
Date: Wed, 15 Feb 2012 15:23:37 +0000
Message-ID: <1329319417.14552.0.camel@odin>
References: <1329318937-14488-1-git-send-email-lrg@ti.com>
	<1329318937-14488-3-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog120.obsmtp.com (na3sys009aog120.obsmtp.com
	[74.125.149.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 63249103E0A
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 16:23:40 +0100 (CET)
Received: by mail-ww0-f49.google.com with SMTP id dt13so948541wgb.6
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 07:23:38 -0800 (PST)
In-Reply-To: <1329318937-14488-3-git-send-email-lrg@ti.com>
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
Cc: alsa-devel@alsa-project.org, Sebastien Guiriec <s-guiriec@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-15 at 15:15 +0000, Liam Girdwood wrote:
> From: Sebastien Guiriec <s-guiriec@ti.com>
> 
> Allow platform widgets to be visible in debugfs like codec widgets.
> 
> Signed-off-by: Liam Girdwood <lrg@ti.com>

> @@ -918,10 +947,10 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num, int order)
>  			if (err < 0)
>  				printk(KERN_ERR "asoc: failed to remove %s\n", platform->name);
>  		}
> -

This line shouldn't be removed. V2 coming.

Liam
