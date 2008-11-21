From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: twl4030 asoc kcontrols and widgets
Date: Fri, 21 Nov 2008 11:49:03 +0200
Message-ID: <200811211149.03905.peter.ujfalusi@nokia.com>
References: <ef0d8a250811200138y36fc840dn9978dd862214dec4@mail.gmail.com>
	<20081120141401.GG4539@sirena.org.uk>
	<5e088bd90811200739x537252efx94e3fbe4e2303180@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id BFE30243D8
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 10:49:10 +0100 (CET)
In-Reply-To: <5e088bd90811200739x537252efx94e3fbe4e2303180@mail.gmail.com>
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
To: ext Steve Sakoman <sakoman@gmail.com>
Cc: ext naveen krishna ch <naveenkrishna.ch@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

Hi,

Sorry about the delayed reply...

On Thursday 20 November 2008 17:39:14 ext Steve Sakoman wrote:
> =

> Agreed! This is a really good thing to do.
> =

> Had I not been under a lot of time pressure when doing the original
> version of the driver I would have taken this approach myself.
> =

> I'm glad to see that you are tackling this.  Peter, you should post
> your patches for comment.  Might help speed things along if we get
> more folks looking and contributing.
> =

> Steve
> =


I'm planing to send patches as soon as possible.
I have been working with the twl4030 codec for about a week now, so the
thing that I have is far from what it should be at the end...
I can explain in short what I have at the moment and what is missing:
- Playback route controls for:
 - PreDriveL (Off, Voice, DACL1, DACL2, DACR2)
 - PreDriveR (Off, Voice, DACR1, DACR2, DACL2)
 - HeadsetL (Off, Voice, DACL1, DACL2)
 - HeadsetR (Off, Voice, DACR1, DACR2)
 - CarkitL (Off, Voice, DACL1, DACL2) # or PRECKT_Right
 - CarkitR (Off, Voice, DACR1, DACR2) # or PRECKT_Left
 - HandsfreeL (Voice, DACL1, DACL2, DACR2) # or IHFL or Class-DL
                                           # (depends which text I take)
 - HandsfreeR (Voice, DACR1, DACR2, DACL2) # or IHFR or Class-DR
                                           # (depends which text I take)

Volume/Gain controls:
 - FGAIN in DAC2 (mute, -62 - 0 dB, in 1 dB steps)
 - CGAIN in DAC2 (0 - 12 dB, in 6 dB steps)
 - PreDrive(L and R, not separate) playback gain,
   or volume control (mute, -6, 0, 6 dB)
 - Headset(L and R, not separate) playback gain,
   or volume control (mute, -6, 0, 6 dB)
 - Carkit(L and R, not separate) playback gain,
   or volume control (mute, -6, 0, 6 dB)

All of the above are added to the twl4030_snd_controls at this
point of time.

The twl4030_reg has been set to disable all outputs by
default, it is up to the user to enable the needed outputs.

SND_SOC_DAPM_INPUT() and SND_SOC_DAPM_OUTPUT() definitions for
all physical inputs, outputs.
I have not yet started with the correct dapm_route for the TWL,
it is going to be quite a mess.
At the moment outputs are connected to DACL/R2, for example:
{"PREDRIVL", NULL, "DACL2"}

So in the playback side what you can do already:
You can select the routing individually for all outputs (except the
Earpiece, hmm I forgot about it).

The capture path is kind of untouched, it is in the to-do list, it does
works with the DIGIMIC0 for me.

Three sets of get/put function for dealing with TWL's specially crafted
registers (Routing selections, Gain controls).

What needs to be done:
Lot's of things... =

Clean up?
snd_soc_dapm_route, snd_soc_dapm_widget things (I need an A3 paper for that=
).
Capture controls and corresponding dapm_route, dapm_widgets

So this is my current status, are you still interested to see these things?
What else should I add before I send the patch?

-- =

P=E9ter
