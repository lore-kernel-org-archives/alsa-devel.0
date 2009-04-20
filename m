From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to
 new-style i2c drivers
Date: Mon, 20 Apr 2009 23:04:52 +0200
Message-ID: <1240261492.4632.21.camel@johannes.local>
References: <20090420225425.2a150a4f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0629975024313657028=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 151EB24364
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Apr 2009 23:05:30 +0200 (CEST)
In-Reply-To: <20090420225425.2a150a4f@hyperion.delvare>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Andreas Schwab <schwab@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: alsa-devel@alsa-project.org


--===============0629975024313657028==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-qFwU4SrOmVTwbnar3JU/"


--=-qFwU4SrOmVTwbnar3JU/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-04-20 at 22:54 +0200, Jean Delvare wrote:
> The legacy i2c binding model is going away soon, so convert the AOA
> codec drivers to the new model or they'll break.
>=20
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Tested-by: Johannes Berg <johannes@sipsolutions.net>
> Tested-by: Andreas Schwab <schwab@linux-m68k.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Takashi Iwai <tiwai@suse.de>
> ---
> Takashi, please push this patch to Linus quickly, as this is blocking
> the removal of the legacy i2c binding model, which is scheduled for
> 2.6.30.

Have you taken care of snd-powermac similarly?

johannes

--=-qFwU4SrOmVTwbnar3JU/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ7ONxAAoJEKVg1VMiehFYD+0QAIFgn6KpT36E4NQ4NyHorx3q
9AfWZtSsNy5LL2UyOnJmszCzXgZ76akZ59oG4yFvHF54qnYSZLmTfgBae9nNHn17
TK7yfKXTJ6cUc6ByoedvoCL5/Lb5PxrtUw3kOwldDgpcxia/7eqQnweK/5WGAA5X
JMs5V64cyaKok+PHqf7QTqOAJNQ7MDGWw5dCrAv9mLWxM5CBSd6QnRMV7Dr0jzdx
Y+giflsKqdAY2RbhkUi5AY3VH273YBIkTN117Gsrf/2yKKnXtQEFqfLUqh89hNTz
uVDpo5UeoFFRX6nVgWH6IwoeuJHC7lP2zRQz+k/u/EkGp3+6fYDO0nspl/Ic5ogT
xp/EmRzzhu/toNLy2/1E7xIiaUuq6LWrbfsWPdAp0w117nRIIFvRwATxSGfLFyhm
4BlK3tdAurT+gQiryu0uO/H/Hp+4Z23YWg2Q1JsSglPYm3E7zDGnkD7P4L3V3c6K
qqF/TTc+7ADy8em00GiFUoRgfCQgeq687ZGgo1njwnQIQ2kM/87zR+O7DZLVixy2
GvmPLVIAoG3W2/kzYOkWErsXvr+15KTFbnGueRbaeg8pvnWN62kPfrcarKKtrp4l
QDxP1DkJ1PeRRERtvgXJ0WoxzyUhyvuk6e+DcP1I1wmPXDZ0KQzDnL4RdO9rnPeI
E59HNyCjgqdtYq0HysPS
=qSa7
-----END PGP SIGNATURE-----

--=-qFwU4SrOmVTwbnar3JU/--


--===============0629975024313657028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0629975024313657028==--
