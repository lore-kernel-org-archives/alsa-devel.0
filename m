From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 5/9] ASoC: sti: Add platform driver
Date: Mon, 25 May 2015 13:50:02 +0100
Message-ID: <20150525125002.GQ21391@sirena.org.uk>
References: <1431951176-24670-1-git-send-email-arnaud.pouliquen@st.com>
 <1431951176-24670-6-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3546691790199118279=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DEFA260686
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 15:02:37 +0200 (CEST)
In-Reply-To: <1431951176-24670-6-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3546691790199118279==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Rnz0oC2K6vQ5doJs"
Content-Disposition: inline


--Rnz0oC2K6vQ5doJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2015 at 02:12:52PM +0200, Arnaud Pouliquen wrote:

> Asoc Platform driver that manages uniperipheral DAIs and associated

ASoC.

> +struct sti_platform_dai {
> +	int stream;
> +	int (*init)(struct platform_device *pdev, struct device_node *node,
> +		    struct uniperif **uni, int idx);
> +	int (*remove)(struct platform_device *pdev);
> +	struct uniperif *uni;
> +	struct snd_dmaengine_dai_dma_data dma_data;
> +};

Again a driver internal abstraction layer...

> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +	if (uni->ops->trigger)
> +		return uni->ops->trigger(uni, SNDRV_PCM_TRIGGER_START);

Coding style.

> +	return snd_dmaengine_pcm_prepare_slave_config(substream, params,
> +						     &dma_params->slave_config);

You're using dmaengine but at least one of the earlier patches supplied
a snd_pcm_hardware - the dmaengine code should be able to figure out
constraints from the dmaengine driver in current code, is that causing
you problems?

> +static int sti_pcm_trigger(struct snd_pcm_substream *substream,
> +			   int cmd)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct sti_pcm_dma_params *params = runtime->private_data;
> +	enum dma_transfer_direction direction;
> +	struct dma_async_tx_descriptor *desc;
> +	unsigned long flags = DMA_CTRL_ACK;
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +		direction = snd_pcm_substream_to_dma_direction(substream);
> +
> +		desc = dmaengine_prep_dma_cyclic(
> +				params->dma_channel,	runtime->dma_addr,
> +				snd_pcm_lib_buffer_bytes(substream),
> +				snd_pcm_lib_period_bytes(substream),
> +				direction, flags);

Can you use snd_dmaengine_pcm_trigger?

> +static snd_pcm_uframes_t sti_pcm_pointer(struct snd_pcm_substream *substream)
> +{

snd_dmaengine_pcm_pointer()?

> +static int sti_platform_engine_probe(struct platform_device *pdev)
> +{
> +	/*
> +	 * Driver can not use snd_dmaengine_pcm_register.
> +	 * Reason is that DMA needs to load a firmware.
> +	 * This firmware is loaded on request_channel from file system.
> +	 * So can not be done in probe while alsa card enumerated before
> +	 * file system is mounted
> +	 */

This is not the only driver with similar needs, the Intel drivers use
firmwares as well (all the DMA is done by the DSP which needs firmware)
and even if it were we should be able to arrange for this to work rather
than having to open code things.  That might mean having the dmaengine
driver requesting firmware with _nowait() and then waiting until the
firmware appears before registering as a DMA controller for example.  We
may also be able to have the DMA engine only load the firmware when it's
used rather than at probe (that might allow us to keep the DMA
controller powered off for longer which would be a power win if possible).

It's not just restricted to audio either.

> +static const struct of_device_id snd_soc_sti_match[] = {
> +	{ .compatible = "st,sti-audio-platform", },
> +	{},
> +};

This doesn't seem to represent actual hardware, it seems to be an
abstraction layer between dmaengine and your DAI drivers.  This is fine
and normal but it means the driver shouldn't appear in DT.  Take a look
at how other drivers like Tegra or the Freescale ones handle this.

--Rnz0oC2K6vQ5doJs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVYxp6AAoJECTWi3JdVIfQf1EH/iHZrMjE+hRT2YTJ+ePzQ7pr
q8VgLhom5GLvbPu/itoMWR7SAzoKP7jWBToGt3SJwwPBY/45X5zjGExKpkzFl03x
XMeXZ1GdUcatXe+DhsiszPtItUqwGbtGh+DzJsWOR6cbrOS3zceuL0y4Utt6N0LP
YWy/hAN+QKYgafVmjoWN7KFkyT0k6NKN3L4X7U8vyZrhO5KH4VUkkN0T8g3Ofxiq
qu3yNbQHuFUCzkr9w9dqBeQmBpT1ukS+ALkT/8FjxIjVc5dr7smuoCCmqSdrlydH
uEVAOc/DQSpIU+mxNxyF/t2BMGcpduFxXS5SdIPXGgA35b824DfX4TMGn+feI3Y=
=iaQv
-----END PGP SIGNATURE-----

--Rnz0oC2K6vQ5doJs--

--===============3546691790199118279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3546691790199118279==--
