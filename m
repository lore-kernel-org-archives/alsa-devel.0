From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] ASoC: wm9713: add binding for WM9713 codec
Date: Fri, 26 Feb 2016 11:30:21 +0900
Message-ID: <20160226023021.GH18327@sirena.org.uk>
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
 <20160220171459.GA18327@sirena.org.uk>
 <871t87z1gz.fsf@belgarion.home>
 <20160220195925.GF18327@sirena.org.uk>
 <87twl3xgud.fsf@belgarion.home>
 <20160220211659.GG18327@sirena.org.uk>
 <878u2fxbp9.fsf@belgarion.home>
 <20160221014920.GK18327@sirena.org.uk>
 <87povkuuf6.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VtO80Grm6b12p/hj"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87povkuuf6.fsf-4ty26DBLk+jEm7gnYqmdkQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--VtO80Grm6b12p/hj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 26, 2016 at 02:33:49AM +0100, Robert Jarzmik wrote:
> Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:

> > It will not be called, the generic AC'97 code will be used.

> Ok, if it's not called no code in sound/soc/codecs/wm9713.c will be used, right
> ?
> In that case wm9713_set_dai_clkdiv() will never be used, nor will the
> wm9713_audio_map or wm9713_dapm_widgets be created, which will break all
> userspace programs relying on these mixers and DAPM routes.

> Or am I missing something ?

No, you're not missing anything - that'll be what happens.  If you need
to preserve the userspace ABI on your board you'd need a much bigger
(but very welcome) refactoring of the AC'97 code to be less hacky and
use the device model more directly, or at least define a generic AC'97
binding somehow.  All the AC'97 support has never really been properly
moved over to the device model and unfortunately nobody's yet cared
about it for device tree except in the simple cases supported by the
generic AC'97 code.  I appreciate that this isn't very helpful, it's
an unfortunate consequence of DT as an ABI.

We probably want to end up with something like what the Intel folks have
been doing recently for HDA to get that working within ASoC.

--VtO80Grm6b12p/hj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWz7i8AAoJECTWi3JdVIfQaKwH/2m0pvEOAFpEjx5yvY52W+n3
1xYPCTbV6Xpn+d3MH8K3CODOczpnFSSX4IyCjkenU3K9JCOL+dCCbeskcOUGyEgA
WLhDRp9j3TivCHf8YC6YlcARp8ntLBBzZxOvf64QdOrZ+GZ0dGd8dUOlEHaFnN85
X2Kn0DuT9i1X2l1BNrn4bTBbcBvAe8w5B+Be5YdEqcrcnomJiyuqTMpzkatBnJ/5
+x9ONK1px1GoxHvMK9/UMcYMs/QgQ1Rpvnvup2Gc1Cerf3OHLqK31JRC0pimIXZi
Wb80ujyZXnw0zVngkjze2A4Ut2tpfKp0P6/xpaxduWcrf+CQdT9Kdqn5UwpsagQ=
=7r+0
-----END PGP SIGNATURE-----

--VtO80Grm6b12p/hj--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
