From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Mixer volume/decibel mapping
Date: Mon, 7 Jun 2010 11:37:35 +0800
Message-ID: <AANLkTikylA_oo6GBKuLHewVX9oMCNjQMeS90HThDR47K@mail.gmail.com>
References: <201005191834.57919.vand2@gmx.de>
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
	<AANLkTikWaBVuo-Vo8LIN6jS19cuPv4nDZbgYKzzZeLWg@mail.gmail.com>
	<201005211018.41802.vand2@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 75C4C2446F
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jun 2010 05:37:36 +0200 (CEST)
Received: by pva4 with SMTP id 4so1522439pva.38
	for <alsa-devel@alsa-project.org>; Sun, 06 Jun 2010 20:37:35 -0700 (PDT)
In-Reply-To: <201005211018.41802.vand2@gmx.de>
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

2010/5/21 Sebastian H. <vand2@gmx.de>

> Am Freitag, 21. Mai 2010 03:30:20 schrieb Raymond Yau:
> > 2010/5/21 James Courtier-Dutton <james.dutton@gmail.com>
> >
> > > On 20 May 2010 10:41, Sebastian H. <vand2@gmx.de> wrote:
> > > > That's clear.
> > > > I imagined that maybe the dB scale could be the "real thing" and the
> > >
> > > volume
> > >
> > > > steps would be a convenient but possibly coarse mapping into a denser
> > > > stepped dB space provided by the hardware/driver.
> > > > This was unlikely but I wanted to ask anyway ;-).
> > >
> > > I believe it could be extended to support a continuous range.
> > > For example, some hardware uses a 32bit value to control the gain.
> > > The mix operation is simply "the_sample" * "the_control_value".
> > > So in this case the hardware has a linear control that can be
> > > considered continuous for our purposes.
> > > The conversion from the control value to a usable value would have to
> > > include a user land log operation.
> > > It was never implemented due to lack of demand.
> > > For the cards that do have this 32bit linear value, a simple lookup
> > > table is used in the kernel code to convert it to 256 step values.
> > > If implemented, one could then introduce professional gain controls
> > > that do not produce "clicks" in the output when adjusted.
> > > gain controls with steps in them produce clicks when the gain control
> > > is adjusted.
> >
> > I thinks Sebastian's question is whether he can use
> > snd_mixer_selem_set_playback_
> > dB() set any values in between the volume steps
> >
> > e.g. Master volume control of ac97 is 1.5 dB per step,
> >
> > when using snd_mixer_selem_set_playback_dB() to set -0.9dB , how can the
> > mixer application know what dB value has been set since the value is in
> > between -1.5dB and 0dB without snd_mixer_selem_get_playbackdB()
>
> Indeed I quite happy with what ALSA already provides (I'm just an
> interested
> amateur). My main problem is that there is no documentation for the Mixer
> API
> and how things are related to each other. Like CTL, HCTL, Mixer and
> SimpleMixer and of course volume and dB in the snd_mixer_selem_ functions.
>
> The root issue is that I wondered if the mixer application should offer a
> separate text input for decibel values besides the text input for volume
> values. As pointed out this would not allow for finer grained volume
> control
> therefore for the moment I'll probably stick with a mere text label for dB.
>
>
The main difference between those volume controls using TLV_DB_SCALE and
TLV_DB_LINEAR is -6dB is at the middle of TLV_DB_LINEAR and TLV_DB_SCALE has
fixed dB value between any two steps.

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/332631

if the user has both hda onboard sound and emu10k1, he may notice that there
is big difference if he set volume at percentage instead of dB

so it is mainly depend on the scaling of the slider in your mixer
application


https://bugs.launchpad.net/ubuntu/+source/linux/+bug/284947

it is not related to ac97 codec but the volume control of DSP which use
TLV_DB_SCALE
