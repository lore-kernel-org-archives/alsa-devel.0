Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E426DC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 18:25:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1545A64F5F
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 18:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1545A64F5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87A16175A;
	Fri, 12 Mar 2021 19:25:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87A16175A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615573554;
	bh=yXUSD6I0i/Hro6z4J6hKnGM12NmrrNUxORUv8a+KYFo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aE3iCJm5OHVBLSlqUv4x4Lr9woz/xFnLQq9nvoJO6rryhOdbZ/Tf5s2qWg/4ZfEkv
	 8C+9/IK2v7EQ03OJiTpbYemL282ZK+TE1EHNBGz06YcHYiWvJQ/S2SSqnp4Me5dBhy
	 fOMOxm2iG7ea8CmNZCjdjTqIHuB5wW7U5O9FOZ9Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00DEBF8049C;
	Fri, 12 Mar 2021 19:23:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9A3DF8049C; Fri, 12 Mar 2021 19:23:27 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2937DF801ED
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 19:23:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2937DF801ED
IronPort-SDR: zlGv7xUhJdwjbtkQzaR2i5VPhysR/YnYPhUj19GIr5AqaqEmleWSaq5ssmmqpww+yK7JfcH7ve
 qqjmORNGh3eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="185515169"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="185515169"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 10:23:11 -0800
IronPort-SDR: hRKnoHE/VowBFnczbtcE9mCoFpZg3OvRWwVpvZEDrZHjTrkzPJX3aue76/cawBAbdFRDqanEua
 37ijkhiH5m/w==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="377791911"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.37.30])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 10:23:10 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 04/23] ASoC: cros_ec_codec: remove null pointer dereference
 warning
Date: Fri, 12 Mar 2021 12:22:27 -0600
Message-Id: <20210312182246.5153-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Guenter Roeck <groeck@chromium.org>, broonie@kernel.org,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Benson Leung <bleung@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>
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

Cppcheck complains of a possible issue:

sound/soc/codecs/cros_ec_codec.c:98:10: warning: Possible null pointer
dereference: in [nullPointer]
  memcpy(in, msg->data, insize);
         ^
sound/soc/codecs/cros_ec_codec.c:162:34: note: Calling function
'send_ec_host_command', 5th argument 'NULL' value is 0
       (uint8_t *)&p, sizeof(p), NULL, 0);
                                 ^
sound/soc/codecs/cros_ec_codec.c:98:10: note: Null pointer dereference
  memcpy(in, msg->data, insize);
         ^

In practice the access to the pointer is protected by another
argument, but this is likely to fool other static analysis tools. Add
a test to avoid doing the memcpy if the pointer is NULL or the size is
zero.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/cros_ec_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index c4772f82485a..a201d652aca2 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -94,7 +94,7 @@ static int send_ec_host_command(struct cros_ec_device *ec_dev, uint32_t cmd,
 	if (ret < 0)
 		goto error;
 
-	if (insize)
+	if (in && insize)
 		memcpy(in, msg->data, insize);
 
 	ret = 0;
-- 
2.25.1

