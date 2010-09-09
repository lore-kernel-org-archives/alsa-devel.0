From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 0/5 v2] fbdev: sh_mobile_hdmi: bug fix
	patches V2
Date: Thu, 9 Sep 2010 08:32:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1009090824080.28837@axis700.grange>
References: <w3paanrprah.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id 0F875103801
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Sep 2010 08:32:14 +0200 (CEST)
In-Reply-To: <w3paanrprah.wl%kuninori.morimoto.gx@renesas.com>
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

Hello Morimoto-san

Thanks
for your patches! But what about this my comment:

<quote>
Besides, I think, this will not link without CONFIG_SND_SOC.
</quote>

? Or is it wrong? If this is right, it would be better to either add a 
"select SND_SOC" to FB_SH_MOBILE_HDMI Kconfig entry, or put calls to 
snd_soc_(un)register_codec (and all the HDMI audio code) under "#ifdef 
CONFIG_SND_SOC." The letter is, probably, less elegant.

Thanks
Guennadi

On Thu, 9 Sep 2010, Kuninori Morimoto wrote:

> 
> Dear Mark, Liam, Guennadi
> 
> These are ALSA V2 bug fix patches which are reported by Guennadi.
> 
> Kuninori Morimoto (5):
>       fbdev: sh_mobile_hdmi: modify noisy comment out
>       fbdev: sh_mobile_hdmi: modify flags name to more specific
>       fbdev: sh_mobile_hdmi: modify snd_soc_dai_driver settings
>       fbdev: sh_mobile_hdmi: add new label for sound error path
>       ASoC: fsi-hdmi: remove unneeded header
> 
> To Mark.
> Please care above patch independently from these patches.
> [alsa-devel] [PATCH 5/5] ASoC: fsi-ak4642: modiry platform_name
> 
> These series are for ALSA side patches.
> I will send SH side V2 patches soon.
> 
> Main diff v1 <==> v2 is
> I added Guennadi's report mail to log area on each patches,
> and care more.
> But these series still didn't care above.
> I added reasons.
> 
> -- Guennadi ------------------------------------------
> > +config SND_FSI_HDMI
> > +	bool "FSI-HDMI sound support"
> > +	depends on SND_SOC_SH4_FSI && FB_SH_MOBILE_HDMI
> > +	help
> > +	  This option enables generic sound support for the
> > +	  FSI - HDMI unit
> > +
> 
> "bool" means, if someone is linking the whole ASoC into the kernel, they 
> will not be able to build this as a module. Not a big deal, but you're 
> stealing some freedom from the user.
> -------------------------------------------------------
> 
> understand.
> But the config which use "bool" for FSI-XXX is not only FSI-HDMI.
> So, I will care your indication as "new function patch" in future.
> 
> 
> -- Guennadi ------------------------------------------
> With this config option you will have 3 SND_SOC_SH4_FSI implementations in 
> the Kconfig, all selectable independently. Do you really think it makes 
> sense and would work, if someone were to select more than one of those 
> options at the same time?
> -------------------------------------------------------
> 
> Yes. I created it for independently.
> For example, you can select FSI-AK4642 and FSI-HDMI in same time,
> and both works well for me on AP4 board now.
> 
> But I guess, if you select FSI-DA7210 and FSI-HDMI,
> small patch which change FSIA <-> FSIB is needed.
> 
>   FSI-AK4642 : FSI-A
>   FSI-DA7210 : FSI-B
>   FSI-HDMI   : FSI-B
> 
> I think that it should be going to enable the selection of
> "FSI-A" and "FSI-B" in the future.
> But now, no way, no idea.
> It is my task
> 
> By the way, about HDMI sound,
> I know that there are some HDMI monitors which can not use sound.
> Now I'm debuging about it.
> 
> -- Guennadi ------------------------------------------
> > +		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
> 
> Again, this I am not sure about. The datasheet says 16 to 32 bit are 
> possible, but then I only see configuration for 16 to 24 bits, but in any 
> case, I think, you'd want to implement .hw_params to support non-default 
> formats.
> -------------------------------------------------------
> 
> Yes. I should modify this .formats.
> But I can not select, test, support 32bit in current environment.
> So, please put it to my TODO list.
> 
> And yes. .hw_params implementation is important for advanced support.
> But now, current HDMI sound support is still prototype (I didn't indicate though).
> So. please put it to my TODO list too.
> 
> Best regards
> --
> Kuninori Morimoto
>  
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
