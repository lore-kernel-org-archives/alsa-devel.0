Return-Path: <SRS0=mf2d=HH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F00C433E6
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 16:40:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD01364ED9
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 16:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD01364ED9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 18EF31614;
	Fri,  5 Feb 2021 17:39:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 18EF31614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612543202;
	bh=09h5+uSLMEJpUDrIaW0qwsb6QfigEP6kMngTUCUiMxg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oviipG1Zj+IiLbXXe17y4NGSWVuoXO1u07YBqkZ4m0ZuXp4GDvw0AocGFrQMfbXwC
	 0t3QQuRv/e+W1Do5FCp35XyWqKcorofapf7MmYYWcGgkw4uqxnuC5d/uyHnR5A5gN/
	 gF6KvU4mj3OUcqbctT9M8x1x7CRIf+/rWKtn9rqc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5FF5F80152;
	Fri,  5 Feb 2021 17:39:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9189FF8015A; Fri,  5 Feb 2021 17:39:09 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34E57F80152
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2021 17:39:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34E57F80152
IronPort-SDR: q7Xah/OWpGQYHxmpkSVNIu3cp1m3NQF84UOWggUt3anXwx0SIgRX1oWWog6Ddyh//nkhmFWWS/
 WEqzodBEJZ5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="180679990"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; d="scan'208";a="180679990"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2021 08:39:00 -0800
IronPort-SDR: /sUGJ1YTZQPx5Kcpctd2nrXwAgQAhY7iNpFQIcg8MRHSpAWon4T53/iNZwq5QHbY0K+9kERFYm
 X5UJHLQzEnfg==
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; d="scan'208";a="393929306"
Received: from gjcomber-mobl.amr.corp.intel.com (HELO [10.255.228.165])
 ([10.255.228.165])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2021 08:38:58 -0800
Subject: Re: [PATCH 14/14] ASoC: SOF: Intel: hda: add dev_dbg() when DMIC
 number is overridden
To: Mark Brown <broonie@kernel.org>
References: <20210204203312.27112-1-pierre-louis.bossart@linux.intel.com>
 <20210204203312.27112-15-pierre-louis.bossart@linux.intel.com>
 <20210205153336.GE4720@sirena.org.uk>
 <d6f10083-f046-a708-60b1-86e3fd731e60@linux.intel.com>
 <20210205155157.GF4720@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8e0b6cc2-7221-f867-3422-db946bfe038a@linux.intel.com>
Date: Fri, 5 Feb 2021 10:38:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205155157.GF4720@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, tiwai@suse.de,
 vkoul@kernel.org, Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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



> Like I say it's not that patch that's causing the break, I didn't walk
> through and work out which one was - the patch isn't actually adding the
> usage or anything.

Ah yes, you're correct. Mea culpa. We're using the parameter for HDA and 
SoundWire now, but HDA is disabled with allmodconfig due to a mutual 
exclusion with NOCODEC. I've had this on my todo list for a while.

We need something like this, will test and resend a v2. Sorry about the 
noise.

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 2014058bddf2..0dc3a8c0f5e3 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -285,11 +285,13 @@ static char *hda_model;
  module_param(hda_model, charp, 0444);
  MODULE_PARM_DESC(hda_model, "Use the given HDA board model.");

-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA) || 
IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
  static int hda_dmic_num = -1;
  module_param_named(dmic_num, hda_dmic_num, int, 0444);
  MODULE_PARM_DESC(dmic_num, "SOF HDA DMIC number");
+#endif

+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
  static bool hda_codec_use_common_hdmi = 
IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI);
  module_param_named(use_common_hdmi, hda_codec_use_common_hdmi, bool, 
0444);
  MODULE_PARM_DESC(use_common_hdmi, "SOF HDA use common HDMI codec driver");

