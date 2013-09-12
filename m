From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: codecs: da9055: Update driver name to
 fix breakage due to pmic driver with same name
Date: Thu, 12 Sep 2013 22:58:10 +0100
Message-ID: <20130912215810.GX29403@sirena.org.uk>
References: <20130902103843.GL3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E612F5@SW-EX-MBX01.diasemi.com>
 <20130902174121.GV3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E6157D@SW-EX-MBX01.diasemi.com>
 <20130904183405.GX3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E61991@SW-EX-MBX01.diasemi.com>
 <20130909112643.GX29403@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E630F5@SW-EX-MBX01.diasemi.com>
 <20130910170724.GU29403@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E634EF@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eayjU+2cFWOKR49Y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A033751E634EF@SW-EX-MBX01.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Ashish Chavan <ashish.chavan@kpitcummins.com>, lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>, David Dajun Chen <david.chen@diasemi.com>, linux-kernel <linux-kernel@vger.kernel.org>, "kiran.padwal" <kiran.padwal@kpitcummins.com>
List-Id: alsa-devel@alsa-project.org


--eayjU+2cFWOKR49Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2013 at 05:11:06PM +0000, Opensource [Adam Thomson] wrote:

> It's limiting in as much as it's insisting on a required order for
> initialisation which shouldn't be there. As said previously they're 2 separate
> devices in one package, with no internal connection, so either could be
> instantiated first. It should be open to the user to decide on this based on
> their platform and needs.

> With your approach, it is more work for no gain here, and holds us to a
> logical representation which doesn't fit with the device in question (which is
> not really an MFD, it's two devices, one of which is an MFD, the PMIC).

I'm having a hard time understanding this as a practical limitation, can
you be more specific about the cases where this would present a noticable
problem?  It'd at least ensure that the configuration where the whole
device is present gets tested to some extent, though that doesn't seem
likely to break again.

--eayjU+2cFWOKR49Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMjjvAAoJELSic+t+oim9iZgP/AxCOYz6PCLDR1eE5NyvGQms
WtrGxuM3R7pOwx7/tMviL6OjCeE1kiQqZUNi9E8UKC9+V2jtdy5wDE6+8mEl9zrH
OkRlKntL/uVc38uVH3JzFLcbW8mey5OXs5GJAZjKGu5RhjywNjEB8ggOKuNVYkAJ
hTw9ovgYe+kLM76YOtiwz6bQ8Nd6wds8dIXlS9336vf44SMZiM+Cff8n7mXvq3M6
u13GP3/VSMs5b0omVgmS8y8cV4ihtQoRe8EOFoQEumqqA8q5e4TqA/9Lqs2v19I1
WQa/2Rk7gL5wnff4VDRvzF/4QyGCLmHpU+f44dJErpS8oaYeOFMgtKkkQVkNL4kv
XMJXAzthXR8+7ewti/P3idyWo+E+R/kZVSTf9AnFswoRVihxa9VnAfTuizLT05Yw
5CzMIKFllwh2Sh/YVWuuMDBDa2g+CGvgRMFDEPyhvIDOIT3MwcbjXlCcP0pWr3UG
8aUOfXLUw0VXvn1xU9umluLR3l6tH+SvBvdqReu/Mw9ahL0SMmeKM7FnmBKcMfN4
IDuxp0leEIfWNGmao/eYMdQVGImUrw6RJEQMkg93dibTxtdvwh0UinBI+qS+2C73
9cMnaOhWpMUu0XVon1xDnMtLVOKgflUbmPQNmnKKQhAetrfybI8rVdH7xdIpRUsJ
C0CVnRx2CUiv+hNcIObu
=vGgr
-----END PGP SIGNATURE-----

--eayjU+2cFWOKR49Y--
