From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: Some Patches for emu10k1
Date: Tue, 8 Jun 2004 10:07:08 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406080807.i58878cb012056@www4.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: joachim.falk@gmx.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Subject: And another fix this time for ld10k1
>Date: Mon, 31 May 2004 20:15:44 +0200
>From: Joachim Falk <joachim@jfalk.easynet.de>
>To: Jaroslav Kysela <perex@suse.cz>
>
>Hey Jaroslav,
>
>attached is patch to fix accept_comm function for ld10k1.
>Third parameter of accept syscall is inout.

Everything about ld10k1/lo10k1 should be routed to me
pzad@pobox.sk

>The following is a question I asked on IRC channel

AFAIK there is no other documentation. (best is driver source)

>I am especcially interested what this emu10k1 registers do.=20

They are mostly used in midi synth, some of them are exported as mixer
controls.

>I assume they are per emu10k1 channel (there are 64 of them ?).
>I think I have understood that for each PCM output stream one of this
>channels is used (For mono 1 for stereo 2). This channels can also be
>used for wavetable synthesis.=20

Not exactly (as I read on alsa-devel mailing list).
for mono PCM stream 2 channels are used
for stereo PCM stream 3 channels are used
but from user point of view it doesn't metter.

>And than this magic send routing decides in which FX buses the
>processed
>stream will be targeted. Maximal 4 FX buses chan be selected per
>channel
>? Send bus A,B,C, and D. Is this sendbus the same for each channel
>or can it be configured for each channel seperatly. Is it fixed
> or can for
>all channels globally be configured what FX bus sendbus A,B,C and
> D is ?=20

Maybe this helps you:
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg11671.html

Can be configured via
EMU10K1 PCM Volume
EMU10K1 PCM Send Routing
EMU10K1 PCM Send Volume
controls.

>But some FX buses seam to be connected to outputs even if there is no
>code in the dsp. Is that hardcoded in hardware or configurable and if
>yes where ?

This is maybe hardware feature or ld10k1 bug. If you connect FX bus
0,1 to AC97 PCM output I think it will stop to do this.

Peter Zubaj=0A____________________________________=0Ahttp://www.pobox.sk/ -=
 najvacsi slovensky freemail=0A=0A=0A


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
