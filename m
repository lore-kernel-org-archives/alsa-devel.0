From: Vinod Koul <vinod.koul@intel.com>
Subject: builidng alsa-utils
Date: Tue, 19 Jan 2016 16:26:26 +0530
Message-ID: <20160119105625.GS11130@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A2749260534
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 11:52:41 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I was trying to build alsa-utils (lib built fine) but it seems stuck on
libpanelw. I did quick google the symbolic links and packages seems to be
there, what am i missing

checking for alsa/pcm.h... yes
checking for alsa/mixer.h... yes
checking for alsa/rawmidi.h... yes
checking for alsa/seq.h... yes
checking for alsa/use-case.h... yes
checking for alsa/topology.h... yes
checking for samplerate.h... no

This doesnt block now, but which package is required for this

checking for fftw_malloc in -lfftw3... yes
checking for sqrtf in -lm... yes
checking for pthread_create in -lpthread... yes
checking for librt... checking for clock_gettime in -lrt... yes
checking for xmlto... yes
checking for ANSI C header files... yes
checking for NCURSESW... no
checking for ncursesw5-config... yes
checking for curses library... ncursesw
checking for curses header name... <ncurses.h>
checking for curses compiler flags... -I/usr/include/ncursesw
checking for curses NLS support... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking panel.h usability... yes
checking panel.h presence... yes
checking for panel.h... yes
checking menu.h usability... yes
checking menu.h presence... yes
checking for menu.h... yes
checking form.h usability... yes
checking form.h presence... yes
checking for form.h... yes
checking for new_panel in -lpanelw... no
configure: error: panelw library not found

And I have panelw

$ locate libpanelw
/usr/lib/x86_64-linux-gnu/libpanelw.so.5
/usr/lib/x86_64-linux-gnu/libpanelw.so.5.9

And created symbolic link

$ ll /usr/lib/x86_64-linux-gnu/libpanelw*
lrwxrwxrwx 1 root root    40 Jan 19 15:14 /usr/lib/x86_64-linux-gnu/libpanelw.so -> /usr/lib/x86_64-linux-gnu/libpanelw.so.5
lrwxrwxrwx 1 root root    16 Apr 28  2015 /usr/lib/x86_64-linux-gnu/libpanelw.so.5 -> libpanelw.so.5.9
-rw-r--r-- 1 root root 14240 Mar 23  2014 /usr/lib/x86_64-linux-gnu/libpanelw.so.5.9

Any reasons this would happen? Btw if it do
./gitcompile --with-curses=ncurses --disable-xmlto it works fine

Thanks
-- 
~Vinod
