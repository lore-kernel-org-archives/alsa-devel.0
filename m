From: Joachim Feise <jfeise+alsa@ics.uci.edu>
Subject: Re: [Alsa-user] cs46xx (Turtle Beach Santa Cruz), kernel 2.6 recording
 silence
Date: Sat, 14 Feb 2004 11:50:24 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <402E7C00.7070004@ics.uci.edu>
References: <402E6430.9050001@ics.uci.edu> <Pine.LNX.4.50.0402141105550.16731-100000@string.physics.ubc.ca>
Reply-To: jfeise+alsa@ics.uci.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.50.0402141105550.16731-100000@string.physics.ubc.ca>
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

[moderators: sorry for repost, I need to remember to set my email
to the one I registered with]
Bill Unruh said  on 2/14/2004 11:08:

> On Sat, 14 Feb 2004, Joachim Feise wrote:
>
>
>>I wanted to replace my aging sbawe (which works fine with Alsa)
>>with a Turtle Beach Santa Cruz card.
>>I can play sound, but recording from Line-In does not work.
>>I just get silence.
>>The recording sw (RealProducer 8.5) uses the OSS emulation.
>>It finds /dev/dsp just fine, but there just seems to be no
>>data delivered on the device (btw, with devfs, /dev/dsp
>>is a symlink to /dev/sound/dsp.)
>
>
> a) Line in is muted
> b) Line in has its amplitude all the way down.

Nope. Checked all that.
Using alsamixer, I unmuted line in, and set the amplitude to 100%.

- -Joe
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (MingW32)

iD8DBQFALnwAKc8oZ1MoTeoRAq1NAJ4nMOunuJCfkkl4wr8pF34aLE8zaACfQ5Yi
Q4q/W2KWEjWfnMwUuf68k+A=
=pzbn
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
