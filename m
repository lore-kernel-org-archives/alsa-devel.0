From: Tony Vroon <tony@linx.net>
Subject: Re: Problems with safe API and snd-cs46xx
Date: Mon, 07 Sep 2009 14:29:15 +0100
Message-ID: <1252330155.3283.5.camel@localhost>
References: <a080dbc80909050524o7b00ceas46184b52fdac9cbc@mail.gmail.com>
	<s5hljkrrl3s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4601073032199767754=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gold.linx.net (gold.linx.net [195.66.232.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 848FD24133
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 15:30:10 +0200 (CEST)
In-Reply-To: <s5hljkrrl3s.wl%tiwai@suse.de>
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
Cc: Sophie Hamilton <sophie-alsa@theblob.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4601073032199767754==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-KIYerDxGFGDXKCS85u4m"


--=-KIYerDxGFGDXKCS85u4m
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-09-07 at 14:32 +0200, Takashi Iwai wrote:
> Hm, I don't know of "safe API"...

It is described here:
http://0pointer.de/blog/projects/guide-to-sound-apis.html

Should this be incomplete or otherwise incorrect it would be useful to
have a rebuttal.

> A small test case, preferably a short C program just to reproduce
> the problem would be really needed in such a case.  It's very hard to
> guess what's going on and what is actually wrong in the driver only
> from your problem description, because of no obvious debug logs.

If it is anything like the Aureal Vortex bug, the minimum period size
doesn't make sense. Unlike the older the ALSA plugin, the new ALSA-NG
plugin in Audacious opens the audio device with defaults and does not
attempt to set period sizes.
The code is available here:
http://hg.atheme.org/audacious-plugins/file/c44c39dd30b5/src/alsa-ng

> thanks,
> Takashi

Regards,
Tony V.

--=-KIYerDxGFGDXKCS85u4m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAkqlCqsACgkQp5vW4rUFj5rvYACcDcsuF8CXiPrkxp60fJ7emtHq
cTkAoKEaD8/Plq2rkA3J4SCtWvf2g1et
=Cz5J
-----END PGP SIGNATURE-----

--=-KIYerDxGFGDXKCS85u4m--


--===============4601073032199767754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4601073032199767754==--
