Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0F2C77B7A
	for <alsa-devel@archiver.kernel.org>; Wed, 31 May 2023 13:44:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47C9186F;
	Wed, 31 May 2023 15:43:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47C9186F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685540687;
	bh=WMsEmoBN7Jqx8OgNmYtXkh6lIUqdZCMyiuLG4MgDS5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nHJukE8KWC7FHYWdyyYZQpeYgwrpxKvKfr9vCp8YTID04QTaQAOxemPVAUAMmpXmV
	 l2xHi+ma3XRK5xy9pedxQ5RQEiU9Ua8604Lsp1t6Z5EbfdStLGLcB7kXMoDbI9ea08
	 EbySWtoFtkEGaRmb6ADwNX38x9jmV88OTUXbvMmA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 32F87F8057F; Wed, 31 May 2023 15:42:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A93ECF8055B;
	Wed, 31 May 2023 15:42:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 74870F805C0; Wed, 31 May 2023 15:42:43 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B1FABF8057F
	for <alsa-devel@alsa-project.org>; Wed, 31 May 2023 15:42:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1FABF8057F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AJORz37N
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7326A63B65;
	Wed, 31 May 2023 13:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925CFC4339B;
	Wed, 31 May 2023 13:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685540560;
	bh=WMsEmoBN7Jqx8OgNmYtXkh6lIUqdZCMyiuLG4MgDS5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AJORz37Nh92xc7++EWH9T5lpR3ezkzNmJ92yd6MIwGU6iiWOM7R4QFHUcMXzuydXU
	 Ei4abGA6Vo/qxPzjFv5sNzlgng2jPHJmbbNcgcWhPcvA7lu+FIzxMvmcXIooqdixPL
	 b2lj5kiMJKhs86pEO98CfzpamAEczynx3Lo3TfalBlV9Ebfz52FtKjbE0lOM5qjWT/
	 XzhRYyyeo4FAcfcBcC+0onOYakKm/t+SOmIqRBT/Be91jlfXZWdUIIeN3Y9BxIoaGe
	 CpFhEUYvajr8I1JSYuMJ7YuoXLY6IUDWO3n3iJ3MUSHqNsOAArDPmOAaxpEa6pY/zS
	 vpl1g8GcsIfSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ahplka19@gmail.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 20/33] ASoC: Intel: avs: Account for UID of ACPI
 device
Date: Wed, 31 May 2023 09:41:46 -0400
Message-Id: <20230531134159.3383703-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134159.3383703-1-sashal@kernel.org>
References: <20230531134159.3383703-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Message-ID-Hash: X7P7X5HH5GNKBNS3LKQX6CQVQOZPDTZI
X-Message-ID-Hash: X7P7X5HH5GNKBNS3LKQX6CQVQOZPDTZI
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X7P7X5HH5GNKBNS3LKQX6CQVQOZPDTZI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit 836855100b87b4dd7a82546131779dc255c18b67 ]

Configurations with multiple codecs attached to the platform are
supported but only if each from the set is different. Add new field
representing the 'Unique ID' so that codecs that share Vendor and Part
IDs can be differentiated and thus enabling support for such
configurations.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20230519201711.4073845-6-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc-acpi.h              | 1 +
 sound/soc/intel/avs/board_selection.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index b38fd25c57295..528279056b3ab 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -170,6 +170,7 @@ struct snd_soc_acpi_link_adr {
 /* Descriptor for SST ASoC machine driver */
 struct snd_soc_acpi_mach {
 	u8 id[ACPI_ID_LEN];
+	const char *uid;
 	const struct snd_soc_acpi_codecs *comp_ids;
 	const u32 link_mask;
 	const struct snd_soc_acpi_link_adr *links;
diff --git a/sound/soc/intel/avs/board_selection.c b/sound/soc/intel/avs/board_selection.c
index 87f9c18be238d..87353b4b0cd73 100644
--- a/sound/soc/intel/avs/board_selection.c
+++ b/sound/soc/intel/avs/board_selection.c
@@ -394,7 +394,7 @@ static int avs_register_i2s_boards(struct avs_dev *adev)
 	}
 
 	for (mach = boards->machs; mach->id[0]; mach++) {
-		if (!acpi_dev_present(mach->id, NULL, -1))
+		if (!acpi_dev_present(mach->id, mach->uid, -1))
 			continue;
 
 		if (mach->machine_quirk)
-- 
2.39.2

