From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: utils: Add DT support
Date: Mon, 15 May 2017 11:21:31 +0100
Message-ID: <20170515102131.4o4jm6bcoayavgjj@sirena.org.uk>
References: <1493712508-27919-1-git-send-email-vishalthanki@gmail.com>
 <20170514095651.jbk2fkea6th24yay@sirena.org.uk>
 <CAC3a_SCJU_pxNhJOyXdW8x8Eeso8bVV38PkfRL+cRzd+rOoO7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8286395007147588643=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7926A266851
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 12:21:46 +0200 (CEST)
In-Reply-To: <CAC3a_SCJU_pxNhJOyXdW8x8Eeso8bVV38PkfRL+cRzd+rOoO7Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vishal Thanki <vishalthanki@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8286395007147588643==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wuiqepywcn73e7gz"
Content-Disposition: inline


--wuiqepywcn73e7gz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 15, 2017 at 10:41:43AM +0200, Vishal Thanki wrote:

> Thanks for you comments. Actually in our custom hardware, the codec is
> not accessible/visible from kernel directly, rather additional MCU
> controls and configures it. However MCU needs the I2S clocks and data
> from kernel. So I am using I2S platform driver from Linux just to
> configure I2S clocks, and registering a dummy codec driver to DAI link
> in DT, so that codec can be instantiated and clocks can be enabled
> from user-space ALSA utils while accessing this dummy codec. Please
> suggest if there is any better way to achieve this kind of
> configuration.

You should be representing the I2S control offered by the MCU as a CODEC
driver.  Even if there's no changes ever made there must be some
constraints.

--wuiqepywcn73e7gz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkZgSoACgkQJNaLcl1U
h9DWKgf+JDbg3ngfRNV/ImUsAR9VmcV/yaqLKHT5ZkKlENwW9dyLd8LxJ+540Zvw
tKJQDsLuwxyzfipW0qaoi+SzYUqBzLkRLQW4pvd062rokctBBkaS4DeWfM3jihSB
EYWwyOp4k8MUOJ+zdNRBtSWJN9nDbs+BuCfOYFMUx9Pi7zjH3O0UiuXpjI+RZNz2
LdhHrLw5UUHpz4E2xugKqAcD/7jgchs2xqukDoA+CJhcRJz36RFS30QU/KGJu0MM
QRRiVSIoJIb1RurPS9Z7t7+UkJynFit9LFt4S4cGfNTJCq/RBly+CShuD6EzCNnJ
8Yy5u6hiTYcZy+BI1jCER5UNo699bg==
=ntI6
-----END PGP SIGNATURE-----

--wuiqepywcn73e7gz--

--===============8286395007147588643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8286395007147588643==--
