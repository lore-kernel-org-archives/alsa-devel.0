From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Support DSP function for VAD
	application
Date: Fri, 3 Oct 2014 16:54:11 +0100
Message-ID: <20141003155411.GA3594@sirena.org.uk>
References: <1409574467-12465-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3671807027632407092=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2693E260492
 for <alsa-devel@alsa-project.org>; Fri,  3 Oct 2014 17:54:32 +0200 (CEST)
In-Reply-To: <1409574467-12465-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============3671807027632407092==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 01, 2014 at 08:27:47PM +0800, Oder Chiou wrote:
> The ALC5677 has a programmable DSP, and there is a SPI that is dadicated for DSP
> firmware loading. Therefore, the patch includes a SPI driver for writing the DSP
> firmware. The VAD(Voice Activaty Detection) has be implemented and use the DSP to
> recognize the key phase.

This is fine but doesn't apply against current code, please check and
resend.

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULsaiAAoJECTWi3JdVIfQm4gIAIUPO328ZPh3vnfBg7BdmnZT
JFLOp1xa/H0Ys8DJdwHyECKPKvwN9qQm9i31amNdYzQEvzpxzY6PXwodHpxxF5I/
jLUZ6SEyglJmjqgqoAYrr7z7PNtdy3KHT8FRo6vujxmFGUpCMp6Ihr/FotD39XU1
eEdXO7ItFxj+jY/MCpYxN0E5e8atigt6owzBAn5DL/eitmBcwx/p294ZicCTUcXs
g7XEmLnyf6fzbuiJyQSjNszIEsoQz0Uxur4Red68Qs6SvAFo6dXW4s8P96WeeWQi
ll3B2EsUi6HLdUnma3c2Fm1Q3ajFwQuKym3p7lKRo56u8Fm4d5ToXxQm9el7qAs=
=L9v5
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--

--===============3671807027632407092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3671807027632407092==--
