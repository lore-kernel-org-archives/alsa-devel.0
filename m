From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Applied "ASoC: hdmi-codec: Add ELD control" to the
	asoc tree
Date: Wed, 27 Apr 2016 10:42:19 +0100
Message-ID: <20160427094219.GL19428@n2100.arm.linux.org.uk>
References: <1461142804-26728-4-git-send-email-p.zabel@pengutronix.de>
 <E1atHJ9-0003ey-9b@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id DAC14265090
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2016 11:42:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <E1atHJ9-0003ey-9b@debutante>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Koro Chen <koro.chen@mediatek.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, Philipp Zabel <p.zabel@pengutronix.de>, PC Liao <pc.liao@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Cawa Cheng <cawa.cheng@mediatek.com>
List-Id: alsa-devel@alsa-project.org

It would have been good to have this as a generic ALSA control rather than
an ASoC control.  The dw-hdmi driver is an ALSA driver, and now we have to
re-invent this for ALSA...

On Thu, Apr 21, 2016 at 05:18:23PM +0100, Mark Brown wrote:
> The patch
> 
>    ASoC: hdmi-codec: Add ELD control
> 
> has been applied to the asoc tree at
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.  
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 
> >From 81151cfb6bfe69f1c5a52b795eb005226a322c9e Mon Sep 17 00:00:00 2001
> From: Philipp Zabel <p.zabel@pengutronix.de>
> Date: Wed, 20 Apr 2016 10:59:58 +0200
> Subject: [PATCH] ASoC: hdmi-codec: Add ELD control
> 
> ALSA doesn't know about all the different compressed audio formats,
> so there is no interface to let userspace enumerate the formats that
> are supported by the connected sink. Exporting the raw ELD bytes to
> userspace allows an application to select the appropriate audio format
> depending on the current capabilities of the connected HDMI sink device.
> Usually userspace then just pretends to ALSA that the data is in one of
> the raw 16-bit PCM audio formats and relies on the IEC controls to tell
> the sink how to interpret the data.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Jyri Sarha <jsarha@ti.com>
> Tested-by: Jyri Sarha <jsarha@ti.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/codecs/hdmi-codec.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
> index b46b8edb9319..c78333b4311d 100644
> --- a/sound/soc/codecs/hdmi-codec.c
> +++ b/sound/soc/codecs/hdmi-codec.c
> @@ -47,6 +47,42 @@ enum {
>  	DAI_ID_SPDIF,
>  };
>  
> +static int hdmi_eld_ctl_info(struct snd_kcontrol *kcontrol,
> +			     struct snd_ctl_elem_info *uinfo)
> +{
> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
> +	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
> +
> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
> +	uinfo->count = sizeof(hcp->eld);
> +
> +	return 0;
> +}
> +
> +static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
> +			    struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
> +	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
> +
> +	mutex_lock(&hcp->eld_lock);
> +	memcpy(ucontrol->value.bytes.data, hcp->eld, sizeof(hcp->eld));
> +	mutex_unlock(&hcp->eld_lock);
> +
> +	return 0;
> +}
> +
> +static const struct snd_kcontrol_new hdmi_controls[] = {
> +	{
> +		.access = SNDRV_CTL_ELEM_ACCESS_READ |
> +			  SNDRV_CTL_ELEM_ACCESS_VOLATILE,
> +		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
> +		.name = "ELD",
> +		.info = hdmi_eld_ctl_info,
> +		.get = hdmi_eld_ctl_get,
> +	},
> +};
> +
>  static int hdmi_codec_new_stream(struct snd_pcm_substream *substream,
>  				 struct snd_soc_dai *dai)
>  {
> @@ -312,6 +348,8 @@ static const struct snd_soc_dai_driver hdmi_spdif_dai = {
>  };
>  
>  static struct snd_soc_codec_driver hdmi_codec = {
> +	.controls = hdmi_controls,
> +	.num_controls = ARRAY_SIZE(hdmi_controls),
>  	.dapm_widgets = hdmi_widgets,
>  	.num_dapm_widgets = ARRAY_SIZE(hdmi_widgets),
>  	.dapm_routes = hdmi_routes,
> -- 
> 2.8.0.rc3
> 

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
