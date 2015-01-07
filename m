From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 2/2] ASoC: fsl_dma: Do not use 'full_name'
	node reference
Date: Wed, 07 Jan 2015 11:26:44 -0600
Message-ID: <54AD6C54.4090709@tabi.org>
References: <1420651312-21671-1-git-send-email-festevam@gmail.com>
 <1420651312-21671-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id F0DA026516D
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 18:26:45 +0100 (CET)
In-Reply-To: <1420651312-21671-2-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fabio Estevam wrote:
> -			ssi_np->full_name);
> +			pdev->name);
>   		of_node_put(ssi_np);
>   		return ret;
>   	}
>
> -	dma = kzalloc(sizeof(*dma) + strlen(np->full_name), GFP_KERNEL);
> +	dma = kzalloc(sizeof(*dma), GFP_KERNEL);

Something is missing here.  Since we're no longer allocating space in 
the 'dma' object for the name, then you should probably delete the code 
that copies the string to the 'dma' object.
