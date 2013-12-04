From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: soc-pcm: Use valid condition
 for snd_soc_dai_digital_mute() in hw_free()
Date: Wed, 4 Dec 2013 11:47:09 +0000
Message-ID: <20131204114709.GJ29268@sirena.org.uk>
References: <cover.1386126119.git.b42378@freescale.com>
 <6bf200dcb47ffcf3ab342e4cc3a278e9ed010553.1386126119.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4710240802293157834=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B497926545E
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 12:47:11 +0100 (CET)
In-Reply-To: <6bf200dcb47ffcf3ab342e4cc3a278e9ed010553.1386126119.git.b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4710240802293157834==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qD3brAgIG4LbUq6d"
Content-Disposition: inline


--qD3brAgIG4LbUq6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2013 at 11:18:36AM +0800, Nicolin Chen wrote:
> The snd_soc_dai_digital_mute() here will be never executed because we only
> decrease codec->active in snd_soc_close(). Thus correct it.

Applied, thanks.

--qD3brAgIG4LbUq6d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnxY5AAoJELSic+t+oim9wKgP/AtLdysKAy8cQitDOkan0Vui
q/4508m+rS02GpRQLuUt9kOhHq7r3KX3tLZHEnsQTZoezkpdTrmytSHja/6LPJbh
V4qSIJLCIIKk9rUJdOKLE07s1CA5cOmEG6vwM2GqvswdiIXcx3KaTf7hZJWbvWLR
u/RgaWYU21JVdsgnnoy+hB0TyFAd4n5anAqvkJ5BxwpF9OLILcpm4nvYhtinX23G
3JvAT/qA+SfvyN3N4Uh9uTmNRHL8vMAeXllFXB2WLWmO5TTi5hRBE2YhDR+XPHtQ
MuUyi9E7B4u8nU76bFHFcOkdVvMOG0z5+86ZoK/ukxifw5DUvyQzeIKkmoMmHjXf
DKWGyAFn1Fqa0PTBIksPzFAevPbGHrOz6k1fipXL0BYSid9PRN9EZHznSVJLBljE
VQfsXBmv5f5ChXodpebp1xZXwS+4ZCc5fJ969OBgy47jHXwwdM/hLTLVHT0/r0Kk
Q4AQQcmxQewEsjzLKzOWdqifLReT1e2R91KmijcTkfPnAdn66ekDfuyfVDvsMBfT
k3KjZdKJkV7isQybodCEBT9OvTthY+6xiNxE0tlMbrvmGdse3aNYvfMmcewpy8b5
Ty9b13Q146Zbo1HWU0v2t9TE5bm76eq9YXbSXUnbqqUB77GJRjueKSF3iHqMlzav
kuVPeiEkVUYoGfgpGZLD
=LeWw
-----END PGP SIGNATURE-----

--qD3brAgIG4LbUq6d--

--===============4710240802293157834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4710240802293157834==--
