From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/4] ASoC: rt286: rt286_mic_detect() uses
 component
Date: Wed, 26 Oct 2016 21:36:28 +0530
Message-ID: <20161026160628.GD3000@localhost>
References: <87eg3a2v32.wl%kuninori.morimoto.gx@renesas.com>
 <87d1iu2v1j.wl%kuninori.morimoto.gx@renesas.com>
 <s5hshrmnsj2.wl-tiwai@suse.de>
 <e615912f-f6e7-a696-31f2-009c927838ec@metafoo.de>
 <87insi2obs.wl%kuninori.morimoto.gx@renesas.com>
 <5a1187a2-521a-0cd7-856a-ffdc69a045ed@metafoo.de>
 <20161026035045.GB3000@localhost>
 <87pomnwwpv.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 10099267131
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 17:57:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87pomnwwpv.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Simon <horms@verge.net.au>, Takashi Iwai <tiwai@suse.de>, Mengdong Lin <mengdong.lin@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jin Yao <yao.jin@linux.intel.co>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 26, 2016 at 04:48:29AM +0000, Kuninori Morimoto wrote:
> 
> Hi Mark, Lars, Vinod
> 
> > > Maybe somebody from the Intel side can look into fixing this. The affected
> > > boards are cht_bsw_rt5672 and broadwell, which both access the cards
> > > codec_dev_list field.
> > 
> > This also exists in some customer SKL machines.
> > 
> > I agree that this may not be best implementation so I can send a patch for
> > this.
> > 
> > As Lars suggested we can use DAI link init callback, but then I dont feel it
> > is right to use rtd->codec to get codec pointer, again we will be looking
> > into rtd internals. So would make sense to combine two suggestion and add an
> > API:
> > 
> > struct snd_soc_codec *snd_soc_get_codec(struct snd_soc_pcm_runtime *rtd)
> > {
> > 	return rtd->codec;
> > }
> > 
> > then we can use this is drivers.
> > 
> > Let me know if all are in agreement, I can test this and send out..
> 
> I guess my patch series should based on Vinod's new patch
> which doesn't use codec_dev_list ?
> Or can I post separately ?
> 
> Vinod, can you please Cc to me about your new patch ?

Sure thing..

-- 
~Vinod
