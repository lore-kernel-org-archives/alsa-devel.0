From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Support for limiting the volume
Date: Mon, 10 May 2010 10:46:10 +0100
Message-ID: <20100510094610.GA31804@rakim.wolfsonmicro.main>
References: <1273230349-6351-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100507154120.GC25793@rakim.wolfsonmicro.main>
	<201005101007.58347.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 04AE110381B
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 11:46:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201005101007.58347.peter.ujfalusi@nokia.com>
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

On Mon, May 10, 2010 at 10:07:58AM +0300, Peter Ujfalusi wrote:

> however it seams that if the control has invert enabled this is going to break.
> In case of invert we need to invert from the chip maximum, and not from the 
> platform dependent limit.
> The only way I can think of to solve this is to introduce new variable in 
> soc_mixer_control struct. It can be called platform_max.
> The snd_soc_limit_volume would modify the platform_max leaving the max as 
> configured by the drivers (chip maximum).
> In volsw_info calls than we return the platform_max instead of max.
> If in the _info call the platform_max is 0, than we take the max to report (some 
> custom kcontrol macro might not aware of the change in codec drivers).

> What do you think?

That sounds sensible enough.
