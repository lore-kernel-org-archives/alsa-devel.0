From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: Question about dapm setup
Date: Wed, 29 May 2019 11:34:39 +0100
Message-ID: <20190529103439.GI28362@ediswmail.ad.cirrus.com>
References: <87woi9x4ho.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A80EF8065A
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2019 12:34:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87woi9x4ho.wl-kuninori.morimoto.gx@renesas.com>
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

On Wed, May 29, 2019 at 01:50:07PM +0900, Kuninori Morimoto wrote:
> 
> Hi ALSA ML
> 
> snd_soc_instantiate_card() setups dapm, but its timing seems
> very randomly for me.
> In my understanding, dapm setup timing is not so serious.
> So, I think we can do it in one place,
> but are there some reasons ?
> For example, "xxxx should be called after yyyy"
> 

There are certainly reasons for some of it, but might be easier
to explain what you are thinking of moving, rather than trying to
list all dependencies.

> 
> static int snd_soc_instantiate_card(struct snd_soc_card *card)
> {
> 	...
> 
> =>	snd_soc_dapm_debugfs_init(&card->dapm, card->debugfs_card_root);
> 
> 	...
> 
> 	if (card->dapm_widgets)
> 		snd_soc_dapm_new_controls(&card->dapm, card->dapm_widgets,
> 					  card->num_dapm_widgets);
> 
> 	if (card->of_dapm_widgets)
> 		snd_soc_dapm_new_controls(&card->dapm, card->of_dapm_widgets,
> 					  card->num_of_dapm_widgets);
> 
> 	...
> 
> 	snd_soc_dapm_link_dai_widgets(card);
> 	snd_soc_dapm_connect_dai_link_widgets(card);

For example we need the calls to snd_soc_dapm_new_controls to
be before these two so that the widgets exist for linking them.

> 
> 	if (card->controls)
> 		snd_soc_add_card_controls(card, card->controls,
> 					  card->num_controls);
> 

This needs to be before the routes are added so that the routes
can find their associated controls.

> 	if (card->dapm_routes)
> 		snd_soc_dapm_add_routes(&card->dapm, card->dapm_routes,
> 					card->num_dapm_routes);
> 
> 	if (card->of_dapm_routes)
> 		snd_soc_dapm_add_routes(&card->dapm, card->of_dapm_routes,
> 					card->num_of_dapm_routes);
> 	...

And the routes also obviously need to be after the widgets are
added as well.

> 
> 	snd_soc_dapm_new_widgets(card);
> 
> 	...
> 
> 	dapm_mark_endpoints_dirty(card);
> 	snd_soc_dapm_sync(&card->dapm);
> 	...
> }
> 
> 

Hope that is roughly the sort of thing you were interested in.

Thanks,
Charles
