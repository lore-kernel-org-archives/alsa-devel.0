From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: builidng alsa-utils
Date: Tue, 19 Jan 2016 21:35:38 +0530
Message-ID: <20160119160537.GT11130@localhost>
References: <20160119105625.GS11130@localhost>
 <569E1B1C.8020602@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E16E261A5A
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 17:02:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <569E1B1C.8020602@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 19, 2016 at 12:16:44PM +0100, Clemens Ladisch wrote:
> Vinod Koul wrote:
> > I was trying to build alsa-utils (lib built fine) but it seems stuck on
> > libpanelw.
> > ...
> > checking for ncursesw5-config... yes
> > checking for curses library... ncursesw
> > checking for curses header name... <ncurses.h>
> > checking for curses compiler flags... -I/usr/include/ncursesw
> > checking for curses NLS support... yes
> > ...
> > checking for new_panel in -lpanelw... no
> > configure: error: panelw library not found
> >
> > And I have panelw
> >
> > $ locate libpanelw
> > /usr/lib/x86_64-linux-gnu/libpanelw.so.5
> > /usr/lib/x86_64-linux-gnu/libpanelw.so.5.9
> >
> > And created symbolic link
> >
> > $ ll /usr/lib/x86_64-linux-gnu/libpanelw*
> > lrwxrwxrwx 1 root root    40 Jan 19 15:14 /usr/lib/x86_64-linux-gnu/libpanelw.so -> /usr/lib/x86_64-linux-gnu/libpanelw.so.5
> >
> > Any reasons this would happen?
> 
> So it works now?  That missing link would appear to be a bug of your
> distribution's package.

Nope even adding this link does not make it work :(

I am on Ubuntu 14.04 LTS and latest greatest packages and was trying to build
latest lib and utils from git

> > Btw if it do
> > ./gitcompile --with-curses=ncurses --disable-xmlto
> > it works fine
> 
> This does not uses libpanelw but libpanel (which apparently exists).
> (w = wide-character support for non-ASCII locales)

Thanks for explanation, this is the only way it worked for me
-- 
~Vinod
