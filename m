From: Bob McElrath <bob+alsa-devel@mcelrath.org>
Subject: Re: cs46xx sound quality and CD volume
Date: Sun, 13 Oct 2002 17:59:48 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021013225946.GI8862@draal.physics.wisc.edu>
References: <E180JU9-0004lc-00@usw-sf-list2.sourceforge.net> <20021012223943.GA8862@draal.physics.wisc.edu> <3DA92FD2.1050302@cucumelo.org> <E180JU9-0004lc-00@usw-sf-list2.sourceforge.net> <20021012223943.GA8862@draal.physics.wisc.edu> <3DA92D58.4090603@cucumelo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WR+jf/RUebEcofwt"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3DA92FD2.1050302@cucumelo.org> <3DA92D58.4090603@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--WR+jf/RUebEcofwt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Benny Sjostrand [gorm@cucumelo.org] wrote:
> That is a problem not related to the "CD Volume" that should be fixed
> by now.  The  "~3 kHz sound" that you are talking about usually happen
> when the DSP hangs and it leaves some junk left in the HW FIFO.
>=20
> I think you should try latest CVS.

The latest CVS has the tick-tick-tick recording problem I mentioned
earlier.  No matter what I record, no matter what source, no matter what
mixer settings, all I get is 'tick-tick-tick' in the right channel with
a frequency of 2Hz.  If I turn down the 'Capture' mixer setting the
ticking becomes quieter, but it is not affected by any other mixer
setting.  (I get it with all inputs and outputs muted)

Haven't seen the CVS one do the 3kHz sound thing though.

Benny Sjostrand [gorm@cucumelo.org] wrote:
> >Is the amplifier the IEC 958?  (it now shows up in the mixer with the
> >new DSP code)
> >
> That's not the amplifier, that's the SPDIF input/output control. On the
> Game Theater XP card the amplifier is always turned on (with the
> exception when unmute the CD volume). There is no mixer
> control for this.

No?  That seems odd...

> >Also I tried the SPDIF in with this new DSP code, and it doesn't seem to
> >work.  There is an 'Optical/Coaxial SPDIF Input' in alsamixer but I
> >can't change its levels, only mute it.
> >
> With that control you selects to use Coaxial digital input or Optical
> digital input. Look on the back on your beutiful blue break-out box
> and you will find them -;)

I know where it is!  ;)  I'm saying nothing comes out of my speakers
when I put an input there.  (but the fault may be my input -- so ignore
this complaint for now)

BTW, I tried opening /dev/dsp three times (simultaneously) and it
beautifully plays all three!  Neat!

Also, when trying to do full duplex record/play, the PCM output is
affected by a couple of quick scratches on device open.

Cheers,
-- Bob

Bob McElrath
Univ. of Wisconsin at Madison, Department of Physics

    "The surest way to corrupt a youth is to instruct him to hold in higher
    esteem those who think alike than those who think differently."=20
        -- Nietzsche

--WR+jf/RUebEcofwt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2p+uIACgkQjwioWRGe9K37DgCg+YGdZ7r8zAVziZ7Qm+9cEe4X
jg0AoPU+Nex4Xosz41+WkgpiFLkqqr5W
=dtUp
-----END PGP SIGNATURE-----

--WR+jf/RUebEcofwt--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
