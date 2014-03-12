From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: core: Add support for DAI multicodec
Date: Wed, 12 Mar 2014 22:51:25 +0000
Message-ID: <20140312225125.GZ28112@sirena.org.uk>
References: <1394536644-21438-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7077290047019212827=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B88E0265079
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 23:51:44 +0100 (CET)
In-Reply-To: <1394536644-21438-1-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7077290047019212827==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JUUThYPLGgF4ELUJ"
Content-Disposition: inline


--JUUThYPLGgF4ELUJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 11, 2014 at 12:17:24PM +0100, Benoit Cousson wrote:

> +struct snd_soc_dai_link_codec {
> +	const char *codec_name;
> +	const struct device_node *codec_of_node;
> +	const char *codec_dai_name;
> +
> +	struct snd_soc_codec *codec;
> +	struct snd_soc_dai *codec_dai;
> +
> +	int (*hw_params_fixup)(struct snd_soc_pcm_runtime *rtd,
> +			       struct snd_pcm_hw_params *params);
> +	struct snd_pcm_hw_params hw_params;
> +};

The implementation looks basically fine, it's possible there's something
nasty in there but the patch is rather large and not quite repetitive
enough.  Most of the interface seems good - I'm not super thrilled with
having the separate CODECs list but equally well the idea of updating
all the machine drivers isn't super awesome either and should be punted
for a cleanup run later.

I would like to see something nicer for the fixup though - I think we
can avoid doing it if we use the TDM API to specify the slots that are
in use by a CODEC.  Xiubo has done some nice work there recently which
is handy.  Instead of having a fixup function if we specified a TDM
and channel map configuration then the core core could override the
params so that the channel count was clamped by how many channels are
actually being sent to the device - so if there's two TDM slots active
the device would be told to play stereo.  Would that work for your use
cases?

--JUUThYPLGgF4ELUJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIOTqAAoJELSic+t+oim9ITgQAIZwW/r6+XHX+0d36EEWa3uN
JQo7PbtBrrf4+vSLOTa+gxSjcTGO37voi6kGNQJJfL36kK4XRSZPunjFm8EeiVRC
JuMQpwPXBtOR5x/0DvBdVn8MrY+9qLMkNccOAw+J9tvNP07KpZTSQAnV+v//BxV+
DLpua2zhsO5dHnOE+up85DpJpoEXFwjmLcaUkht/DK98t1H+77DG3A7e+0rSddPe
347GtZgL9GUNEK9NrTkvYOMromAbij18r7LgVuKiPnj1UytnIdN5Tcn/t/3w/lMr
Y0HTZjsp8G05TZgmiKUSGY/3mBTd5Yaon5UHkWi6yglBKEbn64eAmRC+itdBHzPS
NxN63Uhsjpw4FH9z75S6iDi+IThYz7tif6xkHZzP5KGVHRNOAuGOdswYGkQmOyjJ
zkbL8LMPLuh5zjhT5in8PzbJUn7NbpgSPQBkXcdtoGQK5qy0E3cx/E1cU5pZ9pSH
LF1FjRBpAcInAeXkgC1djWNIWdqFLUOlM+fq6tD+sG06N5WF52BMWfJQZN9DPgMm
Gt4ImYACEekBQcu9SqEGeREqIOotjuleCA5RFANZw+1YWqskVNjmUpaHMYiz/qPw
Ls4qRpNwgz46Ok6cFg9bZPr6YbwqkfxlCcrRkzGIEo0I1YIWgbJZKX9KeS8Ks3G/
98L+zUreyxu+PMidvYhK
=lbHj
-----END PGP SIGNATURE-----

--JUUThYPLGgF4ELUJ--

--===============7077290047019212827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7077290047019212827==--
