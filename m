From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: Question about dapm setup
Date: Thu, 30 May 2019 15:56:13 +0100
Message-ID: <20190530145613.GJ28362@ediswmail.ad.cirrus.com>
References: <87woi9x4ho.wl-kuninori.morimoto.gx@renesas.com>
 <20190529103439.GI28362@ediswmail.ad.cirrus.com>
 <87zhn4g6g3.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C9ABF8072E
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2019 16:56:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87zhn4g6g3.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 30, 2019 at 09:12:10AM +0900, Kuninori Morimoto wrote:
> But, it was my fault, the question was not clear.
> I wanted to know was that there are many non dapm functions
> are called between dapm setup.
> pseudo code is..
> 
> It looks very random. So my original question was
> can we do like this (with keeping dapm order)?
> 

Ah ok I see, sorry I understand now.

> 	static int snd_soc_instantiate_card(struct snd_soc_card *card)
> 	{
> 
> =>		snd_soc_dapm_debugfs_init()
> =>		snd_soc_dapm_new_controls(...)
> =>		snd_soc_dapm_link_dai_widgets()
> =>		snd_soc_dapm_connect_dai_link_widgets()
> =>		snd_soc_add_card_controls()
> =>		snd_soc_dapm_add_routes()
> =>		snd_soc_dapm_new_widgets()
> =>		dapm_mark_endpoints_dirty()
> =>		snd_soc_dapm_sync()
> 
> 		card->probe(..)
> 		soc_probe_link_components(...)
> 		soc_probe_aux_device(...)
> 		soc_bind_dai_link(...)
> 		soc_probe_link_dais
> 		snprintf(...)
> 		card->late_probe()
> 		snd_card_register()
> 
> =>		/* or dapm setup here instead ? */
> 	}
> 
> For example, snd_soc_dapm_xxx() should be called before/after
> card->probe() etc, etc...
> 

There are definitely some dependencies for example component probes
will add widgets, controls and routes from those components so
those will need to be done before the card level routes are
added. The card level routes may link to widgets on individual
components.

Also the DAPM sync definitely needs to be after everything has
been setup.

I wouldn't be surprised if there are others as well, things like
creating the DAI link widgets are probably done through some
of these helpers and probably need to be at certain points in the
process.

Thanks,
Charles
