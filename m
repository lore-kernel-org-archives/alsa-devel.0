From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH v4 3/8] ASoC: Intel: Boards: Machine driver
 for SKL+ w/ HDAudio codecs
Date: Wed, 25 Jul 2018 16:41:45 +0530
Message-ID: <20180725111145.GM3661@vkoul-mobl>
References: <20180725005055.18138-1-pierre-louis.bossart@linux.intel.com>
 <20180725005055.18138-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 16D9126774A
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 13:11:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180725005055.18138-4-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

On 24-07-18, 19:50, Pierre-Louis Bossart wrote:

> +/* skl_hda_digital audio interface glue - connects codec <--> CPU */
> +struct snd_soc_dai_link skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS] = {
> +
> +	/* Back End DAI links */
> +	{
> +		.name = "iDisp1",
> +		.id = 1,
> +		.cpu_dai_name = "iDisp1 Pin",
> +		.codec_name = "ehdaudio0D2",
> +		.codec_dai_name = "intel-hdmi-hifi1",
> +		.platform_name = "0000:00:1f.3",

you are setting this one in skl_hda_fill_card_info() so this is
superfluous

> +		.dpcm_playback = 1,
> +		.no_pcm = 1,
> +	},
> +	{
> +		.name = "iDisp2",
> +		.id = 2,
> +		.cpu_dai_name = "iDisp2 Pin",
> +		.codec_name = "ehdaudio0D2",
> +		.codec_dai_name = "intel-hdmi-hifi2",
> +		.platform_name = "0000:00:1f.3",
> +		.dpcm_playback = 1,
> +		.no_pcm = 1,
> +	},
> +	{
> +		.name = "iDisp3",
> +		.id = 3,

shouldn't this be queried. not all will have 3 links

> +int skl_hda_hdmi_jack_init(struct snd_soc_card *card)
> +{
> +	struct skl_hda_private *ctx = snd_soc_card_get_drvdata(card);
> +	struct skl_hda_hdmi_pcm *pcm;
> +	struct snd_soc_component *component = NULL;
> +	int err;
> +	char jack_name[NAME_SIZE];

many people prefer inverted christmas tree for these..

> +static struct platform_driver skl_hda_audio = {
> +	.probe = skl_hda_audio_probe,
> +	.driver = {
> +		.name = "skl_hda_dsp_generic",

who creates this pdev, is it the board details (mach name?)

-- 
~Vinod
