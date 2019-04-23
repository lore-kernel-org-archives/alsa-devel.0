From: Phil Burk <philburk@google.com>
Subject: Re: [PATCH 0/2 v4] ALSA: pcm: anonymous dup
	implementation
Date: Tue, 23 Apr 2019 13:11:50 -0700
Message-ID: <CACL=Q7xSpeqyQzDyexCr+Nxs+nf3o9doaHGxiu-y8biK9w_9YQ@mail.gmail.com>
References: <20190204093910.23878-1-perex@perex.cz>
 <20190326140928.GC10898@sirena.org.uk>
 <s5hva0567vs.wl-tiwai@suse.de>
 <CACL=Q7we61BwO81W7tQFvb9ohkBZkk34DSXL2B-Ky2B6zfWk1A@mail.gmail.com>
 <f5b429c6-803c-b624-6d39-5001c76e892f@perex.cz> <s5hd0lcppbn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E213F8070C
 for <alsa-devel@alsa-project.org>; Tue, 23 Apr 2019 22:12:03 +0200 (CEST)
Received: by mail-io1-xd44.google.com with SMTP id i21so13185366iol.7
 for <alsa-devel@alsa-project.org>; Tue, 23 Apr 2019 13:12:03 -0700 (PDT)
In-Reply-To: <s5hd0lcppbn.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Baolin Wang <baolin.wang@linaro.org>, Zach Riggle <riggle@google.com>, Mark Brown <broonie@kernel.org>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

Sorry for the late reply. I got pulled off on some other projects.

We will try to test this in-house but we will need Qualcomm's help.
I will also try to get some of our SOC partners to help with testing.

> If we miss it, it'll be postponed at least for 5.3,
> i.e. more three months.

I think it will be difficult to complete the testing before that 5.2
deadline.
We should probably shoot for 5.3. If someone needs it sooner that they will
have the patches.

Thanks again for all this work.

I assume the four emails below have all the latest patches needed for rev 6.

Thanks,
Phil Burk


On Tue, Apr 23, 2019 at 11:08 AM Takashi Iwai <tiwai@suse.de> wrote:

> On Tue, 26 Mar 2019 15:41:11 +0100,
> Jaroslav Kysela wrote:
> >
> > Dne 26. 03. 19 v 15:27 Phil Burk napsal(a):
> > > Hello,
> > >
> > > Thanks for keeping this moving forward.
> > >
> > > Any suggestions for testing this? We can try to test it here in
> Android. It may be tricky because your patches may conflict with some
> proprietary Qualcomm changes in the kernel we are currently using.
> > >
> > > Can I get a summary list of the patches required for kernel and
> tinyalsa?
> >
> > The v6 is the last version, the full information is in the cover letter:
> >
> >
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-February/145127.html
> >
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-February/145128.html
> >
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-February/145129.html
> >
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-February/145130.html
>
> Is there any test result from the practical use cases?
>
> Basically now is the last chance for merging such an intrusive change
> for 5.2 kernel.  If we miss it, it'll be postponed at least for 5.3,
> i.e. more three months.
>
>
> thanks,
>
> Takashi
>
>
> >
> >                                               Jaroslav
> >
> > >
> > > Thanks,
> > > Phil Burk
> > >
> > >
> > > On Tue, Mar 26, 2019 at 7:13 AM Takashi Iwai <tiwai@suse.de <mailto:
> tiwai@suse.de>> wrote:
> > >
> > >     On Tue, 26 Mar 2019 15:09:28 +0100,
> > >     Mark Brown wrote:
> > >     >
> > >     > On Mon, Feb 04, 2019 at 10:39:08AM +0100, Jaroslav Kysela wrote:
> > >     > > This patchset contains the anonymous dup implementation with
> permissions
> > >     > > checking for the ALSA's PCM interface in kernel to enable the
> restricted
> > >     > > DMA sound buffer sharing for the restricted tasks.
> > >     >
> > >     > Is there any news on merging this during the current development
> cycle,
> > >     > or anything else needed to move this forwards?
> > >
> > >     I've seen no reaction whether the patch really tested, worked or
> > >     helped in the real scenario...
> > >
> > >
> > >     Takashi
> > >
> >
> >
> > --
> > Jaroslav Kysela <perex@perex.cz>
> > Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
> >
>
