From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v6 02/11] ASoC: topology: Make PCM backward
 compatible from ABI v4
Date: Tue, 1 Nov 2016 14:02:41 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F88198AB76@shsmsx102.ccr.corp.intel.com>
References: <cover.1476166990.git.mengdong.lin@linux.intel.com>
 <84e2ad13cc7ac401b62e421352b7af49fd7876a5.1476166990.git.mengdong.lin@linux.intel.com>
 <20161028185105.xvxvf5tmekivpa4n@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 251DF261560
 for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2016 15:02:45 +0100 (CET)
In-Reply-To: <20161028185105.xvxvf5tmekivpa4n@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "Shah, Hardik T" <hardik.t.shah@intel.com>, "Singh, Guneshwor O" <guneshwor.o.singh@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Ughreja,
 Rakesh A" <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Saturday, October 29, 2016 2:51 AM
> To: mengdong.lin@linux.intel.com
> Cc: alsa-devel@alsa-project.org; tiwai@suse.de;
> liam.r.girdwood@linux.intel.com; Shah, Hardik T <hardik.t.shah@intel.com>;
> Singh, Guneshwor O <guneshwor.o.singh@intel.com>; Koul, Vinod
> <vinod.koul@intel.com>; Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>;
> Lin, Mengdong <mengdong.lin@intel.com>
> Subject: Re: [PATCH v6 02/11] ASoC: topology: Make PCM backward
> compatible from ABI v4
> 
> On Tue, Oct 11, 2016 at 02:36:49PM +0800, mengdong.lin@linux.intel.com
> wrote:
> 
> > @@ -508,6 +541,10 @@ static void remove_link(struct
> snd_soc_component *comp,
> >  	if (dobj->ops && dobj->ops->link_unload)
> >  		dobj->ops->link_unload(comp, dobj);
> >
> > +	kfree(link->name);
> > +	kfree(link->stream_name);
> > +	kfree(link->cpu_dai_name);
> > +
> >  	list_del(&dobj->list);
> >  	snd_soc_remove_dai_link(comp->card, link);
> >  	kfree(link);
> > @@ -1606,7 +1643,8 @@ static int soc_tplg_dai_create(struct soc_tplg
> *tplg,
> >  	if (dai_drv == NULL)
> >  		return -ENOMEM;
> >
> > -	dai_drv->name = pcm->dai_name;
> > +	if (strlen(pcm->dai_name))
> > +		dai_drv->name = kstrdup(pcm->dai_name, GFP_KERNEL);
> >  	dai_drv->id = pcm->dai_id;
> >
> >  	if (pcm->playback) {
> 
> These appear to be fixes unrelated to the ABI handling?

Sorry, they're not related to ABI handling. I'll move them to other patches.

Thanks
Mengdong
