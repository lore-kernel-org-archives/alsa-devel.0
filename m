From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: da7219: read fmw property to get
 mclk for non-dts systems
Date: Wed, 2 May 2018 05:50:06 +0900
Message-ID: <20180501205006.GE2714@sirena.org.uk>
References: <1525080203-18947-1-git-send-email-akshu.agrawal@amd.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E93BC@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4383235185703909080=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 558EA26762A
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 22:50:13 +0200 (CEST)
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1E93BC@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>, "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org


--===============4383235185703909080==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Content-Disposition: inline


--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 30, 2018 at 07:05:19PM +0000, Adam Thomson wrote:

> There is already a means via DT to specify the MCLK for a device using the
> generic clock DT bindings, and this driver already uses that. Should ACPI not
> have something similar to that which is generic, rather than adding device
> specific bindings/properties to achieve the same? There will be other drivers
> that will want to do the same.

There's a lot of things that ACPI *should* do but doesn't - it's a bit
of a shambles how ACPI standards get defined and what's there is not
really intended to handle systems like these semi-embedded ones.  One of
the big gaps in ACPI is that it has no handling at all of clocks, that's
supposed to be done transparently by firmware in the ACPI model.  What a
lot of the embedded Intel people have been doing is coopting the DT
bindings wholesale for ACPI systems but that has problems when you get
into areas which should be handled in some way on ACPI systems like
power and unfortunately clocks are kind of power adjacent so might be a
bit sketchy here.

--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlro0vwACgkQJNaLcl1U
h9CnAAf/VwTBy/ZB+foJzxfOU8xVz87nhic1tcWLDgNCiii2I9Cfik/BYvRa3iNF
MG2RsXxnHFmJEWt2bJMfCSpL8jPoc3zDpvm8vCVx3RHVHHJDzeD9Ju4YVIXf0Rzl
0YSW3hPQ9Kh5XiEl5bP35mRrzKKR0j2BJry7zKyvz79qKfg62NZFCfoEkUT622Ei
kK1DPkVo0laMTyRvx0U+s6U22tPPSQOetx9Gnajs3WGSbdg0Em2TQB6lp4WPG1U1
UT1EgDl8OQZ+jb2BPQXyIGsTd94k54JcrMhNrf3J+LyApPVr6XkJM8cNA2+OlPTd
vfR510l747ogAeMpE8LoyT3D0euZYA==
=Et4f
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--

--===============4383235185703909080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4383235185703909080==--
