From: Georgi Georgiev <chutz@gg3.net>
Subject: Broken AC3 on EMU10K1 since July 2-nd
Date: Tue, 28 Sep 2004 01:03:14 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040927160314.GA16100@lion.gg3.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

When trying to play an AC3 sound on my Creative Live I got heavy
skipping. The "Digital" light on my decoder was flashing for less than a
second and then remained turned off for a little longer (but still less
than a second).

I tried different versions of alsa-driver, and versions prior to 1.0.5
were OK. I thought the problem is related to the fact that the
passthrough device changed from subdevice 2 to subdevice 3 in version
1.0.6, but it seems it is unrelated.

I checked out the CVS in my kernel source tree, and after playing with
different dates:

cvs up -D "1  Jul 2004" -- sound plays OK
cvs up -D "2  Jul 2004" -- sound skips heavily

However, there were a lot of changes between these two versions, some of
them pretty extensive, especially in the emu10k1 driver.

I sent the AC3 file with:

$ ac3dec -C city.ac3 
Using PCM device 'plug:iec958:{AES0 0x2 AES1 0x82 AES2 0x0 AES3 0x2}'
AC3 Stream 48.0 KHz 448 kbps

but the effect was identical to when using mplayer with -ac hwac3 on a
DVD for example.

-- 
 >   Georgi Georgiev    > Love thy neighbor as thyself, but choose      >
<     chutz@gg3.net    <  your neighborhood. -- Louise Beal            <
 >  +81(90)6266-1163    >                                               >


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
