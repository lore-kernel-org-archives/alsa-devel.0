From: Bob McElrath <mcelrath@draal.physics.wisc.edu>
Subject: cs46xx bug on alpha
Date: Thu, 9 May 2002 10:30:05 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <acqdo1$e0l$2@main.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The cs46xx driver seems to compile, install, and load fine on alpha, and
the mixer (alsamixer) appears to work fine.  When trying to play a .wav
file with aplay though, I get this message repeatedly:
    May  9 10:11:47 draal kernel: ALSA pcm_lib.c:116: Unexpected
    hw_pointer value (stream =3D 0, delta: -2679, max jitter =3D 2756):
    wrong interrupt acknowledge?
Follwed by:
    May  9 10:11:57 draal kernel: ALSA pcm_lib.c:1864: playback write
    error (DMA or IRQ trouble?)

My /proc/interrupts:
  1:      19515          XT-PIC   keyboard
  2:          0          XT-PIC   cascade
  3:          0          XT-PIC   serial
  8:   27950319             RTC  +timer
 10:      44924          XT-PIC   eth0
 12:      91482          XT-PIC   PS/2 Mouse
 14:       2221          XT-PIC  +ide0
 16:     115375       CABRIOLET   BusLogic BT-958
 17:      15103       CABRIOLET  +CS46XX
 18:          2       CABRIOLET  +mgacore
 19:          9       CABRIOLET   usb-uhci
 20:          0       CABRIOLET   isa-cascade
ERR:          0

My /proc/dma:
 4: cascade

This is kernel 2.4.17 with a Hercules Game Theater XP.

Any ideas?

P.S. I'm surprised to see many more channels in alsamixer than I thought
the OSS driver supported.  Does the alsa driver really do 3D and support
all the extra inputs on this card?  (YAY!)

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjzalf0ACgkQjwioWRGe9K2usQCgsbcxxj3EP5O8pTFho4GUVXMS
2EMAoL+0dhrz6sP8GCnNjJsmEx3rxpRG
=vSYp
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
