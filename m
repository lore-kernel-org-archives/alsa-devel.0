From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Use less aggressive caching to
 ensure correctness
Date: Tue, 6 Nov 2018 17:18:45 +0000
Message-ID: <20181106171845.GF31950@sirena.org.uk>
References: <20181105111912.14464-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8595648966537034064=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B3FBE2678F2
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 18:18:46 +0100 (CET)
In-Reply-To: <20181105111912.14464-1-tzungbi@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tzung-Bi Shih <tzungbi@google.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, dgreid@google.com, lgirdwood@gmail.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org


--===============8595648966537034064==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TU+u6i6jrDPzmlWF"
Content-Disposition: inline


--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 07:19:12PM +0800, Tzung-Bi Shih wrote:

> +++ b/sound/soc/soc-dapm.c
> @@ -2722,7 +2722,7 @@ static int snd_soc_dapm_add_path(struct snd_soc_dap=
m_context *dapm,
>  		dapm_mark_dirty(widgets[dir], "Route added");
>  	}
> =20
> -	if (dapm->card->instantiated && path->connect)
> +	if (path->connect)
>  		dapm_path_invalidate(path);
> =20
>  	return 0;

The whole point with the instantiated check here is that when we
instantiate the card we're supposed to go through and redo all the DAPM
configuration for the card in one fell swoop rather than having to
constantly redo things while we're building up the graph.  If that
invalidation isn't happening then we should fix that.

--TU+u6i6jrDPzmlWF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvhzPQACgkQJNaLcl1U
h9DHGQf/eoud7SLinHkEdgWGwXt4r4xNW/ix57pZcWjEam/4mR8gqEYj4+iCQmUR
/VaEMmgVWUOaclKeA9PMHQKU9vN+m/XkWCU2463EYXqVJjs0N6UuPw3ar/mg58RA
Kd4mCuLF31ux6rJY5wd3XOX73acMX2TTGPAdRYIruQjAhMxgOkDm4i0HSRr/UszI
JcDdOTu6H/UrbH80L4VQWplLEV/vz8lWCcpg1Aw7lINnOXxZhJfkIItUZ91aDzVH
kmxolw1P+9w9w+0gT9v6mpFuYDlpB58TO1au6mOaVQPxeU2tnDBnmY9X5OdyNkpJ
5/4pFor+9Kga5nwz5mtCtxogzjXy2Q==
=0UdI
-----END PGP SIGNATURE-----

--TU+u6i6jrDPzmlWF--

--===============8595648966537034064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8595648966537034064==--
