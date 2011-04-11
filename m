From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/3] ASoC: fsi: bug fix for driver
	probe/remove
Date: Mon, 11 Apr 2011 20:50:56 +0100
Message-ID: <1302551456.3449.55.camel@odin>
References: <w3pei5dwa0e.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D30D510384C
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 21:51:01 +0200 (CEST)
Received: by wwf26 with SMTP id 26so5657493wwf.20
	for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2011 12:51:01 -0700 (PDT)
In-Reply-To: <w3pei5dwa0e.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: yoshii <takashi.yoshii.zj@renesas.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus <magnus.damm@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-04-08 at 15:08 +0900, Kuninori Morimoto wrote:
> Dear Mark, Liam
> 
> These are bug fix patches for FSI driver probe/remove
> 
> Kuninori Morimoto (3)
> 	ASoC: fsi: take care in failing case of dai register
> 	ASoC: fsi: modify vague PM control on probe
> 	ASoC: fsi: driver safely remove for against irq
> 
> Magnus
> 
> Can you please check #2 patch which modify pm_runtime
> 

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
