From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH]alsa-driver-0.9.6/acore/hwdep.c
Date: Thu, 4 Sep 2003 20:45:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0309042045200.6731@pnote.perex-int.cz>
References: <200309041842.31333.annabellesgarden@yahoo.de>
 <Pine.LNX.4.53.0309042012160.6731@pnote.perex-int.cz> <s5hznhk2z1r.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznhk2z1r.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 4 Sep 2003, Takashi Iwai wrote:

> At Thu, 4 Sep 2003 20:12:38 +0200 (CEST),
> Jaroslav wrote:
> >
> > On Thu, 4 Sep 2003, Karsten Wiese wrote:
> >
> > > Hi,
> > >
> > > I'm trying the hwdep interface with poll().
> > > looking for reasons why removal of USB-device caused bad MAGIC in hwdep.c,
> > > I found this solution:
> >
> > Thanks. Applied with small changes to fix the error path.
>
> shouldn't we add also module_get/put() ?

Yes, we should. Done.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
