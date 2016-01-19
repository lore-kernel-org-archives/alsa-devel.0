From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: builidng alsa-utils
Date: Tue, 19 Jan 2016 12:16:44 +0100
Message-ID: <569E1B1C.8020602@ladisch.de>
References: <20160119105625.GS11130@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 5166B260534
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 12:16:45 +0100 (CET)
In-Reply-To: <20160119105625.GS11130@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Vinod Koul wrote:
> I was trying to build alsa-utils (lib built fine) but it seems stuck on
> libpanelw.
> ...
> checking for ncursesw5-config... yes
> checking for curses library... ncursesw
> checking for curses header name... <ncurses.h>
> checking for curses compiler flags... -I/usr/include/ncursesw
> checking for curses NLS support... yes
> ...
> checking for new_panel in -lpanelw... no
> configure: error: panelw library not found
>
> And I have panelw
>
> $ locate libpanelw
> /usr/lib/x86_64-linux-gnu/libpanelw.so.5
> /usr/lib/x86_64-linux-gnu/libpanelw.so.5.9
>
> And created symbolic link
>
> $ ll /usr/lib/x86_64-linux-gnu/libpanelw*
> lrwxrwxrwx 1 root root    40 Jan 19 15:14 /usr/lib/x86_64-linux-gnu/libpanelw.so -> /usr/lib/x86_64-linux-gnu/libpanelw.so.5
>
> Any reasons this would happen?

So it works now?  That missing link would appear to be a bug of your
distribution's package.

> Btw if it do
> ./gitcompile --with-curses=ncurses --disable-xmlto
> it works fine

This does not uses libpanelw but libpanel (which apparently exists).
(w = wide-character support for non-ASCII locales)


Regards,
Clemens
