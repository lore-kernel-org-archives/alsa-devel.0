From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Fix race in dapm_power_widgets
Date: Fri, 5 Nov 2010 10:38:09 -0400
Message-ID: <20101105143809.GD15977@opensource.wolfsonmicro.com>
References: <1288858605-8388-1-git-send-email-peter.ujfalusi@nokia.com>
	<201011041618.07655.peter.ujfalusi@nokia.com>
	<20101104180858.GA6088@opensource.wolfsonmicro.com>
	<201011050953.35854.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D7474103964
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 15:38:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201011050953.35854.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 05, 2010 at 09:53:35AM +0200, Peter Ujfalusi wrote:

> Well, I think if we want to have one place to use a lock, this is the highest we 
> can go.

This assumes that we've figured out the correct thing to lock and where
we need to hold it - if you want to lock the DAPM algorithm then that's
one thing, but it's not clear to me that this is the only thing we need
to lock or if we need to ensure that the users of DAPM are handled and
therefore this level of stuff becomes redundant.

> All other places, when dapm_power_widgets called are protected by codec->mutex 
> so those paths are safe.
> By replacing the custom kcontrol/callbacks with SOC_DAPM_PIN_SWITCH() the 
> problem is gone.
> So it seams that my case can be solved easily with the SOC_DAPM_PIN_SWITCH(), 
> but the race remains, and other setups might fail under some rare scenario

This is all smelling like we should be doing something to ensure that
all the controls take the CODEC lock.  We're relying pretty heavily on
that throughout the code so there's going to be other smoking guns
there.

> It might be a good idea to go through the machine drivers, and check for 
> snd_soc_dapm_sync usage.

I think so; probably any DAPM function has this issue.
