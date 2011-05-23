From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 0/9] ASoC: sh: fsi: tidyup and cleanup FSI
Date: Mon, 23 May 2011 15:43:08 +0100
Message-ID: <4DDA727C.7000600@ti.com>
References: <w3pipt17i99.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id D148224419
	for <alsa-devel@alsa-project.org>;
	Mon, 23 May 2011 16:43:15 +0200 (CEST)
In-Reply-To: <w3pipt17i99.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, yoshii <takashi.yoshii.zj@renesas.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus <magnus.damm@gmail.com>, Simon <horms@verge.net.au>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 23/05/11 12:45, Kuninori Morimoto wrote:
> 
> Dear Mark, Liam
> 
> Cc Simon, yoshii-san, Magnus
> 
> These are tidyup and cleanup patches for FSI
> 
> Kuninori Morimoto (9):
>       ASoC: sh: fsi: tidyup parameter of fsi_stream_push
>       ASoC: sh: fsi: tidyup unclear variable naming
>       ASoC: sh: fsi: remove pm_runtime from fsi_dai_set_fmt.
>       ASoC: sh: fsi: make sure fsi_stream_push/pop access by spin lock
>       ASoC: sh: fsi: Add fsi_set_master_clk
>       ASoC: sh: fsi: irq control moves to fsi_port_start/stop
>       ASoC: sh: fsi: Add fsi_hw_startup/shutdown
>       ASoC: sh: fsi: remove fsi_module_init/kill
>       ASoC: sh: fsi: cleanup suspend/resume
> 
> #1 and #2 are tidyup for fsi_fifo_data_ctrl.
> The variables and sub-functions were unclear nameing.
> So, it was difficult to understand the detail of calculation.
> Thank you for pointing it yoshii-san.
> 
> #3 - #9 are clean up for RuntimePM.
> Current FSI driver was wrong for RuntimePM.
> these patches fixup for RuntimePM and
> clean up for suspend/resume.
> last patch remove noisy saved_xxx variable.
> 

All

Acked-by: Liam Girdwood <lrg@ti.com>
