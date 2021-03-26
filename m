Return-Path: <SRS0=Z4e1=IY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFE5C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 22:04:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3530619C9
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 22:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3530619C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38A3D1692;
	Fri, 26 Mar 2021 23:03:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38A3D1692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616796258;
	bh=YJOWNXQFye6xx8+LXtMXb1edWo4V1LKAlet3msswDBA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XfdUKkvl2iTdx/zzW4KBkmIk55lnKRDR/c6fK7IvHV62PBXnk1JdK2j6mz5a0wieJ
	 /gtizK1JM1dK0TB8Q6wLpEodmznaR9gP43yHsN2VeuIP3d6S+5GvmkDDLZ/cW+f3uk
	 FeUNmLoIJyPML7EdG6kksfav6bz/1DJ7B/h5L7Sc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C02B8F804D1;
	Fri, 26 Mar 2021 23:00:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C1D8F80431; Fri, 26 Mar 2021 23:00:15 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 823A0F8032D
 for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2021 23:00:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 823A0F8032D
IronPort-SDR: f7JO11bYM7uy91gJ32etwnWDVCpkiGCiTV8eQktOvmq3o+dQSqdlbznmnZ6Bb0hR6+DxMqrkPk
 9bDmb7VjNaDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="211396717"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="211396717"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 15:00:06 -0700
IronPort-SDR: 7NWZHaaay1C/1PxCKzjdVdf7YwM5gdF5YFKIj46EH6by9m9zByzidJ4/VP14TKr0nh48yjZQF1
 4NwB0i7DUqAQ==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="416706795"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.255.231.203])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 15:00:05 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 08/17] ASoC: sti: sti_uniperif: add missing error check
Date: Fri, 26 Mar 2021 16:59:18 -0500
Message-Id: <20210326215927.936377-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 Takashi Iwai <tiwai@suse.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 broonie@kernel.org
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

cppcheck warning:

sound/soc/sti/sti_uniperif.c:490:6: style: Variable 'ret' is
reassigned a value before the old one has been
used. [redundantAssignment]
 ret = devm_snd_soc_register_component(&pdev->dev,
     ^
sound/soc/sti/sti_uniperif.c:486:6: note: ret is assigned
 ret = sti_uniperiph_cpu_dai_of(node, priv);
     ^
sound/soc/sti/sti_uniperif.c:490:6: note: ret is overwritten
 ret = devm_snd_soc_register_component(&pdev->dev,
     ^

sti_uniperiph_cpu_dai_of() can return -EINVAL which seems like a
good-enough reason to bail.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sti/sti_uniperif.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 7b9169f04d6e..67315d9b352d 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -484,6 +484,8 @@ static int sti_uniperiph_probe(struct platform_device *pdev)
 	priv->pdev = pdev;
 
 	ret = sti_uniperiph_cpu_dai_of(node, priv);
+	if (ret < 0)
+		return ret;
 
 	dev_set_drvdata(&pdev->dev, priv);
 
-- 
2.25.1

