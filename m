From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 1/2] ASoC: cs35l33: Initial commit of
 the cs35l33 CODEC driver.
Date: Mon, 6 Jun 2016 19:31:41 +0100
Message-ID: <20160606183141.GI7510@sirena.org.uk>
References: <1464984546-2672-1-git-send-email-Paul.Handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8807056290019349116=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 044D32650C0
 for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2016 20:31:53 +0200 (CEST)
In-Reply-To: <1464984546-2672-1-git-send-email-Paul.Handrigan@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul.Handrigan@cirrus.com
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, robh+dt@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8807056290019349116==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4LwthZj+AV2mq5CX"
Content-Disposition: inline


--4LwthZj+AV2mq5CX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 03, 2016 at 03:09:05PM -0500, Paul.Handrigan@cirrus.com wrote:

> +		regmap_update_bits(cs35l33->regmap, CS35L33_CLK_CTL,
> +			CS35L33_MCLKDIV2, CS35L33_MCLKDIV2);
> +			cs35l33->mclk_int = freq/2;

Coding style, spaces around /.

> +       if (CS35L33_VBSTMON_OVFL & sticky_val2)
> +               dev_err(codec->dev,
> +                       "ERROR: VPMON Overflow Interrupt\n");

Cut'n'paste.

> +	/* Make sure that the bits are cleared */
> +	for (i = 0; i < CS35L33_INT_ATTEMPTS; i++) {
> +		regmap_read(cs35l33->regmap, CS35L33_INT_STATUS_1,
> +			&sticky_val1);
> +		regmap_read(cs35l33->regmap, CS35L33_INT_STATUS_2,
> +			&sticky_val2);
> +
> +		if (!(sticky_val1 & ~mask1) && !(sticky_val2 & ~mask2))
> +			break;
> +	}

I still don't understand this.  If these interrupts are clear on read
(which seems to be the case since we don't ack anything?) then these
repeated reads are obviously just going to ignore interrupts.  I really
hope that the masking also applies to the clear on read behaviour but
that's a separate thing.

I'm guessing the hardware is just broken here but it's not clear to me
that just letting the interrupt fire a couple of extra times isn't the
best solution and we need a clear explanation of what this is trying to
accomplish and why so that the code is maintainable.

> +       ret = request_threaded_irq(i2c_client->irq, NULL, cs35l33_irq_thread,
> +                       IRQF_ONESHOT | IRQF_TRIGGER_LOW, "cs35l33", cs35l33);
> +       if (ret != 0)
> +               dev_err(&i2c_client->dev, "Failed to request IRQ: %d\n", ret);

But otherwise ignore the error?

--4LwthZj+AV2mq5CX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVcGNAAoJECTWi3JdVIfQcyMH+wdmCY2Swv2vHAJUbJygj7VH
rgCrXI0sJ8jS3p1m4gml6zfN9nilDF7DJd98J0HYdfcmXH5N8ky5VThDg853r/mj
VtaixQWRObm6OgUTBNHWYKs0J276S5jtkGoLDYZv0aaMu9k1wzT3yJ8b36Y2bjHx
8/+m3qMBPGQJpSQ8Wf+uESqpM7aWHt8SHYnOJlJ02uAld/NI2uRkaV+XM0zsCZLS
JjZvoaO21XVLnXtNxkTC2kRypyyfk0NOyzcbovh7B+VC0jlZYFFrlDDk5sabPWy8
tQWubfySX8LODjRSzoejFGuiZZuVJG+0fYX1A0zmgriyX7Tlme+gjLN6lyjmwgQ=
=ITyS
-----END PGP SIGNATURE-----

--4LwthZj+AV2mq5CX--

--===============8807056290019349116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8807056290019349116==--
