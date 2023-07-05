Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2D9EB64DA
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Jul 2023 14:40:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43C2E84D;
	Wed,  5 Jul 2023 16:40:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43C2E84D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688568055;
	bh=CMTp5PjcrdGB1YgiokfJfbw4f+gtghxZ4pFtHuNvMII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UWxcdus9lnDdr0gZz2WD5TJrzl4GWnQzKqjtO9B91wvlDTJXxPfMIdAWqIcFl5yxi
	 2pUEiTnNjD9AEGZQPxlFtQsokMe/WcKsH6a+l79mswnr/mHixKEP9ZdJ6nq0kiaCln
	 Lj0+ong9IfZIAzrk3DPlNbq4q157R4g1/VvFAuWQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 197AFF80578; Wed,  5 Jul 2023 16:39:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A5CBAF80568;
	Wed,  5 Jul 2023 16:39:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0E61AF80548; Wed,  5 Jul 2023 14:33:23 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8ACE9F800E4
	for <alsa-devel@alsa-project.org>; Wed,  5 Jul 2023 14:33:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8ACE9F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=L0Dgj5tm
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 200B061553;
	Wed,  5 Jul 2023 12:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AA8C433CA;
	Wed,  5 Jul 2023 12:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688560389;
	bh=CMTp5PjcrdGB1YgiokfJfbw4f+gtghxZ4pFtHuNvMII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L0Dgj5tmXqHoyyYmXI4/RmaTjUN4wyzU/xOCwCBvvGoE39qgLwvw+J1h106R3nsDs
	 Sef6fGSlgU22yQq+WQMbyo9fpKjJiBIMrTbYCxBXWou4lKdL5kFZ6b4IBLSP0/T2A3
	 uqoVQUKZd6PlWEPqZE+n6mw0SJbDbCbssW5sgI3z9/5jwEDHeQIto4znL7GBKASZgW
	 FAhE0hSZ0ngFp3V44O8SMuKy+rHr743Uz5Ci4GeaIhkMbTCXU3Nl/w0MvM7SRsFbST
	 KxcuBFBhR9Lfvz0mvlhZGOBNNNv6ojq8fZzldhjMt9Y1u1t89wnokWr25IGUghR+7M
	 21ZSaShu23tpg==
Received: from johan by xi.lan with local (Exim 4.96)
	(envelope-from <johan+linaro@kernel.org>)
	id 1qH1hK-000848-0Q;
	Wed, 05 Jul 2023 14:33:30 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Rander Wang <rander.wang@linux.intel.com>
Subject: [PATCH 1/8] soundwire: fix enumeration completion
Date: Wed,  5 Jul 2023 14:30:11 +0200
Message-Id: <20230705123018.30903-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230705123018.30903-1-johan+linaro@kernel.org>
References: <20230705123018.30903-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: johan+linaro@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: DJXTWZVQ5WC24CORVYW7Q45A46JJ72CO
X-Message-ID-Hash: DJXTWZVQ5WC24CORVYW7Q45A46JJ72CO
X-Mailman-Approved-At: Wed, 05 Jul 2023 14:39:06 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DJXTWZVQ5WC24CORVYW7Q45A46JJ72CO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The soundwire subsystem uses two completion structures that allow
drivers to wait for soundwire device to become enumerated on the bus and
initialised by their drivers, respectively.

The code implementing the signalling is currently broken as it does not
signal all current and future waiters and also uses the wrong
reinitialisation function, which can potentially lead to memory
corruption if there are still waiters on the queue.

Not signalling future waiters specifically breaks sound card probe
deferrals as codec drivers can not tell that the soundwire device is
already attached when being reprobed. Some codec runtime PM
implementations suffer from similar problems as waiting for enumeration
during resume can also timeout despite the device already having been
enumerated.

Fixes: fb9469e54fa7 ("soundwire: bus: fix race condition with enumeration_complete signaling")
Fixes: a90def068127 ("soundwire: bus: fix race condition with initialization_complete signaling")
Cc: stable@vger.kernel.org      # 5.7
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/soundwire/bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 1ea6a64f8c4a..66e5dba919fa 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -908,8 +908,8 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 			"initializing enumeration and init completion for Slave %d\n",
 			slave->dev_num);
 
-		init_completion(&slave->enumeration_complete);
-		init_completion(&slave->initialization_complete);
+		reinit_completion(&slave->enumeration_complete);
+		reinit_completion(&slave->initialization_complete);
 
 	} else if ((status == SDW_SLAVE_ATTACHED) &&
 		   (slave->status == SDW_SLAVE_UNATTACHED)) {
@@ -917,7 +917,7 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 			"signaling enumeration completion for Slave %d\n",
 			slave->dev_num);
 
-		complete(&slave->enumeration_complete);
+		complete_all(&slave->enumeration_complete);
 	}
 	slave->status = status;
 	mutex_unlock(&bus->bus_lock);
@@ -1941,7 +1941,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 				"signaling initialization completion for Slave %d\n",
 				slave->dev_num);
 
-			complete(&slave->initialization_complete);
+			complete_all(&slave->initialization_complete);
 
 			/*
 			 * If the manager became pm_runtime active, the peripherals will be
-- 
2.39.3

