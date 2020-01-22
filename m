Return-Path: <SRS0=vsGj=3L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF864C2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 19:58:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B93C21835
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 19:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lqjNmtc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B93C21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9078916AA;
	Wed, 22 Jan 2020 20:57:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9078916AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579723121;
	bh=+Gtxk0q+/38lymzUXbIjpCVWokRSfmf1d/cXEF0iUnE=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lqjNmtc9Jn9s3mpulh84eWWojw9HDEFl6x/5X4kTovZGJsds83YY8JnPYbbK4LlPS
	 qxXnPfW2WR3AZHidmxcaNfy1UteKMIISL5s5JNY0c3igZyhoSOFF0CLZxi2uP0WxP8
	 GUTmUeEO3+xbbB5u1kpKGhaAAJd5LDGpjyu8JDrA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D14AAF800E7;
	Wed, 22 Jan 2020 20:56:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D822EF80273; Wed, 22 Jan 2020 20:56:44 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60AC7F800E7
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2020 20:56:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60AC7F800E7
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Jan 2020 11:56:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; d="scan'208";a="250734872"
Received: from jovercas-mobl1.amr.corp.intel.com (HELO [10.254.105.26])
 ([10.254.105.26])
 by fmsmga004.fm.intel.com with ESMTP; 22 Jan 2020 11:56:31 -0800
To: Jaroslav Kysela <perex@perex.cz>,
 ALSA development <alsa-devel@alsa-project.org>
References: <20200122190752.3081016-1-perex@perex.cz>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <26ae4dbd-b1b8-c640-0dc0-d8c2bbe666e2@linux.intel.com>
Date: Wed, 22 Jan 2020 13:28:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122190752.3081016-1-perex@perex.cz>
Content-Language: en-US
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, Takashi Iwai <tiwai@suse.de>,
 Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: topology: fix
 soc_tplg_fe_link_create() - link->dobj initialization order
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 1/22/20 1:07 PM, Jaroslav Kysela wrote:
> The code which checks the return value for snd_soc_add_dai_link() call
> in soc_tplg_fe_link_create() moved the snd_soc_add_dai_link() call before
> link->dobj members initialization.
> 
> While it does not affect the latest kernels, the old soc-core.c code
> in the stable kernels is affected. The snd_soc_add_dai_link() function uses
> the link->dobj.type member to check, if the link structure is valid.
> 
> Reorder the link->dobj initialization to make things work again.
> It's harmless for the recent code (and the structure should be properly
> initialized before other calls anyway).
> 
> The problem is in stable linux-5.4.y since version 5.4.11 when the
> upstream commit 76d270364932 was applied.

I am not following. Is this a fix for linux-5.4-y only, or is it needed 
on Mark's tree? In the latter case, what is broken? We've been using 
Mark's tree without issues, wondering what we missed?

> 
> Fixes: 76d270364932 ("ASoC: topology: Check return value for snd_soc_add_dai_link()")
> Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> ---
>   sound/soc/soc-topology.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> index 92e4f4d08bfa..4e1fe623c390 100644
> --- a/sound/soc/soc-topology.c
> +++ b/sound/soc/soc-topology.c
> @@ -1906,6 +1906,10 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
>   	link->num_codecs = 1;
>   	link->num_platforms = 1;
>   
> +	link->dobj.index = tplg->index;
> +	link->dobj.ops = tplg->ops;
> +	link->dobj.type = SND_SOC_DOBJ_DAI_LINK;
> +
>   	if (strlen(pcm->pcm_name)) {
>   		link->name = kstrdup(pcm->pcm_name, GFP_KERNEL);
>   		link->stream_name = kstrdup(pcm->pcm_name, GFP_KERNEL);
> @@ -1942,9 +1946,6 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
>   		goto err;
>   	}
>   
> -	link->dobj.index = tplg->index;
> -	link->dobj.ops = tplg->ops;
> -	link->dobj.type = SND_SOC_DOBJ_DAI_LINK;
>   	list_add(&link->dobj.list, &tplg->comp->dobj_list);
>   
>   	return 0;
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
