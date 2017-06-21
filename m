From: Mark Brown <broonie@kernel.org>
Subject: Re: [asoc:topic/pxa 2/2] /tmp/ccrgbnNE.s:1411: Error:
 unknown mnemonic `ldmia' -- `ldmia x26, {r0, r1, r2, r3}'
Date: Wed, 21 Jun 2017 18:11:18 +0100
Message-ID: <20170621171118.443vx2fvg4yrcoyn@sirena.org.uk>
References: <201706220154.6jfiHx4x%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4076033115417520807=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F1EB2669F3
 for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2017 19:11:30 +0200 (CEST)
In-Reply-To: <201706220154.6jfiHx4x%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: alsa-devel@alsa-project.org, kbuild-all@01.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============4076033115417520807==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uyb63lscyylhphkk"
Content-Disposition: inline


--uyb63lscyylhphkk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 22, 2017 at 01:10:56AM +0800, kbuild test robot wrote:

>    /tmp/ccrgbnNE.s: Assembler messages:
> >> /tmp/ccrgbnNE.s:1411: Error: unknown mnemonic `ldmia' -- `ldmia x26,{r0,r1,r2,r3}'
> >> /tmp/ccrgbnNE.s:1412: Error: unknown mnemonic `stmia' -- `stmia x19!,{r0,r1,r2,r3}'

Reverted, it's the select of SND_ARM that does this.

--uyb63lscyylhphkk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllKqLYACgkQJNaLcl1U
h9DMgwf8CgyfROikkViKf8hKUvJTIF1RZPWSR13RJWrRSk1kROoBAP7ahl2IfFpR
1IyoxWrmryxuCA8iem1ULWDqWrp0oLkRgHFdUOfXf1/N0aP+wr8VfTQBs39x0izN
Io+sgMcKOh6gH3p3QidkMNjWlyn4cOs7x1zgYES8B9iVBcRWrSkDLINbTCdQE2fY
hI8n/myyUXZz4S0YB2vg89yS7nZCIK/T0lhDcUeF/azsZ+7iF+HpKDH59v9MFCVW
LgQ429afysw9z4yMX8AczkoHTDxeKRN90zXyaXikoP1meFvgL0+4BBs/6SfzX5S2
ZS+Vcz1n9yZOqkLJC28/ULTcN6kcBA==
=fBkt
-----END PGP SIGNATURE-----

--uyb63lscyylhphkk--

--===============4076033115417520807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4076033115417520807==--
