From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Confusion about whether
 snd_pcm_poll_descriptors_revents()'s revents field is a single integer or
 an array
Date: Mon, 2 Feb 2009 16:02:38 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0902021556520.7902@tm8103.perex-int.cz>
References: <20090202025021.GA20642@tango.0pointer.de>
	<s5hwsc98goq.wl%tiwai@suse.de>
	<20090202144912.GA32202@tango.0pointer.de>
	<s5heiygevmx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id BC69224358
	for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2009 16:02:38 +0100 (CET)
In-Reply-To: <s5heiygevmx.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Mon, 2 Feb 2009, Takashi Iwai wrote:

> At Mon, 2 Feb 2009 15:49:13 +0100,
> Lennart Poettering wrote:
> > 
> > On Mon, 02.02.09 08:02, Takashi Iwai (tiwai@suse.de) wrote:
> > 
> > > > If we look into the pcm example how snd_pcm_poll_descriptors_revents()
> > > > is used then we can see that the revents parameter apparently is
> > > > supposed to be a single integer. (which makes a lot of sense to me)
> > > > 
> > > > http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html#a33
> > > > 
> > > > However, snd_pcm_wait_nocheck() calls the same function and assumes it
> > > > is a complete array!
> > > > 
> > > > http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/pcm/pcm.c;h=74d1d1a4bd6083cd461b6d793c0ae41cca912f16;hb=HEAD#l2368
> > > > 
> > > > So what's it now? It makes more sense to me if it would be a single
> > > > fd. 
> > > 
> > > No, it's a bug in test/pcm.c.  As documented, the API converts (fixes)
> > > each poll_fd in the given array.
> > 
> > But does that really make sense? I mean
> > snd_pcm_poll_descriptors_revents() is supposed to be called by
> > applications that integrate ALSA into some kind of event loop. What
> > are they supposed to do with those multiple entries -- except simply
> > ORing them together and treating them as one? The application has no
> > information what those seperate fds mean, so why export that
> > information to the app?
> 
> Originally the multiple pfds were introduced to handle multi plugin,
> which bundles multiple instances.  So, the original version of it was
> pretty straightforward -- just simply calls poll to each and update
> each pfd necessarily.

But snd_pcm_poll_descriptors_revents() was designed to return single 
value originally. Multiple fds were never used in pcm_multi for 
revents, too. Also, snd_pcm_wait() was OK (in the sense revents 
callback) before:

commit d5b98234478680c4afdf475988b8952605f66ff8
Author: Takashi Iwai <tiwai@suse.de>
Date:   Wed May 18 13:28:06 2005 +0000

    Fix snd_pcm_wait() for multiple pollfd's

    Fixed snd_pcm_wait() to handle multiple pollfd's.


					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
