From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: 2.5 kbuild: use of '-z muldefs' for LD?
Date: Mon, 9 Jun 2003 16:01:41 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306091550000.1323-100000@pnote.perex-int.cz>
References: <20030609130438.A6417@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (UNKNOWN@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA07541
	for <alsa-devel@alsa-project.org>; Mon, 9 Jun 2003 16:01:55 +0200
In-Reply-To: <20030609130438.A6417@infradead.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Christoph Hellwig <hch@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA development <alsa-devel@alsa-project.org>, "kbuild-devel@lists.sourceforge.net" <kbuild-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 9 Jun 2003, Christoph Hellwig wrote:

> On Mon, Jun 09, 2003 at 01:56:59PM +0200, Jaroslav Kysela wrote:
> > one object file for more targets. Example:
> > 
> > ------
> > snd-ice1712-objs := ice1712.o delta.o hoontech.o ews.o ak4xxx.o
> > snd-ice1724-objs := ice1724.o amp.o revo.o aureon.o ak4xxx.o
> > 
> > # Toplevel Module Dependency
> > obj-$(CONFIG_SND_ICE1712) += snd-ice1712.o
> > obj-$(CONFIG_SND_ICE1724) += snd-ice1724.o
> > ------
> > 
> > The ak4xxx.o module is shared and has defined a few public functions.
> > Unfortunately, the default build-in.o rule fails when targets are 
> > requested to be included into the solid kernel because the public 
> > functions are duplicated in snd-ice1712.o and snd-ice17124.o.
> > 
> > I can instruct the ld compiler to ignore the multiple definitions using 
> > '-z muldefs':
> > 
> > EXTRA_LDFLAGS = -z muldefs
> > 
> > But it seems like a hack for me.
> > Does anybody have another idea to solve my problem?
> 
> Move ak4xxx.o out of the multi-obj rules.  Just declare a new helper-
> config option CONFIG_SND_AK4XXX that gets defined by all drivers
> using it and add
> 
> obj-$(CONFIG_SND_AK4XXX)	+= ak4xxx.o
> 
> You'll just have to make sure to export all symbols in 2.5

But this solution will create a new kernel module. The shared code is 
really small and having small codes in separated modules is waste of 
memory in my eyes.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
