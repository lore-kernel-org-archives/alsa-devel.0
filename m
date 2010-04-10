From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Sat, 10 Apr 2010 15:23:07 +0800
Message-ID: <q2m4f3252891004100023n4396c59cp734d3e7c564d9b62@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<q2z98391a7b1004060101kd5ffef92tf4d98faa62a3ad5b@mail.gmail.com>
	<q2l4f3252891004071905l553da6a0he8b53448524fc94d@mail.gmail.com>
	<z2s98391a7b1004080542ud4af307l992ac9636d9aa508@mail.gmail.com>
	<u2w4f3252891004081611tc0293e7fzb6312ca188eacdc1@mail.gmail.com>
	<s2l98391a7b1004090030vd55faadew6ae97c85a7a4b379@mail.gmail.com>
	<r2u4f3252891004090649p3f327273x3af60905a06045fe@mail.gmail.com>
	<4BBF5F81.1010205@yellowcouch.org>
	<w2t4f3252891004091632j1728479at2c4d623e44f0d0c7@mail.gmail.com>
	<4BC02137.6000207@yellowcouch.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 93B52103820
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Apr 2010 09:23:08 +0200 (CEST)
Received: by pwj8 with SMTP id 8so2322922pwj.38
	for <alsa-devel@alsa-project.org>; Sat, 10 Apr 2010 00:23:07 -0700 (PDT)
In-Reply-To: <4BC02137.6000207@yellowcouch.org>
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

2010/4/10 Werner Van Belle <werner@yellowcouch.org>

> Raymond Yau wrote:
> >> Yes about that. I always wondered how they come up with 96dB ?
> >>
> >> A perceived doubling of volume is normally assumed to be +3dB,
> >> (log_10(2)=0.3) which means that if you have 16 bit audio you have 16
> >> 'doublings', or in essence only 48 dB. Even worse, since the last bit is
> >> a sign bit, you essentially can only achieve a dynamic range of 45dB !
> >>
> >> Now, I know this is off topic, but I never heard any good explanation
> >> why CD audio is suddenly 45 dB ?  If anybody knows, please share your
> >> thoughts !
> >>
> > http://en.wikipedia.org/wiki/Decibel
> >
> > When referring to measurements of amplitude it is usual to consider the
> > ratio of the squares of *A*1 (measured amplitude) and *A*0 (reference
> > amplitude). This is because in most applications power is proportional to
> > the square of amplitude,
> >
> > in electrical circuit , dissipated power is typically proportional to the
> > square of voltage or current
> >
> Okay, that would then only make for a factor two. Instead of 45dB one
> gets 90dB, this is still not 96dB as ordinarily claimed ?
>
> Wkr,
>
> Werner,-
>
>
You are assume all DAC can provide perfect conversion of the digital signal
to analog signal .

that why the professional use try to compare the SNR of the sound card

I just want to point out that the dB range of the hardware volume controls
of codec/DAC cannot be -inf dB to 0dB since they just convert fixed entropy
of digital information to analog signal

The pulseaudio server did not sum up the dB range of all hardware volume
controls of those amplifier /attenuator in the audio path and this is why
the sliders of the volume controls cannot move at same scale since the DR of
digital data and dB range of the hardware volume control are not the same ,
so this is not really a driver bug , it is due to PA only use onet of the
hardware volume controls in the audio path to calculate the dB

if PA really provide software gain according to, that mean when the hardware
slider stayed at 0dB and all the gain are provide the PA server by software
