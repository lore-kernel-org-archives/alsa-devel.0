From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 06/16] ASoC: Intel: Skylake: Add support
 for Load/Unload IPCs
Date: Thu, 3 Dec 2015 11:21:01 +0530
Message-ID: <20151203055101.GH1854@localhost>
References: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
 <1448703121-5831-7-git-send-email-vinod.koul@intel.com>
 <20151201225854.GZ1929@sirena.org.uk>
 <20151202050702.GD1854@localhost>
 <20151203005914.GA5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8110959287389083548=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D23E266190
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 06:48:04 +0100 (CET)
In-Reply-To: <20151203005914.GA5727@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Dharageswari R <dharageswari.r@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8110959287389083548==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2015 at 12:59:14AM +0000, Mark Brown wrote:
> On Wed, Dec 02, 2015 at 10:37:02AM +0530, Vinod Koul wrote:
> > On Tue, Dec 01, 2015 at 10:58:54PM +0000, Mark Brown wrote:
>=20
> > > So the multiple modules are a block of at most 255 16 bit words?  Tha=
t's
> > > a bit surprising - is it really a count of the number of modules or
> > > rather the size of the block of data that's being squirted at the DSP?
>=20
> > Nope, as you would think that does not make sense :)
>=20
> > So we do not point to module memory here, we are sending IPC saying mod=
ule
> > X, Y and Z are being loaded, data contains the module IDs only. The IDs=
 are
> > 16 bits so sizeof(u16) and number of modules pass as arg
>=20
> > The modules are transfered with Code Loader DMA which invokes this as I=
PC
> > after preparing DMA from Host.
>=20
> > This way IPC allows us to load One or multiple modules at one shot
>=20
> Can you please at least put this in the same patch as the user if not
> merge it more closely?  This is another of those abstractions that's
> really unclear just sitting by itself with no explanation.

The next patch "ASoC: Intel: Skylake: Add support for Loadable modules" does
add the actual code which uses the IPC.

I think it should be okay to merge these two in single patch to have
complete feature in one patch, i will fold these, add comments for this and
resend

Thanks
--=20
~Vinod

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWX9hFAAoJEHwUBw8lI4NHt1cQAISeeGT6N1swzxJXyqt4lKOZ
7RD1cHVlic8Xzy5qscBUSUF74jvAjjguVM3S0hGGJE/R3RIk2v52HTFQTmZoupiO
dfztdEK7r7qBcj638DkDRwzHbH+4gFzsyha58tuFlv+CdD43tA+aT2nv4TyRfwrZ
iz0+sb/AYmuuDo0q6Cveyukn8b/lfzWUKdLulVCJpFe/oWHVhyVW36ty2VeETWZp
Fm8gxv1QIExF0XJ1wo1pbETRFEjztdZMlAcWy7hmeqxjfPz0X8xmkZfnC2qe6Mlb
jfpqk2+JQbSyl5dcDo0y5afqFm3miVz67kFNq8FZGnw1Jz/v3+TOBxIQ0anietah
JS1tsPQ6t+9N1a9DMLllW2hbnsmiNDIeNfhrNq7cvTWmvLbCz86HZlSvT3maPTb6
iJuVOf3SGqTwndxGD2qrOTh22pmtuOBXMRI16bEPF59QTsBaA2COs+OacZ30nxZQ
aJYRE7/9xzooTR5izYFbTm+1b8hMQYkl6neC8BrM8F1gBIUWnh2wnHlBBXl24Qb6
nIMsOmMOz92Hh0x5a2vsUgFrXCKHY3stTPPif057pbNLTNjioWtertmOD/z7GpQm
/Q1b0HYBhm26Tk5rH00piR/ZY4FUqZPqzyFHHIQZ0g0IaSAEewzCvmUIOfjJqJG9
Fhf4nRZWmxdyNKooxRlc
=3U1T
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--

--===============8110959287389083548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8110959287389083548==--
