From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 01/11] ASoC: dpcm: Add helper function
 for initializing runtime pcm
Date: Mon, 6 Jan 2014 17:40:33 +0000
Message-ID: <20140106174033.GP31886@sirena.org.uk>
References: <1389014356-7014-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0363692996463624084=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3974B264FFB
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 18:40:41 +0100 (CET)
In-Reply-To: <1389014356-7014-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0363692996463624084==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mT4yAvgikiid89S9"
Content-Disposition: inline


--mT4yAvgikiid89S9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2014 at 02:19:06PM +0100, Lars-Peter Clausen wrote:
> We have the same code for initializing the runtime pcm on both the playback and
> the capture path. Factor this out into a common helper function.

Applied, thanks.

--mT4yAvgikiid89S9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSyuqOAAoJELSic+t+oim9QGEP/R31F4Dd/iuw5JLJHsGnVdtU
dpxsEojY6Dt0ulDTmlK2FM8YYHVA+bmdtQuNCYTuQ6FUV/TZGnxubHpbzBASMoxW
ecAy3wPUFRuYSxRyCPLkbsYAmA2NowHLIicD6Vm7ayzZBkac4ab3GKfH8BCdvWkd
RmAaAubOxy3gM4k1vKfkIoMDy6meGYbrsotok2xLR5RGfKsZIs44bArxj9Fe1j7s
YZBhr2gPhOQxxboK6G2UNMdXiFBBS2EtN4hx90TubK3B/bqFd0veDExGPAXA8va4
ChqEba+0CxEK0ozRaAKDF8nolB9R/ACIFhxzQHkf+gHF+8xKt+thhAGLnXTuGwqG
ZLdd8gwviRaIQTfXuJZKLkBlG9mE1WV1oez4W8yhF9Iw3T+kFhC/mddQhRL1egcI
57IlFO5scXM5J3D5vdhCRT+KMrhShSHAAhIytH0JNFPgwmJnO5P1ZqBRJQiMmkyd
ORqKuEoqN5nNwwFZu9AsnM2K16a0ZtQkVgGn2tvlpIepe6H6c9Ma5HtTLVEp9sK6
C4pWYVvjUehkILrXsGEVYzRsgvF2w2eCmu/QLZv69gP5ssaffpFHs/kVnP8iWdNy
B1Pl3IAUUbH+jCgguUfx8FQM88Pa6CX8tgwmoKFoYbE0AKNOEwjN2wwTuQPDfIom
8pCDJnE+WjrHJbCrpYuG
=h+5j
-----END PGP SIGNATURE-----

--mT4yAvgikiid89S9--

--===============0363692996463624084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0363692996463624084==--
