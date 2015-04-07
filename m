From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Fix ruledata setup in
 davinci_mcasp_startup
Date: Tue, 7 Apr 2015 12:05:52 +0100
Message-ID: <20150407110552.GE6023@sirena.org.uk>
References: <1428404633-25365-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8751660526572809563=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A72A260545
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 13:05:59 +0200 (CEST)
In-Reply-To: <1428404633-25365-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org


--===============8751660526572809563==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kqAFKZ++CrkAX0DV"
Content-Disposition: inline


--kqAFKZ++CrkAX0DV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 07, 2015 at 02:03:53PM +0300, Peter Ujfalusi wrote:
> Passing &mcasp->ruledata[dir] to snd_pcm_hw_rule_add() is not correct since
> commit:
> 7b3d165a2821 ASoC: davinci-mcasp: Index ruledata in drvdata with substream->stream
> now sets up the struct based on the substream->stream (0 or 1) while we pass
> a pointer which we take with dir (1 or 2). This will lead kernel crash.

Applied, thanks.

--kqAFKZ++CrkAX0DV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVI7oPAAoJECTWi3JdVIfQrKQH/3FtCzAyPWjnq3u3zcIzmDiA
B9SuoudzQLGfahH+eT+DQfGEglTNFOAqrjA5Vaa8wRDvKGgd4CrOs/v2vpEmepXI
/RMbIXiHCGQlLLM5JFUzKHHF6dtmNwZVhLbvEMQ1fDZVjzd9M+X9daSuTZau1pC9
jgYtFv/ybnQTQPvcgNGGSUX3GdWrVc+qpYG9VzJVhYp5NzZ9AemnpuCJ6NSEuzKp
aXeA7GmSpsCAAo0wje34Xkr5h+PeqIb57S9FmnubvQ2NKiILvOePzwjtonmRKWiX
0k32u6g+XewgaYYaa8ksDSdQaMoog5F4L1AwSmvj2eUfwMC8cW+t6/u8ZdzFneA=
=EsdI
-----END PGP SIGNATURE-----

--kqAFKZ++CrkAX0DV--

--===============8751660526572809563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8751660526572809563==--
