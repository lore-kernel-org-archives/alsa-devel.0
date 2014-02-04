From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/5] ASoC: tda998x: add DT documentation of the
 tda998x CODEC
Date: Tue, 4 Feb 2014 18:12:13 +0000
Message-ID: <20140204181213.GO22609@sirena.org.uk>
References: <cover.1391274627.git.moinejf@free.fr>
 <8e4231b7a55802f58a14dd07ac5cd8b0babb1dce.1391274628.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e59cmCxsGlzMyaN0"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8e4231b7a55802f58a14dd07ac5cd8b0babb1dce.1391274628.git.moinejf-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--e59cmCxsGlzMyaN0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 01, 2014 at 05:48:49PM +0100, Jean-Francois Moine wrote:

> +	- compatible: must be "nxp,tda998x-codec".

It's not clear to me why there's a separate compatible here - as far as
I can see this can only appear as part of one of these devices and
there's no addressing or other information that'd account for chip
variation so I'd not expect to need to bind this independently of the
parent.

--e59cmCxsGlzMyaN0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8S16AAoJELSic+t+oim9eOIP/AyusIviYZa8U00UwCEjbhBb
O32EjirGkgP7RFqbsaVN6u3nudovMhGrwEs7AGX/gB0Y37YA92bJVj4k3PkmrEiV
e9qFEEgQSSfTsrZ0c6vb/QdgRkdlKFl5WD8YX8JzhocociiRyok0mFJBVCESGbkv
cRWnlWTR1S0WPoQj/KCeky/Mqjfn2x9KK1GaKnSEb9QfxXLvaLfpFmsF3ufWhkr4
y/LQ20xPO6YgpgUUxe44OeK2G3YfUDTw0biMjMJrL9x4GyUv0dnSkQhP8dntG4iu
mn+xu6y7u1vBTcB41+FrbsdZAYIsOV4iK93ynjQOMSPtb+fj+ukg5BuYxyz1fkPR
p62RBBz9DfdINtXwQdiYDMTSgEl9Da7r/6vs+RNsaVrgSWThm/qHY6kDpukP/r3y
68pxxXhzExxSN8srmWniMY1nKAx046SK6NJ0YRfs9pnjelYu5m7u67KMgJysbcBz
1Wcd0Yva2aaGfkzcikeEFmASDZxgX0Alh5GzSJ5MLqjatGFF7QBG6ReHLUMMjWlk
Ydw70uDkSbpKsJHE3pO5FNDj9+bd12wM92HP5t1w1hpzvR53PZGBknOVWzevRL8L
NA9aTEZ3Est7UnfwqVHW/xIRuqUClHn0cnYzfnlldGmEoD2Rpo9SKMxx7zxQwpUc
asguWWttm5sdpHL5eHxZ
=AI7n
-----END PGP SIGNATURE-----

--e59cmCxsGlzMyaN0--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
