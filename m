From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 13/15] ASoC: codec/dw-hdmi-audio: add codec driver for
 dw hdmi audio
Date: Thu, 26 Mar 2015 11:11:06 -0700
Message-ID: <20150326181106.GY3572@sirena.org.uk>
References: <1425175834-24661-1-git-send-email-ykk@rock-chips.com>
 <1425178760-2655-1-git-send-email-ykk@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7966825947444972214=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1425178760-2655-1-git-send-email-ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bard Liao <bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, mmind00-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>, Oder Chiou <oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Ben Zhang <benzh-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Philipp Zabel <p.zabel@pengut>
List-Id: alsa-devel@alsa-project.org


--===============7966825947444972214==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rmLdANEyqdgxlbgR"
Content-Disposition: inline


--rmLdANEyqdgxlbgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 28, 2015 at 09:59:20PM -0500, Yakir Yang wrote:

> codec driver creat an standard alsa device, than config audio
> and report jack status through some callback interfaces that
> dw_hdmi driver support.

Looking at this it's not althogether clear to me how specific this is to
the Designware hardware - it looks like it's all callbacks into the main
driver doing pretty generic things apart from the fact that we request
an interrupt here (but then use it to do another callback into the
driver).

Please also try to only CC relevant people on mails - you've got a
*very* large list of people there and for a lot of them it's hard to
understand why you've copied them.  Copying people adds to the amount of
mail they need to read so it's good to try to stay relevant.

> +	if (jack_status != hdmi->jack_status) {
> +		snd_soc_jack_report(&hdmi->jack, jack_status,
> +				    SND_JACK_LINEOUT);

We may need a new jack type here, or perhaps we ought to just be
reporting the jack status via extcon?

> +		hdmi->jack_status = jack_status;
> +
> +		dev_info(hdmi->dev, "jack report [%d]\n", hdmi->jack_status);

Please remove this and all the other prints, it's far too noisy.

> +/* we don't want this irq mark with IRQF_ONESHOT flags,
> + * so we build an irq_default_primary_handler here */
> +static irqreturn_t snd_dw_hdmi_hardirq(int irq, void *dev_id)
> +{
> +	return IRQ_WAKE_THREAD;
> +}

Why do we not want to use IRQF_ONESHOT?

> +static int dw_hdmi_audio_remove(struct platform_device *pdev)
> +{
> +	struct snd_dw_hdmi *hdmi = platform_get_drvdata(pdev);
> +
> +	snd_soc_unregister_codec(&pdev->dev);
> +	devm_free_irq(&pdev->dev, hdmi->data.irq, hdmi);
> +	devm_kfree(&pdev->dev, hdmi);

Explicitly freeing devm_ things seems to be missing the point a bit...

> +static const struct of_device_id dw_hdmi_audio_ids[] = {
> +	{ .compatible = DRV_NAME, },
> +	{ }
> +};

Your driver name didn't have a vendor prefix, this is broken - you
should probably just remove DRV_NAME and use the string directly in the
few places it's used.  It's also not clear to me that this is a separate
device from the parent device and should therefore appear separately in
DT at all.

> +static struct platform_driver dw_hdmi_audio_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +		.owner = THIS_MODULE,

No need to assign owner any more.

--rmLdANEyqdgxlbgR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVFEu5AAoJECTWi3JdVIfQV4EH/1Tcb/z86vDPZ2gkqXExXi4K
zflEkPBVZg7PSRJ7HvS0DyFt4hRZiKqNPSHP1MEaECOUgX5BHtpwD61vtb3ZRgUD
e/ES2KixzMu2Aq4rdRJhCTbvzJQeo/XkmTHI0LzIi692YgMPSjpIvcU9f4EEfDmY
E0QJdyw56TbT8cKPbrO8/z107au7cTvEbnyowYHeg3O8lfnXeGnb97bHfv38hnVi
Gs6ZRw01qu0CXyWAgxlNiZ3Hto2T1X/lVsNs9caFjkNyuE7O34c7RPJhSTplWJJL
JhNt+Sma3FXrNiwZzwqnXYzyVq8QB9Brs+3ymMyMToxORvXucO4uzAjyNAodQ/g=
=Ofzc
-----END PGP SIGNATURE-----

--rmLdANEyqdgxlbgR--


--===============7966825947444972214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============7966825947444972214==--
