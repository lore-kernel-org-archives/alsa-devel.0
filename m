Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B778BC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:27:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44844206E9
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sPxyWgCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44844206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C00C6169B;
	Tue,  7 Jul 2020 21:26:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C00C6169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594150064;
	bh=NCkkHF4yGJ+7ImZr3PdtS+aj4laPMgr9bqloWCFEFI8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sPxyWgCbv/9J40AXSqWBumjV1On4E2G3UkTD/fO9XLB/kotH2sxoo1N8EEcH4CDFV
	 t44UYWyxQ3JNdGgdCzHtD1Y56xq4D9mc/M9RFa4QLYs3NuSD9MioQGPLWvnjNvj09j
	 2I3WT5NPlFbRuPjnn8lZyHcF63XB+FU3qxkJ8RPk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B5DB7F80257;
	Tue,  7 Jul 2020 21:26:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4CA3F80257; Tue,  7 Jul 2020 21:26:51 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2B92F8011F
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 21:26:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2B92F8011F
IronPort-SDR: HKm3Xh2YCi+GIg73jKUXgjx8rskXgPgVfwBgZrtVZgFp4vpUCBssARK70SsN4VfTetb0XL3v7G
 x1tspihri/PQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="146751728"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="146751728"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 12:26:45 -0700
IronPort-SDR: PJ2Pr9HKoJiDzpm/sNxhX0XcUkS+HhvcTX+0P0ERPRiYihnaaibWyQwnIrx3s0BYd+UwH1DFjt
 row3O05nQZsA==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="297493428"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO [10.254.77.62])
 ([10.254.77.62])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 12:26:44 -0700
Subject: Re: [PATCH 03/11] ASoC: q6asm: make commands specific to streams
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200707163641.17113-4-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9ff595b4-1093-36c8-f27f-f097e24657a0@linux.intel.com>
Date: Tue, 7 Jul 2020 11:52:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707163641.17113-4-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
 vkoul@kernel.org
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




> @@ -184,8 +186,8 @@ static void event_handler(uint32_t opcode, uint32_t token,
>   	switch (opcode) {
>   	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
>   		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> -			q6asm_write_async(prtd->audio_client,
> -				   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
> +			q6asm_write_async(prtd->audio_client, prtd->stream_id,
> +				   prtd->pcm_count, 0, 0, 0);

sound/soc/qcom/qdsp6/q6asm.h:#define NO_TIMESTAMP    0xFF00

is the change on the previous line intentional?

>   		break;
>   	case ASM_CLIENT_EVENT_CMD_EOS_DONE:
>   		prtd->state = Q6ASM_STREAM_STOPPED;
> @@ -194,8 +196,8 @@ static void event_handler(uint32_t opcode, uint32_t token,
>   		prtd->pcm_irq_pos += prtd->pcm_count;
>   		snd_pcm_period_elapsed(substream);
>   		if (prtd->state == Q6ASM_STREAM_RUNNING)
> -			q6asm_write_async(prtd->audio_client,
> -					   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
> +			q6asm_write_async(prtd->audio_client, prtd->stream_id,
> +					   prtd->pcm_count, 0, 0, 0);

ditto for the timestamp change?


> @@ -501,8 +514,8 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
>   	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
>   		spin_lock_irqsave(&prtd->lock, flags);
>   		if (!prtd->bytes_sent) {
> -			q6asm_write_async(prtd->audio_client, prtd->pcm_count,
> -					  0, 0, NO_TIMESTAMP);
> +			q6asm_write_async(prtd->audio_client, prtd->stream_id,
> +					  prtd->pcm_count, 0, 0, 0);

and here as well.

>   			prtd->bytes_sent += prtd->pcm_count;
>   		}
>   
> @@ -527,8 +540,8 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
>   		avail = prtd->bytes_received - prtd->bytes_sent;
>   
>   		if (avail >= prtd->pcm_count) {
> -			q6asm_write_async(prtd->audio_client,
> -					   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
> +			q6asm_write_async(prtd->audio_client, prtd->stream_id,
> +					   prtd->pcm_count, 0, 0, 0);

and here.

