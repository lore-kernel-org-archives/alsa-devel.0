From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dmix plugin
Date: Wed, 12 Feb 2003 14:32:33 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302121411370.15382-100000@pnote.perex-int.cz>
References: <20030212125323.C75F059D34D@kerberos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA05589
	for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2003 14:32:43 +0100
In-Reply-To: <20030212125323.C75F059D34D@kerberos.suse.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Feb 2003, Paul Davis wrote:

> >	a next step to get the lowlatency sharing of exclusive PCM devices 
> >is in ALSA CVS - the dmix (direct mixing) plugin..
> >	How it works? Basically, the playback in driver runs forewer
> >without any xrun detection. The ring buffer (only just played areas) is
> >also silenced in each interrupt. Then we have multiple clients and a
> >process (server) which passes the file descriptor of playback devices to
> >them. The server also takes care about freeing of used shm memory and
> >semaphore.
> >	The big step forward is that we share one mmaped ring buffer
> >accross many processes and each process can add samples into it without
> >any process<->kernel swaps. Also, each processes are independant, thus
> >failing of one doesn't break others. It's not multithreaded, we don't need
> >this mechanism.
> 
> this all sounds fabulous, but could you explain a little about what is
> actually going on here? i'd like to understand the
> architecture/mechanism a little more deeply in ways that reading the
> source probably won't provide. 

I'll talk about the dmix plugin on LAD meeting in Karlsruhe, but the main
part (as for aserver) is the unix ability to send an active file
descriptor over unix socket (see send_fd() function in pcm_dmix.c and
snd_receive_fd() function in pcm_shm.c). Then we can mmap control
(appl_ptr), status (hw_ptr) and the DMA ring buffer from the driver's PCM
stream more times - ALSA driver supports it - for each client process
separately.

Once we have the hardware pointer which is updated from the interrupt
handler and the ring buffer common for each processes, it's sufficient to
add samples to the ring buffer at right time. Also, the interrupt handler
in the driver takes care about silencing of just played area before
hardware pointer is updated, thus we are sure, that samples won't be
played/accumulated more times.

Also, I use as the poll source the slave timer for the playback PCM 
stream. Slave timers can have multiple instances.
 
> this will be a godsend for consumer audio apps, thats for sure!

We can create more plugins in this way (a new version of share plugin to
share channels among processes, a tee plugin for capture etc..).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
