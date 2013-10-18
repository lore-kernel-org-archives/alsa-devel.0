From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: kirkwood: add S/PDIF support
Date: Fri, 18 Oct 2013 01:34:39 +0100
Message-ID: <20131018003439.GG2443@sirena.org.uk>
References: <20130924124122.64834b2a@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tPwux3QCgxkzM4Gx"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130924124122.64834b2a@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--tPwux3QCgxkzM4Gx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 24, 2013 at 12:41:22PM +0200, Jean-Francois Moine wrote:

> This patch adds S/PDIF input/output for mvebu DT boards.

This got less discussion than I was expecting and then slipped under a
lot of other patches in my queue while that was timing out, sorry...  in
any case, this still has the issue that it used a single DAI and a
single DAI link to represent two physical DAIs and their links.

Please as covered in the prior threads on this either implement DPCM or
implement two traditional DAIs which can't be used simultaneously (which
should be simpler and can then be built on incrementally).

The last set of DPCMish patches was reported to work so should be a
fairly small refactoring away from being OK - the main thing is to
create back end DAIs for the physical links and then put the widgets
that manage the enable of the S/PDIF and I2S interfaces between the FE
and BE DAIs instead of directly connecting them to widgets on the CODEC.

For two traditional DAIs it should just be a case of duplicating the DAI
with a differnet ID then setting the enable bits based on the ID of the
DAI in use and ideally adding some code to check that they're not both
active (or that limit can be enforced by only having machine drivers
that use one or the other).

--tPwux3QCgxkzM4Gx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYIIcAAoJELSic+t+oim9TGMP/A1E9YB6IawqUiVErkoC/l+g
warTiBPhWiLXzmPC2PEBs8l2++S2VYpS7cVnSMVHkciddMTJTSCZ3dy8Za7700Vl
9E3c1UjJYJhljKzziidX8DTMwz2krcZtZpuSIsuYBTgRDP5E6b+8oT3JyezVqdE+
OYyLrLkz4X/M/nWdMV62rFkLxMQEsle9Ck8IxJVKdJPm/p+QiWtSlqLGzR5BVbz6
IcxJnb6WoLgR30U4bcxluvocX3xMlaq4kVsNdRlvt/G5Hzafag/Y6H8VPby2MBjo
pvLbwWwUNcCACkbwTRXFfZ/aVD7fBP2OY07qE14HHD/1mOv1ZD4nLcD31h7C8ioW
t8FYxMho1j7KCydaF7ZV+JovRlbRPxm05fiDTH846XbSBRRM/wAeMMBQxhN1tLpr
RdIHnSDsXivcLKAmf7ypyIhBG2ApRpEsJq/QU6l820aVWVnMeNhxcke09PnSBKci
XTS/kzKEkfjsIhTrGCCWP79W/qniOyhlreVCZPnry79ZjuPJrb/89JzK8DlMwNRy
UCwdl5lM0AbKOQlZLl8MIZNQS9ck5+Ja3RT6/ebNx72D+Wyj+IhQE7OTBZLXVrdY
Z+afVitblo+EaJ4dUVX2KxJSby9wkfdyVTu/M0evZ4qpuryPsN09s6dMUdEmIXOT
JW4VyI4OG5F7//SJDgBo
=0rnc
-----END PGP SIGNATURE-----

--tPwux3QCgxkzM4Gx--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
