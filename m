Return-Path: <SRS0=vE6Q=M3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D295C4338F
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Aug 2021 19:27:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676D760BD3
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Aug 2021 19:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 676D760BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 672281691;
	Wed,  4 Aug 2021 21:26:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 672281691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628105224;
	bh=0b+LxiSwOJL+lbwy+HqvR0PdOsnD82BO0RoWCCPeKqA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PRBnjYt4h6p7oKxq6Sekmd5N4UECDiVu0zqf8z0ZKP1BJiATM7+gTFe2qDUL05od6
	 W2HMv0we58LGLOv5wuGzbJJlS6+hIhmBEtkgL70GzVgFxCSBBiow/cUDskg1lWtXYQ
	 /dkAWulGbOqSbBxouecAl2tFrqB4VzgMyGOBtutU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E992EF8010A;
	Wed,  4 Aug 2021 21:25:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 56122F802C4; Wed,  4 Aug 2021 21:25:26 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D6A0F8010A
 for <alsa-devel@alsa-project.org>; Wed,  4 Aug 2021 21:25:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D6A0F8010A
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="235952804"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; d="scan'208";a="235952804"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2021 12:25:10 -0700
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; d="scan'208";a="569142452"
Received: from ccho-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.189.253])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2021 12:25:10 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/3] ASoC: max98090: remove duplicate status reads and useless
 assignmment
Date: Wed,  4 Aug 2021 14:24:54 -0500
Message-Id: <20210804192456.278702-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804192456.278702-1-pierre-louis.bossart@linux.intel.com>
References: <20210804192456.278702-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

The logic for the jack detection has not changed since the first
commit for this driver. Remove a duplicate read and remove useless
assignment

sound/soc/codecs/max98090.c:2170:6: style: Variable 'reg' is
reassigned a value before the old one has been
used. [redundantAssignment]
 reg = snd_soc_component_read(component, M98090_REG_JACK_STATUS);
     ^

sound/soc/codecs/max98090.c:2161:7: note: reg is assigned
  reg = snd_soc_component_read(component, M98090_REG_JACK_STATUS);
      ^

sound/soc/codecs/max98090.c:2170:6: note: reg is overwritten
 reg = snd_soc_component_read(component, M98090_REG_JACK_STATUS);
     ^

sound/soc/codecs/max98090.c:2170:6: style: Variable 'reg' is
reassigned a value before the old one has been
used. [redundantAssignment]
 reg = snd_soc_component_read(component, M98090_REG_JACK_STATUS);
     ^

sound/soc/codecs/max98090.c:2167:7: note: reg is assigned
  reg = snd_soc_component_read(component, M98090_REG_JACK_STATUS);
      ^

sound/soc/codecs/max98090.c:2170:6: note: reg is overwritten
 reg = snd_soc_component_read(component, M98090_REG_JACK_STATUS);
     ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/max98090.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index bc30a1dc7530..b45ec35cd63c 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2158,13 +2158,11 @@ static void max98090_jack_work(struct work_struct *work)
 
 		msleep(50);
 
-		reg = snd_soc_component_read(component, M98090_REG_JACK_STATUS);
+		snd_soc_component_read(component, M98090_REG_JACK_STATUS);
 
 		/* Weak pull up allows only insertion detection */
 		snd_soc_component_update_bits(component, M98090_REG_JACK_DETECT,
 			M98090_JDWK_MASK, M98090_JDWK_MASK);
-	} else {
-		reg = snd_soc_component_read(component, M98090_REG_JACK_STATUS);
 	}
 
 	reg = snd_soc_component_read(component, M98090_REG_JACK_STATUS);
-- 
2.25.1

