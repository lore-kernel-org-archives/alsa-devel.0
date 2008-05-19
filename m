From: Tony Vroon <tony@linx.net>
Subject: Re: [ALC262_FUJITSU patch_realtek.c] Use jack
	sense	for both	headphone outputs
Date: Mon, 19 May 2008 12:33:44 +0100
Message-ID: <1211196824.3878.2.camel@localhost>
References: <1211155219.4974.10.camel@localhost>
	<s5hod72d22y.wl%tiwai@suse.de> <1211193069.3899.4.camel@localhost>
	<s5hlk26d1gp.wl%tiwai@suse.de>  <s5hhccud0l8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5481075609151618196=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bronze.linx.net (bronze.linx.net [195.66.232.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 64014245FC
	for <alsa-devel@alsa-project.org>;
	Mon, 19 May 2008 13:34:46 +0200 (CEST)
In-Reply-To: <s5hhccud0l8.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5481075609151618196==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mZI4/Okcxud/t4Pw1+VL"


--=-mZI4/Okcxud/t4Pw1+VL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-05-19 at 12:56 +0200, Takashi Iwai wrote:
> On the second thought, it's also not so trivial in this case because
> of the combination with the jack detection code.
>=20
> How about the patch below?

Acked-by: Tony Vroon <tony@linx.net>

The jacks are no longer inconsistent at boot-up. Correct state is
maintained, and no repeated plug/unplug is required before the speaker
mutes/unmutes.

> Takashi

Regards,
Tony V.

--=-mZI4/Okcxud/t4Pw1+VL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkgxZZgACgkQp5vW4rUFj5pSLACZAabt0RCKTvZojnj/aWi5Orvo
0aUAn07sndMMTf8AbzNGSRUXBN61bhDA
=O1g5
-----END PGP SIGNATURE-----

--=-mZI4/Okcxud/t4Pw1+VL--


--===============5481075609151618196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5481075609151618196==--
