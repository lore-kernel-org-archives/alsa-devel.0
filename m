From: Bob McElrath <bob+alsa-devel@mcelrath.org>
Subject: Re: Re: Alsa-devel digest, Vol 1 #810 - 3 msgs
Date: Wed, 30 Oct 2002 00:11:49 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021030061147.GG1046@draal.physics.wisc.edu>
References: <E186QHN-0002BE-00@usw-sf-list2.sourceforge.net> <20021029163629.GD1046@draal.physics.wisc.edu> <20021029164403.GC776@porky> <20021029170914.GE1046@draal.physics.wisc.edu> <3DBF173F.2010209@cucumelo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VACxsDaSTfeluoxK"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3DBF173F.2010209@cucumelo.org>
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


--VACxsDaSTfeluoxK
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
>=20
> Hm.,, just weird, does it work OK with the fron channel (hw:0,0) ???
>=20
> What do get on dmesg output ???

The relevant stuff is:
Oct 29 23:52:11 draal kernel: ALSA dsp_spos_scb_lib.c:1188: dsp_spos: creat=
ing SRC "SrcTask_SCB0"
Oct 29 23:52:11 draal kernel: ALSA dsp_spos_scb_lib.c:295: dsp_spos: creati=
ng SCB <SrcTask_SCB0>
Oct 29 23:52:11 draal kernel: ALSA dsp_spos_scb_lib.c:1355: dsp_spos: setti=
ng SRC rate to 44100
Oct 29 23:52:11 draal kernel: ALSA dsp_spos_scb_lib.c:1211: dsp_spos: creat=
ing PCM "PCMReader_SCB0" (1)
Oct 29 23:52:11 draal kernel: ALSA dsp_spos_scb_lib.c:295: dsp_spos: creati=
ng SCB <PCMReader_SCB0>
Oct 29 23:52:11 draal kernel: ALSA dsp_spos_scb_lib.c:1355: dsp_spos: setti=
ng SRC rate to 11025
Oct 29 23:52:21 draal kernel: ALSA dsp_spos_scb_lib.c:231: cs46xx_dsp_proc_=
free_scb_desc: freeing PCMReader_SCB0
Oct 29 23:52:21 draal kernel: ALSA dsp_spos_scb_lib.c:231: cs46xx_dsp_proc_=
free_scb_desc: freeing SrcTask_SCB0

Why does it set 44.1kHz first and then set it to 11kHz?

I hear the first piece (frag?) of the sample played repeatedly, as if it
were not servicing interrupts...

Messages for the 2nd pcm channel are identical if you s/(1)/(2)/ above.

As to the recording problem, I have tried all the options I can think
of, all the mixer settings and possible inputs, and I still get ticking.
NO messages are written to the logs during the record.
    arecord -d 2 -f cd blah.wav
I have placed this file here: http://mcelrath.org/blah.wav.bz2

Cheers,
-- Bob

Bob McElrath
Univ. of Wisconsin at Madison, Department of Physics

    "The surest way to corrupt a youth is to instruct him to hold in higher
    esteem those who think alike than those who think differently."=20
        -- Nietzsche

--VACxsDaSTfeluoxK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2/eCIACgkQjwioWRGe9K1e0QCeKEQ3px9T69uagTV+d2dRA4N+
vbMAnRfFaU212rjrBsKzyqpWk91bYyzz
=+BsE
-----END PGP SIGNATURE-----

--VACxsDaSTfeluoxK--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
