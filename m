From: Itay Ben-Yaacov <nib_maps@yahoo.com>
Subject: More on the intel8x0 resume problems.
Date: Tue, 18 Nov 2003 21:16:44 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031119051644.49322.qmail@web21001.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


As I reported earlier, intel8x0 fails to resume properly on my Dell I8200 with alsa >= 0.9.7

This is due to the fact that snd_intel8x0_ich_chip_init() no longer waits that extra 1/4 second it
used to in 0.9.6 and ealier.  It seems to believe that all the codecs are ready, but apparently
they are not.

I tried to look into this a bit further and found that:
In intel8x0_resume() there are two ac97 codecs actually resumed on my machine (I suppose that
these are precisely the primary and secondary ones that snd_intel8x0_ich_chip_init() has waited
for already), indexed 0 and 1.

When resuming ac97 no. 0, in snd_ac97_resume() there are quite a few registers that do not get set
properly.  For example, here's a bit of my debugging messages: 

Nov 18 23:58:24 pisica kernel: PEZZ: bad register 2: c0c 8000
Nov 18 23:58:24 pisica kernel: PEZZ: bad register 6: 801f 8000
Nov 18 23:58:24 pisica kernel: PEZZ: bad register a: 801e 0
Nov 18 23:58:24 pisica kernel: PEZZ: bad register c: 801f 8008
Nov 18 23:58:24 pisica kernel: PEZZ: bad register e: 801f 8008
Nov 18 23:58:24 pisica kernel: PEZZ: bad register 10: 9f1f 8808
Nov 18 23:58:24 pisica kernel: PEZZ: bad register 12: 9f1f 8808
Nov 18 23:58:24 pisica kernel: PEZZ: bad register 14: 9f1f 8808
Nov 18 23:58:24 pisica kernel: PEZZ: bad register 16: 9f1f 8808
Nov 18 23:58:24 pisica kernel: PEZZ: bad register 18: 1010 8808
Nov 18 23:58:24 pisica kernel: PEZZ: bad register 1c: 0 8000
Nov 18 23:58:24 pisica kernel: PEZZ: bad register 1e: 0 8000

The first value is the one read from the register after writing into it, the second is what was
written.

On the other hand, if I just add a hard-coded 1/4 second wait before snd_ac97_resume(), emulating
the good old days, I only get:

Nov 19 00:00:26 pisica kernel: PEZZ: bad register 2a: 9 209

And the sound resumes fine.

The other ac97, indexed 1, seems to be indifferent to whether I resume it with or without such a
delay.

So I believe the problem is that codec no. 0 is not waited for properly, even though it reports to
be ready... Could that be?

Please help me out here.

Thanks,
Itay

__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
