From: Joachim Feise <jfeise+alsa@ics.uci.edu>
Subject: cs46xx (Turtle Beach Santa Cruz), kernel 2.6 recording silence
Date: Sat, 14 Feb 2004 10:08:48 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <402E6430.9050001@ics.uci.edu>
Reply-To: jfeise+alsa@ics.uci.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

System:
Slackware 9.0, upgraded to kernel 2.6.2, using devfs.

I wanted to replace my aging sbawe (which works fine with Alsa)
with a Turtle Beach Santa Cruz card.
I can play sound, but recording from Line-In does not work.
I just get silence.
The recording sw (RealProducer 8.5) uses the OSS emulation.
It finds /dev/dsp just fine, but there just seems to be no
data delivered on the device (btw, with devfs, /dev/dsp
is a symlink to /dev/sound/dsp.)

I tried using the latest drivers (1.0.2c), and the cvs version,
but no change.

There are no error logs.

Does anybody have an idea what's going on?

TIA,
- -Joe



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (MingW32)

iD8DBQFALmQwKc8oZ1MoTeoRArXdAJ98R5bwEFMyRdHDJdZ2Ap8JEVsgZACeNISb
S/vrEKq07jj9e7sISI0eWlc=
=i4V8
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
