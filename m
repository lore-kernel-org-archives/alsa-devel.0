From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 3/3] ASoC: Add Multi CPU DAI support in DAPM
Date: Mon, 12 Mar 2018 09:21:06 +0000
Message-ID: <20180312092106.eke3lfc6op3lz42d@localhost.localdomain>
References: <1520334030-8018-1-git-send-email-shreyas.nc@intel.com>
 <1520334030-8018-4-git-send-email-shreyas.nc@intel.com>
 <20180309163124.5vxiponvnubxnez2@localhost.localdomain>
 <20180312053751.GC2887@snc-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id D7ECB266E43
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 10:21:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180312053751.GC2887@snc-desk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shreyas NC <shreyas.nc@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, Patches Audio <patches.audio@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 12, 2018 at 11:07:52AM +0530, Shreyas NC wrote:
> On Fri, Mar 09, 2018 at 10:01:24PM +0530, Charles Keepax wrote:
> > On Tue, Mar 06, 2018 at 04:30:30PM +0530, Shreyas NC wrote:
> > > -static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
> > > -					  struct snd_soc_pcm_runtime *rtd)
> > > +static void dapm_check_dai_valid_widget(struct snd_soc_card *card,
> > > +					struct snd_soc_pcm_runtime *rtd,
> > > +					struct snd_soc_dai *codec_dai,
> > > +					struct snd_soc_dai *cpu_dai)
> > 
> > Not sure about the name here dapm_check_dai_valid_widget doesn't
> > sound like it should be adding paths, otherwise I think this one
> > looks ok.
> > 
> 
> Ok, does dapm_add_valid_widget() sound better?

Yeah that seems like a better name to me.

Thanks,
Charles
