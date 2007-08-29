From: "Maxim Levitsky" <maximlevitsky@gmail.com>
Subject: Re: [PATCH] STAC92xx : add support for missing features
Date: Thu, 30 Aug 2007 01:17:05 +0300
Message-ID: <6d1efe520708291517yd98559cp78852213e49c3d08@mail.gmail.com>
References: <200708280454.29250.maximlevitsky@gmail.com>
	<s5hy7fw2b0e.wl%tiwai@suse.de>
	<1188309336.31933.25.camel@razman.gruemaster.com>
	<200708282141.32222.maximlevitsky@gmail.com>
	<s5htzqi1xot.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.229])
	by alsa0.perex.cz (Postfix) with ESMTP id D68B610386D
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Aug 2007 00:17:06 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id t11so333355wxc
	for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2007 15:17:05 -0700 (PDT)
In-Reply-To: <s5htzqi1xot.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, mranostay@embeddedalley.com
List-Id: alsa-devel@alsa-project.org

2007/8/29, Takashi Iwai <tiwai@suse.de>:
> At Tue, 28 Aug 2007 21:41:32 +0300,
> Maxim Levitsky wrote:
> >
> > > > About 3 (volume-knob), we'd need a bit more checks and tests.  Does
> > > > the volume knob widget work always as a mater control regardless
> > > > whetehr the real hardware component exists or not?  I.e. can we use it
> > > > blindly?
> > According to datasheet, it works, also driver already assumes it there, and sets it to maximum volume
> > see hda_verb stac922x_core_init, hda_verb d965_core_init, hda_verb stac927x_core_init,hda_verb stac9205_core_init
>
> Interesting.  So, writing to the volume knob widget actually works
> just like a normal mixer amp?
Yes, but volumeknob doesn't support standard verbs that amps do, thus
I coded it as a custom control, but generally it is a amp
>
> > > >
> > > > Tobin, Matt, could you test these patches, especially patch 3, with
> > > > your hardwares?  Anyone who has STAC92xx hardwares are welcome for
> > > > testing it, too!
> > > >
> > > >
> > > > Thanks,
> > > >
> > > > Takashi
> > >
> >
> > Hi,
> >
> > Thanks for review, I will fix all things you pointed out, but
> > I am coding against latest linus' kernel tree, and snd_ctl_boolean_mono_info() isn't there, and thus I didn't use it,
> > I will download latest alsa tree, and compile against it
> >
> > But I have a question: can I only complile snd-hda-intel from that tree, and leave kernel's sound core modules?
>
> If you build from alsa-driver tree, then yes, only modules.
>
> You can get use kernel.git perex/alsa.git mm branch for the latest
> ALSA codes, too:
>         http://git.kernel.org/?p=linux/kernel/git/perex/alsa.git;a=shortlog;h=mm
>
>
> thanks,
>
> Takashi
>


Hi,
  Thanks for information, I will send updated patches soon.

Best regards,
       Maxim Levitsky
