Return-Path: <SRS0=zNzy=JG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33E5C433B4
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 22:04:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54135610CF
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 22:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54135610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EAEB01697;
	Sat, 10 Apr 2021 00:03:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EAEB01697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618005851;
	bh=KDCGOo5AqndK0Ik4SnhT0ZpHAcLlPT5jH7aJ2r770ek=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Phgy8W5lzjRDTdlYUVxiUy8hum0OUPSgdBBDWz/1s2vc8cTZiK2x6ddLuA12CZtqW
	 Csv6xrs4ITih6YRnoNqAqajcRRsEQpE8YrJUG2ItvU99hNzoTJa+miDpsTfjAT69JJ
	 wpV3RqVYpkatvIoCXzmkMDsWcAVlUK63i3PEPLuc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE238F80431;
	Sat, 10 Apr 2021 00:01:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E1EFBF8042F; Sat, 10 Apr 2021 00:01:51 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB276F80260
 for <alsa-devel@alsa-project.org>; Sat, 10 Apr 2021 00:01:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB276F80260
IronPort-SDR: MQodrjbAEdTxceAXESrfWXzMbv9a9Dlf/yIPRge/Cla5Oe5Wzsr5CG7Xdu2XIS5VaxrrOxKnHL
 Ntnro1O+6hqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="214284734"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; d="scan'208";a="214284734"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 15:01:39 -0700
IronPort-SDR: ev2Xmty/kfStGth8MxbM83LPaZyAm7G+hYnpeoerKK/SEsOoKPVTYE7VY/d0HVjMhyxXKM5cac
 1lIEx8L17tmg==
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; d="scan'208";a="599290644"
Received: from ukorat-mobl2.amr.corp.intel.com (HELO rsridh-mobl1.localdomain)
 ([10.212.104.152])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 15:01:38 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 5/6] ASoC: SOF: pcm: export snd_pcm_dai_link_fixup
Date: Fri,  9 Apr 2021 15:01:20 -0700
Message-Id: <20210409220121.1542362-6-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409220121.1542362-1-ranjani.sridharan@linux.intel.com>
References: <20210409220121.1542362-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In preparation of the nocodec refactoring, export the dai-link
fixup. This will also be required when we have more clients and
platform drivers.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index d6b1c8b7bdfb..9893b182da43 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -775,6 +775,7 @@ int sof_pcm_dai_link_fixup(struct snd_soc_pcm_runtime *rtd, struct snd_pcm_hw_pa
 
 	return 0;
 }
+EXPORT_SYMBOL(sof_pcm_dai_link_fixup);
 
 static int sof_pcm_probe(struct snd_soc_component *component)
 {
-- 
2.25.1

