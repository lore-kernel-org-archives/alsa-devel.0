From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/4 v2] ASoC: sh: fsi-codec
Date: Wed, 18 Apr 2012 12:47:46 +0200
Message-ID: <201204181247.46345.rjw@sisk.pl>
References: <874nt2aphw.wl%kuninori.morimoto.gx@renesas.com>
	<87zkashytm.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ogre.sisk.pl (ogre.sisk.pl [193.178.161.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 25C971045A3
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Apr 2012 12:43:14 +0200 (CEST)
In-Reply-To: <87zkashytm.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <magnus.damm@gmail.com>, Liam Girdwood <lrg@ti.com>, Paul Mundt <lethal@linux-sh.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Wednesday, April 04, 2012, Kuninori Morimoto wrote:
> 
> Hi Mark, Liam
> Cc: Paul, Rafael
> 
> These are v2 patches of fsi-codec support for SuperH board.
> 
> Kuninori Morimoto (4):
>       ASoC: sh: fsi: add fsi-common-codec card support
>       ASoC: sh: fsi: use fsi-common-codec instead of fsi-ak4642
>       ASoC: sh: fsi: use fsi-common-codec instead of fsi-hdmi
>       ASoC: sh: fsi: use fsi-common-codec instead of fsi-da7210
> 
> #2-#3 patches remove fsi-xxx card driver and
> Kconfig settings from ${LINUX}/sound/soc/sh/Kconfig.
> 
> And adds board specific CODEC on each board Kconfig.
> CODEC/fsi-common-codec will be selected automatically
> if you select board and FSI.

Could you please re-post this series and include linux-sh and Magnus in the
CC list?

Rafael
