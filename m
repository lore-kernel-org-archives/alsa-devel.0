From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [BUG] alsa-lib leaves sound device open for child
 processes
Date: Wed, 12 Feb 2003 13:46:29 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302121305320.15382-100000@pnote.perex-int.cz>
References: <s5hptpxn27z.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hptpxn27z.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Sebastian Kapfer <sebastian_kapfer@web.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "rankincj@yahoo.com" <rankincj@yahoo.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Feb 2003, Takashi Iwai wrote:

> At Sat, 8 Feb 2003 20:53:14 +0100 (CET),
> Jaroslav wrote:
> > 
> > On Sat, 8 Feb 2003, Sebastian Kapfer wrote:
> > 
> > > On Sat, 8 Feb 2003 12:50:01 +0100 (CET)
> > > Jaroslav Kysela <perex@suse.cz> wrote:
> > > 
> > > > > All of the remaining applications should be
> > > > > considering what will happen to their resources on
> > > > > exec(), and I see no reason why careless programmers
> > > > > should have a few of their bugs swept under the rug
> > > > > for them.
> > > > 
> > > > I fully agree here.
> > > 
> > > Can anyone comment on exactly how an alsa-lib client app should make
> > > sure that exec'd processes don't inherit file handles? I can't find a
> > > way to know the FD number which alsa-lib uses. snd_pcm_file_descriptor
> > > is gone. What replaced it?
> > 
> > The applications should use snd_pcm_close() function (or related one 
> > snd_*_close()). Note that more complex plugins can use more file 
> > descriptors so the application is not able to enumerate them.
> 
> maybe it's just whipping a dead horse, but let me take this issue back
> again.
> 
> 
> there might be some situations in which you cannot call *_close()
> functions.  for example, if you are sharing the handle with several
> threads and want to start an external program from one of the
> threads.
> 
> in such a case, the only correct method is to call fcntl(CLOEXEC).

Not really:

	int i = sysconf(_SC_OPEN_MAX);
	while (--i >= 3) {
		if (i != do_not_close_fd[])
			close(i);
	}
	exec(...);

But it's true that the application cannot filter ALSA's file descriptors 
in this case (to pass only specific interfaces to executed process). We 
have similar troubles with shm.

I'd propose to have a function 'snd_pcm_free_system_resources()' which 
will close all open file descriptors, detaches all shm handles and cleans 
all resources necessary before exec() or after fork():

int snd_pcm_free_system_resources(snd_pcm_t *pcm, int memory);

When memory != 0, it will free all memory resources.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
