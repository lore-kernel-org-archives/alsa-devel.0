From: juan <jcb@niluge.net>
Subject: Re: alsa => hardware freeze on laptop
Date: Tue, 9 Sep 2003 22:53:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030909205308.GA17854@zeus.homenet>
References: <20030905072618.GB3567@athena> <s5h4qzlu8u5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h4qzlu8u5.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 09 September, 2003 � 08:15:30PM +0200, Takashi Iwai wrote:
> At Fri, 5 Sep 2003 09:26:18 +0200,
> juan wrote:
> > 
> > hi,
> > 
> > i have a dell c600 and it randmonly freezes when i load the maestro3
> > driver. my only choice is to reboot.
> 
> at which stage does it freeze?  immediately after loading the module?

something like 2 seconds after i load the modules.
again, it does not happened every time. it can happened 10 times in a
row, and then no problemes for a few days.

i really don't understand, i guess some irq problem somewhere

> > i have no idea what can be the cause and how i can track the problem.
> > 
> > i tried inserting printks in maestro3.c but they are not great help .
> 
> can you get alt+sysrq control at panic?

no i can't. even the fn+f1 (for dell bios) does not work


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
