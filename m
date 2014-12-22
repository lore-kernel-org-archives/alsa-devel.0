From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: intel: Remove superfluous backslash
 in	Kconfig
Date: Mon, 22 Dec 2014 12:37:10 +0000
Message-ID: <20141222123710.GJ17800@sirena.org.uk>
References: <1418208827-2001-1-git-send-email-tiwai@suse.de>
 <s5hlhm62oks.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2637937414608604946=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 240232604E2
 for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2014 13:37:31 +0100 (CET)
In-Reply-To: <s5hlhm62oks.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2637937414608604946==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P6YfpwaDcfcOCJkJ"
Content-Disposition: inline


--P6YfpwaDcfcOCJkJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 17, 2014 at 06:06:27PM +0100, Takashi Iwai wrote:
> At Wed, 10 Dec 2014 11:53:47 +0100,
> Takashi Iwai wrote:

> > The line continuation in Kconfig should be a '\' instead of '\\'.

> > Signed-off-by: Takashi Iwai <tiwai@suse.de>

> Mark, would you apply this to your tree?  I merged it only to master
> branch for fixing the build of alsa-driver tarball build for now but
> left other branches intact.  If you don't mind, I'll apply it by
> myself, though.

I've not been applying anything except for urgent bugfixes during the
merge window, I've just applied it now.

--P6YfpwaDcfcOCJkJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmBB1AAoJECTWi3JdVIfQExEH/0EwH+oIyQP7Ve1xxU8939tq
PxEV0wf/kt5qstd1dBvhRWOQGFCtMv2gyCRih+lR3duz8CzGCU90g70vpOewi7/W
Brn3VcOWj/m45jo0lZ/bv+6Yuj+nFr92y7p+dK6VhIF46PvfpE5e15yOr0nEttBr
t6Pg8CQn98pR9ugvY0N/qsA3lMU+W0RmZUWZHXbf15N737+ZMKFqpvbu+EdTRvEo
ysuS7k7W7rbLH4U5AKbBQT2OGp3UjQdm9XZdYPO+IUWw10DXh2eik7Es75L9vZU6
yaRX34SrbyWpr8QMMdoxQAiPkJir9h4/EPcSFSym+nZR7dN18otZ80tqNmKcrig=
=Jc/K
-----END PGP SIGNATURE-----

--P6YfpwaDcfcOCJkJ--

--===============2637937414608604946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2637937414608604946==--
