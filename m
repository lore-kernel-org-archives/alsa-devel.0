From: Bob McElrath <bob+alsa-devel@mcelrath.org>
Subject: Re: cs46xx sound quality and CD volume
Date: Sat, 12 Oct 2002 17:39:44 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021012223943.GA8862@draal.physics.wisc.edu>
References: <E180JU9-0004lc-00@usw-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E180JU9-0004lc-00@usw-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

alsa-devel-request@lists.sourceforge.net [alsa-devel-request@lists.sourcefo=
rge.net] wrote:
>=20
> >However, one small buglet.  When recording from line1 (aux in the
> >current driver), the sound sometimes sounds very tinny and scratchy.  I
> >can fix this by muting/unmuting the CD and adjusting the CD volume.
> >Yes, the CD slider in alsamixer.  Not the Aux one or the Capture one or
> >the DAC one.  The CD one.  Weird, huh?  I've tried playing with all the
> >other sliders and they do not affect the recording quality.
> > =20
> >
> This is a known problem (at least forme). When you unmute the CD volume
> the soundcard amplifier is turned off, and at least for the Hercules=20
> Game Theater XP card
> this makes no good.
> This thing could be easily fixed.

Is the amplifier the IEC 958?  (it now shows up in the mixer with the
new DSP code)

So I'm using 0.90pre3 right now with the new DSP code, and it does
something different-strange.  When I first insert the module everything
sounds great, but if I unmute the IEC958, I get a constant tone in my
speakers (~3 kHz, I'm guessing) and anything which tries to play PCM
audio just hangs.

It was not this way on bootup.  I think the card got into some bad
state.  I tried inserting both the alsa and oss drivers to try to reset
the card, but to no avail.

Also it seems like every mixer element is duplicated in alsamixer, but
you probably know that.

Also I tried the SPDIF in with this new DSP code, and it doesn't seem to
work.  There is an 'Optical/Coaxial SPDIF Input' in alsamixer but I
can't change its levels, only mute it.

And last thing, while the card is in this state, when I record I don't
get the proper audio.  It sounds like tick-tick-tick with a frequency of
about 2 Hz.

Cheers,
-- Bob

Bob McElrath
Univ. of Wisconsin at Madison, Department of Physics

    "The surest way to corrupt a youth is to instruct him to hold in higher
    esteem those who think alike than those who think differently."=20
        -- Nietzsche

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2opK8ACgkQjwioWRGe9K2udQCgletsBcQJ8W4d9Mo8x8xi10Ni
WMQAoI+UZHJwXhIk6YkiHI31I4xovdO2
=g2ab
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
