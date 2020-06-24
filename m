Return-Path: <SRS0=wWF8=AF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE0FC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:21:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68D0420723
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="X4zpL85L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D0420723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF00A1856;
	Wed, 24 Jun 2020 17:20:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF00A1856
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593012086;
	bh=S5J+FVAKxVkCB1In0I6T6c95GE+Iz2p9hmXrlQ4oT2U=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X4zpL85LpnQQYvG1U/JpkoO1SLnTgEfFeT5CqRxyAeNl8Ik0uOfLHWtMBzxt3tbsa
	 dzx2N6UbtUgc/y/POpdp8ZLvvYtNZW4AyD3eOPnde/7jlow4Mi62y7lVgA9OiyhIdT
	 ouas9xAuVrNXfV9wNp/zpzOFUDoxI/qYpNNkfuqw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72812F8015A;
	Wed, 24 Jun 2020 17:20:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C378F8015B; Wed, 24 Jun 2020 17:20:35 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86FA4F800B2
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2020 17:20:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86FA4F800B2
IronPort-SDR: Ytrzxx4HosaGMupcV6fDgYsT2LygyOF5hals1x4DqJXabssdVNokM6di1BdaY7/JCCS3QJJkUn
 ZkgF624TXuGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="146007392"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; d="scan'208";a="146007392"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2020 08:20:23 -0700
IronPort-SDR: KthMzFyEl+Z+3oHEZKWAhiMVGsE0+zzjoyfbYYib8GepZG1omsKR/JMJCX53jjf1l9wDom6Jt2
 8+LyYd+a+Egg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; d="scan'208";a="279502647"
Received: from bkorrapa-mobl1.amr.corp.intel.com (HELO [10.254.109.185])
 ([10.254.109.185])
 by orsmga006.jf.intel.com with ESMTP; 24 Jun 2020 08:20:22 -0700
Subject: Re: Fwd: [PATCH] snd/soc: correct trivial kernel-doc inconsistency
To: Colton Lewis <colton.w.lewis@protonmail.com>, alsa-devel@alsa-project.org
References: <4574918.31r3eYUQgx@laptop.coltonlewis.name>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <db6d3b05-33c1-91b9-d0b4-c5063ebafcae@linux.intel.com>
Date: Wed, 24 Jun 2020 10:20:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <4574918.31r3eYUQgx@laptop.coltonlewis.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
 lgirdwood@gmail.com
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



On 6/20/20 9:09 PM, Colton Lewis wrote:
> Can some please accept or comment on this patch?

It's a valid fix, I added the same change in the SOF tree yesterday but 
you beat me to it.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

You probably want to resend and CC: Takashi and Mark.

> 
> ----------  Forwarded Message  ----------
> 
> Subject: [PATCH] snd/soc: correct trivial kernel-doc inconsistency
> Date: Saturday, June 13, 2020, 9:29:08 PM CDT
> From: Colton Lewis <colton.w.lewis@protonmail.com>
> To: lgirdwood@gmail.com
> CC: trivial@kernel.org, Colton Lewis <colton.w.lewis@protonmail.com>
> 
> 
> 
> Silence documentation build warning by correcting kernel-doc comment
> for snd_soc_runtime_action.
> 
> ./sound/soc/soc-pcm.c:220: warning: Function parameter or member 'action' not described in 'snd_soc_runtime_action'
> 
> Signed-off-by: Colton Lewis <colton.w.lewis@protonmail.com>
> ---
>   sound/soc/soc-pcm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 2c114b4542ce..9ab376844ac1 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -208,6 +208,7 @@ static inline void dpcm_remove_debugfs_state(struct snd_soc_dpcm *dpcm)
>    * PCM runtime components
>    * @rtd: ASoC PCM runtime that is activated
>    * @stream: Direction of the PCM stream
> + * @action: Activate stream if 1. Deactivate if -1.
>    *
>    * Increments/Decrements the active count for all the DAIs and components
>    * attached to a PCM runtime.
> 
