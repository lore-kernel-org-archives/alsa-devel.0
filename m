Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7E1C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 06:03:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A35E6192B
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 06:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A35E6192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 267DF1779;
	Tue, 11 May 2021 08:02:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 267DF1779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620712984;
	bh=Q80bRCSsAajEE73iMLYB81XRi6bex5IH5i3JMmVwakg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pF3F4Iiui4P+je1uxjAcw8J613xR7LzzfdDse8UDycF0XrYjqfeZABIph7S3R2OcK
	 JNkpEfFXrkUMkI+j54hw2rUYsCmtRamgQJPNDhWBwwcGB4008ueA/Zw/bqgNE9UGgb
	 7ZB0zrFyTWDN14WEgSRJNIpQ6XjjqGsVv59QDptE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AEB34F80156;
	Tue, 11 May 2021 08:02:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A6BFAF80163; Tue, 11 May 2021 08:02:12 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7212F80129
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 08:01:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7212F80129
IronPort-SDR: HUDe5VTUdbgxz80Rc77q8kRdVibWwCQFeY4PoW6xXDXyG1oju81ICOfLJpciQHwqQFPYPth/kj
 v2FxxzCZM6Hw==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="263295114"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; d="scan'208";a="263295114"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 23:01:56 -0700
IronPort-SDR: nbPHKOeW38Qyu/1ovsiZtH57Ftv8SGgARty5t7lMCfGB35bhsP9Fcqzijsw0nVDs5mXwbCinrv
 ZwuopUyszJAw==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; d="scan'208";a="624540173"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 23:01:48 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH] soundwire/ASoC: add leading zeroes in peripheral device name
Date: Tue, 11 May 2021 14:01:37 +0800
Message-Id: <20210511060137.29856-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 jank@cadence.com, sanyog.r.kale@intel.com, rander.wang@linux.intel.com,
 bard.liao@intel.com
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

We recently added leading zeroes in dev_dbg() messages but forgot to
do the same for the peripheral device name. Adding leading zeroes
makes it easier to read manufacturer ID and part ID, e.g.:

sdw:0:025d:0700:00
sdw:0:025d:0711:00
sdw:1:025d:0700:00
sdw:1:025d:1308:00
sdw:2:025d:0700:00
sdw:2:025d:0701:00
sdw:3:025d:0700:00
sdw:3:025d:0715:00

The use of '01x' for link_id and unique_id is intentional to show the
value range in the code, it's understood it does not actually change
the format.

To avoid problems with git bisect, the same change needs to be applied
to the Intel SoundWire machine driver, otherwise the components can't
be found and the card registration fails.

Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/slave.c        | 4 ++--
 sound/soc/intel/boards/sof_sdw.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index ff01b96c6e56..cc1e0fab5905 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -39,12 +39,12 @@ int sdw_slave_add(struct sdw_bus *bus,
 
 	if (id->unique_id == SDW_IGNORED_UNIQUE_ID) {
 		/* name shall be sdw:link:mfg:part:class */
-		dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x",
+		dev_set_name(&slave->dev, "sdw:%01x:%04x:%04x:%02x",
 			     bus->link_id, id->mfg_id, id->part_id,
 			     id->class_id);
 	} else {
 		/* name shall be sdw:link:mfg:part:class:unique */
-		dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x:%x",
+		dev_set_name(&slave->dev, "sdw:%01x:%04x:%04x:%02x:%01x",
 			     bus->link_id, id->mfg_id, id->part_id,
 			     id->class_id, id->unique_id);
 	}
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index ecd3f90f4bbe..8df1e69235cc 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -581,13 +581,13 @@ static int create_codec_dai_name(struct device *dev,
 		comp_index = i + offset;
 		if (is_unique_device(link, sdw_version, mfg_id, part_id,
 				     class_id, i)) {
-			codec_str = "sdw:%x:%x:%x:%x";
+			codec_str = "sdw:%01x:%04x:%04x:%02x";
 			codec[comp_index].name =
 				devm_kasprintf(dev, GFP_KERNEL, codec_str,
 					       link_id, mfg_id, part_id,
 					       class_id);
 		} else {
-			codec_str = "sdw:%x:%x:%x:%x:%x";
+			codec_str = "sdw:%01x:%04x:%04x:%02x:%01x";
 			codec[comp_index].name =
 				devm_kasprintf(dev, GFP_KERNEL, codec_str,
 					       link_id, mfg_id, part_id,
-- 
2.17.1

