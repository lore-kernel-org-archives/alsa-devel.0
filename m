From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: core: Fix race in dapm_power_widgets
Date: Fri, 5 Nov 2010 09:53:35 +0200
Message-ID: <201011050953.35854.peter.ujfalusi@nokia.com>
References: <1288858605-8388-1-git-send-email-peter.ujfalusi@nokia.com>
	<201011041618.07655.peter.ujfalusi@nokia.com>
	<20101104180858.GA6088@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DD1110387A
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 08:53:37 +0100 (CET)
In-Reply-To: <20101104180858.GA6088@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thursday 04 November 2010 20:08:58 ext Mark Brown wrote:
> Right, that's what I was thinking - I'm mostly concerned that we need to
> have the locking further up the stack rather than further down.  This
> feels like a band aid which fixes the symptom (the list pointers getting
> corrupted) but it smells like we may have something further up the stack
> which can still create issues.  For example, if both DAPM and something
> else manipulate the register map simultaneously we could get R/M/W
> issues.

Well, I think if we want to have one place to use a lock, this is the highe=
st we =

can go.
But I did figured out the reason for the crash.
In my machine driver I had a kcontrol (ENUM_EXT) for muting the speaker.
In the set callback I used snd_soc_dapm_enable_pin/snd_soc_dapm_disable_pin=
 + =

snd_soc_dapm_sync.
This is the place where it is crashing, since dapm_sync calls dapm_power_wi=
dgets =

directly without locking.
All other places, when dapm_power_widgets called are protected by codec->mu=
tex =

so those paths are safe.
By replacing the custom kcontrol/callbacks with SOC_DAPM_PIN_SWITCH() the =

problem is gone.
So it seams that my case can be solved easily with the SOC_DAPM_PIN_SWITCH(=
), =

but the race remains, and other setups might fail under some rare scenario

We can not add the codec->mutex to the snd_soc_dapm_sync, since it is calle=
d =

from soc_probe_dai_link, which is part of the initialization, and the codec-
>mutex has been taken up in the chain.

It might be a good idea to go through the machine drivers, and check for =

snd_soc_dapm_sync usage.

-- =

P=E9ter
