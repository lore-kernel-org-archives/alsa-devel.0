Return-Path: <SRS0=t/pq=4B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874A7C2BA83
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 17:06:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F95217F4
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 17:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Om9fA2Y+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F95217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21BB916DE;
	Thu, 13 Feb 2020 18:05:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21BB916DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581613596;
	bh=8kNVrrbCA0ScB+EYTLEFiMlpNout7IB/hbDL0ZW41hQ=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Om9fA2Y+qVKSgooFU/Wyd1DV+FivbkFtU3Nt9/LNXPbPUBdgRUhhweA7yOVVErR6N
	 JCYwSYzFo2GYwfvSTVtnf0omjovP1cv23WMw9aynl9itMGF1tUBla94rkXanwLMEL9
	 pcUkk8oU7aRTLXhBFio/Fz4dHRGf/v5F0NaVrkHQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E4141F800F0;
	Thu, 13 Feb 2020 18:04:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A4AEBF8021E; Thu, 13 Feb 2020 18:04:51 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EDD8F80138
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2020 18:04:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EDD8F80138
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Feb 2020 09:04:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,437,1574150400"; d="scan'208";a="222709220"
Received: from rebrandt-mobl.amr.corp.intel.com (HELO [10.251.9.115])
 ([10.251.9.115])
 by orsmga007.jf.intel.com with ESMTP; 13 Feb 2020 09:04:44 -0800
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <87blq3ru4w.wl-kuninori.morimoto.gx@renesas.com>
 <871rqzru2y.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3ea74049-c07a-bfed-204b-96f6bd9d9032@linux.intel.com>
Date: Thu, 13 Feb 2020 09:56:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <871rqzru2y.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] [PATCH 07/10] ASoC: soc-pcm: add
 snd_soc_dpcm_can_be() and remove duplicate code
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



> +int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
> +		struct snd_soc_pcm_runtime *be, int stream)
> +{
> +	enum snd_soc_dpcm_state state[] = {
> +		SND_SOC_DPCM_STATE_START,
> +		SND_SOC_DPCM_STATE_PAUSED,
> +		SND_SOC_DPCM_STATE_SUSPEND,
> +	};

should this be const?


> +	enum snd_soc_dpcm_state state[] = {
> +		SND_SOC_DPCM_STATE_START,
> +		SND_SOC_DPCM_STATE_PAUSED,
> +		SND_SOC_DPCM_STATE_SUSPEND,
> +		SND_SOC_DPCM_STATE_PREPARE,
> +	};

const as well?
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
