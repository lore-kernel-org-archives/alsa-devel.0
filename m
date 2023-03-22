Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C6AC6FD1F
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Mar 2023 20:01:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ACA9EEC7;
	Wed, 22 Mar 2023 21:00:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ACA9EEC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679515284;
	bh=FKBZKY8qQ6HXoFsT/mRrgOqXCpdTA4uhACvftMNXzMI=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=m5FVhfIRO0e8J7zDJlXVHoYR0OXrs9DoZCFXIZuiPlORzCwI3nDEw0dnz1utyic/k
	 niyuXSptNn4Cso5lbbZyDt6U9b5TsuUI5XEtiyW/Cb5w5DNzQin0o8DEOv0WwPawmH
	 u8njcr1k5Qd+QgVfADQBjDa2Gclo2b3nNMlnDunE=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F3674F805AC;
	Wed, 22 Mar 2023 20:58:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DE493F805A0; Wed, 22 Mar 2023 20:58:27 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D66BAF8057D;
	Wed, 22 Mar 2023 20:58:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D66BAF8057D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=mCLfT8B1
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id C0B70CE1D2D;
	Wed, 22 Mar 2023 19:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B8BC4339C;
	Wed, 22 Mar 2023 19:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679515097;
	bh=FKBZKY8qQ6HXoFsT/mRrgOqXCpdTA4uhACvftMNXzMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mCLfT8B199cKvacvZZeL+w0fSqovOPKSEl8wkFOXy7ebs6SK3D0ZA05Q+VpmPRewF
	 FziQabpTpGnqSuLq3mFP0uDIZmCquSfgxAV7uQrGqUXL9vyYLnGWwjCxB1hcGVVgX2
	 041/6/Dc9B+SK7oE5YF+NWdD5z1RtVIU/VQzN/hECgL3+oKtAZkWrEaDhqmzWI2PZ4
	 4oOXHh+KpTOcTdb0RdvYA5Hn6PXHqR16ItH3ttbJCgGTNhWzCWbUxahH5FE44XgkHn
	 Ga5LY1xKG8sJVVWncFz5Usn9QeGCPosKzcRCUAMEsDj+LhDuZuFtGOoGS9kpZ38GXl
	 1H72Qe+aLWA9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 18/45] ASoC: SOF: Intel: hda-ctrl: re-add sleep
 after entering and exiting reset
Date: Wed, 22 Mar 2023 15:56:12 -0400
Message-Id: <20230322195639.1995821-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322195639.1995821-1-sashal@kernel.org>
References: <20230322195639.1995821-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Message-ID-Hash: O6PFORBAY2OHVPOKXK24MD224JPQVLQK
X-Message-ID-Hash: O6PFORBAY2OHVPOKXK24MD224JPQVLQK
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, Mark Brown <broonie@kernel.org>,
 Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
 yung-chuan.liao@linux.intel.com, daniel.baluta@nxp.com, tiwai@suse.com,
 sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O6PFORBAY2OHVPOKXK24MD224JPQVLQK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 8bac40b8ed17ab1be9133e9620f65fae80262b7e ]

This reverts commit a09d82ce0a867 ("ASoC: SOF: Intel: hda-ctrl: remove
useless sleep")

It was a mistake to remove those delays, in light of comments in the
HDaudio spec captured in snd_hdac_bus_reset_link() that the codec
needs time for its initialization and PLL lock.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://lore.kernel.org/r/20230307095412.3416-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-ctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/intel/hda-ctrl.c b/sound/soc/sof/intel/hda-ctrl.c
index 3aea36c077c9d..f3bdeba284122 100644
--- a/sound/soc/sof/intel/hda-ctrl.c
+++ b/sound/soc/sof/intel/hda-ctrl.c
@@ -196,12 +196,15 @@ int hda_dsp_ctrl_init_chip(struct snd_sof_dev *sdev)
 		goto err;
 	}
 
+	usleep_range(500, 1000);
+
 	/* exit HDA controller reset */
 	ret = hda_dsp_ctrl_link_reset(sdev, false);
 	if (ret < 0) {
 		dev_err(sdev->dev, "error: failed to exit HDA controller reset\n");
 		goto err;
 	}
+	usleep_range(1000, 1200);
 
 	hda_codec_detect_mask(sdev);
 
-- 
2.39.2

