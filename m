From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/9] ASoC: sti: Add CPU DAI driver for
	playback
Date: Mon, 25 May 2015 13:37:45 +0100
Message-ID: <20150525123745.GO21391@sirena.org.uk>
References: <1431951176-24670-1-git-send-email-arnaud.pouliquen@st.com>
 <1431951176-24670-4-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4973284454138069085=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EA2A261555
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 15:04:14 +0200 (CEST)
In-Reply-To: <1431951176-24670-4-git-send-email-arnaud.pouliquen@st.com>
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


--===============4973284454138069085==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CMx2Qe8y1jN1ar4Y"
Content-Disposition: inline


--CMx2Qe8y1jN1ar4Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2015 at 02:12:50PM +0200, Arnaud Pouliquen wrote:

> Add code to manage Uniperipheral player IP instances.
> These DAIs are dedicated to playback and support I2S and IEC mode.

There's some small things below but the main thing is that I'm still
unclear about the driver internal abstraction layers.  Perhaps that will
become obvious later in the series...

> +struct uniperif_ops {
> +	int (*open)(struct uniperif *player);
> +	void (*close)(struct uniperif *player);
> +	int (*prepare)(struct uniperif *player,
> +		       struct snd_pcm_runtime *runtime);
> +	int (*trigger)(struct uniperif *player, int cmd);
> +};

These ops still look suspiciously like the ALSA level ops which suggests
a driver internal abstraction layer.  Why is that happening?

> +static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
> +{
> +	irqreturn_t ret = IRQ_NONE;
> +	struct uniperif *player = dev_id;
> +	unsigned int status;
> +	unsigned int tmp;
> +
> +	if (player->state == UNIPERIF_STATE_STOPPED) {
> +		/* Unexpected IRQ: do nothing */
> +		dev_warn(player->dev, "unexpected IRQ");
> +		return IRQ_HANDLED;
> +	}

Just return IRQ_NONE here - as well as coping with any sharing of
interrupts that ends up happening in the future one of the reasons for
reporting if we handled things or not is to allow us to reuse the
support that genirq has for handling things like spurious interrupts.
In this case if something goes seriously wrong it'll complain and
eventually shut down the interrupt while this will result in a continual
spam to the console with no error handling.

> +	/* Error on unhandled interrupt */
> +	if (ret != IRQ_HANDLED)
> +		dev_err(player->dev, "IRQ status : %#x", status);

Let genirq worry about this.

> +static void uni_player_set_channel_status(struct uniperif *player,
> +					  struct snd_pcm_runtime *runtime)
> +{
> +	int n;
> +	unsigned int status;
> +
> +	/*
> +	 * Some AVRs and TVs require the channel status to contain a correct
> +	 * sampling frequency. If no sample rate is already specified, then
> +	 * set one.
> +	 */

Please take a look at Russell King's patch "sound/core: add IEC958
channel status helper" (currently in review though I'd expect it to hit
-next the next time it's built) - it does this (or most of it anyway) in
a factored out function that can be shared between drivers.

> +	/* No sample rates below 32kHz are supported for iec958 */
> +	if (runtime->rate < MIN_IEC958_SAMPLE_RATE) {
> +		dev_err(player->dev, "Invalid rate (%d)", runtime->rate);
> +		return -EINVAL;
> +	}

The driver should be imposing constraints which prevent this happening
either by using a different driver structure or by registering new
constraints from code on open.

> +	/* Set the number of channels (maximum supported by spdif is 2) */
> +	if (UNIPERIF_PLAYER_TYPE_IS_SPDIF(player) &&
> +	    (runtime->channels != 2)) {
> +		dev_err(player->dev, "invalid nb of channels");
> +		return -EINVAL;
> +	}

Similarly here.

> +	/* Calculate number of empty cells available before asserting DREQ */
> +	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
> +		trigger_limit = UNIPERIF_FIFO_SIZE - transfer_size;
> +	else
> +		/*
> +		 * Since SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0
> +		 * FDMA_TRIGGER_LIMIT also controls when the state switches
> +		 * from OFF or STANDBY to AUDIO DATA.
> +		 */
> +		trigger_limit = transfer_size;

Please use braces for multi-line branches of if statements even if the
extra lines are just comments, it makes things easier to read.

> +	switch (player->daifmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_IB_IF:
> +	case SND_SOC_DAIFMT_NB_IF:
> +		SET_UNIPERIF_I2S_FMT_LR_POL_HIG(player);
> +		break;

I didn't spot the code where the inverted and normal bit clock
polarities are handled?

> +const struct uniperif_ops uni_player_ops = {
> +	.close = uni_player_close,
> +	.prepare = uni_player_prepare,
> +	.trigger = uni_player_trigger
> +};

Again a driver internal abstraction layer...

> +	player->mem_region = platform_get_resource(pdev, IORESOURCE_MEM, idx);
> +
> +	if (!player->mem_region) {
> +		dev_err(&pdev->dev, "Failed to get memory resource");
> +		return -ENODEV;
> +	}
> +
> +	player->base = devm_ioremap_resource(&pdev->dev,

devm_ioremap_resource() will do the null check for you.

> +	ret = devm_request_irq(&pdev->dev, player->irq,
> +			       uni_player_irq_handler, IRQF_SHARED,
> +			       dev_name(&pdev->dev), player);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to request IRQ");
> +		return -EBUSY;
> +	}

Use the error code you got, don't ignore it.

> +	/* request_irq() enables the interrupt immediately; as it is
> +	 * lethal in concurrent audio environment, we want to have
> +	 * it disabled for most of the time...
> +	 */
> +	disable_irq(player->irq);

That's a bit worrying...  can you expand on what problems you see if the
interrupt is left enabled?

> +int uni_player_remove(struct platform_device *pdev)
> +{
> +	struct uniperif *player = platform_get_drvdata(pdev);
> +
> +	if (player->clk)
> +		clk_put(player->clk);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(uni_player_remove);

What's this about - if nothing else shouldn't we be using
devm_clk_get()?

--CMx2Qe8y1jN1ar4Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVYxeZAAoJECTWi3JdVIfQFHMH/0HGHLd0OtkeFozYv+lkPoim
5WFEyVmwQvwTGfikyaqtlJrMs1CQDqCj2tVXPDGqJTZJO0Z9ouoQXtOaZUstRPog
0za3KQUuUpbKQUHt37PA5WsOo1Bbuz1OnGCARJsl5qqSBmFrQyv6J5OvJDswZ0Dy
PRj4k2DUdes/bnOlWImiB4DIIHbtlsgaUojy2soypplrNtdsyZHQr1fs6S3CB+/s
fLadSGb9q1Bf5loVX/HXOduGepR+VQfUQ8lkwRCbGCZptaT4Up1ZcnORKNMh1m3t
VCZbzhKrK3CNU3fIGIp0OvC2AetIcquWLSJRw/4aLN773XHxI0rY7DFLe+P64pk=
=kTAd
-----END PGP SIGNATURE-----

--CMx2Qe8y1jN1ar4Y--

--===============4973284454138069085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4973284454138069085==--
