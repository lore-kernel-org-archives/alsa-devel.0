From: Tony Vroon <tony@linx.net>
Subject: Re: [ALC262_FUJITSU patch_realtek.c] Use jack sense
	for both	headphone outputs
Date: Mon, 19 May 2008 11:31:09 +0100
Message-ID: <1211193069.3899.4.camel@localhost>
References: <1211155219.4974.10.camel@localhost> <s5hod72d22y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1192193910969032947=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bronze.linx.net (bronze.linx.net [195.66.232.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 465B0245E6
	for <alsa-devel@alsa-project.org>;
	Mon, 19 May 2008 12:32:10 +0200 (CEST)
In-Reply-To: <s5hod72d22y.wl%tiwai@suse.de>
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


--===============1192193910969032947==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4fWrtElYamezgHewLQyx"


--=-4fWrtElYamezgHewLQyx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-05-19 at 12:23 +0200, Takashi Iwai wrote:
> Any reason to remove this?
> Otherwise the internal speaker won't react together with the Master volum=
e.

It seemed to only take the internal headphone output into account, not
the dock headphone output. But if it's just to link the two volumes
together I'll add it back. It will fix the compile warning as well.
Its purpose was unclear to me.

Will the existing mechanism cope if 0x14 (internal HP output) is muted
and 0x1B (dock HP output) is not?

> Maybe a cleaner fix is to remove the bind_sw and bind_vol hacks and
> use vmaster instead.

Is there example code I can look at please?

> thanks,
> Takashi

Regards,
Tony V.

--=-4fWrtElYamezgHewLQyx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkgxVu0ACgkQp5vW4rUFj5qkkgCfbnASIBqBBflTzgxyERegoUJw
DiwAniEBARv8wiBuNFK85dPUtC4NsXnz
=jkqj
-----END PGP SIGNATURE-----

--=-4fWrtElYamezgHewLQyx--


--===============1192193910969032947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1192193910969032947==--
