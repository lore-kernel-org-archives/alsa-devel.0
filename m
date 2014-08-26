From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 8/8] ASoC: add snd-soc-dummy DT support
Date: Tue, 26 Aug 2014 10:11:20 +0100
Message-ID: <20140826091120.GC17528@sirena.org.uk>
References: <87fvgriqrb.wl%kuninori.morimoto.gx@gmail.com>
 <874mx7iqgt.wl%kuninori.morimoto.gx@renesas.com>
 <53F9A6EE.5070005@metafoo.de>
 <871ts4nmki.wl%kuninori.morimoto.gx@gmail.com>
 <20140826062558.GR17528@sirena.org.uk>
 <87wq9vmyyc.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jsNFkiRwgzQUdnk6"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87wq9vmyyc.wl%kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--jsNFkiRwgzQUdnk6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 26, 2014 at 01:34:21AM -0700, Kuninori Morimoto wrote:

> This patch expand route setting by using DAI name.
> You can select "ak4642-hifi" side "Playback" by below.

> DT
> 	simple-audio-card,routing =
> 		"ak4642-hifi Playback", "DAI0 Playback";

> non DT
> 	struct snd_soc_dapm_route route[] = {
> 		{ "ak4642-hifi Playback", NULL, "DAI0 Playback"},
> 	}

If we're already specifying the DAI links for the (D)PCM code it seems
like we shouldn't also have to put DAPM routes for them in DT as well.

--jsNFkiRwgzQUdnk6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/E81AAoJELSic+t+oim9mEoQAJC04zxQkyEU8l/ZpgqJzQC9
tB+8SY7wEU/JhTraaaD92BckhtnQiL0JWWy+DU15KSvsWBFBqgWZmTFQC6o1zZAk
wjSMOrRfrn0Cb4AOpH0+1mnp+Z48IGN8sUDtb0tOTClJGSHDS9V1fVccEPmfOsXA
lI9bcfF8MuHMZW86zEWz+cpDjAOYTSBzFnwg1ncjIjQEne+ImO08scUMr5vvxGtu
IDkpArSSnhoekbOmPt5kKLZL/z+NRyRnxd68S0AWNzg9efhIl+4v/wLPxY8LaR2A
EjNvw/wl6qE4No+l7T3/FlboW7+6Htm0R/db+32667bUsFVw6eGPxzk23/WlyQGD
ki8N7/TRhVol0ueEmjnfAqZVNFaJlVmHOTDXnNI0MdHxYf0s1v+LkS4R8p8A1QqD
bwi4mbH+d3CpcOh+1G4Z1HGLjvJ1a+CgMx/mEwZXrb66bJOo3W0D1lNcWyGpCKmh
AInH9gajms98GZDSLmddK07HY9QShdTmyC6IjcjPX2ryDBgQhPNpDOKdZHHdl2pl
xF1eLbC4IL5Nem7/0nxWGNG07AzmQa4LIwlu8RkBq6likjWsQzp7O7cC+cvmENzT
cVfZNwmsC64WsJnbvqOXdgYBmnK99eJzu20taXH7Wa+T6YZb7/uFYlqrovce+EZu
rcy35tJd1lkHIqSu4YoV
=7uLH
-----END PGP SIGNATURE-----

--jsNFkiRwgzQUdnk6--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
