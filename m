From: Johannes Berg <johannes@sipsolutions.net>
Subject: hda-intel channels hibernate bug
Date: Sun, 05 Apr 2009 10:55:30 +0200
Message-ID: <1238921730.3782.3.camel@johannes.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6660572771617169303=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id A7BEA2433E
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Apr 2009 10:55:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============6660572771617169303==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-OsO/AYHG6Nj6k9fv7LU7"


--=-OsO/AYHG6Nj6k9fv7LU7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

On my macbook 5,1 I need to use model=3Dmbp3, as you may still remember. I
also need to set channels to 6 to hear anything at all, probably due to
the codec mismatch -- it's not really an mbp3 so that only works 80%,
but I haven't gotten around to writing a better codec description.

However, when I hibernate with channels set to 6, I always need to reset
the channels to 6 again after resume to hear anything -- it seems the
channels control isn't reset to the hardware at resume time. I suppose
this bugs affects any users of this codec, regardless of whether it is
actually right or wrong.

johannes

PS: I wanted to file a bug on the alsa bugtracker but mantisbt decided I
had not entered all fields correctly and didn't give me an option to
edit, so I had to reenter, which frustrated me enough to give up on
mantis.

--=-OsO/AYHG6Nj6k9fv7LU7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ2HH/AAoJEKVg1VMiehFYnToP/i0U9Z+ViXHanblL5fnf4m88
3lbJv050sNEd+DpRF93w4NgIt1lFWok2EFmlwCIpPVf6+sI5mrrcXWrc/JPY6ptd
mhLbBs51ft/QUiVjf0UnovI1Q87Gww24YVF8/8pt0BTzio8ss5Ibv7yYC3L3d3t5
KEuTB2hCgF1UBt50dsaxqQfAR3+wzTiNOV0xwPiWzuF0+pCI3gpuuCTzC+3G7gZV
w3q0V1pFYWG5XvvqdcXYhw5La6rFK+GauT+uOK/3qQQd+LUJw4iQiovnjBPj4KPL
4LQ01StQvC/0/0joMFcNc6aPYgH1xy9LThLkUYTLuT5V/hSNQsR/potDLf0wiiQq
EDlo3dMSw4DyvmbmI9LrHfnmfDmgfkTSv9Zi+Wo2+rzd3fmRnVJK1Kn0MUnzMS9d
zfgpanNSAspemMTNyPE7I16IG1Mv/5XDiBVHVNVM3yghuH7m6jnrsOtdl6w0Qt6w
eyPqRUj+u9CCPsTfe8UYMnPFRskmRENBohHKEtP0INeJ+02phS5ePkpo1pXDoH9u
jOo/MpPEKFD5jFsou6tfMGaBLtGUAnIiAhkHLmrq7vVOIHdjy9D9kiF6nnSUzOYR
HL8Kl9YL2cNnKJrhcvZHkABZZzXRJf4E6hQZrlcvueYxGZAFfVJLmWqpEZYfTdzX
Qr3kGsHt+gmFjyLMjTGu
=vWUV
-----END PGP SIGNATURE-----

--=-OsO/AYHG6Nj6k9fv7LU7--


--===============6660572771617169303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6660572771617169303==--
