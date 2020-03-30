Return-Path: <SRS0=jBUr=5P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05F1C43331
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 18:16:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6084720780
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 18:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OZppkYza";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="Uatvm9v2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6084720780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C819A15F9;
	Mon, 30 Mar 2020 20:15:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C819A15F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585592187;
	bh=NI+ExJbeQqcqKIDG8K0HP1qDysJavhTN5GnoHKrHvgE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OZppkYzakJMPXafgoRPZIxuqOPfZc8HUseNLoSoVMI0iQ0C7TuNVHEXk61+Avr7ne
	 kfEMUrR+j0QzdNAKFzYNLf5ddXlSi9eFDlebDYmOw/Kgs2UFRQXki6xvBhyIigCw2f
	 pNxuS9AFbI5b6s1V6pQG5tFWy7bTPrS8nDQTyS3w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56F01F800EB;
	Mon, 30 Mar 2020 20:15:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B5EFF80148; Mon, 30 Mar 2020 20:15:36 +0200 (CEST)
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28654F800EB
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 20:15:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28654F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de
 header.b="Uatvm9v2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de; 
 s=default2002;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7zL/QlUf15bnQwk3jXS/SCNcp4cSMC+nk7B7INu6KvE=; b=Uatvm9v2F1TL0vaStPhuWY7iMg
 3fNO1PU6FTNo28lLJJouoDlhSK5GerlLq/q4utRmldvKJxTlalWJnp4zcGMPu4hURis/2nSCT4rZj
 s1SC6qkht53AcQNXQJey7gDQGDGru6hp1NZuC+Soni5wEkCs3Cbrlo3CDDjC830bnzhgIr2wxqiAT
 7sdLaodn9/IgdyTTP4gLmqgPsgp1kUtGZ2SaQmwfUrqanes+ZDuErdgqV+KYNhzsThd/QBtEIK4bn
 F1RET452jOweVD1pIHkS7MvCvR0YDlvs66V1hIB0JhLn5ZuTL0YtsK+5rG90a8Kqc9f6rcabEzntw
 OhEcHH9g==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.89_1) (envelope-from <lars@metafoo.de>)
 id 1jIywc-0002d6-7n; Mon, 30 Mar 2020 20:15:30 +0200
Received: from [82.135.79.215] (helo=[192.168.178.20])
 by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <lars@metafoo.de>)
 id 1jIywb-000Nem-Sd; Mon, 30 Mar 2020 20:15:29 +0200
Subject: Re: [PATCH] ASoC: qcom: q6asm-dai: Add SNDRV_PCM_INFO_BATCH flag
To: Stephan Gerhold <stephan@gerhold.net>, Mark Brown <broonie@kernel.org>
References: <20200330175210.47518-1-stephan@gerhold.net>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <ca71ef4e-069f-af8b-ae43-bdd5a3e45be0@metafoo.de>
Date: Mon, 30 Mar 2020 20:15:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330175210.47518-1-stephan@gerhold.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25767/Mon Mar 30 15:08:30 2020)
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 ~postmarketos/upstreaming@lists.sr.ht
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

On 3/30/20 7:52 PM, Stephan Gerhold wrote:
> At the moment, playing audio with PulseAudio with the qdsp6 driver
> results in distorted sound. It seems like its timer-based scheduling
> does not work properly with qdsp6 since setting tsched=0 in
> the PulseAudio configuration avoids the issue.
>
> Apparently this happens when the pointer() callback is not accurate
> enough. There is a SNDRV_PCM_INFO_BATCH flag that can be used to stop
> PulseAudio from using timer-based scheduling by default.
>
> According to https://www.alsa-project.org/pipermail/alsa-devel/2014-March/073816.html:
>
>      The flag is being used in the sense explained in the previous audio
>      meeting -- the data transfer granularity isn't fine enough but aligned
>      to the period size (or less).
>
> q6asm-dai reports the position as multiple of
>
>      prtd->pcm_count = snd_pcm_lib_period_bytes(substream)
>
> so it indeed just a multiple of the period size.
>
> Therefore adding the flag here seems appropriate and makes audio
> work out of the box.
>
> Fixes: 2a9e92d371db ("ASoC: qdsp6: q6asm: Add q6asm dai driver")
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> I'm still quite confused about the true meaning of SNDRV_PCM_INFO_BATCH,
> so please correct me if I'm wrong :)

The meaning might have changed over the years, but the way it is used 
right now is that it means that the position pointer has limited 
granularity. With 'limited' being a bit fuzzy, but typically means that 
the granularity is worse than a few samples.

This driver definitely falls into the limited category as the 
granularity seems to be period size.

- Lars

