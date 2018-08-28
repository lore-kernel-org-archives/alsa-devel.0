From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: cs4265: SOC_SINGLE register
	value error fix
Date: Tue, 28 Aug 2018 19:57:56 +0100
Message-ID: <20180828185756.GK2414@sirena.org.uk>
References: <20180826225844.13754-1-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9144498737258441870=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BB04F26779D
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 20:58:03 +0200 (CEST)
In-Reply-To: <20180826225844.13754-1-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============9144498737258441870==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o9mtL5OVI48+DSkO"
Content-Disposition: inline


--o9mtL5OVI48+DSkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 27, 2018 at 08:58:42AM +1000, Matt Flax wrote:
> The cs4265 driver declares the "MMTLR Data Switch" register setting with
> a 0 register value rather then the 0x12 register (CS4265_SPDIF_CTL2).
> This incorrect value causes alsamixer to fault with the output :
> cannot load mixer controls: Input/output error

How is this patch series different to the apparently identical three
patch series you sent a few minutes earlier?

--o9mtL5OVI48+DSkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluFmzMACgkQJNaLcl1U
h9CoiQf/Xzdk9aGulMQj10vCF67/4k8mKivD3932A5fZxgVMNjWDNZt8b4HAIlnZ
Pcmt4A8R4s2XlytzVh3/j55SzX3XEo7tKxQ9FHsDeied9YcuByAyxjsRh4mne1Fe
jwAAMwli2wQ9AU+p6mSNff9Uke7JR1IfZVfay2p0IqN7piRafNVQyARhcT9ylyh8
kaSt325OZPmy1kBKbj5pk3cPyZLPSr8eJncINFAEg+woPwBukQuUXLvT5PxETPjP
nhMxBrq6yQWWHvEMcCSKvZvzXsacIdpM3f1Wq2nB7yIYKSd1yxfjVeodSUuK+AiR
F3jeSHbNQK5QgMbdmDvu00Zb7vC5Tw==
=b3Rg
-----END PGP SIGNATURE-----

--o9mtL5OVI48+DSkO--

--===============9144498737258441870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9144498737258441870==--
