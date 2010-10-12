From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/5] ASoC: fsi: clean up patches
Date: Tue, 12 Oct 2010 10:16:13 +0100
Message-ID: <1286874973.3267.3.camel@odin>
References: <w3pvd58rv87.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 271B1244BE
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 11:16:18 +0200 (CEST)
Received: by wyb32 with SMTP id 32so2616492wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2010 02:16:17 -0700 (PDT)
In-Reply-To: <w3pvd58rv87.wl%kuninori.morimoto.gx@renesas.com>
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

On Tue, 2010-10-12 at 11:38 +0900, Kuninori Morimoto wrote:
> Dear Mark, Liam
> 
> These patches are clean up for fsi driver
> 
> Kuninori Morimoto (5):
>       ASoC: fsi: Add fsi_get_frame_width function
>       ASoC: fsi: remove un-necessary variable from fsi_dai_startup
>       ASoC: fsi: avoid un-necessary status read
>       ASoC: fsi: Add fsi_is_play function
>       ASoC: fsi: Add new macro and shift for PortA/B In/Out
> 
> Best regards
> --
> Kuninori Morimoto
>  

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

One comment in 4/5 that can be fixed incrementally.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
