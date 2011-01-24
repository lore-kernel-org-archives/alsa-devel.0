From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: sh: fsi-hdmi: Add FSI port and HDMI
 selection
Date: Mon, 24 Jan 2011 11:24:45 +0000
Message-ID: <1295868285.3419.8.camel@odin>
References: <w3poc77151t.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id AB6492446F
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 12:24:54 +0100 (CET)
Received: by wyi11 with SMTP id 11so4000775wyi.38
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 03:24:54 -0800 (PST)
In-Reply-To: <w3poc77151t.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-01-24 at 10:09 +0900, Kuninori Morimoto wrote:
> This patch add platform_device_id which can control
> PortA/PortB for FSI2-HDMI from platform data.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> Paul
> 
> Can you please check it ?
> because it change ap4/mackerel board
> 
>  arch/arm/mach-shmobile/board-ap4evb.c   |    5 ++
>  arch/arm/mach-shmobile/board-mackerel.c |    5 ++
>  sound/soc/sh/fsi-hdmi.c                 |   66 ++++++++++++++++++++++++++++--
>  3 files changed, 71 insertions(+), 5 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
