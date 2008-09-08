From: Liam Girdwood <lrg@kernel.org>
Subject: Re: ASoC vs non-ASoC: 2 pcm driver questions.
Date: Mon, 08 Sep 2008 09:37:48 +0100
Message-ID: <1220863068.17091.70.camel@odin>
References: <ga2i5s$sge$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id D8397244DE
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 10:37:53 +0200 (CEST)
In-Reply-To: <ga2i5s$sge$2@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2008-09-08 at 06:53 +0000, Dmitry Baryshkov wrote:
> Hi,
> 
> While unifying pxa2xx-pcm drivers (ASoC and plain one) I've encountered the
> following differences in snd_pcm_open:
> 
> 1. ASoC one uses snd_soc_set_runtime_hardware() function instead of
>  just copying runtime->hw = pxa2xx_pcm_hardware;
> However the major difference is that snd_soc_set_runtime_hardware() doesn't
> initialise few fields which are set later in generic soc_pcm_open().
> Can I drop this call and use the same assignment as in non-asoc driver.
> 

Do you mean snd_soc_set_runtime_hw_params() ?

Give it a try.

> 2. To enforce some constraints ASoC driver uses generic
>  snd_pcm_hw_constraint_step() instead of hand-written rule functions.
>  Can this be also unified or there are some hidden differencies?
> 

This could also be unified, can't think of any reason why they should
not.

Liam
