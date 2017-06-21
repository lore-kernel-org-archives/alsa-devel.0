From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: nau8825: fix jack type detection issue after
	resume
Date: Wed, 21 Jun 2017 11:59:27 +0100
Message-ID: <20170621105927.nnxu3moceqkz6zub@sirena.org.uk>
References: <1498028390-10952-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2416370746495098359=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DBCB266C31
 for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2017 12:59:33 +0200 (CEST)
In-Reply-To: <1498028390-10952-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <supercraig0719@gmail.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, mac.chiang@intel.com, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2416370746495098359==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5uanrbbsw6rg5fxc"
Content-Disposition: inline


--5uanrbbsw6rg5fxc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 21, 2017 at 02:59:50PM +0800, John Hsu wrote:
> Fix the issue that mic type detection error after resume.
> The patch help to fix the issue as follows:
> Google issue 37973093: CTIA/OMTP jack type detection failure after resume

What is the issue and in what way does this patch help fix it?  The
changelog just says it's fixing a problem, it doesn't say what the
problem is or what the change is supposed to do.

--5uanrbbsw6rg5fxc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllKUY4ACgkQJNaLcl1U
h9BJuwf8ClKuJRKQFsGACr3AySXkM70cl+J8iRBH4PLChJ2X599mvRkEMPTAzCcf
HbOGPTSbPMzhWhAdx3PINWIyn2XApEpVfFFbdJXbKYz9JmKsXnIrcQSBq5Vl+mD1
EGLtO+6l1wRNjHIehsOMqBR2wP3E1b+FSFa4bzLwybAI7uqSStyuMCjsm9dS7R1j
EbyMmQuNTFz0AJI6GUwGSwcSj2SPieSHYprGRybpnlULR/1yziHnTXl2yMcKFxM5
LT3yZpUX5eOwwnhYifAyYquvNK8HWqVrIJgVaIIb2pytEhkH789F7gBJw9NFpRRm
ICu6M1jaqzh4Ji25jsWWKrBv/E6xLw==
=Y+He
-----END PGP SIGNATURE-----

--5uanrbbsw6rg5fxc--

--===============2416370746495098359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2416370746495098359==--
