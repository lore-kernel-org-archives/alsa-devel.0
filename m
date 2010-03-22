From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: TWL4030: PM fix for output amplifiers
Date: Mon, 22 Mar 2010 14:15:44 +0000
Message-ID: <20100322141543.GC1379@rakim.wolfsonmicro.main>
References: <1269264967-2003-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100322134701.GB1379@rakim.wolfsonmicro.main>
	<201003221604.56497.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6F5A1103844
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 15:15:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201003221604.56497.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 22, 2010 at 04:04:56PM +0200, Peter Ujfalusi wrote:

> bit 4-5: Gain (0x0 - power down, 0x1 - 6dB, 0x2 - 0dB, 0x3 - -6dB)

> If there is no audio activity, and user changes the routing, than the gain value 
> will be also written to the chip, which causes the amp to be enabled.

So it's shared power and volume in a single bitfield.

> > If it's supposed to be holding the controls at a mute value while the
> > PGA is powered down then this is something that ASoC could benefit from
> > in general - it'd be much better if we could keep amplifiers muted while
> > not in active use and sequence the unmute into the power management at
> > the end since this is good for pop/click management in general.  I'd
> > started to look at this but not yet got enough time to finish off
> > implementing it.

> Yes, I have been also thinking about that, but I really don't know how it can be 
> done:

> For the DAPM part it is kind of easy, since we can decide in the core when to 
> write to the chip, and when only to the reg_cache.
> But since I have the gain in the same register, when the user changing the 
> volume, than that control don't have information about the associated DAPM 
> widget's state.

That's why I'm saying you'll need a new control type - it'd need to know
how to look at the state of a DAPM widget and decide if it should update
the hardware based on that.  The PGA handling code that's in current
mainline (not for-2.6.35, it got removed) is an example of this.

> Well, I think the core could have some basic support for similar cases, but I'm 
> not sure if it is possible to cover all cases in the core.

I don't see any fundamental problem here - mostly this just maps on to
"if the widget is powered on write this value, otherwise write the
value configured by the control.".

> I do think, that at least the TWL codec has to be handled in a custom way. For 
> now at least.

> Should I add more explanation to the commit message to make the intention more 
> clear?

Well, I was rather hoping I could convince you to make this more
generic.  But if that's not possible then yes, please do make the commit
message clearer.
