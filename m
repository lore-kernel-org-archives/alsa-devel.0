From: "Arve Knudsen" <arve.knudsen@gmail.com>
Subject: Re: snd_pcm_drain and lockups
Date: Thu, 6 Sep 2007 16:33:55 +0200
Message-ID: <a0d6258d0709060733y7b8989d2mccaa6c1f7f004e5@mail.gmail.com>
References: <a0d6258d0709041403s5e084541q203af02df22458eb@mail.gmail.com>
	<s5hzm016ycq.wl%tiwai@suse.de>
	<a0d6258d0709051019q4f507148ndabea8f9077cda69@mail.gmail.com>
	<s5hr6lb6gr5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 12171103986
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 16:33:56 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so25976ana
	for <alsa-devel@alsa-project.org>; Thu, 06 Sep 2007 07:33:55 -0700 (PDT)
In-Reply-To: <s5hr6lb6gr5.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 9/6/07, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Wed, 5 Sep 2007 19:19:10 +0200,
> Arve Knudsen wrote:
> >
> > Hi Takashi
> >
> > On 9/5/07, Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > At Tue, 4 Sep 2007 23:03:27 +0200,
> > > Arve Knudsen wrote:
> > > >
> > > > Hello
> > > >
> > > > Users of the PortAudio library on top of ALSA-lib have reported that
> it
> > > may
> > > > hang in a call to snd_pcm_drain. I have also been able to confirm
> that
> > > this
> > > > can happen in conjunction with the dmix device at least. Can the
> ALSA
> > > > developers please tell me how, if at all, snd_pcm_drain may be
> safely
> > > used?
> > > > Is this function simply best avoided (snd_pcm_drop being the
> > > alternative)?
> > >
> > > Of course, it's supposed to be safe to use :)  But, it's hard to tell
> > > you more unless I get the details in your case...
> > >
> > > In which situation is it called?  Are they multi-threaded?
> >
> >
> > The lock-up happens in a background thread within PortAudio. What has
> been
> > known to cause lock-ups at least is that PA restarts the device after
> the
> > detection of an xrun. This procedure entails first draining the stream
> > (snd_pcm_drain), the dmix and front devices have been known to lock up
> here
> > (I've experienced it with dmix at least). I've googled a bit on the
> problem,
> > and I didn't find a whole lot of evidence of this problem, but I did
> find
> > this:
> http://www.ohloh.net/projects/5344/contributors/32264/commits/10293341
> > .
>
> It's still hard to imagine what's going on there without a small test
> case.  I vaguely remember a similar problem, but I thought it should
> have been fixed in the recent versions.


I can try to procure a test case, but I believe it happens rather randomly.

Arve
