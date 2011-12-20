From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3 v5] sound/soc/codecs: add LAPIS
	Semiconductor ML26124
Date: Tue, 20 Dec 2011 10:40:47 +0000
Message-ID: <20111220104047.GE2866@opensource.wolfsonmicro.com>
References: <1324349144-12784-1-git-send-email-tomoya.rohm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 60E2C103ACE
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 11:40:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1324349144-12784-1-git-send-email-tomoya.rohm@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 20, 2011 at 11:45:42AM +0900, Tomoya MORINAGA wrote:

> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		/* VMID ON */
> +		snd_soc_update_bits(codec, ML26124_PW_REF_PW_MNG,
> +				    ML26124_VMID, ML26124_VMID);
> +		msleep(500);
> +	case SND_SOC_BIAS_PREPARE:

You're missing a break here.

> +static int ml26124_pcm_trigger(struct snd_pcm_substream *substream,
> +			      int cmd, struct snd_soc_dai *codec_dai)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +
> +	if (cmd == SNDRV_PCM_TRIGGER_STOP) {
> +		snd_soc_update_bits(codec, ML26124_REC_PLYBAK_RUN, 0x3, 0);
> +		return 0;
> +	} else if (cmd == SNDRV_PCM_TRIGGER_START) {
> +		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)

Use switch statements, though frankly I'd be astonished if this code
actually runs as the trigger() callback is called in atomic context and
the register I/O functionality needs interrupts.  How have you tested
this code?

> +	.reg_cache_size = ML26134_CACHESIZE,
> +	.reg_word_size = sizeof(u8),
> +	.reg_cache_default = ml26124_reg,

New drivers really should use regmap rather than the ASoC cache code.
