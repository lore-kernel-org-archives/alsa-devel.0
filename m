From: Phil Burk <philburk@google.com>
Subject: Re: [PATCH 0/2] ALSA: pcm: implement the anonymous dup
	v3
Date: Thu, 31 Jan 2019 07:48:06 -0800
Message-ID: <CACL=Q7ykqDEsaJzcxVexaaNCukw4yiNNQSGZLON=fXbJ7AH-9g@mail.gmail.com>
References: <20190130124139.10439-1-perex@perex.cz>
 <20190130223237.GK2804@sirena.org.uk>
 <s5hsgx9ckrf.wl-tiwai@suse.de> <20190131122624.GA20797@sirena.org.uk>
 <ae257dec-72b9-654c-6366-486e3d7ff836@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
 [209.85.166.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 97CE2267441
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2019 16:48:19 +0100 (CET)
Received: by mail-io1-f66.google.com with SMTP id r200so2966215iod.11
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2019 07:48:19 -0800 (PST)
In-Reply-To: <ae257dec-72b9-654c-6366-486e3d7ff836@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Zach Riggle <riggle@google.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org

+Zach Riggle <riggle@google.com>

Hello,

> Eventually, your security expert can freely join to our conversation here.

Thanks. The biggest unanswered question is whether Android security will
allow the file descriptor to be passed to an app. So I have added our
security person, Zach Riggle, who originally requested the
anon_inode:dmabuf FD.  If Zach is happy then I am happy.

We will need two file descriptors, one with full permissions for the HAL,
and one with only PCM access for the app to use.
It seems we are considering two options for the app's FD:
1) provide an anon_inode:dmabuf that never has CONTROL permissions, which
seems safe, but requires more changes to the driver and is a bit of a hack
2) provide an anon_inode:snd-pcm  that has CONTROL permissions turned off,
which seems seems less safe, but requires fewer changes and fits with the
design

Which one is actually better for security?

Here is an earlier argument for snd-pcm from Jaroslav:

My point is that the dma-buf -> sound pcm buffer maping interface is
> more complex, error prone and the code review/audit expensive than
> reusing the current code without any functionality or security benefits.
>


We can nicely restrict the file operations to allow to mmap only the pcm
> sound buffer and eventually, if we are too much paranoid (to bypass the
> the bitmap like permission checking as I suggested), we can create a
> special case for the Android usage to return the file descriptor with
> very restricted 'struct file_operations' with just the mmap and release
> callbacks. We can also change the name for this file descriptor to
> distinguish it from the "anon_inode:snd-pcm" (for example
> "anon_inode:snd-pcm-paranoid") to let SELinux do it's work properly.
>


The mmap implementation for the sound driver is few lines of the code
> (for the standard devices - very easy to review), so we cannot speak
> about security holes at all. If there is a problem with the kernel page
> allocation/management in the sound driver, there will be problem with
> dmabuf -> sound pcm buffer mapping, too (plus other problems caused by
> the concurrent access to the buffer which is managed /alloc/free/ by the
> sound driver - not dma-buf).


Also note that my emails bounce off the alsa-project mail list.

Phil Burk

On Thu, Jan 31, 2019 at 5:30 AM Jaroslav Kysela <perex@perex.cz> wrote:

> Dne 31.1.2019 v 13:26 Mark Brown napsal(a):
> > On Thu, Jan 31, 2019 at 09:08:04AM +0100, Takashi Iwai wrote:
> >> Mark Brown wrote:
> >
> >>> anything O_APPEND based.  My understanding is that this is
> fundamentally
> >>> a risk mitigation thing - by not having any of the sound kernel
> >>> interfaces available to the applications affected there's no
> possibility
> >>> that any problems in the sound code can cause security issues.
> >
> >> The patch 2 implements exactly that kind of access restriction, so
> >> that the passed fd won't do anything else than wished.
> >
> > Yeah.
> >
> >> If we want to be super-conservative, the implementation could be even
> >> simpler -- instead of filtering, we may pass a minimum fd ops that
> >> contains only mmap and release for the anon-dup fd...
> >
> > I think that'd definitely help address the concerns.
>
> A possible implementation:
>
>
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=ca15bc69a984cc0eae2c43d0a49c66a20c937f39
>
>                                 Jaroslav
>
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
>
