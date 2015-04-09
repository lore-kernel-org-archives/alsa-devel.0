From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Do not create debugfs
	directory
Date: Thu, 9 Apr 2015 00:49:54 -0700
Message-ID: <20150409074953.GA62585@Asurada-CZ80>
References: <1428513684-26577-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 by alsa0.perex.cz (Postfix) with ESMTP id BE949261600
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 09:50:00 +0200 (CEST)
Received: by pdea3 with SMTP id a3so144296802pde.3
 for <alsa-devel@alsa-project.org>; Thu, 09 Apr 2015 00:49:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1428513684-26577-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, timur@tabi.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 08, 2015 at 02:21:24PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit 81c7cfd1b22a0 ("ASoC: Move debugfs registration to the
> component level") ASoC core code deals with registering debugfs, so we
> should not be creating the debugfs directory locally in order to avoid
> the following warning:
> 
> fsl-ssi-dai 2028000.ssi: ASoC: Failed to create component debugfs directory
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Only remove dir creation/remove as suggested by Mark Brown

> diff --git a/sound/soc/fsl/fsl_ssi_dbg.c b/sound/soc/fsl/fsl_ssi_dbg.c
> index 5469ffb..46cea84 100644
> --- a/sound/soc/fsl/fsl_ssi_dbg.c
> +++ b/sound/soc/fsl/fsl_ssi_dbg.c
> @@ -142,22 +142,15 @@ static const struct file_operations fsl_ssi_stats_ops = {
>  
>  int fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg, struct device *dev)
>  {
> -	ssi_dbg->dbg_dir = debugfs_create_dir(dev_name(dev), NULL);
> -	if (!ssi_dbg->dbg_dir)
> +	ssi_dbg->dbg_stats = debugfs_create_file("stats", S_IRUGO, NULL,
> +						 ssi_dbg, &fsl_ssi_stats_ops);
> +	if (!ssi_dbg->dbg_stats)
>  		return -ENOMEM;
>  
> -	ssi_dbg->dbg_stats = debugfs_create_file("stats", S_IRUGO,
> -			ssi_dbg->dbg_dir, ssi_dbg, &fsl_ssi_stats_ops);

It seems that dropping the dbg_dir and using NULL will make the stats
become an orphan inside the debugfs. I am wondering if we can get the
dbg_dir from the component so as to put this stats under the directory
of SSIn as before.

Nicolin
