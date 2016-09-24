From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: cs35l34: Initial commit of the
 cs35l34 CODEC driver.
Date: Sat, 24 Sep 2016 19:42:31 +0100
Message-ID: <20160924184231.klxvwfamtqbm3ydb@sirena.org.uk>
References: <73bdbc44-4e95-41bf-a941-47c969686f57@EX3.ad.cirrus.com>
 <20160920142241.GU21682@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sxg7246dyebxt2a2"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160920142241.GU21682-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--sxg7246dyebxt2a2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 20, 2016 at 03:22:41PM +0100, Charles Keepax wrote:
> On Fri, Sep 16, 2016 at 04:48:40PM -0500, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org wrote:

> > +			usleep_range(5000, 5010);

> These are really tight usleep ranges do they need to be so tight?

Remember that usleep() will tend to pick the upper rather than lower
bound...

--sxg7246dyebxt2a2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX5skXAAoJECTWi3JdVIfQoLIH/ilhjGbgApVoNYyIZ7nOMnW0
RUIZ4RuqJDCBin2hlHAGrtYNECJ9N/giYOVi9oixPamfzSt6A8KdKnKIgbIP1fOS
fjzBqMVn2C5K3yd9ewRU2YT0eIqaRZlnml7qiPeLT+elgwPZOn68flNbInyn0xi3
i93OCH0EnQ6b6uoQo1EkJPPhi1rYlZGwsajgTomlwN49x0MTOHgdNbdp4uXiLTlv
fYQsiNrAufgApjnoj5SwB72rt8s8g4HCyr8DknrkuQ22ePo1d8wCeXL/TxG5E3sE
1J/cZcq6P2IGKl6tLakwr8P2p3DzYLoTzTS3Lp53hOMh7ppvBSxWHweLLPjVRaE=
=lfNa
-----END PGP SIGNATURE-----

--sxg7246dyebxt2a2--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
