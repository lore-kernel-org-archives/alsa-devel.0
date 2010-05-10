From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/5] Enabling ASoC paths over suspend
Date: Mon, 10 May 2010 08:30:37 +0100
Message-ID: <1273476637.3288.0.camel@odin>
References: <20100509120741.GA16918@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 4A9EA2470F
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 09:30:43 +0200 (CEST)
Received: by wyb33 with SMTP id 33so342676wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 10 May 2010 00:30:43 -0700 (PDT)
In-Reply-To: <20100509120741.GA16918@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2010-05-09 at 13:07 +0100, Mark Brown wrote:
> The following patch series implements support for keeping some paths in
> the audio codec enabled while the system is suspended.  This is
> primarily intended for mobile phones, where the GSM modem is normally
> capable of supporting a voice call with no intervention from the CPU so
> power can be saved by suspending the Linux system.  This is done by
> allowing DAPM nodes to be marked as ignoring suspend.  Any audio paths
> between two widgets set up like this at suspend time will be kept active
> and the CODEC device will not be suspended.
> 
> The existing testing is very light (especially for digital paths), the
> intention is to do more of that get this merged into Takashi's tree
> early next week.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git suspend-enable
> 
> Mark Brown (5):
>       ASoC: Remove unneeded suspend bias managment from CODEC drivers
>       ASoC: Remove unused DAPM suspend flag
>       ASoC: Refactor DAPM suspend handling
>       ASoC: Support leaving paths enabled over system suspend
>       ASoC: Allow active paths from the GSM modem while the GTA02 is suspended

All :-

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
