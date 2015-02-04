From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt286: add jack detection
 enable/disable APIs and export
Date: Wed, 4 Feb 2015 20:26:04 +0000
Message-ID: <20150204202604.GF21293@sirena.org.uk>
References: <1423056843-26490-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1157355698300177764=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9ABF12604D5
 for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2015 21:26:12 +0100 (CET)
In-Reply-To: <1423056843-26490-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1157355698300177764==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xFaRvbw97Zfv6UcM"
Content-Disposition: inline


--xFaRvbw97Zfv6UcM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 04, 2015 at 09:34:03PM +0800, Jie Yang wrote:

> +int rt286_disable_jack_detection(struct snd_soc_codec *codec)
> +{
> +	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
> +
> +	disable_irq(rt286->i2c->irq);
> +
> +	snd_soc_dapm_disable_pin(&rt286->codec->dapm, "LDO1");
> +	snd_soc_dapm_sync(&rt286->codec->dapm);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(rt286_disable_jack_detection);

So, now I look at this again I'm wondering why this isn't writing to any
registers - looking at the code we run on probe there's a register write
if we're passed an interrupt which looks awfully like we're enabling
jack detect.  Probably we wouldn't need to do the rather odd disabling
of the IRQ if we did that, but perhaps it's required.

I think there's actually problems with the existing jack detection code
in the driver, I'd expect that the initial enabling of jack detect would
be done when the machine driver says it wants jack detect by passing in
the jack to report for.

--xFaRvbw97Zfv6UcM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0oBbAAoJECTWi3JdVIfQX08H/255W39TFzRc2yZgEaIJ219n
11ZMnPsAyfLACLCXHKjZfE+47D+e7RvfAVZbYY2IE2RyJWLIoHWvMUI5Axin419Y
5K5DxC7+ZeCXK83ZrvJuiUqFjf70mN4Id3bMLNVoaZmWI73ORHoJJS08TzK7mKAo
wgifP5rrkFHrf4COlrHShnxhp3XzERzlUSc9McHQkkM8YVU2PNYPjQeXLd2Hp6qJ
ItxTxhbPmExD4P0EskkMyogy2zOpSh3ieOm/0E/u7Sc+TCCOv29u5mR6XHvOXQGA
2kh+4fka85k0y53Xi64AA7GAn0CV+KNHhiQq/9o7A7YuJT7aNk9+MsHfpPBJ2/w=
=a6Sb
-----END PGP SIGNATURE-----

--xFaRvbw97Zfv6UcM--

--===============1157355698300177764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1157355698300177764==--
