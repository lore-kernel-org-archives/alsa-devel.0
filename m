From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Fix race in dapm_power_widgets
Date: Sat, 6 Nov 2010 11:10:55 -0400
Message-ID: <20101106151055.GA26711@opensource.wolfsonmicro.com>
References: <1288858605-8388-1-git-send-email-peter.ujfalusi@nokia.com>
	<201011041618.07655.peter.ujfalusi@nokia.com>
	<20101104180858.GA6088@opensource.wolfsonmicro.com>
	<201011050953.35854.peter.ujfalusi@nokia.com>
	<20101105143809.GD15977@opensource.wolfsonmicro.com>
	<1289041206.3318.12.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 199D3103815
	for <alsa-devel@alsa-project.org>; Sat,  6 Nov 2010 16:10:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1289041206.3318.12.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 06, 2010 at 11:00:06AM +0000, Liam Girdwood wrote:

> I think we need to consider non CODEC components too that have DAPM
> controls (and have no CODEC mutex). i.e OMAP4 ABE. 

> I'll try and look into this later as part of the OMAP4 upstream. Ideally
> a card/DAPM mutex may be more desirable here.

Another option is to just move the mutex up to the card level so we
don't need mutexes on the individual objects.  I think we're going to
need to lock at the card level to do cross-object DAPM sequences, and if
we do that we may not need to bother with anything more fine grained.
