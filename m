From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound: soc: intel: bxt_da7219_max98357a:
 Replace GFP_ATOMIC with GFP_KERNEL in broxton_audio_probe
Date: Tue, 10 Apr 2018 15:02:51 +0100
Message-ID: <20180410140251.GB14657@sirena.org.uk>
References: <1523270781-22627-1-git-send-email-baijiaju1990@gmail.com>
 <482591fb-bf12-2e0a-e0ef-2ae0b4095000@linux.intel.com>
 <s5h3704dvad.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2008624062510159452=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8448D266C1C
 for <alsa-devel@alsa-project.org>; Tue, 10 Apr 2018 16:03:41 +0200 (CEST)
In-Reply-To: <s5h3704dvad.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jia-Ju Bai <baijiaju1990@gmail.com>, sathyanarayana.nujella@intel.com, Adam.Thomson.Opensource@diasemi.com
List-Id: alsa-devel@alsa-project.org


--===============2008624062510159452==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 09, 2018 at 09:39:06PM +0200, Takashi Iwai wrote:

> It must be sleepable context as it's a standard platform driver probe
> callback.

> And now looking at grep output, only sound/soc/intel contains so many
> calls with GFP_ATOMIC.  I bet that almost all can be done with
> GFP_KERNEL, maybe only one or two in atom/sst would be conditionally
> with GFP_ATOMIC.

Yeah, it's not like it'd be the first code quality problem found in the
Intel drivers.

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrMxAoACgkQJNaLcl1U
h9Af9Qf9G3jjm88KOaPES27ZSNhU49vRVZfy2H5IzqPPi6vt/ibAMs7WLTzKA7Bi
94SoRQjmZZRjXOq2x2kMLmR1m/+EmkvExHFwy3pFiFJ8yWak64egJDUR2lOnb5Fm
PEzJyMpEPBxySkhkhLs2JSlHhqxyErrLHX070fPviy68c7kkmO4JadcMVHqzclAf
chQvTrP+PG17VuzfcUFjIuziSEOQqDSz/ZRC7wpptorIHhVw9JK0p/6P47lkb0/M
9F9oQ5tpDwZlg+T965LUh98vBFE7J1jdRI3jqhrV3C/JAk4yM0X6+kscZsjiTAQY
7DD/S0COX89nr6Ih9wJQjCnU404nzA==
=H+RI
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--

--===============2008624062510159452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2008624062510159452==--
