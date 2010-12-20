From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add optional pointer to machine
 audio routes to snd_soc_card
Date: Mon, 20 Dec 2010 12:02:01 +0000
Message-ID: <20101220120201.GB26706@rakim.wolfsonmicro.main>
References: <1292607580-27040-1-git-send-email-jhnikula@gmail.com>
	<201012201322.49437.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 122912454A
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 13:02:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201012201322.49437.peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 20, 2010 at 01:22:49PM +0200, Peter Ujfalusi wrote:

> For sure we need to have the card level DAPM map, when we have more than one 
> codec in the system.

That's already possible - this is more a convenience for defining it.

> What I was thinking is more like to move the DAPM map from codec domain up to 
> card level.
> What I mean is, that when you build up your ASoC card, the DAPM map/routes are 
> going to be attached to the card, and not to the codec.

At runtime everyting is treated (or should be treated) as one map - the 

> One thing that might need to be changed in DAPM is how we handle the 
> connected/not connected endpoints.
> Currently if you have DAPM_OUTPUT, and you do not connect it to speaker/HP/line, 
> it is handled like it has some connection.
> In multi comp this might be not what we want.
> Also the treatment of the inputs might need to be changed.

I don't see anything different here with multi-component?  The general
idea is that by default a floating output or input should be treated as
connected.

> Now if you enable the bypass on codec2, it shall not bring up the codec2 bias, 
> since we do not have full route.

This isn't abundantly clear - there may potentially be analogue
interface issues if two devices which aren't connected aren't both
powered up and down together.  Robust system design should avoid these
issues but I'd prefer it if software were conservative and at the very
least always had an option to ensure everything is powered on at once.

> If we do not have the:
> {"codec2 Line in", NULL, "codec1 to line out"},
> in the machine driver, we shall not power the bypass path in codec2, even if the 
> switch is on, since the machine does not specified any connection.

> IMHO this is more logical, than treating non connected OUTPUTs/INPUTs as 
> connected.
> But this is a different issue.

I don't see any relationship between multi-component and the state of
the pins here?  If there's a path through the device the path would be
there even if there's only one device in the system.
