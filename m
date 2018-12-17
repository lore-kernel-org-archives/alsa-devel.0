From: Mark Brown <broonie@kernel.org>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Mon, 17 Dec 2018 12:37:03 +0000
Message-ID: <20181217123703.GF13868@sirena.org.uk>
References: <c0546298-960e-df17-273f-fa0734050aac@gmail.com>
 <20181114230255.GG2089@sirena.org.uk>
 <b48bc9d6-767a-24df-692e-fe675afed22e@gmail.com>
 <20181115003313.GH2089@sirena.org.uk>
 <56e02571-fd5b-0add-c6c7-98e4f746448c@gmail.com>
 <20181115190403.GI2089@sirena.org.uk>
 <00b68fe8-403d-b129-1166-f414e5bd21ab@gmail.com>
 <724efe46-d604-0de1-caa2-efcfd7c91510@gmail.com>
 <20181213174229.GU10669@sirena.org.uk>
 <fff018b4-c2e5-d3f3-0589-b837e62e9c5e@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4544837027747066710=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A5CB126789E
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 13:37:04 +0100 (CET)
In-Reply-To: <fff018b4-c2e5-d3f3-0589-b837e62e9c5e@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4544837027747066710==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Content-Disposition: inline


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 17, 2018 at 02:17:45PM +0200, Dimitris Papavasiliou wrote:

> Even worse, it would let the pop through at full volume, as it
> doesn't depend on the gain.  Still, there doesn't seem to be a
> safe way to avoid the pop altogether, as far as I can see, since
> the only way I have found to avoid it, is to suspend the chip
> during the switch, and I can't synchronize access to the relevant
> register by the machine and CODEC drivers.

> If you have any other ideas/pointers on approaches I could
> investigate, please let me know.

If you're doing this during DAPM there shouldn't be anything else
running on the card at the time.

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwXmG4ACgkQJNaLcl1U
h9C5BQf/Wf2BcvYPSDB7BLR4x08h34zug2OVqvfN7DyUrgQNGXcL/UevoAcIcpVS
BE9NQn3RHZt0SeF7zVEaMvB7BsviCoT+7Kz0aw3vz7xtKf/AewZ9zpkoccCF4jIR
by6GYymt9buEndEE6fvw8VhvbER8d5uw9XvZtaRCP+LPZ3LptMcbg+zjxZY1+EF4
Vq3DEBj2zYD84HDwj6fhBcPkXZP2AnbygCSwznlxXfVc1b5uXIAUWAOGq6vx/IcI
RTz0AzrB/sH3Y1vBDhFyoL+Wi/MkxGOJaHSTQd5LG3x28ANkxNDtluKnc66Ym7sX
KGGLpnVYE4/Q6B/bDRjbIp883yvewA==
=MDNH
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--

--===============4544837027747066710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4544837027747066710==--
