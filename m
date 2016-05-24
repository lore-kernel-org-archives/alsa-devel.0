From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2 v2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Tue, 24 May 2016 12:03:09 +0100
Message-ID: <20160524110309.GI8206@sirena.org.uk>
References: <1463131037-19220-1-git-send-email-KCHSU0@nuvoton.com>
 <20160513104841.GA22038@sirena.org.uk> <573926C5.70704@nuvoton.com>
 <20160518170549.GR8104@sirena.org.uk> <573E80A7.50602@nuvoton.com>
 <20160520110137.GJ8206@sirena.org.uk>
 <5742641A.9070409@nuvoton.com>
 <20160523170432.GA8206@sirena.org.uk>
 <5743CD4E.6020805@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1428593711359145025=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 346582606BA
 for <alsa-devel@alsa-project.org>; Tue, 24 May 2016 13:03:17 +0200 (CEST)
In-Reply-To: <5743CD4E.6020805@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1428593711359145025==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hy6Wd/+xmQCqA1QQ"
Content-Disposition: inline


--Hy6Wd/+xmQCqA1QQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 24, 2016 at 11:41:02AM +0800, John Hsu wrote:
> On 5/24/2016 1:04 AM, Mark Brown wrote:

> > The trouble is you'd have to do the configuration in userspace or do
> > something like only do the DC offset correction if no other filter is
> > configured.  TBH it's not unreasonable to suggest people should just
> > configured a high pass filter if they're having issues, though it's a
> > bit more work :(

> Is it acceptable if we change our patch to do the DC offset correction
> instead of general BIQ filter for the issue?

That's probably going in the opposite direction to what I'd expect...
I've not properly read the patch yet and there's quite a backlog from
the merge window...

--Hy6Wd/+xmQCqA1QQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRDOkAAoJECTWi3JdVIfQp+IH+gIVA1tqku3XssZP4/5m9eqk
brxR/bjTOOQPeH214bdK2o7ty3Sn/mM/PKecrqDh0crC/1SIs5bvYRzVTcNlln4E
BQraQKLAZDnnmSh3qPRJTnLWPUwdYeMzNvqs6qrXT42krQM8M4woif/28I2GA5mW
FmUJPcSuh31ypwy2mnrBssfW0Wv+azWYziBIeRQYqaPA+cdAk9+rOjyJ8obQnFyW
+stIYoRVo62puOxbWfftB/TNMeC0OMyhXBeAxDaew8jdqUopFRLfA9zr9KrmrfGO
+eKyxgeUapgxeUXJqY60riXbWwKyTeAxXyNUQ79Ivv7xhirq00Fim08KvV7fv4c=
=rram
-----END PGP SIGNATURE-----

--Hy6Wd/+xmQCqA1QQ--

--===============1428593711359145025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1428593711359145025==--
