Return-Path: <SRS0=jBUr=5P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217B4C43331
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 11:48:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C8122072E
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 11:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BBgvkFmZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxhaTbln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8122072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E8B7215F9;
	Mon, 30 Mar 2020 13:47:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E8B7215F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585568899;
	bh=bolhhtn/zsW9hgT7sOG/KCu4gAqAzVYB+AcJBxuTk/Y=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BBgvkFmZOHzW1O8Y8NmUkQ01PW5aSwT7AtRkYuPvgMXsH4T8nv9GDRfHXxpurmORZ
	 9/6/zUnDjTUiU5ocrqh9tg+13vqFpXCj6pbkAovW70VRM1KnmGn4Kq+GTnYWfvrjLs
	 c7qI0wQfx04cEcpQ3uIywGsKhCBawhukXm4PNprY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 623F3F80145;
	Mon, 30 Mar 2020 13:47:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7B4AFF80148; Mon, 30 Mar 2020 13:47:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83453F8010C
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 13:47:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83453F8010C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lxhaTbln"
Received: from localhost (unknown [122.182.197.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 07EA22072E;
 Mon, 30 Mar 2020 11:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585568840;
 bh=bolhhtn/zsW9hgT7sOG/KCu4gAqAzVYB+AcJBxuTk/Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lxhaTblnEtSCP2BqFNQkF9GBZXoW5jBKFfIZV3YDY4wM1Lj3u6CxdImkWJv5TAd6Z
 gkXNnalXMS6RQaI1HgTW/ONbXNgBRw0+o3CLh5KgnEjZaucSkaZYZt+sbYNN+/j5Nm
 lLzvZeywPedQ2ZsR3xJAw20Sclw8etbkciqzXqcM=
Date: Mon, 30 Mar 2020 17:17:16 +0530
From: Vinod Koul <vkoul@kernel.org>
To: =?utf-8?B?77+9zLDvv73vv73vv70=?= <gt82.lee@samsung.com>
Subject: Re: [PATCH 1/1] ASoC: soc-compress: lock pcm_mutex to resolve
 lockdep error
Message-ID: <20200330114716.GA72691@vkoul-mobl>
References: <CGME20200330110126epcas2p4525e5c6f61f7452df008696f9153770d@epcas2p4.samsung.com>
 <002101d60682$8ec21ed0$ac465c70$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <002101d60682$8ec21ed0$ac465c70$@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com,
 tiwai@suse.com
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hello,

On 30-03-20, 20:01, �̰��� wrote:
> snd_soc_runtime_activate() and snd_soc_runtime_deactivate()
> require locked pcm_mutex.
> 
> Signed-off-by: Gyeongtaek Lee <gt82.lee@samsung.com>
> ---
>  sound/soc/soc-compress.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
> index 392a1c5b15d3..42d416ac7e9b 100644
> --- a/sound/soc/soc-compress.c
> +++ b/sound/soc/soc-compress.c
> @@ -207,7 +207,9 @@ static int soc_compr_open_fe(struct snd_compr_stream
> *cstream)
>  	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_OPEN;
>  	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
>  
> +	mutex_lock_nested(&fe->pcm_mutex, fe->pcm_subclass);
>  	snd_soc_runtime_activate(fe, stream);
> +	mutex_unlock(&fe->pcm_mutex);

Can you please explain why you need the lock here, as
>  
>  	mutex_unlock(&fe->card->mutex);

we already have a lock here..

> @@ -285,7 +287,9 @@ static int soc_compr_free_fe(struct snd_compr_stream
> *cstream)
>  	else
>  		stream = SNDRV_PCM_STREAM_CAPTURE;
>  
> +	mutex_lock_nested(&fe->pcm_mutex, fe->pcm_subclass);
>  	snd_soc_runtime_deactivate(fe, stream);
> +	mutex_unlock(&fe->pcm_mutex);

And this instance is also using fe->card->mutex.. so I think double lock
may not serve any purpose here..

Can you explain why we need the extra lock?

Thanks
-- 
~Vinod
