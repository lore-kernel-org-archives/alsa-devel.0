From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/6] ASoC: davinci-mcasp: Place constraint
 on number of channels
Date: Mon, 10 Nov 2014 15:00:24 +0000
Message-ID: <20141110150024.GY3815@sirena.org.uk>
References: <1415615540-28981-1-git-send-email-peter.ujfalusi@ti.com>
 <1415615540-28981-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0114952752390273916=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EE4C426154C
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 16:01:43 +0100 (CET)
In-Reply-To: <1415615540-28981-3-git-send-email-peter.ujfalusi@ti.com>
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
Cc: daniel@zonque.org, Misael Lopez Cruz <misael.lopez@ti.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0114952752390273916==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="36OpTq80o519DUb3"
Content-Disposition: inline


--36OpTq80o519DUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2014 at 12:32:16PM +0200, Peter Ujfalusi wrote:
> In IIS (I2S, TDM, etc) mode the maximum number of allowed channels for
> either direction can be:
> number of serializers for the direction * tdm_slots.
> This constraint applicable for the first stream, while consequent stream
> should not have more channels then the first stream.

Applied, thanks.

--36OpTq80o519DUb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYNMHAAoJECTWi3JdVIfQ3OUH/2vA3L6+I/iRzk7E9+0SLI1m
yfjNzJpMJSWrX8eHLrobtYQeaoJLdL3CnCYgzCnpDcWYhQoPyYoaN9x3FWml+3po
E+VQQNQdOtSxsgK6hURetEoi1XkQnGwPM2LInNuAx+TgZmbsZH/q8II4AdZt11B1
ILfLV92OytPcm6S8s3q1V8AA+m4PQeidHkyNCU/2/w/CSCEJRW+JsZ3rRkVCwiZB
9BzwfAY5xh3WWBm6qbhjen4/s5c9YiUHSKS5MUMyimVfDp/7VhsAiOKgLpdeddsN
NeZ7Gv0v5J0Pw4br9/ouuJN5Q5uw5V2f2vrkfkGu8XkZtfPxYsnRztEeX1fVAQA=
=EZBk
-----END PGP SIGNATURE-----

--36OpTq80o519DUb3--

--===============0114952752390273916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0114952752390273916==--
