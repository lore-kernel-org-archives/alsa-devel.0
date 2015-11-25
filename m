From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: core: add a dapm sink widget
Date: Wed, 25 Nov 2015 12:51:38 +0000
Message-ID: <20151125125138.GU1929@sirena.org.uk>
References: <1448293951-32071-1-git-send-email-vinod.koul@intel.com>
 <1448293951-32071-3-git-send-email-vinod.koul@intel.com>
 <5654327A.5080406@metafoo.de> <20151124101907.GC25173@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5217980381853688142=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ACD2D2606C9
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 13:51:46 +0100 (CET)
In-Reply-To: <20151124101907.GC25173@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============5217980381853688142==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Sx3M3By4KbPIrykT"
Content-Disposition: inline


--Sx3M3By4KbPIrykT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 24, 2015 at 03:49:07PM +0530, Vinod Koul wrote:
> On Tue, Nov 24, 2015 at 10:48:42AM +0100, Lars-Peter Clausen wrote:
> > On 11/23/2015 04:52 PM, Vinod Koul wrote:

> > > To make the dapm graph complete for such paths we need a dapm
> > > sink widget for these modules, so add a SND_SOC_DAPM_SINK to
> > > declare such a widget.
> > > This widget will be treated as SND_SOC_DAPM_EP_SINK endpoint in
> > > the dapm graph

> > Except for the strange formating of the commit message this looks good.

> Checkpath now seems to warn if commit message > 65chars so have set it for
> commit message

I think it's more the random wrapping above - it looks like those are
either two paragraphs or one paragraph with random word wrapping within
it.

--Sx3M3By4KbPIrykT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWVa7ZAAoJECTWi3JdVIfQop4H/i14FPl3Hu8oGAQTmjNBFJVo
OKQSu9iK/dF0C05yCl3Fw312JJo984xbBdnAO/2iovkheZoPHoWnjavSXPWQchwa
woOGtzl+DelyktMZfKhvQTqc7MdyVs/NBgcQlQ+TtkXuELb4Xu3uS3RTovVNvotu
TET8jFW3IuK9mnOFwsIdsVWG1/vMaWLwtvAydksVZ/lRpFg+/bxp3TKAqDFRglsx
cwqU/XIHOotBrQVl3A9ISVlYWlMNTgNoinhQsdaApibRR6XksPFpr+nEKKNndud4
qRPWwUmTU1f3BzKqbJ4SXwYFSRFLIdW8R3sLctjVVpBVASHYH66B9Rk/LDv6GXE=
=rEMP
-----END PGP SIGNATURE-----

--Sx3M3By4KbPIrykT--

--===============5217980381853688142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5217980381853688142==--
