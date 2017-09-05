From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: rsnd: stop all working stream
	when	.remove
Date: Tue, 5 Sep 2017 08:58:37 +0000
Message-ID: <PS1PR0601MB188127AD25441AE8543A0EE1D4960@PS1PR0601MB1881.apcprd06.prod.outlook.com>
References: <874lsnniv3.wl%kuninori.morimoto.gx@renesas.com>
 <s5htw0mx4ek.wl-tiwai@suse.de>
 <87d17akgqr.wl%kuninori.morimoto.gx@renesas.com>
 <s5h1snqvnnc.wl-tiwai@suse.de>
 <PS1PR0601MB1881FD07A3E16E039943DA7FD4910@PS1PR0601MB1881.apcprd06.prod.outlook.com>
 <s5h1snmuwxk.wl-tiwai@suse.de>	<s5hziaati7p.wl-tiwai@suse.de>
 <PS1PR0601MB18818E81D00F3056E7F7D54CD4960@PS1PR0601MB1881.apcprd06.prod.outlook.com>
 <s5hk21dtvm6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relmlie2.idc.renesas.com (relmlor3.renesas.com
 [210.160.252.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 75195266E25
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 10:58:42 +0200 (CEST)
In-Reply-To: <s5hk21dtvm6.wl-tiwai@suse.de>
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

> Right, you can't cancel or return an error at that point.
> That is, you'd need to sync (wait) until the all top-level operations are canceled at remove callback.
>
> For example, snd_card_free() processes the disconnection procedure at first,
> then waits for the completion.  That's how the hot-unplug works safely.
> It's implemented, at least, in the top-level driver removal.
>
> Now for the lower level driver, you'd need a similar strategy; notify to the toplevel for
> hot-unplug (disconnect in ALSA), and sync with the stop operation, then continue the rest of its own remove procedure.

OK, it needs ALSA SoC framework side new feature.
But can I confirm current situation ?

In ALSA SoC, it has Card/CPU/Codec/Platform drivers, and we can unbind these randomly.
Now, if I unbind CPU first, it checks connected Card, and will disconnect it if needed (Then, other drivers are as-is).
Because of this, Card will be disconnected automatically, and we can't use it again if user didn't remove all other
remaining drivers and re-bind all drivers again. This is current ALSA SoC I think.

If my understanding was correct, your idea is that we want to call remove function for all connected drivers somehow.
And then, Card want to wait all drivers are removed. Correct ?

I'm happy to work for it.
But adding new unplug feature is for sync with all "drivers", and this patch is sync for "clk" for my CPU driver.
Can we separate these ?

Morimoto
