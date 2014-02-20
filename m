From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 082/102] ASoC: Add SOC_ENUM_SINGLE_CONST()
 and SOC_ENUM_DOUBLE_CONST() macros
Date: Thu, 20 Feb 2014 11:33:39 +0900
Message-ID: <20140220023339.GR2669@sirena.org.uk>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
 <1392724308-13375-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3052204945666730329=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6082B265677
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 03:50:11 +0100 (CET)
In-Reply-To: <1392724308-13375-2-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3052204945666730329==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vexDq96c2p6JNt+p"
Content-Disposition: inline


--vexDq96c2p6JNt+p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:51:28PM +0100, Takashi Iwai wrote:
> Add new helper macros for defining the enum elements with a constant
> array.  With these macros, redundant ARRAY_SIZE() can be removed in
> the code.

So, this doesn't seem like the best way to do things.  For one thing
it's not really that the arrays are const, it's the fact that they are a
fixed size that makes the difference with these macros.  An array where
we fill in a fixed number of strings at runtime would work just as well
for this.  I'd also expect this to be more what the default naming does
since we want to try to steer people towards using the simplest and
least error prone mechanism for doing this.

--vexDq96c2p6JNt+p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWmAAAoJELSic+t+oim9lqIP/i58OxptgomiAQOdQtPlK9j4
g6oRoXc2kZqZ1gBWWA4VGKWJ+Pa5TQ3TIIYz+qjTJ1usJJg4g3USMqX7pudg3u8G
U9IAe0KUlU6eC4gcAhOyabx33aOhRVRgH4HtgQHAw5+7TKt13u6oKAbdwgDsCk8c
Mf6AQtJHKrc8mHh6LLlGO6D3iCqZu+fBrMTC9e2gAUCWLpIYaWAzXf2TigaBQamu
+dFQGyxSIJ5VApV14G/0Ge8eZ8XCySNSEDo+O4xJjDR35TakO+FXoWtHfPlIY3ii
ikm+519RB7O3ODslhOLjad+CKtv08DnCxjdejvuY/1Jg3SDQkAAOw9gcz0iFeLxp
ZkY0xV/7ReiA4oTW2jFQk+hCIdUJVixWM2LGvcj44hZ7YB13EDxBkLVOMaX9gZhU
qtpIPUP0SVA6xdNJRCqOzlN7mG5PPVuAIjW7tNzKUJYlI3al7SegCKxLVrz2VPdE
1GCl3ti+XR7NwjTE2oE/bz/d4Uo82QtcNP/KV3nlulY4jkbf6R+QOIFPT4rcC1+U
472PXHfEJ5btN4EWKupjbNR/r4DpNle9T0Duo242z+eP01R7cQMZSYoDDFLPk4R1
DIMFx5qr80n8RSLc//W4pspt2kTNgdmMK4tf/giPrHvBPqPikJtc0KTGOlZ/Ghzb
0Hf1OeK4mv5jxuUiKKx1
=CPdn
-----END PGP SIGNATURE-----

--vexDq96c2p6JNt+p--

--===============3052204945666730329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3052204945666730329==--
