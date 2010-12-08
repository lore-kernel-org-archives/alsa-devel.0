From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Help wanted: emachines em350 internal mic
Date: Wed, 8 Dec 2010 12:13:06 +0800
Message-ID: <AANLkTim4X-=AZtujs20QwDbaFC5CbuRSdFiWK6z3rV0E@mail.gmail.com>
References: <AANLkTi=T_5nGv85YE8DcDvyF_HFouh7a-6tOmk58+8EO@mail.gmail.com>
	<4CFDA5FF.6060403@audioscience.com> <s5hy681ftoj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42])
	by alsa0.perex.cz (Postfix) with ESMTP id C0E091037EE
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 05:13:08 +0100 (CET)
Received: by ewy1 with SMTP id 1so592715ewy.29
	for <alsa-devel@alsa-project.org>; Tue, 07 Dec 2010 20:13:08 -0800 (PST)
In-Reply-To: <s5hy681ftoj.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/12/8 Takashi Iwai <tiwai@suse.de>

> At Tue, 07 Dec 2010 16:11:59 +1300,
> Eliot Blennerhassett wrote:
> >
> > Thanks Raymond,
> >
> > On 03/12/10 15:33, Raymond Yau wrote:
> > >>> Greetings,
> > >
> > >
> > >>> There is only a single mic on this netbook. However, the alsa device
> > >>> shows up as stereo, and the right channel carries an inverted copy of
> > >>> the left channel.
> > >
> > >
> http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=59c774ed5ee00e9623a204c3234191d6a6d8cf7a
> >
> > Commitlog was "Add route_policy copy to HDA-Intel.conf for capture
> > Since some digital mics have the phase-inversion problem in one channel,
> > adding both channels for mono stream results in the noise. Use
> > route_policy copy to avoid that situation."
> >
> > As far as I can guess, the commit helps when an application asks to
> > record mono from the stereo device, by copying L rather than summing L+R
> >
> > My machine already has this, however it doesn't really fix the root of
> > the problem.
>



> >
> > Because the internal mic appears as a stereo device, rather than a mono,
> > applications can open it as stereo.
> >
> > Only later when the resulting signal L+R is sent to a mono output does
> > the signal "disappear".
> >
>

In theory , this should be (L+R)/2 for those stereo mic without phase
inversion to prevent clipping occur when sent to a mono output


> > So I'm back to wondering how to force an app (primarily PulseAudio) to
> > see the mic as mono?
>
> Via pulse configuration?
>

 PA server use SND_PCM_NO_AUTO_CHANNELS , any plugin which defined in the
device string in the profile has no effect if your hardware does not support
1 channel


so you need PA to provide downmixing option for recording mono from stereo
mic
1) (Left+Right)/2
2) Left
3) Right
