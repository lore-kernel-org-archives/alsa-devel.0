Return-Path: <SRS0=ZBV5=4O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EE0C4BA13
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:39:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E9A20656
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RrVRmnwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E9A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC57F166E;
	Wed, 26 Feb 2020 17:39:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC57F166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582735195;
	bh=noH/qZLvTaR1XnENrUQb557QW6QLkN9dSgVsgco9kh4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RrVRmnwIFA1EFD83nNTPO9n1o+6YJxEKYcjzpLBMghRQD0y87YjQ0LXwu+y18l1CA
	 v2gT2YwPPnfVa17/jNtRk2iOl3BbxFlmQ2C2uytzS52hevI7eWTwPm79Sr/md8TW36
	 bsOMRMelEZPzq0jDMjwEEFfqOjtk7E0XRJ1RId1A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85C13F800E8;
	Wed, 26 Feb 2020 17:38:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 04BA0F80171; Wed, 26 Feb 2020 17:38:10 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 598B5F8014D
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 17:38:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 598B5F8014D
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Feb 2020 08:38:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,488,1574150400"; d="scan'208";a="410671946"
Received: from nkaburla-mobl.amr.corp.intel.com (HELO [10.252.133.245])
 ([10.252.133.245])
 by orsmga005.jf.intel.com with ESMTP; 26 Feb 2020 08:38:03 -0800
Subject: Re: [PATCH 8/8] ASoC: soc-pcm: tidyup dulicate handing at
 dpcm_fe_dai_startup()
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <87eeuh97k4.wl-kuninori.morimoto.gx@renesas.com>
 <8736ax97hm.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1e91e2da-2e86-abfb-19fe-7924c92350a8@linux.intel.com>
Date: Wed, 26 Feb 2020 09:22:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8736ax97hm.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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



On 2/26/20 12:41 AM, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> error handling at dpcm_fe_dai_startup() has duplicate code.
> This patch tidyup it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   sound/soc/soc-pcm.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 1f7a86c4bc02..2fdd90437a6f 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -2165,11 +2165,9 @@ static int dpcm_fe_dai_startup(struct snd_pcm_substream *fe_substream)
>   		goto unwind;
>   	}

nit-pick: since the two lines below are removed, the 'goto unwind' above 
becomes unnecessary. I don't mind if you leave it for symmetry with the 
rest of the error handling flow.

> -	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
> -	return 0;
> -
>   unwind:
> -	dpcm_be_dai_startup_unwind(fe, stream);
> +	if (ret < 0)
> +		dpcm_be_dai_startup_unwind(fe, stream);
>   be_err:
>   	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
>   	return ret;
> 
