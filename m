From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] ASoC: rt5677: Convert I2C driver to
	->probe_new()
Date: Fri, 25 Aug 2017 14:56:07 +0100
Message-ID: <20170825135607.2n7guiipir34yojl@sirena.org.uk>
References: <20170824134110.63335-1-andriy.shevchenko@linux.intel.com>
 <20170824134924.uwzksz6ln43nurdd@sirena.org.uk>
 <s5hh8wxjarq.wl-tiwai@suse.de>
 <20170824154947.li6yke5vv5llcxhh@sirena.org.uk>
 <s5hziaphrof.wl-tiwai@suse.de>
 <1503594732.25945.90.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4667369475381168065=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 74CD92673DA
 for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2017 15:56:13 +0200 (CEST)
In-Reply-To: <1503594732.25945.90.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4667369475381168065==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jldhwcrmueti3keh"
Content-Disposition: inline


--jldhwcrmueti3keh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 24, 2017 at 08:12:12PM +0300, Andy Shevchenko wrote:
> On Thu, 2017-08-24 at 18:11 +0200, Takashi Iwai wrote:

> > If we want to take back old i2c ids, better to put the explicit
> > i2c_match_id() check in rt5677_i2c_probe() instead of sticking with
> > the old i2c probe callback.

> Well, there was never user for rt5676, thus, platform code can use
> driver name to register / create platform device to be matched.

The driver handle both rt5676 and rt5677 using different IDs so it can't
just rely on the driver table.

--jldhwcrmueti3keh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmgLHYACgkQJNaLcl1U
h9DEawf/S03q4u1K97fYZH9SV7Xdl0GQNLRMX9E32xzRr2kFNFnfMCwnOUB4JajS
XUWfBXyBMTInPuitPrfw8qY9wpmPxGZybAosv2IuWPTsuNruLKX2BcLJe+EN6Ccb
PQ7PiQJAurDgWSWXfRUtIAC5pfrfK1FhJqrDiHhFusd/6d+OuH+slVrRjYZXm3zQ
JmJnZNizyst81WlHdmWxFjehjTdBXivn2EI8lAz3RzYeRDmNIUKFWFqDAdTQSMp9
crQpKmnt0/Vl4RPuvvZKagn/8sCiH1o32q8YytE/dljG7IEzr4q9dq7iP+VmdZO5
tquxB5kuZn5DfZfbSuN7ZUYzPK3lBg==
=Qs+j
-----END PGP SIGNATURE-----

--jldhwcrmueti3keh--

--===============4667369475381168065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4667369475381168065==--
