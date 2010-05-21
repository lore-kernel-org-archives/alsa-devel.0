From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Mixer volume/decibel mapping
Date: Fri, 21 May 2010 09:30:20 +0800
Message-ID: <AANLkTikWaBVuo-Vo8LIN6jS19cuPv4nDZbgYKzzZeLWg@mail.gmail.com>
References: <201005191834.57919.vand2@gmx.de>
	<AANLkTimQtKql4p3UEs2Wh_tZ6YhzLGgl1q5G18A1y9Jk@mail.gmail.com>
	<AANLkTilKqn_X3FUdDmCqy3YKdYeT47oIGGaqUitzruDk@mail.gmail.com>
	<201005201141.28755.vand2@gmx.de>
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F814245B7
	for <alsa-devel@alsa-project.org>;
	Fri, 21 May 2010 03:30:21 +0200 (CEST)
Received: by pxi13 with SMTP id 13so206558pxi.38
	for <alsa-devel@alsa-project.org>; Thu, 20 May 2010 18:30:20 -0700 (PDT)
In-Reply-To: <AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
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

2010/5/21 James Courtier-Dutton <james.dutton@gmail.com>

> On 20 May 2010 10:41, Sebastian H. <vand2@gmx.de> wrote:
> >
> > That's clear.
> > I imagined that maybe the dB scale could be the "real thing" and the
> volume
> > steps would be a convenient but possibly coarse mapping into a denser
> > stepped dB space provided by the hardware/driver.
> > This was unlikely but I wanted to ask anyway ;-).
> >
>
> I believe it could be extended to support a continuous range.
> For example, some hardware uses a 32bit value to control the gain.
> The mix operation is simply "the_sample" * "the_control_value".
> So in this case the hardware has a linear control that can be
> considered continuous for our purposes.
> The conversion from the control value to a usable value would have to
> include a user land log operation.
> It was never implemented due to lack of demand.
> For the cards that do have this 32bit linear value, a simple lookup
> table is used in the kernel code to convert it to 256 step values.
> If implemented, one could then introduce professional gain controls
> that do not produce "clicks" in the output when adjusted.
> gain controls with steps in them produce clicks when the gain control
> is adjusted.
>

I thinks Sebastian's question is whether he can use
snd_mixer_selem_set_playback_
dB() set any values in between the volume steps

e.g. Master volume control of ac97 is 1.5 dB per step,

when using snd_mixer_selem_set_playback_dB() to set -0.9dB , how can the
mixer application know what dB value has been set since the value is in
between -1.5dB and 0dB without snd_mixer_selem_get_playbackdB()
