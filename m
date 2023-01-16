Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3A9C54EBE
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Jan 2023 14:03:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF40756CF;
	Mon, 16 Jan 2023 15:02:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF40756CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673877783;
	bh=We4AOABTCrlp9F1jwtkkQL4Oz6PzYUIHv8bU4uce94M=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=i3jMW6zJKe572/pBr7+8zKmpxSOkXCeseGJVH1WtoK62HBe0lb7qGiJtBcJmhIq4j
	 VcJcd423hz9aRur7vKVK5cmkQbq4FFnxtMp5StUUy7p0oLYXK/Fl+7u2ztSOel7b4U
	 lDS2NxOsPogLubFFQU8VAlqsQAOt4eiBqURUW4d0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 744B8F8053A;
	Mon, 16 Jan 2023 15:02:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 12A03F804A9; Mon, 16 Jan 2023 15:02:11 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1201F8023B;
 Mon, 16 Jan 2023 15:02:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1201F8023B
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZhVbiC5V
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B182D60FC9;
 Mon, 16 Jan 2023 14:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B327EC433F1;
 Mon, 16 Jan 2023 14:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673877719;
 bh=We4AOABTCrlp9F1jwtkkQL4Oz6PzYUIHv8bU4uce94M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZhVbiC5VuxVgnFlze6h+c0CA4eB/roBtnO2JExucH0g9FyhDi4tMD6HAnbeIFnZVL
 3+MTmkX38kdnE64WVdGZJOsUrUEQAaeM8oMYurYtvLRMOmwADhh/OaQIC3LIdaHbY5
 g30dce1n/ieunFMXxs/sCKZLksvUM/bDsGaWdtj9BsJLFBxakZq0X9C/MYtL6hVNEA
 9ttUkpz2NJO5+Ja1xVBi+MYEIaLSXGMvk4RfubfhV02bZif9SFPSPBBtAMn+DG29mI
 m2triDAhKNDf+XWHJeovcALpRNxQ6vReELx7PToRSMKhRVTjgk7fcZwWdW35ftDMP9
 NG5WU9nBopA7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/53] ASoC: SOF: pm: Set target state earlier
Date: Mon, 16 Jan 2023 09:01:02 -0500
Message-Id: <20230116140154.114951-2-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230116140154.114951-1-sashal@kernel.org>
References: <20230116140154.114951-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, Bard Liao <yung-chuan.liao@linux.intel.com>,
 tiwai@suse.com, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 daniel.baluta@nxp.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Curtis Malainey <cujomalainey@chromium.org>,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 sound-open-firmware@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit 6f95eec6fb89e195dbdf30de65553c7fc57d9372 ]

If the DSP crashes before the system suspends, the setting of target state
will be skipped because the firmware state will no longer be
SOF_FW_BOOT_COMPLETE. This leads to the incorrect assumption that the
DSP should suspend to D0I3 instead of suspending to D3. To fix this,
set the target_state before we skip to DSP suspend even when the DSP has
crashed.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://lore.kernel.org/r/20221220125629.8469-2-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/pm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index df740be645e8..5f88c4a01fa3 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -182,7 +182,7 @@ static int sof_suspend(struct device *dev, bool runtime_suspend)
 	const struct sof_ipc_pm_ops *pm_ops = sdev->ipc->ops->pm;
 	const struct sof_ipc_tplg_ops *tplg_ops = sdev->ipc->ops->tplg;
 	pm_message_t pm_state;
-	u32 target_state = 0;
+	u32 target_state = snd_sof_dsp_power_target(sdev);
 	int ret;
 
 	/* do nothing if dsp suspend callback is not set */
@@ -206,7 +206,6 @@ static int sof_suspend(struct device *dev, bool runtime_suspend)
 		}
 	}
 
-	target_state = snd_sof_dsp_power_target(sdev);
 	pm_state.event = target_state;
 
 	/* Skip to platform-specific suspend if DSP is entering D0 */
-- 
2.35.1

