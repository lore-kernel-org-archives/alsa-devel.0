From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 0/2] ALSA: pcm: implement the anonymous dup
	v3
Date: Thu, 31 Jan 2019 16:06:37 +0800
Message-ID: <20190131080637.GB6593@leoy-ThinkPad-X240s>
References: <20190130124139.10439-1-perex@perex.cz>
 <20190130223237.GK2804@sirena.org.uk>
 <CACL=Q7wH2VHCDgsASWSsOpA63-Y6jynsD7ZRbSYS1kLQ7_b60Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
 [209.85.166.66])
 by alsa0.perex.cz (Postfix) with ESMTP id B897D2673B8
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2019 09:06:56 +0100 (CET)
Received: by mail-io1-f66.google.com with SMTP id g8so1889429iok.4
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2019 00:06:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACL=Q7wH2VHCDgsASWSsOpA63-Y6jynsD7ZRbSYS1kLQ7_b60Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Phil Burk <philburk@google.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Baolin Wang <baolin.wang@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Phil & all,

On Wed, Jan 30, 2019 at 04:45:04PM -0800, Phil Burk wrote:
> Hello Mark,
> 
> Our security team was very concerned about the old ALSA FD. It provided too
> much access to the guts of ALSA.
> 
> I assume they will not like anything other than a plain
> "anon_inode:dmabuf". If it is a new FD, then the code would have to be
> reviewed. Even if it looked OK there might be some holes that we don't
> find. So it would probably be rejected.
> 
> I cannot speak for our security team so I am working on setting up a
> meeting or conversation between Mark and Zach, our security expert.
> 
> Adding the anon_inode:snd-pcm might be great for ALSA. That could be used
> by the HAL for STATUS and CONTROL. But it is likely that we will need an
> additional anon_inode:dmabuf FD that is only associated with the PCM
> buffer. It can then be safely passed to an Android app.

Thanks for the inputs.  I went through discussions, I'd like to divide the
work into two mainly parts:

- The first part is to use dmabuf to dynamically import buffer to
  sound device; so the buffer is not bound to sound device at the
  initialization phase;

- The second part is to use dmabuf to export buffer with anon_inode;
  thus it can meet the security requirement.

I go through Jaroslav implementation (thanks a lot for the quick moving
for this part!), it tries to implement the second part, but it misses
the first part support for dynamically binding audio buffer; and
as Mark/Phil mentioned, Jaroslav patch tries to use the same one FD
for both sound device and audio buffer.

I think it's good to firstly use one test case to demonstrate to
dynamically import buffer to sound device, then this buffer can be
exported with anon_inode for user space.  Is this doable?

Thanks,
Leo Yan

> On Wed, Jan 30, 2019 at 2:32 PM Mark Brown <broonie@kernel.org> wrote:
> 
> > On Wed, Jan 30, 2019 at 01:41:37PM +0100, Jaroslav Kysela wrote:
> > > This patchset contains the anonymous dup implementation with permissions
> > > checking for the ALSA's PCM interface in kernel to enable the restricted
> > > DMA sound buffer sharing for the restricted tasks.
> > >
> > > The code was tested through qemu and it seems to be pretty stable.
> > >
> > > The initial tinyalsa implementation can be found here:
> > >
> > >   https://github.com/perexg/tinyalsa/commits/anondup
> > >
> > > The filtering might be refined. It depends on the real requirements.
> > > Perhaps, we may create more ioctl groups. Any comments are more than
> > > welcome.
> >
> > My understanding based on some off-list discussion is that the Android
> > security people are going to see anything that involves passing more
> > than a block of memory (and in particular anything that gives access to
> > the sound APIs) as a problem.  That's obviously going to be an issue for
> > anything O_APPEND based.  My understanding is that this is fundamentally
> > a risk mitigation thing - by not having any of the sound kernel
> > interfaces available to the applications affected there's no possibility
> > that any problems in the sound code can cause security issues.
> >
