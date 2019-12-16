Return-Path: <SRS0=bmHO=2G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E4BC43603
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:51:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836A022464
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hqyBpwDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836A022464
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iodev.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B9D4850;
	Mon, 16 Dec 2019 23:50:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B9D4850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576536667;
	bh=AENhfs0zoFA2TnOpZE9or4bW3BCkkDt2npBWwP755xA=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hqyBpwDIidB5IOAvYmZA9g2vbY/tM0FmxFLVM0RqQo8x/XhmTv+izP6cg+9mN52H3
	 HGCqQA6AYogyda4iLdoxJ5JbXKQ1QkBvjK4cIh0cGIcD0gUM0OLNQ8yc2VAnyXrD55
	 oXwaUcuTE5t7OlOf9H7US5NXbAClJwykUhIWik+8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD9EEF8022C;
	Mon, 16 Dec 2019 23:50:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D588CF80255; Mon, 16 Dec 2019 23:50:14 +0100 (CET)
Received: from iodev.co.uk (iodev.co.uk [193.29.56.124])
 by alsa1.perex.cz (Postfix) with ESMTP id 9096BF800AD
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2019 23:50:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9096BF800AD
Date: Tue, 17 Dec 2019 00:42:04 +0100
From: Ismael Luceno <ismael@iodev.co.uk>
To: Takashi Iwai <tiwai@suse.de>
Message-ID: <20191216234204.GA32004@pirotess.home>
References: <20191210135849.15607-1-tiwai@suse.de>
 <20191210135849.15607-2-tiwai@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191210135849.15607-2-tiwai@suse.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: alsa-devel@alsa-project.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Andrey Utkin <andrey.utkin@corp.bluecherry.net>,
 Bluecherry Maintainers <maintainers@bluecherrydvr.com>,
 Anton Sviridenko <anton@corp.bluecherry.net>, linux-media@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH for-5.6 01/14] media: solo6x10: Use managed
 buffer allocation
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 10/Dec/2019 14:58, Takashi Iwai wrote:
> Clean up the driver with the new managed buffer allocation API.
> The hw_params and hw_free callbacks became superfluous and dropped.
> 
> Cc: Bluecherry Maintainers <maintainers@bluecherrydvr.com>
> Cc: Anton Sviridenko <anton@corp.bluecherry.net>
> Cc: Andrey Utkin <andrey.utkin@corp.bluecherry.net>
> Cc: Ismael Luceno <ismael@iodev.co.uk>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/media/pci/solo6x10/solo6x10-g723.c | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/media/pci/solo6x10/solo6x10-g723.c b/drivers/media/pci/solo6x10/solo6x10-g723.c
> index eaa57d835ea8..ca349d447610 100644
> --- a/drivers/media/pci/solo6x10/solo6x10-g723.c
> +++ b/drivers/media/pci/solo6x10/solo6x10-g723.c
> @@ -97,17 +97,6 @@ void solo_g723_isr(struct solo_dev *solo_dev)
>  	}
>  }
>  
> -static int snd_solo_hw_params(struct snd_pcm_substream *ss,
> -			      struct snd_pcm_hw_params *hw_params)
> -{
> -	return snd_pcm_lib_malloc_pages(ss, params_buffer_bytes(hw_params));
> -}
> -
> -static int snd_solo_hw_free(struct snd_pcm_substream *ss)
> -{
> -	return snd_pcm_lib_free_pages(ss);
> -}
> -
>  static const struct snd_pcm_hardware snd_solo_pcm_hw = {
>  	.info			= (SNDRV_PCM_INFO_MMAP |
>  				   SNDRV_PCM_INFO_INTERLEAVED |
> @@ -271,8 +260,6 @@ static const struct snd_pcm_ops snd_solo_pcm_ops = {
>  	.open = snd_solo_pcm_open,
>  	.close = snd_solo_pcm_close,
>  	.ioctl = snd_pcm_lib_ioctl,
> -	.hw_params = snd_solo_hw_params,
> -	.hw_free = snd_solo_hw_free,
>  	.prepare = snd_solo_pcm_prepare,
>  	.trigger = snd_solo_pcm_trigger,
>  	.pointer = snd_solo_pcm_pointer,
> @@ -351,11 +338,11 @@ static int solo_snd_pcm_init(struct solo_dev *solo_dev)
>  	     ss; ss = ss->next, i++)
>  		sprintf(ss->name, "Camera #%d Audio", i);
>  
> -	snd_pcm_lib_preallocate_pages_for_all(pcm,
> -					SNDRV_DMA_TYPE_CONTINUOUS,
> -					NULL,
> -					G723_PERIOD_BYTES * PERIODS,
> -					G723_PERIOD_BYTES * PERIODS);
> +	snd_pcm_set_managed_buffer_all(pcm,
> +				       SNDRV_DMA_TYPE_CONTINUOUS,
> +				       NULL,
> +				       G723_PERIOD_BYTES * PERIODS,
> +				       G723_PERIOD_BYTES * PERIODS);
>  
>  	solo_dev->snd_pcm = pcm;
>  
> -- 
> 2.16.4
> 

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
