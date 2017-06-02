From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] ASoC: cs35l35: Add multi-device synchronisation
Date: Fri, 2 Jun 2017 18:11:18 +0100
Message-ID: <20170602171118.4jikytasxphfjosx@sirena.org.uk>
References: <1495121559-1063-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1495121559-1063-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20170529135306.ldn74fwvfa4ots6a@sirena.org.uk>
 <20170530085138.GR1594@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z72kcepzfbm2ydud"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170530085138.GR1594-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--z72kcepzfbm2ydud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 30, 2017 at 09:51:38AM +0100, Charles Keepax wrote:

> These activate the individual types of synchronisation between
> the two stereo amps over a proprietary single wire connection
> between the two amps. The audio option synchronises the group

So we should at least have something that represents that single wire
connection in DT since it might not be there and so that the kernel can
make sure that both devices agree if they're synced or not and can
disable the sync if it's been enabled in error (if one of the devices
is off, you seemed to be saying that might cause problems).

> delay between the two amps. The VPBR links the brown out on the
> two amps and the OTW links the over temperature warning.

It's not clear to me when it'd make sense to disable these from a system
integration point of view.

> The issue is really one of it being use-case specific whether the
> amps are being used independently or in a stereo configuration.
> You could have only a single amp in use in which case the sync
> features are best turned off. Or one might even have use-cases
> with both amps where they are being used independently but at the
> same time.

It feels like if this is going to be user controllable the UI needs to
be pulled up a level to be something like an on/off switch for the sync
rather than a series of magic _EXT controls on the individual CODECs.
Even if it is magic _EXT controls having them being per device feels
wrong.

--z72kcepzfbm2ydud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkxnDUACgkQJNaLcl1U
h9DwbQf/RPXNfMDWZAXSNkxfwW8jhRBIn0ZQxNxPyA1L+ch9pP8izS7H2PJUHlbL
VGUlsfToBAMQz7NPjOdmxm5fg7VitjhGCMt25WxuPJ/c5mg0XJbB5IaoOW1AK6jx
szU76UGb2ZgHNUohca1+YjpjqEpXkGWycfQ05xBoDLzemnKeIG0YQYPcDg9EJjVe
EGQnwf6IXp0DCeYrdZ+a1oyx6OJck2aYmgfnG+VYX6DzV3Jtpx5On6a+aLRV07Yu
fbrVKtfNMjETwZmkjRXzV4qwoKdneunV0blsBJnEP0QiSGuz4wkii0ATYfdPQINw
cCvi69rIegmu66P4KjifLhW30ZqsVQ==
=jl+k
-----END PGP SIGNATURE-----

--z72kcepzfbm2ydud--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
