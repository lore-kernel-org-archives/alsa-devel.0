From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: Audio on Linux is a mess
Date: Mon, 20 Oct 2008 18:23:27 +0200
Message-ID: <200810201823.27422.marek.vasut@gmail.com>
References: <f188924b0810170624k78e74116o19fba5adb0eaf533@mail.gmail.com>
	<200810200835.25706.marek.vasut@gmail.com>
	<f188924b0810200741v2982ecb4i2fea9589aa2958a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 944A424592
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 18:19:10 +0200 (CEST)
Received: by ik-out-1112.google.com with SMTP id c30so1273649ika.0
	for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2008 09:18:52 -0700 (PDT)
In-Reply-To: <f188924b0810200741v2982ecb4i2fea9589aa2958a3@mail.gmail.com>
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
To: "Fred ." <eldmannen@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

You got what you paid for.

Maybe if you change your attitude and supply some information, someone might 
consider looking in your issue, othervise it would be a problem since I 
forgot my crystal ball back at home.

On Monday 20 of October 2008 16:41:45 Fred . wrote:
> Yeah, fix the Linux audio so that if an application behaves wrong, or
> does something stupid, then after I close the application, the system
> should be silent.
> It shouldn't continue make sound even after I quit the application.
> And PulseAudio shouldn't crash because one application did something
> even if it was stupid.
>
> On Mon, Oct 20, 2008 at 8:35 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > On Friday 17 of October 2008 15:24:20 Fred . wrote:
> >> ALSA lib pulse.c:272:(pulse_connect) PulseAudio: Unable to connect:
> >> Timeout ALSA lib pulse.c:272:(pulse_connect) PulseAudio: Unable to
> >> connect: Timeout AL lib: alsa.c:344: Could not open playback device
> >> 'default': Connection refused AL lib: oss.c:179: Could not open
> >> /dev/dsp: Device or resource busy File
> >> "/var/lib/python-support/python2.5/pyglet/media/drivers/openal/__init__.
> >>py" , line 340, in driver_init_device = alc.alcOpenDevice(device_name)
> >>
> >> Audio on Linux is a mess.
> >> I launch an Python script that uses audio then it breaks, and when the
> >> Python script is closed, I still hear the audio skipping and repeating
> >> like,
> >> "kakakakakakaka" in infinite loop.
> >> And PulseAudio seems to be frozen.
> >> Then I kill PulseAudio and finally the audio noise stops.
> >>
> >> Oh, and I heard OpenAL downsamples stereo to mono on Linux due to a bug.
> >>
> >> Whole audio on Linux is just a big mess.
> >
> > Please behave yourself.
> > Is there any way we can help you (which I doubt, but ...)?
> >
> >> _______________________________________________
> >> Alsa-devel mailing list
> >> Alsa-devel@alsa-project.org
> >> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
