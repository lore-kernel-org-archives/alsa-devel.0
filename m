From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: Writing a new plugin for ALSA
Date: Wed, 11 Jul 2007 11:39:30 +0530
Message-ID: <8d6898730707102309j1aac277csf4da8362e8d399a7@mail.gmail.com>
References: <8d6898730707090459o10ea89a0qc9fc888af153b85b@mail.gmail.com>
	<8d6898730707100359g5c76b670y59120a776ed33e51@mail.gmail.com>
	<8d6898730707100408t4f641e21s890c9578e8b9c04a@mail.gmail.com>
	<f27d86200707100515j2277aa28kca8cc238ac70d86a@mail.gmail.com>
	<s5hbqekl9mb.wl%tiwai@suse.de>
	<8d6898730707100554v309f4e05r479cf37b054e8ec0@mail.gmail.com>
	<s5h8x9ol73v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 38D112436C
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 08:09:35 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so2058051wag
	for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2007 23:09:34 -0700 (PDT)
In-Reply-To: <s5h8x9ol73v.wl%tiwai@suse.de>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>, Sudhanshu Saxena <sudhanshu.saxena@gmail.com>
List-Id: alsa-devel@alsa-project.org

If I open both sco and audio simultaneously, where I will push the
data from both streams, because I have only one codec, i.e. single
DAC/ADC pair.

So that needs stopping one of the stream inside the kernel.

When we try to stop one stream from kernel itself, it will lead to
problems I mentioned in the earlier mail.

Thanks
Nobin Mathew

On 7/10/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 10 Jul 2007 18:24:18 +0530,
> Nobin Mathew wrote:
> >
> > On 7/10/07, Takashi Iwai <tiwai@suse.de> wrote:
> > > At Tue, 10 Jul 2007 17:45:03 +0530,
> > > Sudhanshu Saxena wrote:
> > > >
> > > > Hi Takashi,
> > > >
> > > > I am working on this issue along with Nobin, for multiple multiple streams (at
> > > > different rates) playback based on a priority.
> > > >
> > > > I attempted suspend and resume returning -ESTRPIPE, but it has two issues
> > > > 1) All applications may need a change in Suspend logic specific to wait for higher
> > > > priority stream to run to completion.
> > >
> > > Basically every app is _required_ to handle of suspend/resume
> > > properly.
> > >
> > > > 2) I have to still find out a mechanism to reset the hardware settings are reconfigure
> > > > it for second stream.
> > > > snd_pcm_hw_reset has an access to reset using IOCTL "SNDRV_PCM_IOCTL_RESET" , I hope
> > > > that can help, I am not
> > > > very sure on this.
> > >
> > > Well, I don't think the plugin itself requires the reset.
> > >
> > > > As mentioned by Nobin we want to skip any upsampling caused when we use the dmix
> > > > (rate) plugin.
> > > > I was trying to find the way out, with a plugin with following changes:
> > > > 1) All streams will open pcm with a priority. (Pre decided for the system)
> > > > 2) Plug-in will have shared memory to hold the priority list of all applications which
> > > > are accessing sound.
> > > > 3) At any instance only one stream will be active.
> > > > 4) All applications will hold the context of HW params and SW params (accessible
> > > > through apis plugin will support).
> > > > 5) If an application with a higher priority calls snd_pcm_open shared memory with the
> > > > priority list will be updated and
> > > >  when the currently active stream attempts to re-write the data it will check for
> > > > priority list. This will cause saving of params, drain of stream and reset of hw as
> > > > mentioned using above IOCTL and the active stream would be changed to
> > > > currently highest in the priority list.
> > > > 6) The higher priority stream can then start writing data, on completion of access
> > > > similar sequence of drain, hw reset will be caused and the active stream will be
> > > > changed to next in the priority list.
> > > > 7) On resume of lower priority stream the hw params will be set again.
> > >
> > > The question is how the application decides which stream to use.
> > > If it can open a PCM with a different name (to snd_pcm_open call), and
> > > if you have three individual PCM devices, the whole switching can
> > > be done inside the kernel driver.  That is, when an SCO stream is
> > > opened during audio stream(s) is running, the driver triggers SUSPEND
> > > mode for the audio stream.  Then the app will stop and restart the
> > > stream by itself. This means you don't need any change in user-space
> > > side but needs some additions in the driver side.
> >
> > We thought about implementing this in the kernel driver, but after
> > some investigation, we found that we are serializing the driver so
> > much by providing three interfaces (audio, sco and Nav). say
> > pcmC0D0p/c, pcmC0D1p/c and pcmC0D2p/c.
> >
> > Consider the case of two apps audio and sco.
> > We have two interfaces for this pcmC0D0p/c and pcmC0D1p/c
> > priority is audio < sco
> >
> > so interface priority is pcmC0D0p/c < pcmC0D1p/c.
> >
> > Assume that audio is already opened.
> > When we open sco interface audio interface can be in any state, it i
> > can be in paused state or it is about to close etc. So we will have so
> >  many states of application in the kernel driver.
>
> Well, but this is same for user-space solution.
>
> How the exclusiveness is handled in the driver?  What exactly happens
> if you open two different streams (e.g. audio and sco) at the same
> time?  Does it return an error?
>
> > we need to maintain all these states of application in the kernel
> > driver. Say tomorrow one more application came in to picture, then
> > this complexity will increase.
> >
> > Locking of states of streams is also required in this case.
>
> It's needed in any case if the concurrent access is possible.
>
>
> Takashi
>
