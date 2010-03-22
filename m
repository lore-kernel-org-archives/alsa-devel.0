From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: TWL4030: PM fix for output amplifiers
Date: Mon, 22 Mar 2010 13:47:01 +0000
Message-ID: <20100322134701.GB1379@rakim.wolfsonmicro.main>
References: <1269264967-2003-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A5EC6243C5
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 14:47:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1269264967-2003-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 22, 2010 at 03:36:07PM +0200, Peter Ujfalusi wrote:
> Gain controls on outputs affect the power consumption
> when the gain is set to non 0 value.
> To prevent amps beeing enabled, when they are not
> needed, introduce the following workaround:
> Track the state of each of this type of output.
> In twl4030_write only allow actual write, when the
> given output is enabled, otherwise only update
> the reg_cache.
> The PGA event handlers on power up will write the cached
> value to the chip (restoring gain, routing selection).
> On power down 0 is written to the register (disabling
> the amp, and also just in case clearing the routing).

I'm not 100% clear on what the existing code is supposed to be doing so
this explanation isn't entirely clear to me, sorry.

If it's supposed to be holding the controls at a mute value while the
PGA is powered down then this is something that ASoC could benefit from
in general - it'd be much better if we could keep amplifiers muted while
not in active use and sequence the unmute into the power management at
the end since this is good for pop/click management in general.  I'd
started to look at this but not yet got enough time to finish off
implementing it.

What I'd been thinking of doing was introducing a new control type which
would be the inverse of supply - something that's switched on whenever
its inputs are switched on, sequenced to power on at the end of the
sequence and power off at the start.  This would support both events and
a set of controls, with the controls doing what this looks like and only
writing to the device when the widget is powered.  I've not actually
tried implementing this properly yet, though - it'd involve adding a
new bunch of control types, sadly.
