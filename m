From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/4] ASoC: sh: fsi: remove runtime reg check
Date: Fri, 03 Dec 2010 12:00:14 +0000
Message-ID: <1291377614.3271.41.camel@odin>
References: <w3pei9zdzhl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 60EC6103B29
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 13:00:17 +0100 (CET)
Received: by wyi11 with SMTP id 11so9375837wyi.38
	for <alsa-devel@alsa-project.org>; Fri, 03 Dec 2010 04:00:17 -0800 (PST)
In-Reply-To: <w3pei9zdzhl.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-12-03 at 17:36 +0900, Kuninori Morimoto wrote:
> Dear Mark, Liam
> 
> These are "remove runtime reg check" patches from fsi_xx function.
> 
> Kuninori Morimoto (4):
>       ASoC: sh: fsi: remove fsi_master_write
>       ASoC: sh: fsi: change fsi->mst_ctrl to master->a/b_mclk
>       ASoC: sh: fsi: remove runtime register check from fsi_reg_xxx
>       ASoC: sh: fsi: remove runtime register check from fsi_master_xxx
> 
> current runtime check is just useless

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
