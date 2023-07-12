Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7BCEB64DC
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jul 2023 03:01:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC912F75;
	Wed, 12 Jul 2023 05:00:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC912F75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689130869;
	bh=Vu+T9Vt/xiVSWZ4dm1ABkenYAfRvDzwc92fSuwmIzUE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=KyP3kYzyVL23AEYrCRl1yR8lxiyJfj/Vf2EAnIBrNiNMfb2sOCdEs6E+p3LcXXDDe
	 lWLx8WE2IBiuLD9ysX+OdIf0shO2kxDuhNIIs8NT5TAORQXaz4KlqSOa8KVzYgrVFP
	 dBPr9ZBal8zKVazFXqnEjd0zVjAZrZv2Ne7f8tng=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 66AB5F8053B; Wed, 12 Jul 2023 04:59:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AFA76F80249;
	Wed, 12 Jul 2023 04:59:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BC6A2F80249; Wed, 12 Jul 2023 04:59:46 +0200 (CEST)
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 05A48F80093
	for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2023 04:59:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05A48F80093
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM: 
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[183.194.159.125])
	by rmsmtp-lg-appmail-19-12022 (RichMail) with SMTP id 2ef664ae17086da-de900;
	Wed, 12 Jul 2023 10:59:22 +0800 (CST)
X-RM-TRANSID: 2ef664ae17086da-de900
From: Shenghao Ding <13916275206@139.com>
To: broonie@kernel.org,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	lgirdwood@gmail.com,
	perex@perex.cz,
	pierre-louis.bossart@linux.intel.com
Cc: kevin-lu@ti.com,
	shenghao-ding@ti.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com,
	mengdong.lin@intel.com,
	x1077012@ti.com,
	peeyush@ti.com,
	navada@ti.com,
	tiwai@suse.de,
	Shenghao Ding <13916275206@139.com>
Subject: [PATCH v1] ALSA: hda/tas2781: fix 'fw_entry' is used uninitialized
Date: Wed, 12 Jul 2023 10:44:08 +0800
Message-Id: <20230712024408.316793-1-13916275206@139.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: GCHFKYKSPQGWDP3IZMMGJNRH4C4ITVDZ
X-Message-ID-Hash: GCHFKYKSPQGWDP3IZMMGJNRH4C4ITVDZ
X-MailFrom: 13916275206@139.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GCHFKYKSPQGWDP3IZMMGJNRH4C4ITVDZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Fix 'fw_entry' is used uninitialized.

Signed-off-by: Shenghao Ding <13916275206@139.com>

Changes in v1:
 | Reported-by: kernel test robot <lkp@intel.com>
 | Closes: https://lore.kernel.org/oe-kbuild-all/202307070922.doxi1HFc-lkp@intel.com/
---
 sound/soc/codecs/tas2781-fmwlib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index eb55abae0d7b..0b08e24ed23a 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -1908,7 +1908,7 @@ int tas2781_load_calibration(void *context, char *file_name,
 {
 	struct tasdevice_priv *tas_priv = (struct tasdevice_priv *)context;
 	struct tasdevice *tasdev = &(tas_priv->tasdevice[i]);
-	const struct firmware *fw_entry;
+	const struct firmware *fw_entry = NULL;
 	struct tasdevice_fw *tas_fmw;
 	struct firmware fmw;
 	int offset = 0;
-- 
2.34.1


