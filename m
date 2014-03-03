From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2 1/3] ASoC: codec: Simplify ASoC probe
	code.
Date: Mon, 3 Mar 2014 12:50:08 +0800
Message-ID: <20140303045008.GN2411@sirena.org.uk>
References: <1393578267-18255-1-git-send-email-Li.Xiubo@freescale.com>
 <1393578267-18255-2-git-send-email-Li.Xiubo@freescale.com>
 <20140301042818.GP29849@sirena.org.uk>
 <ea3da7fbf6564020b12bcd8b4878ae4a@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5436124114636405616=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B6ED2654D4
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 05:50:21 +0100 (CET)
In-Reply-To: <ea3da7fbf6564020b12bcd8b4878ae4a@BY2PR03MB505.namprd03.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============5436124114636405616==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CoNbBaeZcnNUO34V"
Content-Disposition: inline


--CoNbBaeZcnNUO34V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 03, 2014 at 03:01:52AM +0000, Li.Xiubo@freescale.com wrote:

> I think we should move the set_cache_io() calling more earlier as we discussed
> before, but need much more research and testing. Splitting them into another
> separate patch later will be much better and easier to be reviewed.

Yes, exactly - do the simple, boring cases first and then anything that
needs thought separately.

--CoNbBaeZcnNUO34V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFAn9AAoJELSic+t+oim9bFwP/ji60dMU2memahwVPL+cBXil
zkVgCoDPl2JXUSHW6Xs1tp3SeJHUfe0rvFk0eJZq6PMD1h2wvL/8usPhWNnWSX2I
7Xxz6/f5k0siX9eFuBBTxYlhSH3csn6cvhrTlNMsA7cH0l5Ccd+Zr2YRBUVTpB+p
frBojoCymruTs0RgZveuHrAwLiIyDoFhkUHjtLwZbV+ZFBt5EhRSTJKdswLhA841
bbDeTrRbGxBSyPmwvw5M2Yc83wtldGh09NBzVPeoCxWSvoUvUDJUaO63KeRYlibA
Y/4Yku+585Bz4qMfGqe2+u+PpPY81ckh4RkMIul5DpWNW+NGJWK5o5P18IJwzY5t
2QWAs5Dm0m2j1J0B8EH3SWvZ1NG5YS4GklY9pTbnctaZ9Po3Qo1dRJzmMIoI+k8E
jwP6DkuCc+19lyRHW1Ryuux7AdpTQhY6ljdM7VQAxdbTr8Y2XyY/eZORHkVWnrDm
ewR0ITRX1Vqduatx0dWuwLIVlDtFc3KhRpsoATHU3F3SbviBha5H9joU9HO1SFAx
uhsYFGxMdX8fBWyETgDJGuFig8YgP0R6dfdhuGTfD/Z5fhtFg0lwdQ5xI+BPOH2g
8eN0+fMQYqsjhCITP3G5bxrLwq8NLtDKEAP3vqjPGMJgVEfOB3O3sChwoU1pcopN
PvxnNPyY9ESx2k5B7LKf
=ZChx
-----END PGP SIGNATURE-----

--CoNbBaeZcnNUO34V--

--===============5436124114636405616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5436124114636405616==--
