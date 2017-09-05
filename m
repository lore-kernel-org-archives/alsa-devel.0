From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: rsnd: stop all working stream
	when	.remove
Date: Tue, 5 Sep 2017 10:07:40 +0000
Message-ID: <PS1PR0601MB1881ECBF54ADD51A9EF68435D4960@PS1PR0601MB1881.apcprd06.prod.outlook.com>
References: <874lsnniv3.wl%kuninori.morimoto.gx@renesas.com>
 <s5htw0mx4ek.wl-tiwai@suse.de>
 <87d17akgqr.wl%kuninori.morimoto.gx@renesas.com>
 <s5h1snqvnnc.wl-tiwai@suse.de>
 <PS1PR0601MB1881FD07A3E16E039943DA7FD4910@PS1PR0601MB1881.apcprd06.prod.outlook.com>
 <s5h1snmuwxk.wl-tiwai@suse.de>	<s5hziaati7p.wl-tiwai@suse.de>
 <PS1PR0601MB18818E81D00F3056E7F7D54CD4960@PS1PR0601MB1881.apcprd06.prod.outlook.com>
 <s5hk21dtvm6.wl-tiwai@suse.de>
 <PS1PR0601MB188127AD25441AE8543A0EE1D4960@PS1PR0601MB1881.apcprd06.prod.outlook.com>
 <s5hy3pto5ft.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relmlie1.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by alsa0.perex.cz (Postfix) with ESMTP id B83AD266C6D
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 12:07:46 +0200 (CEST)
In-Reply-To: <s5hy3pto5ft.wl-tiwai@suse.de>
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

> I'm happy to work for it.
> But adding new unplug feature is for sync with all "drivers", and this patch is sync for "clk" for my CPU driver.
> Can we separate these ?
>
> It belongs with the same thing. Basically you're tweaking clk per PCM stream status.
> By handling the full hot-plug properly, the PCM stream is assured to be stopped,
> thus you don't have to fiddle with clk in the remove callback at all.

Oh, yes, indeed.
Thanks.
