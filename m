From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/4] ASoC: rt286: rt286_mic_detect() uses
 component
Date: Wed, 26 Oct 2016 21:38:43 +0530
Message-ID: <20161026160843.GE3000@localhost>
References: <87eg3a2v32.wl%kuninori.morimoto.gx@renesas.com>
 <87d1iu2v1j.wl%kuninori.morimoto.gx@renesas.com>
 <s5hshrmnsj2.wl-tiwai@suse.de>
 <e615912f-f6e7-a696-31f2-009c927838ec@metafoo.de>
 <87insi2obs.wl%kuninori.morimoto.gx@renesas.com>
 <5a1187a2-521a-0cd7-856a-ffdc69a045ed@metafoo.de>
 <20161026035045.GB3000@localhost>
 <08be64ec-236a-dcc2-5936-9edec930629a@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E89F267131
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 17:59:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <08be64ec-236a-dcc2-5936-9edec930629a@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, Mengdong Lin <mengdong.lin@intel.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jin Yao <yao.jin@linux.intel.co>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 26, 2016 at 08:56:15AM +0200, Lars-Peter Clausen wrote:
> On 10/26/2016 05:50 AM, Vinod Koul wrote:
> >>
> >> Maybe somebody from the Intel side can look into fixing this. The affected
> >> boards are cht_bsw_rt5672 and broadwell, which both access the cards
> >> codec_dev_list field.
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
> 
> I've started working on this series[1] a while ago with the intention of
> eventually removing the CODEC field from the rtd struct. Maybe you can use
> it as a base.

Sure thing :)

-- 
~Vinod
