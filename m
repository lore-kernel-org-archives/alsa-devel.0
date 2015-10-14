From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v4] ASoC: soc-compress: add config item for
 soc-compress to make it compiled only when needed
Date: Wed, 14 Oct 2015 12:57:38 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A9229C6351@SHSMSX101.ccr.corp.intel.com>
References: <1444750860-19355-1-git-send-email-yang.jie@intel.com>
 <20151014092051.GM8805@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 49B272661A2
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2015 14:57:42 +0200 (CEST)
In-Reply-To: <20151014092051.GM8805@ck-lbox>
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
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Charles Keepax [mailto:ckeepax@opensource.wolfsonmicro.com]
> Sent: Wednesday, October 14, 2015 5:21 PM
> To: Jie, Yang
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam R
> Subject: Re: [alsa-devel] [PATCH v4] ASoC: soc-compress: add config item for
> soc-compress to make it compiled only when needed
> 
> On Tue, Oct 13, 2015 at 11:41:00PM +0800, Jie Yang wrote:
> > We don't always need soc-compress in soc, here add a config item
> > SND_SOC_COMPRESS, when nobody select it, the soc-compress will not be
> > compiled.
> >
> > Here also change Kconfig to 'select SND_SOC_COMPRESS' for drivers that
> > needed soc-compress.
> >
> > Signed-off-by: Jie Yang <yang.jie@intel.com>
> > ---
> >  include/sound/soc-dai.h                      |  2 +-
> >  include/sound/soc.h                          |  4 +++-
> >  sound/soc/Kconfig                            |  5 ++++-
> >  sound/soc/Makefile                           |  3 ++-
> >  sound/soc/intel/Kconfig                      |  1 +
> >  sound/soc/intel/atom/sst-mfld-platform-pcm.c |  2 +-
> >  sound/soc/soc-compress.c                     | 12 ++++++++++--
> >  sound/soc/soc-core.c                         |  4 ++--
> >  8 files changed, 24 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h index
> > 2df96b1..238200f 100644
> > --- a/include/sound/soc-dai.h
> > +++ b/include/sound/soc-dai.h
> > @@ -214,7 +214,7 @@ struct snd_soc_dai_driver {
> >  	int (*suspend)(struct snd_soc_dai *dai);
> >  	int (*resume)(struct snd_soc_dai *dai);
> >  	/* compress dai */
> > -	bool compress_dai;
> > +	int (*compress_new)(struct snd_soc_pcm_runtime *rtd, int num);
> 
> This feels a little awkward to be using a function pointer here.
> It somewhat implies I might want to customise this function but am I every
> going to want to set this to something other than snd_soc_new_compress?

Hi Charles, we used compress_dai bool before(in v2), but for that we need
add empty inline soc_compress_new(), Takashi suggest we use callback
func pointer here, it can be compress_new or any other creation here.
This is flexible and can be extended if any new stuff has to be handled.

> 
> > diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c index
> > 3b471f9..24b0960 100644
> > --- a/sound/soc/soc-core.c
> > +++ b/sound/soc/soc-core.c
> > @@ -1370,9 +1370,9 @@ static int soc_probe_link_dais(struct
> snd_soc_card *card, int num, int order)
> >  		soc_dpcm_debugfs_add(rtd);
> >  #endif
> >
> > -	if (cpu_dai->driver->compress_dai) {
> > +	if (cpu_dai->driver->compress_new) {
> 
> Would it maybe be nicer to just change this to:
> if (IS_ENABLED(..)) && cpu_dai...)

This is roll back to the old compress_dai bool? 

~Keyon

> 
> Anyone else have any thoughts on that?
> 
> >  		/*create compress_device"*/
> > -		ret = soc_new_compress(rtd, num);
> > +		ret = cpu_dai->driver->compress_new(rtd, num);
> >  		if (ret < 0) {
> >  			dev_err(card->dev, "ASoC: can't create
> compress %s\n",
> >  					 dai_link->stream_name);
> 
> Thanks,
> Charles
