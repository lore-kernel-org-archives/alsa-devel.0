From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ASoC: dapm: add code to configure dai link parameters
Date: Thu, 11 Sep 2014 19:37:22 +0100
Message-ID: <20140911183722.GR4015@sirena.org.uk>
References: <1410432139-15089-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U0B5otXy6WXfork9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410432139-15089-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--U0B5otXy6WXfork9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 11, 2014 at 11:42:18AM +0100, Nikesh Oswal wrote:

> +	/* add kcontrol */
> +	for (i = 0; i < w->num_kcontrols; i++) {
> +		kcontrol = snd_soc_cnew(&w->kcontrol_news[i], w,
> +		w->name, NULL);
> +		ret = snd_ctl_add(card, kcontrol);

*sigh*  As I wrote before in response to exactly the same code:

| Throughout this you've got coding style problems, you're not indenting
| the continuations of multi-line statements.  Please try to follow the
| kernel coding style, if your code is visibly different to the rest of
| the codebase that's not good.

Please pay attention to review comments, just completely ignoring them
isn't good.  If you don't feel some change should be made then reply and
discuss.

--U0B5otXy6WXfork9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUEevhAAoJECTWi3JdVIfQPL0H+wcGMuYK1NxagI2N6mzs0/MJ
hm9RbtJhiXByUYFPoAbKHHaiedeuZQyzQhQX4rWmSiUXhrRApBNdFXbXBeO5Fuqv
cmJQpvWxv2aGhOMZ9xCMqeeLDNNxCay4omkchGnUQFzgWSGbtMK7+G1TDS7qlrJ/
/cLgwxsbaFvKh7D2rqLDCSZMICBtANBXPW/VfqDi544exZex+R37tp6KHCbywvx7
EaMQL/O7TUb1jK0ptg9EFtpfAuBiG6bQs0pWz7n3CdOYYzTTr911aj7e4zhzxrz0
+w+LKN9j8lH5UDcgmLFgxltaYvC9tSe8kz01Yzaeq9ZVoetT1buqvAh4izd3dgw=
=RfRz
-----END PGP SIGNATURE-----

--U0B5otXy6WXfork9--
