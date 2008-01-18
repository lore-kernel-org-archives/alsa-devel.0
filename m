From: "Christophe Osuna" <christophe.osuna@gmail.com>
Subject: Re: Problems with ALC882
Date: Fri, 18 Jan 2008 18:11:05 +0100
Message-ID: <b6251a620801180911g40a5fe4cxa5ef72de9335e86d@mail.gmail.com>
References: <b6251a620801160920q327049ffifa72f77b17738f75@mail.gmail.com>
	<s5hzlv5r7yx.wl%tiwai@suse.de>
	<b6251a620801180810y6628debcxf9ff36de35514848@mail.gmail.com>
	<s5hve5rayvr.wl%tiwai@suse.de>
	<b6251a620801180850w492acd01v26a6648a710f5f0d@mail.gmail.com>
	<s5h8x2n3wbb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.232])
	by alsa0.perex.cz (Postfix) with ESMTP id C68262443D
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 18:11:07 +0100 (CET)
Received: by nz-out-0506.google.com with SMTP id m22so783236nzf.2
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 09:11:06 -0800 (PST)
In-Reply-To: <s5h8x2n3wbb.wl%tiwai@suse.de>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2008/1/18, Takashi Iwai <tiwai@suse.de>:
> At Fri, 18 Jan 2008 17:50:38 +0100,
> Christophe Osuna wrote:
> >
> > 2008/1/18, Takashi Iwai <tiwai@suse.de>:
> > > Looks like your board disables the third ADC.  The driver probes it
> > > and the codec returns it's no audio-input widget.  Check codec#* proc
> > > output.
> > >
> >
> > I have copied the contents of /proc/asound/card0/codec#2 at the end of
> > this message. Notice that there are three nodes (0x07, 0x08 and 0x09)
> > which claim to support PCM input.
>
> Ah, then it's in patch_realtek.c where alc880_pcm_analog_capture
> claims substreams = 2.  Feel free to fix it.

OK.

That's not the kind of things I want to try on a Friday before leaving
work, so I will try that next week and report results here.


> > The same nodes I mentionned above (0x07, 0x08 and 0x09 in
> > /proc/asound/card0/codec#2) show no support for 8 kHz sample rate.
> > This is confirmed by the failing calls to
> > snd_pcm_hw_params_set_rate().
>
> Then actually the codec doesn't support 8kHz.  Or, at least, the
> hardware vendor doesn't want it to work on 8kHz by any reason.
>
> Of course, you can try to override in the driver, but it's definitely
> at your own risk...

I think it is worth trying (same patch_realtek.c file, isn't it?). In
the worst case we will use a software resampler (8 kHz <-> 48 kHz
shouldn't be too difficult), but I would prefer leaving that to the
codec.
