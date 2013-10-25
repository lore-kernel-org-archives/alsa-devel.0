From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND v2 3/4] ASoC: cs42l52: convert pdata
 config to regmap_update_bits
Date: Fri, 25 Oct 2013 16:43:02 +0100
Message-ID: <20131025154302.GC26122@sirena.org.uk>
References: <1382713277-10306-1-git-send-email-brian.austin@cirrus.com>
 <1382713277-10306-4-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3287528813418380120=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 693A1265669
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 17:43:06 +0200 (CEST)
In-Reply-To: <1382713277-10306-4-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3287528813418380120==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 25, 2013 at 10:01:16AM -0500, Brian Austin wrote:
> Moving platform data to bus probe and convert to regmap_update_bits.
> This will work nicer when converted to device tree instead of having it
> split into multiple probes

Applied, thanks.

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSapGDAAoJELSic+t+oim98vAP/31dD3RUd+S9LZLP/z9e8jRK
YCcbBQRKejgttAUXuV4Qq6m2LVlqW/i/LSRBcKTpPCl6O+ThzkH+nxl/oqwIww8Z
IKTv49w3OftDHbGKfEt9ygqMoAYJoj6AdS5lInFRaxJzUPKn13BXW6v73Gei3Ehv
v1dmkvr5xoGz0lN22pnE2fCXH4D715SydhjuY/7qpFyINee5TF7j28N5JDAgqh/9
0LmG9afUQOR11Qv418XYCClwqOb/eO46gzdOhY0RErh7CTqQEGPEaMbnGI4/9KAx
jca8HhobP+PcUxXZ9baCbmN3bMds/c4MdFQWYARe4u3ezz1ap/WHLqhSnXkiP89I
7HJTuRsRSb1GfKjpq3Rg0nfZVJyIc9FTjsq9JoOSPlBVFw6QdwsxZHJS7Wtmnhga
nxA65Eu1X0y3eUkoiM5BBTeuGDa8ox6hCfYwGPXItngtndU3coms017Yy3CKv8HF
qIWeHdILLXjI6gxQnarMPyoUjqywihSmMav2hCH294/CJIuW/zqy5j7T4Bne/FOP
pliG2cO0hy1tlgPVMLEOvUZYfLHVwk5phlmAkiG620ho6LrfKnP9xmQO670S/fVv
44nUfsucWZaiFgZExJWRT828bDhe+7FI4lvijCSRtBqk84I4m/aeiRXKs2dbcKkL
o60hDxkFRc0N5W5rRULg
=oQAo
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--

--===============3287528813418380120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3287528813418380120==--
