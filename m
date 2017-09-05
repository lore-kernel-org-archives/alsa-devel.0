From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: rsnd: stop all working stream
	when	.remove
Date: Tue, 5 Sep 2017 07:40:11 +0000
Message-ID: <PS1PR0601MB18818E81D00F3056E7F7D54CD4960@PS1PR0601MB1881.apcprd06.prod.outlook.com>
References: <874lsnniv3.wl%kuninori.morimoto.gx@renesas.com>
 <s5htw0mx4ek.wl-tiwai@suse.de>
 <87d17akgqr.wl%kuninori.morimoto.gx@renesas.com>
 <s5h1snqvnnc.wl-tiwai@suse.de>
 <PS1PR0601MB1881FD07A3E16E039943DA7FD4910@PS1PR0601MB1881.apcprd06.prod.outlook.com>
 <s5h1snmuwxk.wl-tiwai@suse.de> <s5hziaati7p.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relmlie3.idc.renesas.com (relmlor4.renesas.com
 [210.160.252.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E264267208
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 09:40:18 +0200 (CEST)
In-Reply-To: <s5hziaati7p.wl-tiwai@suse.de>
Content-Language: ja-JP
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

Hi Takashi-san

Thank you for your feedback

> This isn't something you shouldn't fiddle with the codec layer.
> If the driver gets removed during the operation, you have to cancel 
> the operation and sync with it in a proper way, then proceed the rest 
> of the remove, not only a codec-specific resource management.
(snip)
> Here I mentioned the codec driver, but it's applied to each lower-level
> component.  It'd need some graceful way to communicate with the
> top-level card to assure the removal of the component.

I agree.
I can't access to source code now (I'm in business-trip), but my head-acke is that kernel doesn't check return value from .remove when unbind case.
Thus, we can't "cancel" remove operation.
I'm happy if you can confirm it.
