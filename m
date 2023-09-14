Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70B5EEAA41
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Sep 2023 13:53:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F259B9F6;
	Thu, 14 Sep 2023 15:52:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F259B9F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694699623;
	bh=7gFOQxoYXFU74blJ2VwP0h+TdEkc51N9d7EZW+WhEi4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rCX7dp2lIiVyUnqWvx3aezUp2YVB6Ekhg8uzPmD7hc5ThkBlqis09bO8wvcQResZ4
	 B0ArZ6FTCtHkAkNXvbbSQZp35ziXNxPhWV3WDNHvUOwISDSQ+F7hKFxx+YN/n06hWi
	 +0Qt00i3FZy03b4zusdo5/iqKhjKZrmHfxIkuaUU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 23847F80246; Thu, 14 Sep 2023 15:52:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 771E1F80246;
	Thu, 14 Sep 2023 15:52:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD801F80246; Thu, 14 Sep 2023 15:52:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C82C8F80141
	for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2023 15:52:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C82C8F80141
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bE8tQeI2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694699529; x=1726235529;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=7gFOQxoYXFU74blJ2VwP0h+TdEkc51N9d7EZW+WhEi4=;
  b=bE8tQeI2tkC8dTTuwCQ9SFFnaV+iHQL7GMFoO9FMXUw5y1yCBMoPluCC
   u4KmFu4bxN/CtVYOjO6HLivWxRtr2ShPLgwn2zwl4EvFfz16goCqqKtuF
   ZLKXiSihzZWKnXEw0zEKH9HQqasmYKh/EqWb050YnK6qDygPalPCTwd4I
   gi7/EG9qYjYm/NuR1Z0CSjvDoYBeIqFpep6M6IIt2RAdOTyltm0IWRYQ9
   NkQ1naD5AmELdmle6mNQ2Zl3O6zh3uIiOm6aSlTw4j5AQCyKFBzX0MF/1
   0e815V2Mc7hWiD04kpfsyWzprXkSCK0uMZXTgIZxOwpt7NWdQ0QFoE/QY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="381644441"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000";
   d="scan'208";a="381644441"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2023 06:24:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="814663364"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000";
   d="scan'208";a="814663364"
Received: from pakurapo-mobl3.ger.corp.intel.com (HELO [10.252.37.8])
 ([10.252.37.8])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2023 06:24:03 -0700
Message-ID: <cad960a8-c799-4c1a-be36-f61cc50b0481@linux.intel.com>
Date: Thu, 14 Sep 2023 16:24:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: ipc4-topology: fix wrong sizeof argument
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 yung-chuan.liao@linux.intel.com
References: <20230914130140.1128-1-peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230914130140.1128-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: D2K5FPLOQPWNZFDA3NQGQLKPWTRXL3B6
X-Message-ID-Hash: D2K5FPLOQPWNZFDA3NQGQLKPWTRXL3B6
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D2K5FPLOQPWNZFDA3NQGQLKPWTRXL3B6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 14/09/2023 16:01, Peter Ujfalusi wrote:
> From: Bard Liao <yung-chuan.liao@linux.intel.com>
> 
> available_fmt is a pointer.
> 
> Fixes: 4fdef47a44d6 ("ASoC: SOF: ipc4-topology: Add new tokens for input/output pin format count")
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

My SoB is missing, re-sending it

> ---
>  sound/soc/sof/ipc4-topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
> index f2a30cd31378..7cb63e6b24dc 100644
> --- a/sound/soc/sof/ipc4-topology.c
> +++ b/sound/soc/sof/ipc4-topology.c
> @@ -231,7 +231,7 @@ static int sof_ipc4_get_audio_fmt(struct snd_soc_component *scomp,
>  
>  	ret = sof_update_ipc_object(scomp, available_fmt,
>  				    SOF_AUDIO_FMT_NUM_TOKENS, swidget->tuples,
> -				    swidget->num_tuples, sizeof(available_fmt), 1);
> +				    swidget->num_tuples, sizeof(*available_fmt), 1);
>  	if (ret) {
>  		dev_err(scomp->dev, "Failed to parse audio format token count\n");
>  		return ret;

-- 
Péter
