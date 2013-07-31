From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: dapm: using freed pointer in
 dapm_kcontrol_add_widget()
Date: Wed, 31 Jul 2013 12:19:35 +0100
Message-ID: <20130731111935.GK9858@sirena.org.uk>
References: <20130731085244.GB8210@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4458553299283117022=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BD6426158C
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 13:19:41 +0200 (CEST)
In-Reply-To: <20130731085244.GB8210@elgon.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4458553299283117022==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y4KgtkKhApPt9pfM"
Content-Disposition: inline


--y4KgtkKhApPt9pfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 31, 2013 at 11:52:44AM +0300, Dan Carpenter wrote:
> There is a typo here so we end up using the old freed pointer instead of
> the newly allocated one.  (If the "n" is zero then the code works,
> obviously).

Applied, thanks.

--y4KgtkKhApPt9pfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+PLEAAoJELSic+t+oim9xBoP/RW1oSQ9HtqITt4hbTPk1Eni
RfvCYtbogJMP5vPbA2R8EHYRfFUV2duv0WpbVnTSKVCyXTQOXqfYl2FukIN/tTih
cNILCDBUStJBprrtc1/Kba87Nadh0+nWchLIgP1vKds+Iy/qhYiHUJUsAgohk0GE
aYbJ5YH9xm2pk3UJ9/aMS1RUIwNVTXrXm+9WnHcT+dIXSr/aU8gTQhAcN9poSzDU
AMoABr+oFLgKsuQ5JxGQYJMTg7MctbFvq4K8Tm0/IvE7SAyl9kijEZlyGx8Anznf
eWDTTAVGSfWIgRUd30vDbUScU+kc1nfYTTtJgB/se/P3hFRfAumjdNE3vO4dn5yg
Kp7oG+VORUxCenYle1tirx1xe06fY9D34U+TChvNKncGueP0lQ8uMEfANDmRb8eL
xVMHd2wa4DKA7oGsZyJncSg/jQA3K5IGS1wvBIRw2/bq7boCg03Di83UScTvrwUD
m6dhbOsKiA1CmbccvI4R+J39Bi3JKC0ze+HKAsErf0B2kYC6HK2dS+4pUBKpTj4G
llesg6hLs2LwYnTI4P58eDM3Sa9/Bb4nSkaYELHXVuRBLLGLru91JyhrYqYfT01/
93Hem9p/jCz24Xriz2xE/OIzLOHJEqoZN95yOhGofrYBcCuOOwfX8xn+g5eqAXwV
YqnbG2gD/AOecj60am5s
=+qvf
-----END PGP SIGNATURE-----

--y4KgtkKhApPt9pfM--

--===============4458553299283117022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4458553299283117022==--
