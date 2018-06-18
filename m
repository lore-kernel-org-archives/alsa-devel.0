From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Boards: Add GLK Realtek Maxim
 I2S machine driver
Date: Mon, 18 Jun 2018 11:08:22 -0500
Message-ID: <3593ad31-ca5d-432b-5d68-2c7b2ba42914@linux.intel.com>
References: <1529336788-6835-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 25512266E8B
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 18:08:24 +0200 (CEST)
In-Reply-To: <1529336788-6835-1-git-send-email-naveen.m@intel.com>
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
To: Naveen Manohar <naveen.m@intel.com>, alsa-devel@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org



On 06/18/2018 10:46 AM, Naveen Manohar wrote:
> Patch adds Geminilake I2S machine driver which uses following codecs:
> RT5682 and MAX98357A.
Thanks Naveen. Looks good to me, just 4 nit-picks below on style 
(reverse x-mas tree order for variable definitions)
if you can fix, add my tag below and resubmit it'd nice.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> +static int platform_clock_control(struct snd_soc_dapm_widget *w,
> +					struct snd_kcontrol *k, int  event)
> +{
> +	int ret = 0;
> +	struct snd_soc_dapm_context *dapm = w->dapm;
> +	struct snd_soc_card *card = dapm->card;
> +	struct snd_soc_dai *codec_dai;
here..
> +static int geminilake_rt5682_codec_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	int ret;
> +	struct snd_soc_jack *jack;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	struct snd_soc_component *component = rtd->codec_dai->component;
> +	struct glk_card_private *ctx = snd_soc_card_get_drvdata(rtd->card);
and here
> +static int geminilake_rt5682_fe_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	int ret;
> +	struct snd_soc_dapm_context *dapm;
> +	struct snd_soc_component *component = rtd->cpu_dai->component;
and here
> +static int glk_card_late_probe(struct snd_soc_card *card)
> +{
> +	struct glk_card_private *ctx = snd_soc_card_get_drvdata(card);
> +	struct snd_soc_component *component = NULL;
> +	char jack_name[NAME_SIZE];
> +	struct glk_hdmi_pcm *pcm;
> +	int err, i = 0;
one last, i find it more readable to have one assignment per line.
