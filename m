From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: core: Fix race in dapm_power_widgets
Date: Sat, 06 Nov 2010 11:00:06 +0000
Message-ID: <1289041206.3318.12.camel@odin>
References: <1288858605-8388-1-git-send-email-peter.ujfalusi@nokia.com>
	<201011041618.07655.peter.ujfalusi@nokia.com>
	<20101104180858.GA6088@opensource.wolfsonmicro.com>
	<201011050953.35854.peter.ujfalusi@nokia.com>
	<20101105143809.GD15977@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 073FA10380D
	for <alsa-devel@alsa-project.org>; Sat,  6 Nov 2010 12:00:09 +0100 (CET)
Received: by wyb33 with SMTP id 33so1956627wyb.38
	for <alsa-devel@alsa-project.org>; Sat, 06 Nov 2010 04:00:09 -0700 (PDT)
In-Reply-To: <20101105143809.GD15977@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-11-05 at 10:38 -0400, Mark Brown wrote:
> On Fri, Nov 05, 2010 at 09:53:35AM +0200, Peter Ujfalusi wrote:
> 
> > Well, I think if we want to have one place to use a lock, this is the highest we 
> > can go.
> 
> This assumes that we've figured out the correct thing to lock and where
> we need to hold it - if you want to lock the DAPM algorithm then that's
> one thing, but it's not clear to me that this is the only thing we need
> to lock or if we need to ensure that the users of DAPM are handled and
> therefore this level of stuff becomes redundant.
> 
> > All other places, when dapm_power_widgets called are protected by codec->mutex 
> > so those paths are safe.
> > By replacing the custom kcontrol/callbacks with SOC_DAPM_PIN_SWITCH() the 
> > problem is gone.
> > So it seams that my case can be solved easily with the SOC_DAPM_PIN_SWITCH(), 
> > but the race remains, and other setups might fail under some rare scenario
> 
> This is all smelling like we should be doing something to ensure that
> all the controls take the CODEC lock.  We're relying pretty heavily on
> that throughout the code so there's going to be other smoking guns
> there.
> 

I think we need to consider non CODEC components too that have DAPM
controls (and have no CODEC mutex). i.e OMAP4 ABE. 

I'll try and look into this later as part of the OMAP4 upstream. Ideally
a card/DAPM mutex may be more desirable here.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
