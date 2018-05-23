From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC/RFT PATCH] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Date: Wed, 23 May 2018 09:24:24 +0100
Message-ID: <20180523082424.GA4828@sirena.org.uk>
References: <20180522165842.233949-1-groeck@google.com>
 <fb9aebba-919a-2e80-aec7-2fd44e5e1861@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2027382403483973457=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C7B60266F88
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 10:24:36 +0200 (CEST)
In-Reply-To: <fb9aebba-919a-2e80-aec7-2fd44e5e1861@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Guenter Roeck <groeck@google.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Chintan Patel <chintan.m.patel@intel.com>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============2027382403483973457==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 22, 2018 at 02:59:35PM -0500, Pierre-Louis Bossart wrote:

> I am also not convinced by the notion that maintaining topology files is
> only a userspace/distro issue. This would mean some distros will have access
> to the required topology files, possibly enabling DSP processing
> capabilities, but other will not and will not be able to enable even basic
> playback/capture. Just like we have a basic firmware with limited
> functionality in /lib/firmware/intel, it would make sense to require a basic
> .conf file in alsa-lib for every upstream machine driver - along possibly
> with a basic UCM file so that audio works no matter what distro people use.

The point here is that people should be able to update their kernel
without updating their userspace so things have to work with whatever
they have right now - anything that relies on shipping new firmware or
configuration files to userspace is a problem.

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsFJTcACgkQJNaLcl1U
h9AS4wf+NiCBQ9NPvTyXDKTk07Ae2ufTmBc4iMUvFK5il01eXr02pmf2FtRRodk0
M9R1BVCtmPBDeruSIAbnA9x+u6SUxWwszTbDp6AL5p7oz5VjyJ9o9XBcWcvXKivy
iB3uIommTHeY+9ESd3HBO7SI2UfZtgpVxa9pqYWpIlUyjpeAq7UwN34qbqdmuRu4
tm8n3//+hp09MfiixFoWmOdfbNPIh8iz4sPYSzahAYZ7fYgN355eOE4yLDuZPB08
DsXRyGBqHWD3uIaleZXIvyatKjyJI1uLpS8xb+E64ntcblwh8ph7rrf3Ojb44PCp
6FXCx4HBw1TNTzECC11WsQ8FvZt6Cw==
=m9Pa
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--

--===============2027382403483973457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2027382403483973457==--
