From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALC268 (no sound)
Date: Wed, 6 Feb 2008 08:55:32 +1030 (CST)
Message-ID: <200802052225.m15MPWGN018292@turbo.physics.adelaide.edu.au>
References: <47A89CE8.3010902@harddisk.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelphi.physics.adelaide.edu.au
	(adelphi.physics.adelaide.edu.au [129.127.102.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 776F7243D2
	for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2008 23:25:36 +0100 (CET)
In-Reply-To: <47A89CE8.3010902@harddisk.is-a-geek.org> from "Marco Schuster"
	at Feb 05, 2008 06:29:12 PM
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marco Schuster <marco@harddisk.is-a-geek.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi Marco

> >> Interesting.  I've had another user report getting sound out of the latest
> >> hg tree with an ALC268 both with test mode and the "auto" mode.  Our
> >> continued failure to get anything out of your laptop over the last few
> >> months makes me suspect that there's some other non-standard thing (external
> >> to the ALC268 codec) linked to the sound system in your laptop which
> >> prevents audio unless activated.  Takashi, what's your take on this?
> >
> > Hard to say...  I still think it's either GPIO or EAPD except for very
> > stupid things like the hardware-volume control via laptop keys
> > (e.g. Thinkpad has independent volume controls and you have to unmute
> > it via a button properly).  Marco, did you test all combinations of
> > GPIO and EAPD?
> Well, there are softkeys on the machine, but they don't have any
> effect (for example the LED for mute doesn't change when pressing the
> button). What's that stuff with GPIO/EAPD?

GPIO stands for "General Purpose IO".  They are digital inputs/outputs
provided by the audio codec chip which are not committed to any particular
function within the chip.  They can be used by a board manufacturer to
control "extra" things they have added.  For example, there are some Acer
laptops around which use one of the GPIO lines from the codec to switch an
external audio amplifier (ie: an amplifier not on the codec chip) on and
off.  Without that particular GPIO line turned on no audio is heard from the
machine.

The EAPD line is a digital output provided by the codec chip.  Again, a
board vendor can choose what they like to do with this line but the
convention is that if used it switches an amplifier/buffer.

Note that manufacturers don't *have* to use these lines, and indeed many
vendors leave them completely unused.

The point here is if your machine is one which requires some combination of
the GPIO and/or EAPD lines to be set before audio is emitted then this may
explain the ongoing lack of sound.  However, if I recall correctly you have
already done extensive testing of all possible GPIO/EAPD setting
combinations with all alsamixer controls set to maximum without success.  Is
my recollection correct here?

> > On other earlier ALC codecs, some device require COEF setups.  This
> > might be worth to try for ALC268 if the above is all checked.
> Another thing I don't understand :(

COEF is, I believe, short for coefficients and refers to filter/DSP
coefficients used by processors on the codec chip.  It may be that your
particular implementation of the ALC268 requires particular COEF settings in
order to pass audio.  Having said that I don't think this is the *general*
case with the ALC268 because as I have mentioned a user has reported success
with the ALC268 under Linux and a recent hg snapshot with both the "test"
and "auto" models.

Regards
  jonathan
