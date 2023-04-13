Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45972C7619A
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Apr 2023 02:42:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4090CF9C;
	Thu, 13 Apr 2023 04:41:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4090CF9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681353755;
	bh=9hBcseIcMFaVaM3/tJw5Vlsa6Zi+x20eVlBgfgJCC8c=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=AKSAvOGaJx7tXtkfLkBfo/iA04/RKaG4Uiqtd9sUIbJHfOkv6HY9ImbyjwFKS5vyc
	 hh+ktja+7ItoS6r6CB7UUNWy6oTV+jUYV7KrASHP+Gj+FasLl9KqPW/LF1G5KvjrQm
	 gkYv21EJ2X19XaKu8ocFmq2udgOI2eltl6tk8cOk=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8AE0AF804F2;
	Thu, 13 Apr 2023 04:38:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 186B8F80557; Thu, 13 Apr 2023 04:38:21 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 358AEF804F2
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2023 04:38:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 358AEF804F2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=MsN5EbO6
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2495963AB4;
	Thu, 13 Apr 2023 02:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA359C433EF;
	Thu, 13 Apr 2023 02:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681353496;
	bh=9hBcseIcMFaVaM3/tJw5Vlsa6Zi+x20eVlBgfgJCC8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MsN5EbO6ViyQ+OEFG1LeZM/xqkpkTvvxWXp6evPvNwJrOX83Br3ey+a4/kCW+t1Mw
	 kZS8kOW1S/gUyaC8Lr54J9I67pLZWWrx9JQMNemgptoW+IDX2uL7ko9ZXftmnc4h0d
	 KlNbHW9FYxlF7taOoRI+hjvJM+MBg/K9yIbbDMHOA1clboc6aEA/ndzH+RHYSWbHF4
	 kHStJ3G3QNF7vv3qkiB9LD2iAt9qZZQQsGdd4GPhCunMgTAo8G28pWvhDrRYHUqIt3
	 KRZxZOSWhp6sDUoo4olAsVT9hI/Hi8z+HKiO955lxj1SA21jTHSzXIjyB3GeUb7IXw
	 jmTpEJ6ZwAg1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/2] ASoC: Intel: bytcr_rt5640: Add quirk for the
 Acer Iconia One 7 B1-750
Date: Wed, 12 Apr 2023 22:38:07 -0400
Message-Id: <20230413023809.75099-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413023809.75099-1-sashal@kernel.org>
References: <20230413023809.75099-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Message-ID-Hash: INCADBM3F3EXHDYD7HSDBU6WTAGK7HRR
X-Message-ID-Hash: INCADBM3F3EXHDYD7HSDBU6WTAGK7HRR
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Hans de Goede <hdegoede@redhat.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Sasha Levin <sashal@kernel.org>,
 cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
 peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 tiwai@suse.com, oder_chiou@realtek.com, moisesmcardona@gmail.com,
 ckeepax@opensource.cirrus.com, akihiko.odaki@gmail.com,
 andriy.shevchenko@linux.intel.com, alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/INCADBM3F3EXHDYD7HSDBU6WTAGK7HRR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit e38c5e80c3d293a883c6f1d553f2146ec0bda35e ]

The Acer Iconia One 7 B1-750 tablet mostly works fine with the defaults
for an Bay Trail CR tablet. Except for the internal mic, instead of
an analog mic on IN3 a digital mic on DMIC1 is uses.

Add a quirk with these settings for this tablet.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230322145332.131525-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 2001bc774c643..d27dd170bedaf 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -400,6 +400,18 @@ static int byt_rt5640_aif1_hw_params(struct snd_pcm_substream *substream,
 
 /* Please keep this list alphabetically sorted */
 static const struct dmi_system_id byt_rt5640_quirk_table[] = {
+	{	/* Acer Iconia One 7 B1-750 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "VESPA2"),
+		},
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_JD_SRC_JD1_IN4P |
+					BYT_RT5640_OVCD_TH_1500UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{	/* Acer Iconia Tab 8 W1-810 */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Acer"),
-- 
2.39.2

