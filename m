From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2 01/10] ASoC: Change the PCM runtime
	array to a list
Date: Mon, 17 Aug 2015 06:28:48 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8480D0F79@SHSMSX101.ccr.corp.intel.com>
References: <cover.1439217448.git.mengdong.lin@intel.com>
 <0b1c3916360faff8a36cc860f5b6af802bd6778b.1439217448.git.mengdong.lin@intel.com>
 <20150814200241.GP10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CA62726053D
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 08:28:53 +0200 (CEST)
In-Reply-To: <20150814200241.GP10748@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Saturday, August 15, 2015 4:03 AM

> On Mon, Aug 10, 2015 at 10:45:28PM +0800, mengdong.lin@intel.com wrote:
> 
> > +	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[1].name);
> > +	codec_dai = rtd->codec_dai;
> > +
> 
> For ease of review please split the addition of this new interface for getting
> the runtime from the change to the implementation - the same function can
> be written in terms of a list.  As ever please make one change per commit :(

Okay. I'll split adding snd_soc_get_pcm_runtime() to a new commit.

> > +static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
> > +	struct snd_soc_card *card, struct snd_soc_dai_link *dai_link) {
> > +	struct snd_soc_pcm_runtime *rtd;
> > +
> > +	rtd = devm_kzalloc(card->dev,
> > +			sizeof(struct snd_soc_pcm_runtime), GFP_KERNEL);
> > +	if (!rtd)
> > +		return NULL;
> 
> Why are we allocating something with devm_kzalloc()...

I'll change to use kzalloc() and free the memory for the error path.

> > +static void soc_free_pcm_runtime(struct snd_soc_card *card,
> > +	struct snd_soc_pcm_runtime *rtd)
> > +{
> > +	if (rtd->codec_dai)
> > +		devm_kfree(card->dev, rtd->codec_dais);
> > +	devm_kfree(card->dev, rtd);
> > +}
> 
> ...things that we later explicitly free in (hopefully?) all cases.

Okay. 

> > +static void soc_remove_pcm_runtimes(struct snd_soc_card *card) {
> > +	struct snd_soc_pcm_runtime *rtd, *_rtd;
> > +
> > +	list_for_each_entry_safe(rtd, _rtd, &card->rtd_list, list) {
> > +		list_del(&rtd->list);
> > +		soc_free_pcm_runtime(card, rtd);
> > +	}
> > +
> > +	card->num_rtd = 0;
> > +}
> 
> Why doesn't the free function do the list removal?

Sorry, I'll add the list removal.

Thanks
Mengdong
