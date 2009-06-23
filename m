From: Tony Vroon <tony@linx.net>
Subject: Re: Regarding Sound on Acer Aspire 6935G
Date: Tue, 23 Jun 2009 23:40:09 +0100
Message-ID: <1245796809.3640.10.camel@localhost>
References: <4b8c423b0905152051w7443e1b4u4080514a560fbb6c@mail.gmail.com>
	<s5h3a9sm8oa.wl%tiwai@suse.de>
	<d54969c50906221451o6e92044cj3da24df67e55268b@mail.gmail.com>
	<1245707939.441.5.camel@localhost> <s5hfxdrex0w.wl%tiwai@suse.de>
	<1245709097.441.7.camel@localhost> <1245710676.441.9.camel@localhost>
	<d54969c50906221614k5e12f5edt8973f7bb8e69592c@mail.gmail.com>
	<1245712854.441.11.camel@localhost>
	<d54969c50906221623j4fd17c6yb7fc2c9316d11766@mail.gmail.com>
	<d54969c50906231105k251880eahbf82cf74b699c7d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9168296218594320953=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gold.linx.net (gold.linx.net [195.66.232.40])
	by alsa0.perex.cz (Postfix) with ESMTP id E7C3124552
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 00:40:12 +0200 (CEST)
In-Reply-To: <d54969c50906231105k251880eahbf82cf74b699c7d8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Emilio =?ISO-8859-1?Q?L=F3pez?= <buhitoescolar@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Karthik Ramgopal <applefreakpeeps@gmail.com>, ALSA development ML <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============9168296218594320953==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-rVn3aAf3zfYt5dZRMhOo"


--=-rVn3aAf3zfYt5dZRMhOo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-06-23 at 15:05 -0300, Emilio L=C3=B3pez wrote:
> I had a little free time, so I decided to play a little with alsa. I
> copied the mic verbs from the old model to this new one and it seems
> to be working fine. Here is the patch for that

Takashi, please feel free to apply this. Especially the PIN_IN selector
is obviously correct, and if this fixes the 6935 it should work on the
6930.
Unfortunately the 6930 (which isn't mine) will be out of the country as
of tomorrow.

Emilio, you may want to resubmit with a Signed-Off-By line etc. There's
a Documentation/SubmittingPatches in the kernel source that explains all
the little details.

> Now, the only 'broken' thing is jack sensing, it just mutes front, but
> not LFE. I guess this is an easy to fix issue.

Now that you've got your hands dirty you might want to fix that one as
well :)
You'll want to mute/unmute node 0x17 (the "tuba") in addition to 0x14 in
the jack sense handler. Might as well handle 0x16 now that you're at it,
the codec graph suggests this is a speaker of some kind as well. Copy
alc888_acer_aspire_4930g_init_hook into a new 6930g_init_hook, and look
at 8930g to see how to do multiple speaker nodes.

That's basically it. Hacking on patch_realtek.c is quite doable.

> Emilio

Regards,
Tony V.

--=-rVn3aAf3zfYt5dZRMhOo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEABECAAYFAkpBWckACgkQp5vW4rUFj5rt2wCgp2vnd3X05VwNF38u1UtbdgT4
Ce0AoJZlxxWIXhfR0oMFGKruLKxj1Uxh
=Ta8c
-----END PGP SIGNATURE-----

--=-rVn3aAf3zfYt5dZRMhOo--


--===============9168296218594320953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============9168296218594320953==--
