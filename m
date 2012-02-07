From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add default config for tegra-alc5632 (as
 found on paz00)
Date: Tue, 7 Feb 2012 13:13:39 +0000
Message-ID: <20120207131339.GK3332@opensource.wolfsonmicro.com>
References: <1328561498-19337-1-git-send-email-fercerpav@gmail.com>
	<4F30BC18.3040102@nvidia.com>
	<CALq1K=+brR4OgPzfANKTFDoD-8Pbm0WjwXH+ZzShHvkGg6ntwA@mail.gmail.com>
	<20120207125404.GD11313@home.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2010714748790168590=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120207125404.GD11313@home.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Fertser <fercerpav@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patch@alsa-project.org" <patch@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Marc Dietrich <marvin24@gmx.de>, Oliver Grawert <ogra@ubuntu.com>, Leon Romanovsky <leon@leon.nu>, Andrey Danin <danindrey@mail.ru>
List-Id: alsa-devel@alsa-project.org


--===============2010714748790168590==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g4MvFqI7wmANiPDo"
Content-Disposition: inline


--g4MvFqI7wmANiPDo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 07, 2012 at 04:54:04PM +0400, Paul Fertser wrote:

> Since alsa-lib config file describes how to best deal with the
> combination of chips rather than a particular notebook name
> (especially given same device can have different names from different
> vendors and at the same time some vendors are ill-minded enough to
> call different devices with the same name) it would seem more logical
> to stick to the chips' names.

That needn't follow - especially as you move into the higher end the
devices get much more flexible and system concerns have a major impact
on the configuration so the board in use becomes more and more
important.

> Mark, do you have some idea how to solve the issue at hand (having
> dmix on this netbook by default) better? Is quantity of maximum
> simultaneous playback/record PCM streams already queryable by the
> userspace? Somehow it happened that adding per-device config file was
> ok during all these years, is there a better way now?

For almost all devices there's one stream supported in each direction,
if we were assuming any default that'd be it.

--g4MvFqI7wmANiPDo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMSN9AAoJEBus8iNuMP3dIW8P/1Abuu3JkPUjwn7tbKxTQD61
F/HIw0NmK06fvRqCiLAG8AlGdwrCZKo8a15BQsucLH1t5Wp98set8EQ6upg+gw+o
pN1leRycT0+nThrqgO8N/fV9EO1wAFHt5e13fpyh30DBfsHMTBB5nZvOzwv4got/
DgOv8cIZEKDBK6Iea2H7Jj4783RjFxZrZTQ8ES5LZMHM3hNk2DUopw29NxWx6k6c
/N6savrAL8BWjOmcW7SFIT8WUji00Y0Vk5Yn7tks75sZV82cCs+4haZXWiOdwEc5
LsTpWnVPgvsjw8W3Y7s7fhFW3/HKxk1M9PczAn5uDOK54MNryh+X/rFGSc59spQ5
PW611yeEGw/IGqZODcz4t6yhuoyGxzWRvQ6rMRFx/DTaGE8E7Oi5MNJVxQYOKmRY
37ETBXNnwAoctSxUwifHE3Usrn+Rj3BV2onwaeWzX+gWgSGUgiyobqH67VDBoBz2
TTzcNE8aTcyQEU9ajdFZ5TMKYwrqr0uBu+BvBrpngQSRoiV4djl3au3RHQiuT3Nm
b02/2i32363+vDByHiDf9rf6oibQ2AR4Sudhq49TeyaL7glv2d31EVrEBqfXu777
Wv05VRxQxz4i2sHhAmHjFOZIBC7G/G0fbW4Nd4eSCHrbZEUmk0NHTmv1fjsjnSfO
4z5wAcgcxOjP54PyKze+
=nFEb
-----END PGP SIGNATURE-----

--g4MvFqI7wmANiPDo--

--===============2010714748790168590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2010714748790168590==--
