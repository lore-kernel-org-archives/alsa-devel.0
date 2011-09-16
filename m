From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [v2] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Fri, 16 Sep 2011 13:19:16 -0500
Message-ID: <4E739324.506@freescale.com>
References: <1316182614-9666-1-git-send-email-timur@freescale.com>	<s5hwrd8jy68.wl%tiwai@suse.de>
	<4E736F9B.6080206@freescale.com> <4E7378E2.9050200@metafoo.de>
	<4E737A89.8090509@freescale.com> <4E738B65.6080802@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BB5A10399F
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 20:20:51 +0200 (CEST)
In-Reply-To: <4E738B65.6080802@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Lars-Peter Clausen wrote:
> How do you know which sysclk rate to select for a given sample rate, if you
> don't know the samples rates the CODEC can produces for a given sysclk rate?

You're right that supporting this feature would require the machine driver to
know more about the internals of the codec.  But I still think we need a better
mechanism for the codec driver to tell ASoC which sample rates are actually
supported.

-- 
Timur Tabi
Linux kernel developer at Freescale
