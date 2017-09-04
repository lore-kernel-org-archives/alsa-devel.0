From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: rsnd: stop all working stream
	when	.remove
Date: Mon, 4 Sep 2017 17:44:36 +0000
Message-ID: <PS1PR0601MB1881FD07A3E16E039943DA7FD4910@PS1PR0601MB1881.apcprd06.prod.outlook.com>
References: <874lsnniv3.wl%kuninori.morimoto.gx@renesas.com>
 <s5htw0mx4ek.wl-tiwai@suse.de>
 <87d17akgqr.wl%kuninori.morimoto.gx@renesas.com>
 <s5h1snqvnnc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relmlie1.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by alsa0.perex.cz (Postfix) with ESMTP id BDD6326710B
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 19:44:43 +0200 (CEST)
In-Reply-To: <s5h1snqvnnc.wl-tiwai@suse.de>
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

Hi Takasi-san

> > The lack of stop sync is a known problem in the ALSA PCM 
> > infrastructure.  The standard idiom is to do sync at both prepare 
> > and hw_free (or close) callbacks.
> 
> Thanks.
> This path main sync is for clk ON/OFF
>
> Hm, but it's managed as PCM trigger, no?
> How can the rsnd_io_is_working() return true after PCM streams are stopped?

It is based on PCM trigger, thus, it returns false if PCM streams are stopped.

This driver calls clk_get() when PCM started, and clk_put() when stopped.
And it calles clk_enable() on .probe, and clk_disable() on .remove.

My problem is that user unbinds driver during Sound playing, this means clk_get() is called, but clk_put() is not called. Then, .remove will call clk_disable(), but clk_put() is not yet called. Then, kernel indicates clk user count mismatch. This patch calls missing PCM stop (= clk_put()) position function if needed.
Is this clear answer for you ?
