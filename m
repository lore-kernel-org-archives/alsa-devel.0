From: Joachim Feise <jfeise+alsa@ics.uci.edu>
Subject: Re: cs46xx (Turtle Beach Santa Cruz), kernel 2.6 recording
 silence
Date: Sat, 14 Feb 2004 12:59:35 -0800
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <402E8C37.5020308@ics.uci.edu>
References: <402E6430.9050001@ics.uci.edu> <Pine.LNX.4.50.0402141105550.16731-100000@string.physics.ubc.ca> <402E7C00.7070004@ics.uci.edu> <Pine.LNX.4.50.0402141243210.18246-100000@string.physics.ubc.ca>
Reply-To: jfeise+alsa@ics.uci.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.50.0402141243210.18246-100000@string.physics.ubc.ca>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bill Unruh said  on 2/14/2004 12:44:

>>>a) Line in is muted
>>>b) Line in has its amplitude all the way down.
>>
>>Nope. Checked all that.
>>Using alsamixer, I unmuted line in, and set the amplitude to 100%.
>>
>
> On many cards the input amplitude is IGain, not linein. linein just
> determines how much of the input goes to the output.

Well, alsamixer does not show any IGain column for this card.
I have tried unmuting and upping the amplitude on everything.
Audio into Line-in or Mic in goes fine to the output.
Recording still doesn't work.
I am not sure if I'm missing an option somewhere, or if this
is a deeper problem.

- -Joe
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (MingW32)

iD8DBQFALow3Kc8oZ1MoTeoRAhTuAKDze8keWd9BuTU3Y1cD8p4q+YMPwgCdFsBb
QazKzm53J2OxVltT6PiSruc=
=FrCI
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
