From: Shaju Abraham <shaju@multitech.co.in>
Subject: ALSA hangs under load
Date: Thu, 18 Jul 2002 12:23:35 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3665EF.314AAFB7@multitech.co.in>
References: <1023918629.1921.8.camel@localhost.localdomain> <s5hadp8snjz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, perex@suse.cz
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,
         We usedALSA driver version( 0.5.12a)  on i810 motherboard, Red Hat
7.1 kernel 2.4.4.

We played a mp3 song using mpg123. when the song was being played, we opened
about 20 to 25 konsole windows and netscape navigators, ALSA stopped playing
the song.  After all windows were opened by linux, we checked the dmesg and
found that pcm_lib.c debug msg ----   DMA or IRQ problem?  ----   being
repeated.  cat /proc/interrupts repeatedly used shows that the number of ICH
interrupts does not increase at all.  Meaning ICH interrupts are no longer
being received at all.   Why does this happen? Is it a bug in ALSA?

--Shaju Abraham



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
