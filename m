From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_asrc: sound is wrong after
 suspend/resume
Date: Sun, 20 Dec 2015 23:05:40 -0800
Message-ID: <20151221070539.GA3524@Asurada-CZ80>
References: <66fa43839fccc9aba8ebfc1330afc22747f05f0d.1450428914.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C00E261552
 for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2015 08:05:47 +0100 (CET)
Received: by mail-pa0-f46.google.com with SMTP id jx14so66642278pad.2
 for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2015 23:05:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <66fa43839fccc9aba8ebfc1330afc22747f05f0d.1450428914.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 18, 2015 at 04:58:18PM +0800, Zidan Wang wrote:
> The register ASRCFG is volatile, but some bits need to be recovered
> after suspend/resume.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>

You may send an extra version with my ack after the following change:

> @@ -453,6 +457,8 @@ struct fsl_asrc {
>  
>  	int asrc_rate;
>  	int asrc_width;
> +
> +	u32 regcache_cfg;
>  };
 
Please add a comment after:
435  * @asrc_rate: default sample rate for ASoC Back-Ends
436  * @asrc_width: default sample width for ASoC Back-Ends

Thank you
