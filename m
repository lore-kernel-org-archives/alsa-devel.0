From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/7] ASoC: Intel: cht_bsw_max98090: add
 support for Baytrail
Date: Tue, 19 Sep 2017 12:51:31 +0300
Message-ID: <1505814691.24689.12.camel@linux.intel.com>
References: <20170908051309.19028-1-pierre-louis.bossart@linux.intel.com>
 <20170908051309.19028-4-pierre-louis.bossart@linux.intel.com>
 <1505719053.25945.269.camel@linux.intel.com>
 <37e5b151-f556-aaa3-ff34-877de72d6347@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 41335266819
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 11:51:35 +0200 (CEST)
In-Reply-To: <37e5b151-f556-aaa3-ff34-877de72d6347@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, broonie@kernel.org, jarkko.nikula@linux.intel.com, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2017-09-18 at 12:14 -0500, Pierre-Louis Bossart wrote:
> On 9/18/17 2:17 AM, Andy Shevchenko wrote:
> > On Fri, 2017-09-08 at 00:13 -0500, Pierre-Louis Bossart wrote:
> > >   
> > > +static inline struct snd_soc_dai *cht_get_codec_dai(struct
> > > snd_soc_card *card)
> > > +{
> > > +	struct snd_soc_pcm_runtime *rtd;
> > > +
> > > +	list_for_each_entry(rtd, &card->rtd_list, list) {
> > > +		if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI,
> > > +			     strlen(CHT_CODEC_DAI)))
> > 
> > Same comments as per another patch series wrt str_n_cmp() use.
> 
> Yes, if that's alright with you I'll clean this up in all Intel
> machine 
> drivers in one patch since this is all copy-paste.

Yep, I agree on your other comment to clean up all Intel ASoC drivers at
once.

>  I just need a clear 
> indication on what the preferred means of string comparisons is...

Here just a rule of common sense. No need to use str_n_* variants on top
of constant literals especially followed by strlen().

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
