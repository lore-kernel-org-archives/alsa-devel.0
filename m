From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC][PATCH] ASoC: Add soc_remove_dai_links
Date: Mon, 11 Apr 2011 20:57:36 +0100
Message-ID: <1302551856.3449.61.camel@odin>
References: <w3pfwptwats.wl%kuninori.morimoto.gx@renesas.com>
	<1302284132.3315.120.camel@odin>
	<w3p62qld22d.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CDB2510384C
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 21:57:41 +0200 (CEST)
Received: by wwf26 with SMTP id 26so5663223wwf.20
	for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2011 12:57:40 -0700 (PDT)
In-Reply-To: <w3p62qld22d.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, yoshii <takashi.yoshii.zj@renesas.com>, Magnus <magnus.damm@gmail.com>, Simon <horms@verge.net.au>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-04-11 at 10:11 +0900, Kuninori Morimoto wrote:
> 
> Dear Liam
> 
> Thank you for your reply
> 
> > > # cd /sys/bus/platform/drivers/fsi-ak4642-audio
> > > # echo sh_fsi2_a_ak4643.0 > unbind
> > > # echo sh_fsi2_a_ak4643.0 > bind    *1
> > >
> > > *1
> > > soc_new_pcm isn't called, and "aplay -l" doens't show fsi-ak4642.
> > > snd_soc_instantiate_card return around /* bind comleted ? */
> > >
> >
> > Can you confirm are you unloading (all ?) then reloading the driver
> > modules in this test case ?
> 
> Thanks. I show my test in below.
> 
> But please check this patch carefully.
> I'm not familiar with ASoC core, 
> and don't want "confusion" or "new bug" for it. 

Looks correct.

Acked-by: Liam Girdwood <lrg@ti.com>
