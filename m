From: Bob McElrath <bob+alsa-devel@mcelrath.org>
Subject: Re: Re: Alsa-devel digest, Vol 1 #810 - 3 msgs
Date: Tue, 29 Oct 2002 18:05:13 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021030000513.GG15048@draal.physics.wisc.edu>
References: <E186QHN-0002BE-00@usw-sf-list2.sourceforge.net> <20021029163629.GD1046@draal.physics.wisc.edu> <3DBF1E29.1000901@cucumelo.org> <E186QHN-0002BE-00@usw-sf-list2.sourceforge.net> <20021029163629.GD1046@draal.physics.wisc.edu> <20021029164403.GC776@porky> <20021029170914.GE1046@draal.physics.wisc.edu> <3DBF173F.2010209@cucumelo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Zw+/jwnNHcBRYYu"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3DBF1E29.1000901@cucumelo.org> <3DBF173F.2010209@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: Peter Heatwole <peter599@gotnet.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--/Zw+/jwnNHcBRYYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Benny Sjostrand [gorm@cucumelo.org] wrote:
> >
> >
> >Seems to work well.  The relevant mixer settings are PCM1 and Surround1
> >(both of which must be turned up and unmuted.  However it doesn't seem
> >to deal well with odd rates:
> >
> >(0)<mcelrath@draal:/home/mcelrath> aplay -Dhw:0,1=20
> >/usr/share/sounds/zipper.wav Playing WAVE '/usr/share/sounds/zipper.wav'=
 :=20
> >Unsigned 8 bit, Rate 11025 Hz, Mono
> >aplay: pcm_write:968: write error: Input/output error
> >=20
> >
>=20
> Hm.,, just weird, does it work OK with the fron channel (hw:0,0) ???

Exact same results for hw:0,0.  (i.e. it doesn't work)

> What do get on dmesg output ???

I still need to recompile with debug.  I will send debug messages later.

Benny Sjostrand [gorm@cucumelo.org] wrote:
> >
> >With a GTXP on an alpha. ;)
> >
> Cool! stupid question from me, which endianess does the Alpha=20
> architecture have ??
> well, I believe the cs46xx is never tested on Big-Endian architecture

Alpha is little endian.  (The processor itself can be either, but
linux/alpha uses little endian)

> >I managed to stall the codec by playing with the IEC958.  I turned the
> >IEC958 input all the way down, unmuted it, then unmuted the IEC958
> >output.  I was playing an mp3 at the time, and the mp3 stopped and the
> >codec just puts out a constant ~8khz tone.  This is repeatable.
> >=20
> A old bug that I supposed was fixed, but apparentily it's not, probably=
=20
> course
> I've never tested to play with SPDIF in and SPDIF out control at the same
> time. Hopefully I'll find a way to get around it ....
>=20
> Just to confirm; if you only play with SPDIF input mixer control, leaving
> the SPDIF output unmuted it dont happen right ?

Yes.

BTW I recommend renaming the IEC958 to "SPDIF" or "Digital In/Out" since
nobody knows what an IEC958 is...

> >Recording still seems to not work.  I still get about a 1Hz ticking in
> >the right channel when recording (no matter what the mixer settings).
> >
> Recording should work fine, did you have the DAC capture SPIDF input=20
> "on" ?? then
> it could be SPDIF input related ...

I cannot record anything at all, from any input (I haven't tried from
SPDIF -- I don't have a reliable SPDIF source anyway)  I get the 1Hz
ticking.

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

    "The surest way to corrupt a youth is to instruct him to hold in higher
    esteem those who think alike than those who think differently."=20
        -- Nietzsche

--/Zw+/jwnNHcBRYYu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2/IjkACgkQjwioWRGe9K0FrwCfWLsEjz3Swbh4fuFyfnqu+r3V
J/kAn2sjw82TUqU4CwFgMjolwbpZuquv
=Qsjr
-----END PGP SIGNATURE-----

--/Zw+/jwnNHcBRYYu--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
