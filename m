From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/19] ASoC: upd9976: Add Renesas uPD9976
	codec driver
Date: Wed, 4 May 2011 15:34:51 +0100
Message-ID: <20110504143451.GA10912@opensource.wolfsonmicro.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134458.32443.45825.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DF6C310390D
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 16:35:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110504134458.32443.45825.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Koul Vinod <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 04, 2011 at 09:44:58PM +0800, Lu Guanqun wrote:

Overall this looks very good, a few minor points below.

> +static inline unsigned int upd9976_read(struct snd_soc_codec *codec,
> +					unsigned int reg)
> +{

I guess these SCU write functions are going to be shared with other
CODECs for this CPU - we should probably push this into the soc-cache
for them.

> +static const struct snd_kcontrol_new upd9976_snd_controls[] = {
> +	SOC_DOUBLE_R_TLV("Headphone & Speaker Volume",

Master Volume would be a better name.

> +static const struct snd_kcontrol_new upd9976_hp_spkr_mixer_left_controls[] = {
> +	SOC_DAPM_SINGLE("Audio DAC Left", UPD9976_HPLMIXSEL, 4, 1, 1),
> +	SOC_DAPM_SINGLE("Audio DAC Right", UPD9976_HPLMIXSEL, 3, 1, 1),

These need Switch at the end of the name.

> +static struct snd_soc_dai_driver upd9976_dais[] = {
> +{
> +	.name = "upd9976-audio",
> +	.playback = {

Just drop the audio from the name, it's a CODEC so it's obviously audio.
