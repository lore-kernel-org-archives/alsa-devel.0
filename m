From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dsnoop issues
Date: Fri, 27 Apr 2007 15:18:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0704271512050.8211@tm8103.perex-int.cz>
References: <4631EC14.2060802@btinternet.com> <s5h4pn2yovg.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0704271446570.8211@tm8103.perex-int.cz>
	<s5hzm4ux8uh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id C362424344
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2007 15:18:53 +0200 (CEST)
In-Reply-To: <s5hzm4ux8uh.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 27 Apr 2007, Takashi Iwai wrote:

> At Fri, 27 Apr 2007 15:00:22 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > On Fri, 27 Apr 2007, Takashi Iwai wrote:
> > 
> > > Actually, the documentation is wrong, IMO.  The typical behavior of
> > > read syscall is that it returns a value actually read by that call.
> > > It doesn't guarantee whether the requested size is filled, and can be
> > > shorter than requested.  As snd_pcm_readi() emulates the read syscall,
> > > it should behave in that way.
> > 
> > I don't think so completely. For blocking mode (!O_NONBLOCK), all possible 
> > data should be read. Only signal or an error should break this.
> > 
> > The read logic for dsnoop is in snd_pcm_read_areas() in pcm/pcm.c 
> > (alsa-lib).
> 
> In the current implementation, it may work in that way.  But, in
> general, I'm against such a condition.  It's not what read syscalls
> does, so there is no real reason that snd_pcm_readi() should do so.

Well 'man 2 read' exactly explains when a less count than requested might 
be returned for blocking behaviour. I'm missing something? Of course, 
applications should not expect to read all possible frames, but under 
normal conditions, less count should be returned in rare cases (for 
the blocking mode, of course).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
