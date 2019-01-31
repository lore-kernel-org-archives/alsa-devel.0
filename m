From: Phil Burk <philburk@google.com>
Subject: Re: [PATCH 0/2] ALSA: pcm: implement the anonymous dup
	v3
Date: Wed, 30 Jan 2019 16:45:04 -0800
Message-ID: <CACL=Q7wH2VHCDgsASWSsOpA63-Y6jynsD7ZRbSYS1kLQ7_b60Q@mail.gmail.com>
References: <20190130124139.10439-1-perex@perex.cz>
 <20190130223237.GK2804@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it1-f195.google.com (mail-it1-f195.google.com
 [209.85.166.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 594A82673DD
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2019 01:45:17 +0100 (CET)
Received: by mail-it1-f195.google.com with SMTP id z7so1319848iti.0
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 16:45:17 -0800 (PST)
In-Reply-To: <20190130223237.GK2804@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Leo Yan <leo.yan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

Our security team was very concerned about the old ALSA FD. It provided too
much access to the guts of ALSA.

I assume they will not like anything other than a plain
"anon_inode:dmabuf". If it is a new FD, then the code would have to be
reviewed. Even if it looked OK there might be some holes that we don't
find. So it would probably be rejected.

I cannot speak for our security team so I am working on setting up a
meeting or conversation between Mark and Zach, our security expert.

Adding the anon_inode:snd-pcm might be great for ALSA. That could be used
by the HAL for STATUS and CONTROL. But it is likely that we will need an
additional anon_inode:dmabuf FD that is only associated with the PCM
buffer. It can then be safely passed to an Android app.

Thanks,
Phil Burk


On Wed, Jan 30, 2019 at 2:32 PM Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jan 30, 2019 at 01:41:37PM +0100, Jaroslav Kysela wrote:
> > This patchset contains the anonymous dup implementation with permissions
> > checking for the ALSA's PCM interface in kernel to enable the restricted
> > DMA sound buffer sharing for the restricted tasks.
> >
> > The code was tested through qemu and it seems to be pretty stable.
> >
> > The initial tinyalsa implementation can be found here:
> >
> >   https://github.com/perexg/tinyalsa/commits/anondup
> >
> > The filtering might be refined. It depends on the real requirements.
> > Perhaps, we may create more ioctl groups. Any comments are more than
> > welcome.
>
> My understanding based on some off-list discussion is that the Android
> security people are going to see anything that involves passing more
> than a block of memory (and in particular anything that gives access to
> the sound APIs) as a problem.  That's obviously going to be an issue for
> anything O_APPEND based.  My understanding is that this is fundamentally
> a risk mitigation thing - by not having any of the sound kernel
> interfaces available to the applications affected there's no possibility
> that any problems in the sound code can cause security issues.
>
