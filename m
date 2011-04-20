From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/2] ASoC: sh: fsi: Add module/port control
Date: Wed, 20 Apr 2011 12:11:58 +0100
Message-ID: <1303297918.3436.2.camel@odin>
References: <w3psjtespdm.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E79AF1037FC
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Apr 2011 13:12:01 +0200 (CEST)
Received: by wyg36 with SMTP id 36so558298wyg.38
	for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2011 04:12:01 -0700 (PDT)
In-Reply-To: <w3psjtespdm.wl%kuninori.morimoto.gx@renesas.com>
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

On Tue, 2011-04-19 at 15:54 +0900, Kuninori Morimoto wrote:
> Dear Mark, Liam
> 
> Cc Magnus, Simon, yoshii-san
> 
> These patches control FSI module/port power.
> 
> Kuninori Morimoto:
>          ASoC: sh: fsi: add fsi_is_clk_master function
>          ASoC: sh: fsi: Add module/port control function
> 
> The FIFO of each port were always working even though
> it was not used in current FSI driver.
> 
> 2nd patch add module/port control functions.
> 
> >> Mark
> 
> these patches are depend on my
> [PATCH] ASoC: fsi: add dev_pm_ops :: suspend/resume
> 

These do look fine, but as mentioned please do add some more text to the
commit messages.

Acked-by: Liam Girdwood <lrg@ti.com>

Liam
