Return-Path: <SRS0=E7cH=ZR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9CBC432C3
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:37:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0692082F
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UiKk5bwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0692082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF1C217EF;
	Mon, 25 Nov 2019 16:37:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF1C217EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574696271;
	bh=qd5O3bV67Kcj5eRZuFU/qXN+Tf/BpL9lnIp3i9afNOQ=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UiKk5bwZkMy0dNI9TheFONxeTulx6WIAeEHxBTSpqyp3jLS6eFU8uB5GcGA5rRv6H
	 G2yqf6k0+/v9WhUuGufkDbPDATjzD74rs4uOknqrxQhth0J2kFpO6WCYYyDXCVApL/
	 nDiJ5f6flJ5ILLqLjygPxp3yOu7VsxL1K1MR0uEw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7841FF801DB;
	Mon, 25 Nov 2019 16:36:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B392F800E5; Mon, 25 Nov 2019 16:36:04 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB2E1F800E5
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2019 16:36:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB2E1F800E5
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Nov 2019 07:35:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,241,1571727600"; d="scan'208";a="408342872"
Received: from knezevic-mobl3.amr.corp.intel.com (HELO [10.254.182.224])
 ([10.254.182.224])
 by fmsmga005.fm.intel.com with ESMTP; 25 Nov 2019 07:35:56 -0800
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <877e3og50x.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f18c29fc-4ea1-280e-d0ef-57ed08b2f05b@linux.intel.com>
Date: Mon, 25 Nov 2019 09:29:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <877e3og50x.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] [PATCH v2 00/15] ASoC: soc-core cleanup step6
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



On 11/24/19 6:42 PM, Kuninori Morimoto wrote:
> 
> Hi Mark
> 
> These are v2 of soc-core cleanup step6.
> These doesn't add new features.
> 
> Kuninori Morimoto (15):
>        ASoC: soc-core: remove dai_link_list
>        ASoC: soc-core: remove snd_soc_disconnect_sync()
>        ASoC: soc-core: remove snd_soc_get_dai_substream()
>        ASoC: soc-core: move snd_soc_get_pcm_runtime()
>        ASoC: soc-core: find rtd via dai_link pointer at snd_soc_get_pcm_runtime()
>        ASoC: soc-core: move snd_soc_find_dai_link()
>        ASoC: soc-core: rename snd_soc_add_dai_link() to snd_soc_add_pcm_runtime()
>        ASoC: soc-core: rename snd_soc_remove_dai_link() to snd_soc_remove_pcm_runtime()
>        ASoC: soc-core: move soc_link_dai_pcm_new()
>        ASoC: soc-core: rename soc_link_dai_pcm_new() to soc_dai_pcm_new()
>        ASoC: soc-core: move soc_link_init()
>        ASoC: soc-core: add missing return value check for soc_link_init()
>        ASoC: soc-core: rename soc_link_init() to soc_init_pcm_runtime()
>        ASoC: soc-core: soc_set_name_prefix(): tidyup loop condition
>        ASoC: soc-core: soc_set_name_prefix(): get component device_node at out of loop

For the v2 series

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks Morimoto-san
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
