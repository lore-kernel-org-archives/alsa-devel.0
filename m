From: Jaroslav Kysela <perex@suse.cz>
Subject: ALSA 1.0.4 release
Date: Sat, 3 Apr 2004 13:45:12 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0404031326570.2140@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
Cc: ALSA Announce <alsa-announce@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello all,

	the 1.0.4 release is out. It contains mostly bug-fixes and 
cleanups for the 2.6 kernel driver code.

alsa-driver
 - recoded the configuration system to use 2.6 Kconfig files
   as the dependency source
 - updated/simplifies Kconfig files and Make files
 - driver DMA API recoded - idea from Russell King
 - USB driver updates and cleanups
 - ICE1712 driver updated
   - num_total_adcs variable
   - cs8427_timeout
 - fixed event translating in the OSS sequencer emulation
 - AC97 codec driver updates
 - extended silence PCM API (silence only unused portiong of the ring buffer)
 - moved au88x0 drivers to alsa-kernel (2.6)
 - moved atiixp driver to alsa-kernel (2.6)
 - moved intel8x0m driver to alsa-kernel (2.6)
 - moved MPU401 ACPI code to alsa-kernel (2.6)
 - added USB 2.0 support to USB driver
 - no more oops in snd_pcm_timer_resolution_change()
 - tons of small fixes not listed here
alsa-lib
 - dmix fixes (already released in 1.0.3+ versions)
 - direct plugin fixes (already released in 1.0.3+ versions)
 - pcm_rate plugin fixes
alsa-utils
 - aplay/arecord - fixed timeout overflow
 - alsaconf - updated
alsa-tools
 - updated envy24control
 - updated all tools to not use driver header files
alsa-oss
 - various fixes (poll/select/mmap)


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
