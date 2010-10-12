From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: fsi: simultaneous
 playback/recorde support
Date: Tue, 12 Oct 2010 10:19:17 +0100
Message-ID: <1286875157.3267.8.camel@odin>
References: <w3pbp70rpoq.wl%kuninori.morimoto.gx@renesas.com>
	<w3paamkrpn6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 1642A244C1
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 11:19:20 +0200 (CEST)
Received: by wyb32 with SMTP id 32so2618359wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2010 02:19:19 -0700 (PDT)
In-Reply-To: <w3paamkrpn6.wl%kuninori.morimoto.gx@renesas.com>
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

On Tue, 2010-10-12 at 13:39 +0900, Kuninori Morimoto wrote:
> Current FSI driver had not cared about simultaneous
> playback/recorde on same port.
> This patch add new fsi_stream struct to care it,
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/sh/fsi.c |  142 +++++++++++++++++++++++++++++++--------------------
>  1 files changed, 86 insertions(+), 56 deletions(-)
> 
> diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
> index 895ce75..0c80d10 100644
> --- a/sound/soc/sh/fsi.c
> +++ b/sound/soc/sh/fsi.c
> @@ -48,6 +48,10 @@
>  #define MREG_START	A_MST_CTLR
>  #define MREG_END	FIFO_SZ
>  
> +/* is */
> +#define IS_PLAY		1
> +#define IS_CAPTURE	0

Please use SNDRV_PCM_STREAM_PLAYBACK and SNDRV_PCM_STREAM_CAPTURE here.

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
