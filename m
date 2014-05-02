From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fix stream position pointer.
Date: Fri, 2 May 2014 09:54:19 -0700
Message-ID: <20140502165419.GO3245@sirena.org.uk>
References: <1399046194-5544-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1399046194-5544-7-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6929496350498277575=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 27B7E265510
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 18:54:34 +0200 (CEST)
In-Reply-To: <1399046194-5544-7-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6929496350498277575==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tfkPjF9dLnbqPmYW"
Content-Disposition: inline


--tfkPjF9dLnbqPmYW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 02, 2014 at 04:56:33PM +0100, Liam Girdwood wrote:
> Read the stream offset and presentation position from DSP memory rather
> than using the old estimated position. This fixes timing issues with
> pulseaudio.

Applied, thanks.

--tfkPjF9dLnbqPmYW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTY824AAoJELSic+t+oim9hIsP/RsQDXBYoIDYbYdNhODPkI8H
L6Ls+Tg3CX6B5GmSzgIeWU/ZB+v8IKAscogxMkkG9YJffbkXDMajUuVqmn3IgzET
M5z4OY6QIuWbtH7EMjVPX5lJq5eCKUIspYX7bVfXXwCAg/9ZYrGJZQoU1OIZOYSn
Y9h4hyRCTjmZ24/51QU+PPHwbfnr/r2+moEUwFK5ARxCTR7rYAhz9B+Dchj1Aeat
LPGDV5+q2Y5AkjVOLsciaNVWj5XToElXZnOy6vvsOKR8HKLi0K774kNkhfvwjho+
qA0K3/utfDtTOT9kICQJDzYiKPc2yOea5FLzAGx9+sdgi39yOoYYp8RyJ+jh0Qob
b0ixKXtma2z25ZU8LgsSeWDabSsM3wie40R9EWupF/fT54BEuMmsiCRSinAwnnzx
H0Xd/87vAPfwF6nLInkO+Ld0BUJAr8TolqP2kc8wlptMFr2SMlBu+8Ja3Iittb9+
6Ip4XPBAqy3P21ihgwxkOx0pgBp2JcsZGfPq7Z+o4ZlDD35OLSfhWlC6r9mY82K/
eRcL7YmTgcnUVNhkcszaPfkTLp/DB9ssqAK0Qk+4oJa6AZqziUdKpTUzQqJIWI7J
PGG2VkzztX4kMgOJjKWUyLd8tbojhJ2CiH5LY1h66yJDrOvI9gkG7WvDR5zBYPQg
gbdJ3vI5K8EpLiI1S3kv
=WaLN
-----END PGP SIGNATURE-----

--tfkPjF9dLnbqPmYW--

--===============6929496350498277575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6929496350498277575==--
