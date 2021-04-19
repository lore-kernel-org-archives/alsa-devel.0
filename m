Return-Path: <SRS0=gP9u=JQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD538C433B4
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Apr 2021 01:25:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F271C610CB
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Apr 2021 01:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F271C610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E3271664;
	Mon, 19 Apr 2021 03:24:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E3271664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618795539;
	bh=crAOd1tuh4eHWMvSzm3ChPQS6WWLMsavZ5zgnYuoJqQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=l4rWxVM0xI07bLDJZyNxhlVJWQPAe/H4Q5GXe5o2UjLsFkYy3Et/UsYrfmpJ1NT0r
	 tLdcsMfvjrhVnmQ1VrGOk1NaY6zS0oktHstULrywgWZjXh040zurijPKzPdgz78zHx
	 b6fH4uV4xqoG2AbaXGmYSbU5LxRa6CxrP1LBKmiU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB343F8019B;
	Mon, 19 Apr 2021 03:24:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 24384F80227; Mon, 19 Apr 2021 03:24:44 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DCD36F800C5
 for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2021 03:24:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DCD36F800C5
IronPort-SDR: cE/h+zioaPOq3ONVS6hyroKsfpLTUzKV6kCkAeEtBNxK5X/umkhWT3uwtwkLcR8Ny9PgEWixtx
 jXdTQpyBQIIg==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="182747359"
X-IronPort-AV: E=Sophos;i="5.82,232,1613462400"; d="scan'208";a="182747359"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2021 18:24:28 -0700
IronPort-SDR: zB/Gagp5+vixnmVexCEddJptQ4LNqKi06Wb/CmF74jKQVkFJTk8r4f8SdmVaE3Y4rrQLBmKLEL
 sZ938XkLMQlw==
X-IronPort-AV: E=Sophos;i="5.82,232,1613462400"; d="scan'208";a="426320687"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2021 18:24:25 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH] soundwire: dmi-quirks: remove duplicate initialization
Date: Mon, 19 Apr 2021 09:24:17 +0800
Message-Id: <20210419012417.29366-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, sanyog.r.kale@intel.com, rander.wang@linux.intel.com,
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

cppcheck warning:

drivers/soundwire/dmi-quirks.c:85:12: style: Redundant initialization
for 'map'. The initialized value is overwritten before it is
read. [redundantInitialization]
  for (map = dmi_id->driver_data; map->adr; map++) {
           ^
drivers/soundwire/dmi-quirks.c:83:25: note: map is initialized
  struct adr_remap *map = dmi_id->driver_data;
                        ^
drivers/soundwire/dmi-quirks.c:85:12: note: map is overwritten
  for (map = dmi_id->driver_data; map->adr; map++) {
           ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/dmi-quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/dmi-quirks.c b/drivers/soundwire/dmi-quirks.c
index 82061c1d9835..5db0a2443a1d 100644
--- a/drivers/soundwire/dmi-quirks.c
+++ b/drivers/soundwire/dmi-quirks.c
@@ -80,7 +80,7 @@ u64 sdw_dmi_override_adr(struct sdw_bus *bus, u64 addr)
 	/* check if any address remap quirk applies */
 	dmi_id = dmi_first_match(adr_remap_quirk_table);
 	if (dmi_id) {
-		struct adr_remap *map = dmi_id->driver_data;
+		struct adr_remap *map;
 
 		for (map = dmi_id->driver_data; map->adr; map++) {
 			if (map->adr == addr) {
-- 
2.17.1

