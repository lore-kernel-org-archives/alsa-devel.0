From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: smix plugin available?
Date: Wed, 27 Nov 2002 15:39:22 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211271538130.532-100000@pnote.perex-int.cz>
References: <E18H2SF-0005Yo-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18H2SF-0005Yo-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, Florian Bomers <Florian.Bomers@sun.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Nov 2002, Paul Davis wrote:

> >Sorry, it's not as easy as you've described. It's not possible to invoke
> >any user code from the kernel code directly. There is a scheduler which is
> >informed that a task has been woken up. It depends on scheduler when the
> >task is really invoked. It's quite same as for the r/w model where the
> >application is notified over poll that something occured.
> 
> i think we can consider the behaviour of the kernel scheduler when it
> schedules a SCHED_FIFO task after an audio interface interrupt has
> woken it to be very, very close to the kind of callback system james
> is describing. ditto for any kind of wakeup of a SCHED_FIFO task
> (e.g. when its woken by a write to pipe, or a signal).
> 
> its not perfect, as i am very disappointed to discover, but its also
> very close. 

If you have more processes with same priority, the time gaps might be 
noticable as well.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
