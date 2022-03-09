Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7B2C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Mar 2022 00:50:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 92864182B;
	Wed,  9 Mar 2022 01:49:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 92864182B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646787042;
	bh=ZT2LUkJUtvgsBIT0GvBm/g/EKkCI0w02aZbi9rpYEl8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gO8gjvYcMaLRob2Ybsx6o3VUUQbsL73qqozxVxfle3mR0xnD75WVzFxy2YA8D/klL
	 zO/LI9J9P7wHAZJwalfiHm49ITseoPOhZEau1QX1qjj9g4OVmVDhIIYxU5XkdXEP7Z
	 HaEsEIFmWnnmWrkZpNdAB8Or9w9u6szkbtgCgmho=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C21FF8025E;
	Wed,  9 Mar 2022 01:49:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA874F8026A; Wed,  9 Mar 2022 01:49:50 +0100 (CET)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88028F800D2;
 Wed,  9 Mar 2022 01:49:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 88028F800D2
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R601e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0V6gIl0e_1646786970; 
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0V6gIl0e_1646786970) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Mar 2022 08:49:35 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: pierre-louis.bossart@linux.intel.com
Subject: [PATCH 2/2] ASoC: SOF: amd: Remove unneeded semicolon
Date: Wed,  9 Mar 2022 08:49:28 +0800
Message-Id: <20220309004929.125558-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com,
 Abaci Robot <abaci@linux.alibaba.com>, lgirdwood@gmail.com, broonie@kernel.org,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
 sound-open-firmware@alsa-project.org
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

Fix the following coccicheck warnings:

./sound/soc/sof/amd/acp-ipc.c:74:2-3: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/sof/amd/acp-ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp-ipc.c b/sound/soc/sof/amd/acp-ipc.c
index 9fcd2535fd3b..e1842f037083 100644
--- a/sound/soc/sof/amd/acp-ipc.c
+++ b/sound/soc/sof/amd/acp-ipc.c
@@ -71,7 +71,7 @@ int acp_sof_ipc_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
 			dev_err(sdev->dev, "%s: Failed to acquire HW lock\n", __func__);
 			return -EINVAL;
 		}
-	};
+	}
 
 	acp_mailbox_write(sdev, offset, msg->msg_data, msg->msg_size);
 	acp_ipc_host_msg_set(sdev);
-- 
2.20.1.7.g153144c

