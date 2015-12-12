From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: add support for 8-30kHz
 output sample rate
Date: Fri, 11 Dec 2015 21:34:20 -0800
Message-ID: <20151212053419.GC3564@Asurada-CZ80>
References: <1449745370-18960-1-git-send-email-zidan.wang@freescale.com>
 <1449745370-18960-2-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
 [209.85.218.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 055BB2654B8
 for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2015 06:34:24 +0100 (CET)
Received: by oifz134 with SMTP id z134so5512804oif.0
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 21:34:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449745370-18960-2-git-send-email-zidan.wang@freescale.com>
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

On Thu, Dec 10, 2015 at 07:02:49PM +0800, Zidan Wang wrote:

> @@ -287,6 +287,13 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  		return -EINVAL;
>  	}
>  
> +	if ((outrate > 8000 && outrate < 30000) &&
> +			(outrate/inrate > 24 || inrate/outrate > 8)) {

Indentation
