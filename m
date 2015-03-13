From: Mark Brown <broonie@kernel.org>
Subject: Re: pcm512x driver: Mixer control naming issue
Date: Fri, 13 Mar 2015 18:27:29 +0000
Message-ID: <20150313182729.GE28806@sirena.org.uk>
References: <5500DE5B.2020401@hmbedded.co.uk> <5502DAE1.30609@hmbedded.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2376269254468989142=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 06B322604BC
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 19:27:37 +0100 (CET)
In-Reply-To: <5502DAE1.30609@hmbedded.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Howard Mitchell <hm@hmbedded.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Gordon Garrity <gordon.garrity@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2376269254468989142==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TleQwOBuDO0rokqK"
Content-Disposition: inline


--TleQwOBuDO0rokqK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 13, 2015 at 12:41:05PM +0000, Howard Mitchell wrote:

> Boost Volume) provides a boost of +0.8dB. The hardware reset value of both
> of these gain controls is 0dB, however, in the Raspbian distribution
> 'Playback Volume' is being defaulted to -6dB.

>  * Either change the names of these controls to something that's not
>    affected by the alsa restore mechanism,

You say "these controls" but it seems like only "Playback Volume" has
a problem?  My first suggestion would be to define "Analog" or
"Analogue" as a prefix in ControlNames and then use that, that would
avoid confusing applications while still fittig in with the naming
convention.

>  * or remove them as mixer controls, but make them accessible some
>    other way - e.g. device tree.

It may not be policy that someone wants to tweak at runtime on your
board but it almost certainly will be on someone's board.

--TleQwOBuDO0rokqK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVAywQAAoJECTWi3JdVIfQf0kIAIHH6xp1uCei48xUN5ZUGQeC
TuPntRhh+LiCFePoqmiu1YBnKuel7/76PfGZGow7po6HFwc37TXo3FSADic8Y9VQ
sJHFNCBl7nJA2FQcZqczRNs5Ottvzkm0iQCvte/Ods6sYivmW9NghmGwLRaMew1W
IfUsj1yC9RyN7ESo/VdaU4u7LzdnL0l2EqGO0FHqoQVnXtY8Je/3n3cA1JFxdMrV
IdPR3Odwppt81HVPjIsCmxqoiLwGOO4Vo7iw7V+pxFKqy54hwHwmG0o/yCBJD7kv
8XNG50Aqr9I5TjmuoSHePYHkGgSyj8373ICEVucq952/3BQvN1UcZr1kzlEkKJs=
=2GPT
-----END PGP SIGNATURE-----

--TleQwOBuDO0rokqK--

--===============2376269254468989142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2376269254468989142==--
