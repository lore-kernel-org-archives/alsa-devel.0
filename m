Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE62C25B74
	for <alsa-devel@archiver.kernel.org>; Mon, 27 May 2024 15:52:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA5537F4;
	Mon, 27 May 2024 17:52:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA5537F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1716825158;
	bh=mX5Apq4HueNKh2Lka3LyHKzCw9/ATmUlhhIHaGKdgUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=r5eeUgza5Imq/qLwFYR4UTnYTWzznpovXTvA9w0ESdrmYTimA9ibm+7RPW8X8xD7n
	 Q522ELbc2MoI8oBix+xQsSphd+WvBvhcZmLfqmSi/3YqJICyOIhA+PYzvt/VJ9Whx2
	 PZ/6MPs659N0F7x5Kig3LDISo/Xlq6pC4N6p+dlk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A0EAF805AD; Mon, 27 May 2024 17:52:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BA8B9F80589;
	Mon, 27 May 2024 17:51:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E9D5F8026D; Mon, 27 May 2024 17:51:55 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 06F67F800BA
	for <alsa-devel@alsa-project.org>; Mon, 27 May 2024 17:51:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06F67F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Zuol8982
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A2A4761972;
	Mon, 27 May 2024 15:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8486C32781;
	Mon, 27 May 2024 15:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825106;
	bh=mX5Apq4HueNKh2Lka3LyHKzCw9/ATmUlhhIHaGKdgUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zuol8982ekg+5COYR6QoZYsZPIxTKDI4Ur9tyAd8PbKFNCBWGRPlNCUHb3kitTRZ/
	 YP7I00HNLq+k/ZurEW1Oo5y9q1z9Wfwr+IzBbUQYacRHAieSf//7ywj7GqOWgDzfcs
	 +i9Ms+glxo1efTnTz+/ABYfpIhdslXyrqVD1Xz9dCuceCAmBTb+oR5ZlexmCKINS3B
	 fuak5PBEEZw9T8aQUbYZbEDm9EggSgOWdRPpdW9KmO7k7VuuWL8+YANg63oNYHjrrF
	 Y1jeR7L9G0Lss5leF0yrXmZ2tW13Rqx0yerQ9Bbo+XlTm9Wf22pm5bxWYhCUbtwDuV
	 dsY49MdVMnAaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brent Lu <brent.lu@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	kuninori.morimoto.gx@renesas.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 03/23] ASoC: Intel: sof_cs42l42: rename BT offload
 quirk
Date: Mon, 27 May 2024 11:50:04 -0400
Message-ID: <20240527155123.3863983-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155123.3863983-1-sashal@kernel.org>
References: <20240527155123.3863983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QUWDGB4DW7FE5JUEYGAOZGBHLLRPRMNT
X-Message-ID-Hash: QUWDGB4DW7FE5JUEYGAOZGBHLLRPRMNT
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QUWDGB4DW7FE5JUEYGAOZGBHLLRPRMNT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Brent Lu <brent.lu@intel.com>

[ Upstream commit 109896246a5311aa05692ecf38c0d71e1837fe23 ]

Rename the quirk in preparation for future changes: common quriks will
be defined and handled in board helper module.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Brent Lu <brent.lu@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://msgid.link/r/20240325221059.206042-7-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_cs42l42.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/sof_cs42l42.c b/sound/soc/intel/boards/sof_cs42l42.c
index 323b86c42ef95..330d596b2eb6d 100644
--- a/sound/soc/intel/boards/sof_cs42l42.c
+++ b/sound/soc/intel/boards/sof_cs42l42.c
@@ -34,7 +34,7 @@
 #define SOF_CS42L42_NUM_HDMIDEV_MASK		(GENMASK(9, 7))
 #define SOF_CS42L42_NUM_HDMIDEV(quirk)	\
 	(((quirk) << SOF_CS42L42_NUM_HDMIDEV_SHIFT) & SOF_CS42L42_NUM_HDMIDEV_MASK)
-#define SOF_BT_OFFLOAD_PRESENT			BIT(25)
+#define SOF_CS42L42_BT_OFFLOAD_PRESENT		BIT(25)
 #define SOF_CS42L42_SSP_BT_SHIFT		26
 #define SOF_CS42L42_SSP_BT_MASK			(GENMASK(28, 26))
 #define SOF_CS42L42_SSP_BT(quirk)	\
@@ -268,7 +268,7 @@ static int sof_audio_probe(struct platform_device *pdev)
 
 	ctx->ssp_codec = sof_cs42l42_quirk & SOF_CS42L42_SSP_CODEC_MASK;
 
-	if (sof_cs42l42_quirk & SOF_BT_OFFLOAD_PRESENT)
+	if (sof_cs42l42_quirk & SOF_CS42L42_BT_OFFLOAD_PRESENT)
 		ctx->bt_offload_present = true;
 
 	/* update dai_link */
@@ -306,7 +306,7 @@ static const struct platform_device_id board_ids[] = {
 		.driver_data = (kernel_ulong_t)(SOF_CS42L42_SSP_CODEC(0) |
 				SOF_CS42L42_SSP_AMP(1) |
 				SOF_CS42L42_NUM_HDMIDEV(4) |
-				SOF_BT_OFFLOAD_PRESENT |
+				SOF_CS42L42_BT_OFFLOAD_PRESENT |
 				SOF_CS42L42_SSP_BT(2)),
 	},
 	{ }
-- 
2.43.0

