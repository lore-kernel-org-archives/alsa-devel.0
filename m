Return-Path: <SRS0=IN0D=YE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF018ECE58C
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:46:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245A9206CD
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Cp4PgT5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245A9206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A03671673;
	Fri, 11 Oct 2019 18:45:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A03671673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570812409;
	bh=cyHrT285lrjgG0SIF91aDQ5x3Vx7+4Pzz1NXJvJfDuM=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cp4PgT5Bbo0HHauNNTqdxb1h/H/bZAJH8WziG2qCNDFJou9NoAPs73H+7Udwd7142
	 ZRehHBd1gUMTt9skTOdmoG2+NmqLdYhES+agIUN9zF1OuRElfB/UnM/esqMBThxtje
	 GXa23tLATN+UkF+JkwnCMrYNnddFoaM99wHLQcRs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64685F80600;
	Fri, 11 Oct 2019 18:43:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE460F805A8; Fri, 11 Oct 2019 18:43:29 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13C4EF802DF
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2019 18:43:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13C4EF802DF
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Oct 2019 09:43:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; d="scan'208";a="224387823"
Received: from askelkar-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.254.181.148])
 by fmsmga002.fm.intel.com with ESMTP; 11 Oct 2019 09:43:21 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri, 11 Oct 2019 11:43:12 -0500
Message-Id: <20191011164312.7988-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191011164312.7988-1-pierre-louis.bossart@linux.intel.com>
References: <20191011164312.7988-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 4/4] ASoC: SOF: topology: check errors when
	parsing LED tokens
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

sof_parse_tokens() returns a value that is checked on every call
except for LED tokens, fix with explicit test.

Detected with cppcheck warning:

sound/soc/sof/topology.c:973:6: style: Variable 'ret' is assigned a
value that is never used. [unreadVariable]
 ret = sof_parse_tokens(scomp, &scontrol->led_ctl, led_tokens,
     ^

Fixes: 5d43001ae4360 ("ASoC: SOF: acpi led support for switch controls")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/topology.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 05eec3c464a9..cc138ac6a8eb 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -973,6 +973,11 @@ static int sof_control_load_volume(struct snd_soc_component *scomp,
 	ret = sof_parse_tokens(scomp, &scontrol->led_ctl, led_tokens,
 			       ARRAY_SIZE(led_tokens), mc->priv.array,
 			       le32_to_cpu(mc->priv.size));
+	if (ret != 0) {
+		dev_err(sdev->dev, "error: parse led tokens failed %d\n",
+			le32_to_cpu(mc->priv.size));
+		return ret;
+	}
 
 	dev_dbg(sdev->dev, "tplg: load kcontrol index %d chans %d\n",
 		scontrol->comp_id, scontrol->num_channels);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
