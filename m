Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E41C25B0F
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Aug 2022 16:22:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D71B4AE8;
	Sun, 14 Aug 2022 18:21:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D71B4AE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660494120;
	bh=mwmDbCfw/ao0izZKovfnIvnOORITV54RWHghuELPKFg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iGQcn4jEE2r70n0PtnRC5l7wDlXS9/Xn3eECJUhJqUj1JpiMvZih0fOHHUGowjsZg
	 W4DlzytU+g5LsxTt0tc3T6nfpnlSUDAYPoF0gxuRvCNkksR9fzPMH53a8w6xoiHAYG
	 /er9rWg5l31hKo2UvM4Fyjr2Wd1Jp1Ixg/+EZl3g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 258C5F80548;
	Sun, 14 Aug 2022 18:20:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 820A4F80549; Sun, 14 Aug 2022 18:20:26 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 337A3F804BD;
 Sun, 14 Aug 2022 18:20:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 337A3F804BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uuPsd0b3"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 62DA460F40;
 Sun, 14 Aug 2022 16:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108B2C433D6;
 Sun, 14 Aug 2022 16:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660494016;
 bh=mwmDbCfw/ao0izZKovfnIvnOORITV54RWHghuELPKFg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uuPsd0b3em2aKzU0hTYRB/aKuxMmCzHDS6md7hbvQhgKR1Ig5u2uo0wZ3txHVzRIT
 y4J4XQHx0u7sxAx5U9+0Shm4N0vc2Uw6G1RWXSrJsgv/yxboOtNVfiypyf5+Dq+tTK
 dNrBIBNC9UUBjXfbENY7DinSlVott7zIGbvCSxOvW1X1E32cHWpvz7a4MO/xWBoSkM
 dI/Jj3ZPmYC04v4yEZmEeZyddfar/nHWyHQm46maEtxaSHVDRZ5AaQXeoI86ZoqzTD
 t0LsVaGL5t+EbZeISnbDJLGkAF7wTLD7gJhDAW5AuWi+7rz41I0r8UgYUhiG7qvpjL
 x4ORL+KlSLGtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.19 12/48] ASoC: SOF: Intel: cnl: Do not process IPC
 reply before firmware boot
Date: Sun, 14 Aug 2022 12:19:05 -0400
Message-Id: <20220814161943.2394452-12-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220814161943.2394452-1-sashal@kernel.org>
References: <20220814161943.2394452-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, lgirdwood@gmail.com,
 yung-chuan.liao@linux.intel.com, tiwai@suse.com,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, daniel.baluta@nxp.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit acacd9eefd0def5a83244d88e5483b5f38ee7287 ]

It is not yet clear, but it is possible to create a firmware so broken
that it will send a reply message before a FW_READY message (it is not
yet clear if FW_READY will arrive later).
Since the reply_data is allocated only after the FW_READY message, this
will lead to a NULL pointer dereference if not filtered out.

The issue was reported with IPC4 firmware but the same condition is present
for IPC3.

Reported-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20220712122357.31282-2-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/cnl.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index cd6e5f8a5eb4..6c98f65635fc 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -60,17 +60,23 @@ irqreturn_t cnl_ipc4_irq_thread(int irq, void *context)
 
 		if (primary & SOF_IPC4_MSG_DIR_MASK) {
 			/* Reply received */
-			struct sof_ipc4_msg *data = sdev->ipc->msg.reply_data;
+			if (likely(sdev->fw_state == SOF_FW_BOOT_COMPLETE)) {
+				struct sof_ipc4_msg *data = sdev->ipc->msg.reply_data;
 
-			data->primary = primary;
-			data->extension = extension;
+				data->primary = primary;
+				data->extension = extension;
 
-			spin_lock_irq(&sdev->ipc_lock);
+				spin_lock_irq(&sdev->ipc_lock);
 
-			snd_sof_ipc_get_reply(sdev);
-			snd_sof_ipc_reply(sdev, data->primary);
+				snd_sof_ipc_get_reply(sdev);
+				snd_sof_ipc_reply(sdev, data->primary);
 
-			spin_unlock_irq(&sdev->ipc_lock);
+				spin_unlock_irq(&sdev->ipc_lock);
+			} else {
+				dev_dbg_ratelimited(sdev->dev,
+						    "IPC reply before FW_READY: %#x|%#x\n",
+						    primary, extension);
+			}
 		} else {
 			/* Notification received */
 			notification_data.primary = primary;
@@ -124,15 +130,20 @@ irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 					CNL_DSP_REG_HIPCCTL,
 					CNL_DSP_REG_HIPCCTL_DONE, 0);
 
-		spin_lock_irq(&sdev->ipc_lock);
+		if (likely(sdev->fw_state == SOF_FW_BOOT_COMPLETE)) {
+			spin_lock_irq(&sdev->ipc_lock);
 
-		/* handle immediate reply from DSP core */
-		hda_dsp_ipc_get_reply(sdev);
-		snd_sof_ipc_reply(sdev, msg);
+			/* handle immediate reply from DSP core */
+			hda_dsp_ipc_get_reply(sdev);
+			snd_sof_ipc_reply(sdev, msg);
 
-		cnl_ipc_dsp_done(sdev);
+			cnl_ipc_dsp_done(sdev);
 
-		spin_unlock_irq(&sdev->ipc_lock);
+			spin_unlock_irq(&sdev->ipc_lock);
+		} else {
+			dev_dbg_ratelimited(sdev->dev, "IPC reply before FW_READY: %#x\n",
+					    msg);
+		}
 
 		ipc_irq = true;
 	}
-- 
2.35.1

