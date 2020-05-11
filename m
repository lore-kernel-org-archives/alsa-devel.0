Return-Path: <SRS0=GrjN=62=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEC7C47255
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 01:07:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B10206DD
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 01:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cOBaWBYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B10206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D18439F6;
	Tue, 12 May 2020 03:06:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D18439F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589245653;
	bh=DxxpdMl79VYbx+SgaOMiVE7IDgspORmyROAZzQwFhVs=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cOBaWBYZG5ttwsFbPMHTSh05EIJbbe9yoRW9XiJQbR+w8KztF1tvh6BExYw9dIdqr
	 k7ScqEu01sEVTCCPmkTTNG5BVr07u65IvGj4YUabE2UbIqsfVzpa0Gq1Yt9HJxlslM
	 XhQsgmVY6FsmkoYLOVNxrjPgfD3dVazywwuZHEUk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93805F802A1;
	Tue, 12 May 2020 00:38:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F638F802A2; Tue, 12 May 2020 00:38:11 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 631CEF80299
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2020 00:38:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 631CEF80299
IronPort-SDR: o2F7zg3cKB/XgLtajoRwzyICTGBdz6M5lFNYikZWOvlnmyFAQR5nmpO2UPQ/2kiD7zHtJhANlK
 XAPQTkcSZfhw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2020 15:37:59 -0700
IronPort-SDR: geL5zwfkE4JqI1eI48r4KVBrmBOqKv6SrGjWvqfwO1KrR7YxuNrxkJzTbDRbeoA3IgmW75sDDu
 YH16frUvhBXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; d="scan'208";a="463329359"
Received: from ajgalle-mobl.amr.corp.intel.com ([10.254.179.28])
 by fmsmga005.fm.intel.com with ESMTP; 11 May 2020 15:37:58 -0700
Message-ID: <eaa4bd3a140ccfd150953bfd46615fb8de967387.camel@linux.intel.com>
Subject: Re: [PATCH 01/17] ASoC: soc-dai: add snd_soc_dai_activity()
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown
 <broonie@kernel.org>
Date: Mon, 11 May 2020 15:37:58 -0700
In-Reply-To: <874ksn9fqf.wl-kuninori.morimoto.gx@renesas.com>
References: <875zd39frp.wl-kuninori.morimoto.gx@renesas.com>
 <874ksn9fqf.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
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

On Mon, 2020-05-11 at 14:56 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current snd_soc_runtime_action() is counting
> dai->stream_active for Playback/Capture,
> dai->active        for DAI
> 
> 	static void snd_soc_runtime_action(...)
> 	{
> 		...
> 		for_each_rtd_dais(rtd, i, dai) {
> 			dai->stream_active[stream] += action;
> 			dai->active += action;
> 			...
> 		}
> 	}
> 
> But, these are very verbose, because we can calculate
> DAI activity from stream_activity.
> 
> This patch adds snd_soc_dai_activity() which calculate
> DAI activity from DAI stream_activity.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  include/sound/soc-dai.h |  2 +-
>  sound/soc/soc-dai.c     | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> index 2a0a5af1c1ae..887575d59e31 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -137,7 +137,7 @@ int snd_soc_dai_set_tristate(struct snd_soc_dai
> *dai, int tristate);
>  /* Digital Audio Interface mute */
>  int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
>  			     int direction);
> -
> +int snd_soc_dai_activity(struct snd_soc_dai *dai);
>  
>  int snd_soc_dai_get_channel_map(struct snd_soc_dai *dai,
>  		unsigned int *tx_num, unsigned int *tx_slot,
> diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
> index 8e5fe012aa1d..aa0826136f57 100644
> --- a/sound/soc/soc-dai.c
> +++ b/sound/soc/soc-dai.c
> @@ -305,6 +305,18 @@ int snd_soc_dai_digital_mute(struct snd_soc_dai
> *dai, int mute,
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
>  
> +int snd_soc_dai_activity(struct snd_soc_dai *dai)
I think snd_soc_dai_active() is a better name than activity.

Thanks,
Ranjani

