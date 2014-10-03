From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 4/4] ASoC: tlv320aic3x: fix PLL D configuration
Date: Fri, 3 Oct 2014 16:08:07 +0100
Message-ID: <20141003150807.GD24441@sirena.org.uk>
References: <1410854903-26419-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1412342336-25700-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1412342336-25700-5-git-send-email-d.lavnikevich@sam-solutions.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412342336-25700-5-git-send-email-d.lavnikevich-H6HfJ9slvY0Aspv4Qr0y0gC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Lavnikevich <d.lavnikevich-H6HfJ9slvY0Aspv4Qr0y0gC/G2K4zDHf@public.gmane.org>
Cc: shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 03, 2014 at 04:18:56PM +0300, Dmitry Lavnikevich wrote:
> Current caching implementation during regcache_sync() call bypasses
> all register writes of values that are already known as default
> (regmap reg_defaults). Same time in TLV320AIC3x codecs register 5

Applied, thanks.  This should really have been sent separately to the
other patches - it's not in any way specific to the board and there's no
dependency in either direction.

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULrvWAAoJECTWi3JdVIfQtooH/j0VRfy0vVnHUBnkWD8aN55h
H1Mn+9YdAXAGhgyq23BlFndWvmxRvDpj+CwN6vQpQTkn1na4QV9Uw3QKCdP22hBm
ZUi/Y5BXkmi8dn5L26w0WPcV6/gfwSkemCy3WVPVlb1AFg1W8lkdfwuWlW26yxO2
shuK8KXJ/BzNH8/N0fDi1aZcimpnxWVOBiYmJcpQc+BmNMm6kMPCNNHwTwq+Ij9h
oePetN3sBFTm+n/X6tLV7t7nai11O/SWdAYt9/WmVXpCHGXIctdpYtLJ5fDWwocw
dB2bWHbm263tVElpHhlKnEunGmQ0eGWCnmAbD3TS+FIZRMapq5AHuWdM808QYL8=
=m9N/
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
