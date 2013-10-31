From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v3] ASoC: simple-card: add Device Tree
 support
Date: Wed, 30 Oct 2013 17:31:56 -0700
Message-ID: <20131031003156.GY2493@sirena.org.uk>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
 <87txharb3o.wl%kuninori.morimoto.gx@renesas.com>
 <8738oiog00.wl%kuninori.morimoto.gx@renesas.com>
 <20131003104248.GI27287@sirena.org.uk>
 <87fvsh2966.wl%kuninori.morimoto.gx@renesas.com>
 <20131024171758.GA2461@kartoffel>
 <20131025131357.GB12932@sirena.org.uk>
 <87sivjk2xj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iIOavGAISvUeFFLW"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87sivjk2xj.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--iIOavGAISvUeFFLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2013 at 05:39:17PM -0700, Kuninori Morimoto wrote:

> I had sent v4 patch, but I removed simple-card,card-name on it.
> But, as Mark (Brown) explained, I think simple-card,card-name
> is very helpful for users.
> I can send v5 patch (with it), or incremental patch if we can have it.
> So, I need your comment

Let's review the existing bindings as-is unless there's a need to revise
for some other reason, it's easy enough to add the property back later.

--iIOavGAISvUeFFLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScaT4AAoJELSic+t+oim9TAoP/RMjpRpde/iFCYyhdzUpxiyv
H/bMmFHrHPuuiYttEmUiJxwe+90LiMVLJRcbQcVnJRHb6g3RbVNaNoQ5H786+zqQ
KlcLgIyF5IUvlfvCSuzUvBVTJffMzmdsc07qe11iDHG5DgwvfSHq9CfvJNIL1DEy
6p4HK7rY2EdRMZrnjF3byQ3b5f+9HcSiu0XEwyk2b8VZ49TV0Nv8iH1xuSxr/iQv
ie22+qhsZIREbzkYCqE0ZkiT9KOE/jXn+xz2OriYilJEIkdQmETSGmDBcQdiBlaI
dCm7jR9IO2Z6zTRNssIJP6FqG9DxFEY2B/EPq5nZsCksmYSTQxiUQyAOvlnWk3zJ
NnwHIO6ODK8mUxx/3n9rW7w+gIaIN7zRjrb1YT0a8zTzVfEe4ktH3DHT98EcSsk+
yM7vbUZEdxsM9vFTNy2SHsGpJ3CGMPQ4OGBYu73OxlgIZatzo3HxUqyamNTCLGHk
zYdSyL6vKz5JZb0fSudlujcr1OnXk1L6IvooxWI1swuPD9/3D39tQCJ31PNGqOBV
TB31xAIJRscSVgtPYTh+Ye+an4ttAispe2ATvZgP7jQufFaf3OzekLhV1RLgDWd1
3lm4j19ZMI4+lCc7KP67HTwHirVdmOns7kJ5hPnm00VF6BYjTHqrSNRj2ueuDO+X
Y7YISX+I4i/xtbMufVCk
=YbBh
-----END PGP SIGNATURE-----

--iIOavGAISvUeFFLW--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
