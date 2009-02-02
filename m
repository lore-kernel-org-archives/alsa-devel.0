From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Confusion about
	whether	snd_pcm_poll_descriptors_revents()'s revents field is
	a single	integer or an array
Date: Mon, 2 Feb 2009 15:49:13 +0100
Message-ID: <20090202144912.GA32202@tango.0pointer.de>
References: <20090202025021.GA20642@tango.0pointer.de>
	<s5hwsc98goq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FE0B24342
	for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2009 15:49:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hwsc98goq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 02.02.09 08:02, Takashi Iwai (tiwai@suse.de) wrote:

> > If we look into the pcm example how snd_pcm_poll_descriptors_revents()
> > is used then we can see that the revents parameter apparently is
> > supposed to be a single integer. (which makes a lot of sense to me)
> > 
> > http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html#a33
> > 
> > However, snd_pcm_wait_nocheck() calls the same function and assumes it
> > is a complete array!
> > 
> > http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/pcm/pcm.c;h=74d1d1a4bd6083cd461b6d793c0ae41cca912f16;hb=HEAD#l2368
> > 
> > So what's it now? It makes more sense to me if it would be a single
> > fd. 
> 
> No, it's a bug in test/pcm.c.  As documented, the API converts (fixes)
> each poll_fd in the given array.

But does that really make sense? I mean
snd_pcm_poll_descriptors_revents() is supposed to be called by
applications that integrate ALSA into some kind of event loop. What
are they supposed to do with those multiple entries -- except simply
ORing them together and treating them as one? The application has no
information what those seperate fds mean, so why export that
information to the app?

>From an application's point of view, how is revents[0] = POLLIN,
revents[1] = 0 in any way different than revents[0] = 0, revents[1] =
POLLIN?

Also, a quick search with google code search reveals that everyone
trusted the doxygen docs and treated revents as a single integer:

http://www.google.de/codesearch?num=30&hl=en&safe=off&client=firefox-a&rls=org.mozilla%3Aen-US%3Aofficial&hs=V74&q=snd_pcm_poll_descriptors_revents&btnG=Search

For example, the following systems treat it as a single integer:

PortAudio
mplayer
allegro
wine
clalsadrv
arts
alsa-oss
disorder
alsaplayer
mumble
PulseAudio

and that list goes on and on and on. In fact I couldn't find a single
package treating it is array. Really declaring this now an array will
hence result in breakage in lots and lots of applications.

Maybe the implementation should now actually follow the documentation
and make it really a single integer, given that this makes more sense
to the user anyway?

Also, what's the point of having the revents parameter anyway if it's
just about demangling the pollfd array? I mean, then you could simply
do this in place.  It's not just the documentation and the example
that suggest that this is a single integer, it's also the simple
signature of the function that suggests so.

So, please, make this a single integer. Really going back to making it
an array sounds like an awful solution to me.

BTW, pfds in snd_pcm_poll_descriptors_revents could use a 'const'.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
