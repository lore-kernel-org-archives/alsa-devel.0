From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 0/5 v2] fbdev: sh_mobile_hdmi: bug fix
 patches V2
Date: Thu, 9 Sep 2010 09:17:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1009090916440.28837@axis700.grange>
References: <w3paanrprah.wl%kuninori.morimoto.gx@renesas.com>
	<Pine.LNX.4.64.1009090824080.28837@axis700.grange>
	<w3ptylzo0n8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id 883EB103801
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Sep 2010 09:17:01 +0200 (CEST)
In-Reply-To: <w3ptylzo0n8.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 9 Sep 2010, Kuninori Morimoto wrote:

> 
> Dear Guennadi
> 
> > <quote>
> > Besides, I think, this will not link without CONFIG_SND_SOC.
> > </quote>
> > 
> > ? Or is it wrong? If this is right, it would be better to either add a 
> > "select SND_SOC" to FB_SH_MOBILE_HDMI Kconfig entry, or put calls to 
> > snd_soc_(un)register_codec (and all the HDMI audio code) under "#ifdef 
> > CONFIG_SND_SOC." The letter is, probably, less elegant.
> 
> Oh sorry. I didn't explain about it.
> Yes.
> My 1st idea was same as yours (add SND_SOC to Kconfig).
> But I couldn't decide which is better.
> 
> I send "add select SND_SOC to Kconfig" patch.
> OK ?

Suits me, thanks.

Regards
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
