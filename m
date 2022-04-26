Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E58C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Apr 2022 19:33:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7263D17DE;
	Tue, 26 Apr 2022 21:33:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7263D17DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651001636;
	bh=kViGcP1l1PJKHr9WrtcHcJumrQpC1DBjsTeHFutlSIM=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RAg4F5+a6a7bBDhXLVp5BTKVnojCwbO8yVCZoLljZbzRXtFEO8Hb5+SunY1EfR2k7
	 4TMWcLIJZ/Go/ToaLB26AedTwvvl0LecOjKYwTrtuqFTtmGfEtH9Pk6vl/+L/iGUS0
	 RVWf74qo9mEHbaRGHdKbrDkf+XaaeMvYOZlOvd+E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EDE81F8014B;
	Tue, 26 Apr 2022 21:33:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E70FF80152; Tue, 26 Apr 2022 21:33:04 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr
 [80.12.242.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41BE7F80105
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2022 21:32:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41BE7F80105
Received: from [192.168.1.18] ([86.243.180.246]) by smtp.orange.fr with ESMTPA
 id jQvenj84zrYGrjQvenImsG; Tue, 26 Apr 2022 21:32:55 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 26 Apr 2022 21:32:55 +0200
X-ME-IP: 86.243.180.246
Message-ID: <6e3e881b-787d-30d5-054a-2ef43e3731b1@wanadoo.fr>
Date: Tue, 26 Apr 2022 21:32:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH AUTOSEL 5.17 01/22] ASoC: soc-pcm: use GFP_KERNEL when the
 code is sleepable
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20220426190145.2351135-1-sashal@kernel.org>
From: Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220426190145.2351135-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.com, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
 alsa-devel@alsa-project.org
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

Hi,

I don't think that this patch needs backporting.

It does not fix anything and could introduce some regression if 
b7898396f4bb is not also already backported.
It could avoid some (unlikely?) allocation failure, but as this case is 
already handled ("if (!dpcm)"), it shouldn't be an issue if it happened.


Just for my understanding, why has it auto-selected for backport?
I thought that a Fixes tag and/or a real reported issue was need for 
this to happen.

CJ



Le 26/04/2022 à 21:01, Sasha Levin a écrit :
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
> [ Upstream commit fb6d679fee95d272c0a94912c4e534146823ee89 ]
>
> At the kzalloc() call in dpcm_be_connect(), there is no spin lock involved.
> It's merely protected by card->pcm_mutex, instead.  The spinlock is applied
> at the later call with snd_soc_pcm_stream_lock_irq() only for the list
> manipulations.  (See it's *_irq(), not *_irqsave(); that means the context
> being sleepable at that point.)  So, we can use GFP_KERNEL safely there.
>
> This patch revert commit d8a9c6e1f676 ("ASoC: soc-pcm: use GFP_ATOMIC for
> dpcm structure") which is no longer needed since commit b7898396f4bb
> ("ASoC: soc-pcm: Fix and cleanup DPCM locking").
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Link: https://lore.kernel.org/r/e740f1930843060e025e3c0f17ec1393cfdafb26.1648757961.git.christophe.jaillet@wanadoo.fr
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   sound/soc/soc-pcm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 9a954680d492..11c9853e9e80 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -1214,7 +1214,7 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
>   		be_substream->pcm->nonatomic = 1;
>   	}
>   
> -	dpcm = kzalloc(sizeof(struct snd_soc_dpcm), GFP_ATOMIC);
> +	dpcm = kzalloc(sizeof(struct snd_soc_dpcm), GFP_KERNEL);
>   	if (!dpcm)
>   		return -ENOMEM;
>   
