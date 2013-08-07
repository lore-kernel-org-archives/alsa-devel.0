From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ALSA: Added jack detection KControl
	support
Date: Wed, 7 Aug 2013 17:45:09 +0100
Message-ID: <20130807164509.GO6427@sirena.org.uk>
References: <1375430365-13232-1-git-send-email-eu@felipetonello.com>
 <1375430365-13232-2-git-send-email-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0082010545086669891=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A164A2617AB
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 18:45:12 +0200 (CEST)
In-Reply-To: <1375430365-13232-2-git-send-email-eu@felipetonello.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Felipe F. Tonello" <eu@felipetonello.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0082010545086669891==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y8OL7jWO5wDKNv+B"
Content-Disposition: inline


--y8OL7jWO5wDKNv+B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 02, 2013 at 12:59:24AM -0700, Felipe F. Tonello wrote:

> +int jack_ctl_integer_info(struct snd_kcontrol *kcontrol,
> +                          struct snd_ctl_elem_info *uinfo)
> +{
> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
> +	uinfo->count = 0x10000U;
> +	uinfo->value.integer.min = 0;
> +	uinfo->value.integer.max = 0xffff;
> +	return 0;
> +}

I'd expected to see us creating multiple boolean controls here.  I don't
have a great problem with doing things this way but it's surprising and
I worry about confusing existing userspace, Takashi?

--y8OL7jWO5wDKNv+B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAnmSAAoJELSic+t+oim9xlAP/jcfusQyOPfpS8ZiyFFu4MI+
oJmwHwCy4YQTrcexZwyELF5SGy1RLUEShzuBkdPKJO3Wtq2PoWvzdWX0L2r0rus6
YkFo/tW/DHDeGjUOvojTw7sDTCyNxrjDMzB6eGo7RJEB45eL5cyZTZcxSAoGsOfi
CPpsk0gR+QVo8znl3yqGe64shlVIzRkwiuzUK85XRrWnbOtNe0FelHYLFvjjgEA0
CTqaq1dvO21t5Rcyt7U2JWpfQBieVRbUqTMtLPCYu1+SqRrvUqDKjSPKVZYy0h5n
ZvTTnQsYUBl81Sb1i32u5ZKZOUm1xHEhRonEqRlaxflaeUGQnUe129KhhIYjKGxa
sxEI8/Dt6ib/vQE6eAv05zgLFdsch5el62SnT9xCt/zQ6iUsiByNM+CfGAU0a9+G
Bc8Paj4gskpayco6Iii6XWVxcRnvVROXxVpj1NE9VwFs8BJ0QDu0DA85setL08Xk
55/FT7fFw6NwNZp+HSXkm3nFRr7FQJFnmU+Qk2UdWbC/Fhlk7G5butAn24liUKyL
ylAMbpWw628RcBCw8Xjc9zT8jtH+JxxiD04uJGpZpVf5dks/r5Ml7qUqDc605SGM
/12n/kSHpAD35QivLtjTTe/NtaBLttzcLRr/zTTrtEOz1zquUCnxakETrE+taQrt
sUH1X+nkjp8iPj6o1ES1
=GkSd
-----END PGP SIGNATURE-----

--y8OL7jWO5wDKNv+B--

--===============0082010545086669891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0082010545086669891==--
