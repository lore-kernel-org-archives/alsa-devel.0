Return-Path: <SRS0=XzTt=AG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA01C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:15:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A992065D
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tFXsrI9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A992065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 919181AAB;
	Thu, 25 Jun 2020 21:14:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 919181AAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593112531;
	bh=hjJlaoyLyOYl6yPLRybUKuq9qqygZ+DYo/2xyZzFmUE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tFXsrI9RXu/L70JiEG92N72L9wTa1mKc17qaxFQn39ZVwR2yOsnYDMU43FMeTWNCG
	 JoWqcoTRKonz1hQSObr+Sg0HXMb/2WW1xO6JAZMD+VYk1dD3rwZ9wQumKHDQkeSqLB
	 KmqroYr4dY/jhAQSpBQ2p9EWRdMPI/hlp6pip3ms=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9358DF80218;
	Thu, 25 Jun 2020 21:13:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1472EF802DB; Thu, 25 Jun 2020 21:13:47 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 927D0F80277
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 21:13:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 927D0F80277
IronPort-SDR: NKckVP5d6MZreeQl/c1F9k8fUYiHHBzOEr2JjkwDmEUm/a7yzXBwoDZ+/+bhx65r8L/Gj2QHea
 tS7M3j7cRceQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="144120815"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; d="scan'208";a="144120815"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 12:13:33 -0700
IronPort-SDR: hsIoCVMRgp/T58xBnCyby5ULZEo/s61e4PdCK2rtvmwt8lbSPeECAs31zo86rb1sN3DV9zj4ex
 LnY2zLCjFEjA==
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; d="scan'208";a="354559469"
Received: from zeqimao-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.109.39])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 12:13:32 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 02/17] ASoC: Intel: cml_rt1011_rt5682: add missing .owner field
Date: Thu, 25 Jun 2020 14:12:53 -0500
Message-Id: <20200625191308.3322-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625191308.3322-1-pierre-louis.bossart@linux.intel.com>
References: <20200625191308.3322-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

This field is required for ASoC cards. Not setting it will result in a
module->name pointer being NULL and generate problems such as

cat /proc/asound/modules
 0 (efault)

Reported-by: Jaroslav Kysela <perex@perex.cz>
Suggested-by: Takashi Iwai <tiwai@suse.de>
Fixes: 17fe95d6df93 ('ASoC: Intel: boards: Add CML m/c using RT1011 and RT5682')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/intel/boards/cml_rt1011_rt5682.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/cml_rt1011_rt5682.c b/sound/soc/intel/boards/cml_rt1011_rt5682.c
index 189c908c4aa8..6e8934f348ef 100644
--- a/sound/soc/intel/boards/cml_rt1011_rt5682.c
+++ b/sound/soc/intel/boards/cml_rt1011_rt5682.c
@@ -501,6 +501,7 @@ static struct snd_soc_codec_conf rt1011_conf[] = {
 /* Cometlake audio machine driver for RT1011 and RT5682 */
 static struct snd_soc_card snd_soc_card_cml = {
 	.name = "cml_rt1011_rt5682",
+	.owner = THIS_MODULE,
 	.dai_link = cml_rt1011_rt5682_dailink,
 	.num_links = ARRAY_SIZE(cml_rt1011_rt5682_dailink),
 	.codec_conf = rt1011_conf,
-- 
2.20.1

