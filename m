From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: codecs: Add da7218 codec driver
Date: Mon, 9 Nov 2015 14:02:25 +0000
Message-ID: <20151109140225.GA26072@sirena.org.uk>
References: <cover.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
 <01a9b6e96b66327cf9a27781c13aa50545380acb.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
 <20151105152736.GO18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CA0C@SW-EX-MBX01.diasemi.com>
 <20151106112141.GE18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CA3D@SW-EX-MBX01.diasemi.com>
 <20151106115451.GG18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CAAD@SW-EX-MBX01.diasemi.com>
 <20151108103429.GC6746@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CC6C@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D460CC6C-68WUHU125fLLPO1uwJ3ImwLouzNaz+3S@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 09, 2015 at 12:28:39PM +0000, Opensource [Adam Thomson] wrote:
> On November 8, 2015 10:34, Mark Brown wrote:

> > What I'm trying to figure out here is if this depends on the audio
> > routing at runtime or if it's got dedicated configuration?

> This feature is available for any/all mics connected. Which mics are enabled
> is a runtime configuration of routing, so to me it makes sense also that we can
> configure which channel triggers an event, based on our scenario at that time.

The general userspace expectation is that the detection is always active
and consistent rather than varying at runtime - runtime variability
might be a bit surprising for it, and even then variability in what is
detected based on other settings is a bit surprising.  If the hardware
is that limited I guess it's about all that can be done but I'm still
not clear what the use cases are for configuring the levels (as opposed
ot the routing).

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWQKdtAAoJECTWi3JdVIfQukQH/0UPcE6SnYsX8OCuFbuTTYqV
xq8SW6lLVQnx2AavoQVlPu9bLvOpD73XzvI738Emh8DysF+kSWnxrVHhTYOkykoG
uDYRm+LLoN0BFWDZ0pYHURgMotu3qr7xO2x3duO/serWwxcZIn1kIuHLgw/ygjAW
eriSr9tzUYEm8Cp/actPWLBmEpfhrrQqg4RJYluJezW7OPYTOMCirdMzGCnr+7Wq
8+gBn6bkkq9i7BaPCPIWGrib8eoakI6WihIYkKtSz5Zhxfq6AVPw9mhVlJ9EMvyX
Rb52Ox7KkDrookIqtWf/Imrs4PQNvS3olLX6EUnr2aimUA58zVh0xXx2dB5GGwM=
=g5xJ
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
