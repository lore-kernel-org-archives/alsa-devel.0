From: Solomon Peachy <pizza@shaftnet.org>
Subject: Re: [patch] Fix headphone automute on Asus
	G50Vt	laptops
Date: Mon, 26 Apr 2010 12:21:52 -0400
Message-ID: <20100426162152.GB6550@shaftnet.org>
References: <20100423200814.GA18620@shaftnet.org>
	<s5hhbmy753x.wl%tiwai@suse.de> <20100426152028.GA6550@shaftnet.org>
	<s5hoch65iv8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1649422290503535754=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cdptpa-omtalb.mail.rr.com (cdptpa-omtalb.mail.rr.com
	[75.180.132.122])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FD6A24618
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 18:21:55 +0200 (CEST)
In-Reply-To: <s5hoch65iv8.wl%tiwai@suse.de>
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


--===============1649422290503535754==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Content-Disposition: inline


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 26, 2010 at 05:33:15PM +0200, Takashi Iwai wrote:
> >=20
> > There's still the problem that the 'speaker' and the 'headphone' playba=
ck=20
> > mixer switch affecting both outputs instead of just the one, and I'm no=
t=20
> > sure why -- If I toggle the 'OUT' pin on node 0x14 (speaker) and 0x21=
=20
> > (headphone) it only affects that particular output.  Same for their mut=
e=20
> > controls.
>=20
> That's weird.  So, changing the amp of only one of NIDs 0x02 or 0x03
> influences really on both outputs...?

That's just it -- there's something going on here that I don't=20
understand -- The mute swiches are defined as:

HDA_CODEC_MUTE("Speaker Playback Switch", 0x14, 0x0, HDA_OUTPUT),
HDA_CODEC_MUTE("Headphone Playback Switch", 0x21, 0x0, HDA_OUTPUT),

If manually toggle these pins using hda-analyzer, only that specifc=20
output is disabled/enabled.  But if I use alsamixer to toggle these=20
switches, both outputs are disabled/enabled.  I don't know enough about=20
the bowels of the ALSA codebase to even theorize why this could be=20
happening (though I am using the v1.0.22 userspace stuff against a=20
1.0.23 kernel stack -- or maybe pulseaudio is mucking with something?)
=20
> Another thing you can try is to just use model=3Dauto.
> With the latest version, it should work relatively well.

I've never specified a model=3Dxxxx argument.  Leaving model=3Dxxxx off=20
should be the same thing as model=3Dauto, right?
(and by latest do you mean git head?)

In any case, the 'take3' patch is such an improvement over the former=20
state of affairs that in my opinion it should be applied -- we can=20
always apply another patch once the mute wonkiness is figued out.

Thanks!

 - Solmon
--=20
Solomon Peachy        		       pizza at shaftnet dot org	=20
Melbourne, FL                          ^^ (mail/jabber/gtalk) ^^
Quidquid latine dictum sit, altum viditur.

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFL1b2gPuLgii2759ARAoifAKCKDcnKE80Zm0+z59I5ppy9K3glqACgwCkp
U1JTLpA7fOBNJVuY9WcQjnA=
=9eyZ
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--

--===============1649422290503535754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1649422290503535754==--
