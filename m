Return-Path: <SRS0=Z4e1=IY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1EDC433C1
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 22:07:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47121619FF
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 22:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47121619FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD5FB1688;
	Fri, 26 Mar 2021 23:06:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD5FB1688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616796444;
	bh=QjxZT3sgsg5jVb7nYAejNo8AMJgIR0LKSI2s5j4Vxaw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i/TCxWC55YlQsD51h6ekyBygw9iyJ9h30WqAHcMNUPTiplGzmqQPFpKHTf1NKj7Nh
	 1GpRUqLaTuncASBLCbzSuYyMhZwZ0DHbfmGHzTL4ntY3G8dsC5Ky0chwn8zCMRr4V8
	 NF/vGPkrYLKEv8LFBAuHapJoQtdylC7YpiSTV3E0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C00EBF8051A;
	Fri, 26 Mar 2021 23:00:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B0D2F804BD; Fri, 26 Mar 2021 23:00:28 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E17C9F804B0
 for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2021 23:00:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E17C9F804B0
IronPort-SDR: 3jLA171rr1XFLFKjmeUphMgvZkY7F52MJbUrgnl2uH7sFXZTG0QQdGyspSi9iAn01TgS/ZrdQU
 WzRguxOckuBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="211396780"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="211396780"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 15:00:23 -0700
IronPort-SDR: TAEzOSPlq0akXNPZ3/hxP65If8aqxKNJaLEf/9qsa7edgVEr+XdS8yIVjvwp2y6e5VUN31X0Dy
 8SqYBhpssjtA==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="416706970"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.255.231.203])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 15:00:21 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 17/17] ASoC: ux500: mop500: align function prototype
Date: Fri, 26 Mar 2021 16:59:27 -0500
Message-Id: <20210326215927.936377-18-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, broonie@kernel.org
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

sound/soc/ux500/mop500_ab8500.c:360:60: style:inconclusive: Function
'mop500_ab8500_machine_init' argument 1 names different: declaration
'runtime' definition 'rtd'. [funcArgNamesDifferent]

int mop500_ab8500_machine_init(struct snd_soc_pcm_runtime *rtd)
                                                           ^
sound/soc/ux500/mop500_ab8500.h:16:60: note: Function
'mop500_ab8500_machine_init' argument 1 names different: declaration
'runtime' definition 'rtd'.
int mop500_ab8500_machine_init(struct snd_soc_pcm_runtime *runtime);
                                                           ^
sound/soc/ux500/mop500_ab8500.c:360:60: note: Function
'mop500_ab8500_machine_init' argument 1 names different: declaration
'runtime' definition 'rtd'.
int mop500_ab8500_machine_init(struct snd_soc_pcm_runtime *rtd)
                                                           ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/ux500/mop500_ab8500.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ux500/mop500_ab8500.h b/sound/soc/ux500/mop500_ab8500.h
index 99cfd972ea7a..8138a4e9aaf5 100644
--- a/sound/soc/ux500/mop500_ab8500.h
+++ b/sound/soc/ux500/mop500_ab8500.h
@@ -13,7 +13,7 @@
 
 extern struct snd_soc_ops mop500_ab8500_ops[];
 
-int mop500_ab8500_machine_init(struct snd_soc_pcm_runtime *runtime);
+int mop500_ab8500_machine_init(struct snd_soc_pcm_runtime *rtd);
 void mop500_ab8500_remove(struct snd_soc_card *card);
 
 #endif
-- 
2.25.1

