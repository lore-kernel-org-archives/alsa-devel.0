From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 6/6] ASoC: TWL4030: Add analog loopback
	support
Date: Tue, 27 Jan 2009 14:03:16 +0000
Message-ID: <20090127140316.GB11870@sirena.org.uk>
References: <1233048584-29662-1-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-7-git-send-email-peter.ujfalusi@nokia.com>
	<20090127113737.GA1794@sirena.org.uk>
	<200901271505.34354.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A5F71037EC
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 15:03:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200901271505.34354.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 27, 2009 at 03:05:34PM +0200, Peter Ujfalusi wrote:

> Than if the bypass got disabled it jumped back to 0.01 A. After a bit of 
> debugging I found the reason:
> We have outputs with dedicated gain controls (PreDriveL/R, HeadsetL/R, 
> CarkitL/R, Earpiece), they have to be put to power-down mode (gain bits to 
> 0). We do have volume controls for these, they are not in DAPM, but they can 
> be modified. But now the problem is that something has to track the bypass 
> states in userspace:
> if the bypass disabled, than has to mute all outputs, when enabled, it has to 
> remember, what was the original gain for the outputs. So it's going to be a 
> mess.

This one should be dealable with in-kernel without any work by
applications - WM8350 does a similar dance (for different reasons),
providing a shadow volume control while some of the amplifiers are
powered off.

> But than I played a bit with the registers, enabled the bypass (while the PLL 
> was off) and the readings were: 0.020 A, in short:
> bypass on  + PLL on  = 0.016 A
> bypass on  + PLL off = 0.020 A

I suspect the increased power consumption here is due to the PLL being
required to clock the DAC properly.  Or you've transposed the figures :)

> bypass off + PLL on  = 0.006 A
> bypass off + PLL off = 0.002 A
> 
> Grrr, and I gave up. Oh, and we don't have control for the PLL (it is enabled 

Normally all the PLL control is punted to the machine driver since the
clocking configuration tends to be system dependant, especially when the 
codec is the clock master.  Then again, the TI codecs seem to be fairly
inflexible in this regard so perhaps it doesn't make sense there.  If
there's only one configuration possible then there's no sense bothering
the machine drivers with it.

> all the time at the moment). I was thinking to use the SND_SOC_DAPM_PRE and 
> SND_SOC_DAPM_POST for it but I don't know how to use those.

Just declare them as widgets - the event function you supply will be
called back when the state changes.  The event function interface is the
same as for the _E versions of normal DAPM controls, see WM8900 for one
example of how to use them.

> So I thought that I will write it in a way I have sent it and revisit later, 
> when I (or someone else) have better idea to handle this.

I suspect that if the core were able to automatically push the codec
down into BIAS_OFF as well as BIAS_STANDBY that'd probably be enough to
deal with the issue?  Probably in concert with fixing the core to bring
the codec up to BIAS_ON when bypass paths are active.  It looks like
what you're implementing here is a combination of the fixes for those
two issues.

My main concern is that it feels like this is breaking the model that
the core has of what the codec driver should be doing - I think some
(much?) of this is a case of the core needing more functionality and
that if that is the case then we'd be better off not carrying driver
specific workarounds in case they get broken when things are fixed in
the core.

> Sorry for the long and most probably boring details...

> > 	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

> I can wait till it gets there and send the series on top of it.

Like I said, I've already applied all your other patches.
