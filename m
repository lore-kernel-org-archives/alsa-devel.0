From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Q: is the ALSA-lib API thread-safe
Date: Thu, 5 Aug 2004 14:51:13 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408051440270.1906@pnote.perex-int.cz>
References: <200408051231.i75CVUt8027083@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200408051231.i75CVUt8027083@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 5 Aug 2004, Paul Davis wrote:

> >Daniel Schnell wrote:
> >> is the ALSA-Lib-API thread-safe concerning the following scenario:
> >>
> >> in thread 1 the audio-processing takes place via snd_pcm_avail_update(),
> >> snd_pcm_begin(), snd_pcm_commit(). In thread 2 I call the functions:
> >> snd_pcm_hwsync(), snd_pcm_avail_update() to get the actual delay via
> >> bufferframes - snd_pcm_avail_update().
> >
> >The snd_pcm_t* handle which you're using in both threads refers to one
> >data structure in alsa-lib which isn't protected against concurrent
> >accesses.
> 
> how true. its a bit ironic that one of the big advances of ALSA's
> kernel code over OSS is the addition of thread safety, and that
> another is the use of a user-space library to mediate access. the
> combination of the two, however, eliminates thread safety :(

Above scenario seems worth to support. Also I cannot imagine other 
useability to make other functions reentrant.

The avail_update() + mmap + r/w functions are not much reentrant, but 
you may use in the second thread snd_pcm_delay() which should be
(not verified) reentrant and callable at any time without influence
for avail_update() + r/w operations.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
