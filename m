Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EA7C10F05
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Dec 2023 00:07:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4BE285D;
	Thu,  7 Dec 2023 01:07:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4BE285D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701907640;
	bh=tqGtK7yPaEKw34ATYvLFq32mArCUX/HrYIfdHhs7QmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VvNpWod7P1jW4ENbxsRM25o3nnO7L3Ru/VVoHNfGzfDC8UpDOsFUsLVZDbg3pOVWa
	 OFih8gOfah9NxApQVndVFZeoesEWjHM2ctM0F4teP/DwWaUFKSGeLHI7vNQKTBHK+T
	 m5uTv4XIET+Bs7Kj5X4LnuEcbJhMfyEmWE4nhJ6Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2357F806B5; Thu,  7 Dec 2023 01:05:10 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 91124F806B4;
	Thu,  7 Dec 2023 01:05:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 059F4F80589; Thu,  7 Dec 2023 01:04:56 +0100 (CET)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id EC8A8F8060F
	for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2023 01:04:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC8A8F8060F
Received: from fedori.lan (51b690cd.dsl.pool.telekom.hu
 [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000071708.0000000065710C17.0011910F;
 Thu, 07 Dec 2023 01:04:39 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
  Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
  Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 16/16] ALSA: hda/tas2781: configure the amp after firmware
 load
Date: Thu,  7 Dec 2023 01:04:32 +0100
Message-ID: 
 <06f8c1eddd0e91f08e35722ef7df240113c32e1f.1701906455.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701906455.git.soyer@irl.hu>
References: <cover.1701906455.git.soyer@irl.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
Message-ID-Hash: JU66YFSFAOIEAGSTJEXLURLU5OSTMPCC
X-Message-ID-Hash: JU66YFSFAOIEAGSTJEXLURLU5OSTMPCC
X-MailFrom: soyer@irl.hu
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JU66YFSFAOIEAGSTJEXLURLU5OSTMPCC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Make the amp available immediately after a module
load to avoid having to wait for a PCM hook action.
(eg. unloading & loading the module while listening
music)

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index f72e0beab1fb..07bdff87c962 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -659,6 +659,8 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	tasdevice_load_calibration(tas_priv);
 	tasdevice_apply_calibration(tas_priv);
 
+	tasdevice_tuning_switch(tas_hda->priv, 0);
+
 out:
 	mutex_unlock(&tas_hda->priv->codec_lock);
 	if (fmw)
-- 
2.43.0

