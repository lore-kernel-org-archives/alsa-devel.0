From: Bob McElrath <bob+alsa-devel@mcelrath.org>
Subject: Re: Alsa-devel digest, Vol 1 #810 - 3 msgs
Date: Tue, 29 Oct 2002 10:36:29 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021029163629.GD1046@draal.physics.wisc.edu>
References: <E186QHN-0002BE-00@usw-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E186QHN-0002BE-00@usw-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Benny Sjostrand <gorm@cucumelo.org>
List-Id: alsa-devel@alsa-project.org


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

alsa-devel-request@lists.sourceforge.net [alsa-devel-request@lists.sourcefo=
rge.net] wrote:
> Date: Tue, 29 Oct 2002 08:55:06 +0100
> From: Benny Sjostrand <gorm@cucumelo.org>
> To: alsa-devel@lists.sourceforge.net
> Subject: [Alsa-devel] [PATCH] cs46xx, independant rear PCM channel, IEC95=
8 PCM channel
>=20
> This is a multi-part message in MIME format.
> --------------090804060704000507060108
> Content-Type: text/plain; charset=3Dus-ascii; format=3Dflowed
> Content-Transfer-Encoding: 7bit
>=20
> Hi!
>=20
> First, this stuff is still very experimental, it should work very well=20
> with a
> Game Theater XP course that's card I've got and the only cs46xx sound=20
> card I can
> test with.
>=20
> I've got some reports that stuffs dont seems to work very well with
> the Santa Cruz card, course for some unknown reason the driver dont
> manage to raise GPIO 7 and 9 on the secondary codec that
> enables the rear output, you probably will see the message
> "cs46xx_setup_eapd_slot() Failure to write the GPIO pins for
> slot 12. " and that will probably freeze you computer
> for a while too.
>=20
> In this patch, for the Santa Cruz the amplifier and the GPIO's are
> setup on init, then not touched anymore, like it's done for the
> Hercules XP card with hope and a little of luck maybe that
> works better.
>=20
> Finally, this patch contains the following changes:
> - Rear PCM channel
> - IEC958 PCM channel, in hope that I'm close to get raw AC3 working soon
> - Turn on Amplifier and setup EGPIO for Santa Cruz card on init
> - Cleanup's in voyectra_setup_eapd_slot(...) (hope it's not broken ...)
>=20
> PS. If you have time to help testing this patch, dont forget to turn on
> all debuging stuff, that always helps to find bugs ...

With a GTXP on an alpha. ;)

I managed to stall the codec by playing with the IEC958.  I turned the
IEC958 input all the way down, unmuted it, then unmuted the IEC958
output.  I was playing an mp3 at the time, and the mp3 stopped and the
codec just puts out a constant ~8khz tone.  This is repeatable.

The 3D Depth seems to work now, sounds great.  I don't think it worked
before... ;)

Playing 2 pcm inputs at the same time seems to work great.

Recording still seems to not work.  I still get about a 1Hz ticking in
the right channel when recording (no matter what the mixer settings).

I don't see a debug setting on the modules snd-cs46xx or snd -- is this
a compile time setting?  Anyway, let me know if you want me to send you
some debug output.

What is the easy way to test playing to the rear pcm channel?

Cheers,
-- Bob

Bob McElrath
Univ. of Wisconsin at Madison, Department of Physics

    "The surest way to corrupt a youth is to instruct him to hold in higher
    esteem those who think alike than those who think differently."=20
        -- Nietzsche

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2+uQ0ACgkQjwioWRGe9K27awCfdk0v6Gpjq0OqQb3SowgP1hK0
KyIAnjzvhm8Sw7zzLp6GrWa3gBTPK6Mm
=TwxL
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
