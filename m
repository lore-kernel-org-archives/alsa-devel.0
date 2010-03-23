From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: PM fix for output amplifiers
Date: Tue, 23 Mar 2010 09:05:39 +0200
Message-ID: <201003230905.39319.peter.ujfalusi@nokia.com>
References: <1269264967-2003-1-git-send-email-peter.ujfalusi@nokia.com>
	<201003221731.14380.peter.ujfalusi@nokia.com>
	<20100322161928.GA30295@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CAE4103810
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2010 08:06:04 +0100 (CET)
In-Reply-To: <20100322161928.GA30295@rakim.wolfsonmicro.main>
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
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Monday 22 March 2010 18:19:28 ext Mark Brown wrote:
> > Yes, but it also means, that the change will be not visible at all.
> > I mean, if we did not update the reg_cache (when we should not write to
> > the HW), than that change will be gone.
> > So you will only be able to change the gain on the output, when the path
> > is active?
> =

> No, the control will have to take care of only writing to the chip when
> it knows it's safe to do so.

Now I start to understand what you are actually trying to say.
 =

> > Also, I think, if we can somehow prevent the gain change on the HW, when
> > the associated DAPM widget is not active, we would still have the
> > problem of the DAPM_MIXER. That operates from the cache, and if the
> > cache has no 0 for the gain, than that will be written to the chip.
> =

> Once again, the cache is operating below the controls transparently to
> them.  If the controls haven't written a value to the chip then the
> write won't have gone to the register cache either and so other parts of
> the system won't be affected.  As far as the control layer is concerned
> the register cache and the hardware are identical - I'm not sure why you
> believe that they are separate.

OK. I know that the concept is that the cache should be equal to the actual =

register content.
What I'm doing is kind of misuse the fact, that the upper layers are only =

reading from the cache. So I intentionally 'lie' (in a controlled manner) t=
o the =

control and DAPM layer about the HW status to achieve my goal.
Or I can put it like I made an abstraction at the lower level.

Your proposal is to make about similar abstraction, but in higher level, so=
 the =

cache will actually equals to the HW status.

And you are right, that this shall be handled in the core in the future for=
 the =

benefit of other codecs.

> Please take a look at the old PGA code I mentioned, it implements this
> without any problem.  The control suppresses the write unless the
> widget is powered, storing the value separately.  If the widget is
> powered down then the registers aren't referred to at all when the
> control is accessed.

I did, and I did looked at that when I started to work with the twl4030 cod=
ec.
It turned out not that simple for these outputs.
I ended up with custom handled volume controls (stereo and one mono).

> > I'm not saying that other codecs could not use some generic way (in a
> > way, that you have described) to make their amps muted when they are not
> > needed. What I'm saying, is that I don't see a generic way which can
> > handle the TWL codec.
> =

> Could you please be more specific about what you believe is going on
> with TWL4030 here?  It would really help if you could be more specific
> about how you see the register cache getting updated.

In any ways the output gains has to be handled with custom code no matter i=
f the =

core has support for binding the volume controls to DAPM widget or not.
The root of the problem is how the amplifiers are working:
bit 4-5: Gain
0x0 - power down (mute)
0x1 - 6dB
0x2 - 0dB
0x3 - -6dB

I don't have separate power bit.
I can not just invert the range.
I need to do the following:
If 0 is coming, than I write that (mute, power down)
If 2, than write two
For 1 I write 3
For 3 I write 1
This gives nice gain range for the user space.
0x0 - power down (mute)
0x1 - -6dB
0x2 - 0dB
0x3 - 6dB

When I have done these there were no other way, but to have my own custom c=
alls =

to handle the situation, and going for DAPM PGA would also mean that I actu=
ally =

need to duplicate the PGA code partially in the twl4030 codec.

Yes, this is a workaround, or a controlled hack to achieve what I believe i=
s a =

good thing for this codec, and since I did not found a way to handle these =

particular registers in the core (in a way that it would have been benefici=
al =

for others as well), this was the result.

I have thought about the things, that you wrote, and you are right, if the =

register for controlling the gain is 'sane', than there is no problem to ha=
ve =

generic core level handling such situations.

When my time allows, I can take a look at that.

Thanks for taking the v2 patch!

Thank you,
P=E9ter
