From: Carlo Caione <carlo@endlessm.com>
Subject: Re: RT5640 jack detection
Date: Thu, 24 Sep 2015 22:34:14 +0200
Message-ID: <CAL9uMOG2CgBU2yiKCq4iyt7L-Ms1e=vVqrAFV76G1Zvj3d3PXA@mail.gmail.com>
References: <CAL9uMOHM3tbdKT7s4panz8zyYxu35F38GLUtu9DSmgrQr=Ciqg@mail.gmail.com>
 <1443025358.6977.71.camel@loki>
 <20150923163746.GR30445@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com
 [209.85.213.173])
 by alsa0.perex.cz (Postfix) with ESMTP id B72A6265821
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 22:34:15 +0200 (CEST)
Received: by igcpb10 with SMTP id pb10so24199479igc.1
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 13:34:14 -0700 (PDT)
In-Reply-To: <20150923163746.GR30445@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 23, 2015 at 6:37 PM, Mark Brown <broonie@kernel.org> wrote:

> That can upset userspaces - it means you get things like trying to play
> a notification tone, starting, realising that a headphone is there and
> trying to switch on the headphone in the middle of the notification
> being played back which doesn't tend to work out so well.
>
> What I'd expect the driver to be doing here is enabling whatever it
> needs to do detection enabled while detection is enabled.

What I don't get here is what do you mean with "detection". Can we
simply consider PA listening for jack change events a "detection"?

> There's quite
> a few examples of this in mainline - look for jack code that has DAPM
> calls in it.

Do you thing the rt5670.c could be a good example for that?

In that case a GPIO is used to trigger the jack type detection. The
jack change interrupt is notified also when the codec is off/inactive
and in the codec the status of the jack (jack_inserted) is detected
directly reading from some codec registers. The DAPM calls are used in
the code path to determine the type of the jack.

In my case the setup is different though. The GPIO is driven by the
codec itself and it doesn't work when the codec BIAS is off. So the
problem is that I cannot use the DAPM code since before that I need to
find a way to detect the change in the GPIO status when I'm not
actively using the codec.

I see two possible solutions for this problem: 1) as said before I can
just avoid to turn the BIAS totally off, leaving the I2S clock active
that allows the codec to drive the GPIO or 2) keep polling on the
status of the GPIO enabling and then disabling the BIAS (or using the
DAPM code) just for the time needed to read the GPIO status

Thanks,

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
