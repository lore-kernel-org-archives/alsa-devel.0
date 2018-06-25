From: Shreyas NC <shreyas.nc@intel.com>
Subject: Re: [PATCH v6 1/3] ASoC: Add initial support for
 multiple CPU DAIs
Date: Mon, 25 Jun 2018 10:20:00 +0530
Message-ID: <20180625045000.GA15119@snc-desk>
References: <1529492057-32627-1-git-send-email-shreyas.nc@intel.com>
 <1529492057-32627-2-git-send-email-shreyas.nc@intel.com>
 <d6b2b5a1-a714-e72c-8012-52a40e4e9447@linux.intel.com>
 <20180622041437.GP3116@snc-desk>
 <dffba216-f4ff-4ec6-24f0-f9c7bbdf4b68@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id D985E2673F5
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 06:51:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <dffba216-f4ff-4ec6-24f0-f9c7bbdf4b68@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 22, 2018 at 10:13:28AM -0500, Pierre-Louis Bossart wrote:
> 
> >>>+static int snd_soc_init_single_cpu_dai(struct snd_soc_card *card,
> >>>+				   struct snd_soc_dai_link *dai_link)
> >>>+{
> >>>+	if (dai_link->cpu_name || dai_link->cpu_of_node ||
> >>>+					dai_link->cpu_dai_name) {
> >>>+		dai_link->num_cpu_dai = 1;
> >>>+		dai_link->cpu_dai = devm_kzalloc(card->dev,
> >>>+				sizeof(struct snd_soc_dai_link_component),
> >>>+				GFP_KERNEL);
> >>>+
> >>>+		if (!dai_link->cpu_dai)
> >>>+			return -ENOMEM;
> >>>+
> >>>+		dai_link->cpu_dai[0].name = dai_link->cpu_name;
> >>>+		dai_link->cpu_dai[0].of_node = dai_link->cpu_of_node;
> >>>+		dai_link->cpu_dai[0].dai_name = dai_link->cpu_dai_name;
> >>Question: is cpu_dai[i].of_node defined for i>0 in the multi cpu_dai case?
> >>
> >
> >Yes, it should be defined.
> 
> I have limited understanding of how cpu_of_node would be handled and if
> there is any guidance for DT folks on how to deal with multiple cpu_dais.
> 

>From what I could gather, it looks like we need not add additional code.
But, my understanding of DT is pretty limited as well. Vinod, Liam,  can you help us
here?

> >
> >>>@@ -1644,7 +1751,7 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
> >>>  	unsigned int dai_fmt)
> >>>  {
> >>>  	struct snd_soc_dai **codec_dais = rtd->codec_dais;
> >>>-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> >>>+	struct snd_soc_dai **cpu_dais = rtd->cpu_dais;
> >>>  	unsigned int i;
> >>>  	int ret;
> >>>@@ -1659,35 +1766,44 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
> >>>  		}
> >>>  	}
> >>>-	/* Flip the polarity for the "CPU" end of a CODEC<->CODEC link */
> >>why was this comment removed?
> >>
> >
> >Looks like I messed up resolving ocnflicts while rebase
> >
> >>>  	/* the component which has non_legacy_dai_naming is Codec */
> >>>-	if (cpu_dai->component->driver->non_legacy_dai_naming) {
> >>Not sure if the code refactoring below makes sense in a codec-codec link,
> >>you probably wouldn't have multiple cpu_dais then, would you?
> >
> >Yes, a valid point. You suggest to leave this piece of code as is ?
> 
> Not necessarily. I don't understand how the codec-codec and multi cpu_dais
> intersect, all I am asking for is a check if this change is needed or not.
> 

In soc_link_dai_widgets() which is called from probe_dai_links(),
we call out that we do not support multi cpu/codec for CODEC - CODEC link.
All the operation there are done only on single CPU DAI/Codec DAI.

But, in this function snd_soc_dai_set_fmt() is set on all Codec DAIs. So,
for sake of consistency we can do it for CPU DAIs too.

--Shreyas

-- 
