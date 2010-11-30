From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] ASoC: sh: fsi-ak4642: Add FSI port and
	ak464x selection
Date: Tue, 30 Nov 2010 14:56:48 +0900
Message-ID: <20101130055648.GB17114@linux-sh.org>
References: <w3p7hfvbkyl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from master.linux-sh.org (124x34x33x190.ap124.ftth.ucom.ne.jp
	[124.34.33.190]) by alsa0.perex.cz (Postfix) with ESMTP id C87C42415C
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 06:57:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <w3p7hfvbkyl.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 30, 2010 at 11:32:04AM +0900, Kuninori Morimoto wrote:
> Current FSI-Ak4642 device had niche settings which were
> FSI2-A-AK4643 and FSI-A-AK4642.
> This patch add platform_device_id which can control
> FSI/FSI2, PortA/PortB, AK4642/AK4643 from platform data.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/board-ap4evb.c |    5 +
>  arch/sh/boards/mach-se/7724/setup.c   |    5 +
>  sound/soc/sh/fsi-ak4642.c             |  133 ++++++++++++++++++++++++++++++---
>  3 files changed, 131 insertions(+), 12 deletions(-)
> 
Acked-by: Paul Mundt <lethal@linux-sh.org>
