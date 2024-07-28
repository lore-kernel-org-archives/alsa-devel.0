Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF52AC3DA49
	for <alsa-devel@archiver.kernel.org>; Sun, 28 Jul 2024 16:11:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A5A83E9A;
	Sun, 28 Jul 2024 18:11:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A5A83E9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722183070;
	bh=HPO7cGP7s8Ww89uL/cVx3o/ppVc1I+iEoYqDdS7ryLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=leYXJo3eIbEbNOUWkrcT+E2ZHFD+VbjSd7Nq/keHZip/+45XySFLlFw98Pg4cvC0L
	 IPov6IVmVAAXkbwrNkygAkfLcIsQGn92qIUNW4cZazf5e25BrMuNqtubbKV6JUvqQw
	 oHlvu08kO1PwW0nvxRXGhTdATnJH0tOTzij+JEk8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 71CD9F8069F; Sun, 28 Jul 2024 18:09:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 985CDF806AA;
	Sun, 28 Jul 2024 18:09:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AE0FBF802DB; Sun, 28 Jul 2024 18:08:47 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4F6F0F800C9
	for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2024 18:08:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F6F0F800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=kRRU90JA
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9C753611F1;
	Sun, 28 Jul 2024 16:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED63C32782;
	Sun, 28 Jul 2024 16:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182921;
	bh=HPO7cGP7s8Ww89uL/cVx3o/ppVc1I+iEoYqDdS7ryLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kRRU90JAnb7ilxQDsM6JjtFiI2IQgJJuyO4c/9a5BlPXwCvASvx/a4Qj6VRteKJRN
	 fTes81ZvsITOVr0et2zPaZ8VDz/z6iyngEmtMQu1PrIA/4+bmV2SZTXr5BTiJYC1tW
	 eCwY7e+6JrsUr6XtnFembeLTSKZvQtwSNEFptNnf2VSt5jxNQfZxIAU1h1AZnIyXYG
	 zE/1zeihk1HvKNDRY6qo+WBlEM/Yr3kvE9VQtnEB8b8/uO0ApgxaktFX3KJmxgoE7h
	 74A6z+zBIS0HDgGEWztb3TFeM5tbJJcFmOT7vuAzY1upcnI+PcueutoazWPA6EOIaq
	 Tr2Bz5t3z+ksQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	ckeepax@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 10/15] ASoC: Intel: sof_sdw: add quirk for Dell
 SKU 0B8C
Date: Sun, 28 Jul 2024 12:07:54 -0400
Message-ID: <20240728160813.2053107-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160813.2053107-1-sashal@kernel.org>
References: <20240728160813.2053107-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 55HAKQFN3RBOZUISBYENJP3BX47GQ4ZY
X-Message-ID-Hash: 55HAKQFN3RBOZUISBYENJP3BX47GQ4ZY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/55HAKQFN3RBOZUISBYENJP3BX47GQ4ZY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 92d5b5930e7d55ca07b483490d6298eee828bbe4 ]

Jack detection needs to rely on JD2, as most other Dell
AlderLake-based devices.

Closes: https://github.com/thesofproject/linux/issues/5021
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20240624121119.91552-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index cf501baf6f143..9cd85ab19c553 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -387,6 +387,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 					RT711_JD2 |
 					SOF_SDW_FOUR_SPK),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0B8C"),
+		},
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
+					RT711_JD2),
+	},
 	{
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
-- 
2.43.0

