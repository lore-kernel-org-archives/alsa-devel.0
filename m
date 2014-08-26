From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 8/8] ASoC: add snd-soc-dummy DT support
Date: Tue, 26 Aug 2014 11:50:28 +0100
Message-ID: <20140826105028.GK17528@sirena.org.uk>
References: <87fvgriqrb.wl%kuninori.morimoto.gx@gmail.com>
 <874mx7iqgt.wl%kuninori.morimoto.gx@renesas.com>
 <53F9A6EE.5070005@metafoo.de>
 <871ts4nmki.wl%kuninori.morimoto.gx@gmail.com>
 <20140826062558.GR17528@sirena.org.uk>
 <87wq9vmyyc.wl%kuninori.morimoto.gx@gmail.com>
 <20140826091120.GC17528@sirena.org.uk>
 <53FC5105.6070901@metafoo.de>
 <20140826094211.GF17528@sirena.org.uk>
 <87r403mtip.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e4yZxm10vOVuQa+Y"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87r403mtip.wl%kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--e4yZxm10vOVuQa+Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 26, 2014 at 03:31:44AM -0700, Kuninori Morimoto wrote:

> > > >If we're already specifying the DAI links for the (D)PCM code it seems
> > > >like we shouldn't also have to put DAPM routes for them in DT as well.

> > > Yes, and I think we shouldn't use anything except for datahsheet pin names
> > > in the devicetree routing, because otherwise we are leaking driver
> > > implementation details.

> It came from snd_soc_of_parse_audio_routing()
> Do you mean this function itself is not good ?

That's intended to be routing analogue pins to each other, not for DAI
links in DPCM - for DAI links we should be getting this information from
elsewhere.

> > While I agree with the sentiment for this when it comes to DAIs we
> > probably want to use the name the interfaces get in the documentation
> > rather than pin names since they involve multiple pins working together.

> Sorry, but what does your "interfaces get in the documentation" mean ?

If the documentation refers to the interface as for example "I2S0" then
the DT should refer to it as I2S0 too.

--e4yZxm10vOVuQa+Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/GZxAAoJELSic+t+oim9wtwP/040y/IQvV5KcOYlrzT3rhTq
1WY+OM5nCWAm3Tliq3l3C4bHS9LUSS7NWkor2ftK9IYeI7v0k+kSKzL88uUtogcL
qMUabr6UD30WY9j/7s5MQOR+sgw+48lMyObUADZ3mi5niflATWzEE4PuztAPR/oI
spijyWvRnIfdZqfAzE9N1A81B5+Y794PwFKeMHgo97lLGeGK99bDDHaTyNz8Q5ip
3paJVDwUF7Bqe8zBtLlv+9Qoz8GGDppUDjADLiKu8j5fkYGGcx6oNSOpfuikLyJg
y3Ktd3Xmz+OX5B6gM8aizU+joef5kFGK32N9jol5C720wFoJicGdWjcs8acJhbxp
8MTrEOdFOTzxhG0yD96DZwAw3Ae5+d4X5FMLNJOGdYdpBtuOQRc3xDtaDXbvq841
XwCSxS91juFaQ6IIsG7sk+6C7qH9jDHYxxtG9eZRHk3T0Sco8Zi1yzzsiMDNzHlD
J13g+AaRiJlHkjhk/0atQ4NR/QVco2p7P9hsv1w9raMvVCt6JKrwD7xQQ3lhISfS
90Rmx/y5paiqqa/qn8tUZ1KcPGGhJ6lSnvP2Mtp2bmCFMqBcTfYcMTUXn5rfkOGh
bms5Qbg0ZODk1BLHKcSsP+YpLIYeztd4m3Vqn524MCFkBzyI9PlKLOyGjOQ5huHs
BJ/WSv0INTk+lqgCXf1H
=t1PJ
-----END PGP SIGNATURE-----

--e4yZxm10vOVuQa+Y--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
