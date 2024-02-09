Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C667C4828F
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Feb 2024 06:01:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 445A483B;
	Fri,  9 Feb 2024 07:01:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 445A483B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1707458471;
	bh=fI6cNqUhngSVtPXix0fMo3wRWmm06WucGdKiFh3SYuw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=mVwLvMYiTCvmNapWGBRyH9hk9EeAs0K7zPJBdEgJiZcv3GSEGNUodl+YGjtHkf8AQ
	 bMg5IfLgYGGC7WuaBWANJL+8A86uOt/xFAunYjkghjY8MN80Fe8hZk/K8SFZlRiLhx
	 47VNN0MEoX7A/4AsBGQy23NqMcv5ljdDqdfkJnNI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D355EF80567; Fri,  9 Feb 2024 07:00:49 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 49ABFF80571;
	Fri,  9 Feb 2024 07:00:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B31FF801EB; Fri,  9 Feb 2024 06:59:46 +0100 (CET)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id 0EBFFF8016E
	for <alsa-devel@alsa-project.org>; Fri,  9 Feb 2024 06:59:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0EBFFF8016E
Received: from fedori.lan (51b69e54.dsl.pool.telekom.hu
 [::ffff:81.182.158.84])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000071F9D.0000000065C5BF49.001B3A7F;
 Fri, 09 Feb 2024 06:59:37 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
  Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v4] ASoC: tas2781: remove unused acpi_subysystem_id
Date: Fri,  9 Feb 2024 06:59:34 +0100
Message-ID: 
 <454639336be28d2b50343e9c8366a56b0975e31d.1707456753.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
Message-ID-Hash: LQK2UL3M5WKCNBCVTEAL6PEQGU6TXKZ5
X-Message-ID-Hash: LQK2UL3M5WKCNBCVTEAL6PEQGU6TXKZ5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LQK2UL3M5WKCNBCVTEAL6PEQGU6TXKZ5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The acpi_subysystem_id is only written and freed, not read, so
unnecessary.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
Changes since v3:
- remove Fixes and CC tags from commit message
- remove In-Reply-To from header
- rebase onto for-next
- link to v3: https://lore.kernel.org/lkml/7f056a4148fec176812ff6cc490860bf565b161c.1707255917.git.soyer@irl.hu/
Changes since v2: remove sub from tas2781_read_acpi
Changes since v1: remove physdev from tas2781_read_acpi
---
 include/sound/tas2781.h           |  1 -
 sound/pci/hda/tas2781_hda_i2c.c   | 12 ------------
 sound/soc/codecs/tas2781-comlib.c |  1 -
 3 files changed, 14 deletions(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index 9aff384941de..99ca3e401fd1 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -103,7 +103,6 @@ struct tasdevice_priv {
 	struct tm tm;
 
 	enum device_catlog_id catlog_id;
-	const char *acpi_subsystem_id;
 	unsigned char cal_binaryname[TASDEVICE_MAX_CHANNELS][64];
 	unsigned char crc8_lkp_tbl[CRC8_TABLE_SIZE];
 	unsigned char coef_binaryname[64];
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 1bfb00102a77..4c9a788c3501 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -111,9 +111,7 @@ static int tas2781_get_i2c_res(struct acpi_resource *ares, void *data)
 static int tas2781_read_acpi(struct tasdevice_priv *p, const char *hid)
 {
 	struct acpi_device *adev;
-	struct device *physdev;
 	LIST_HEAD(resources);
-	const char *sub;
 	int ret;
 
 	adev = acpi_dev_get_first_match_dev(hid, NULL, -1);
@@ -129,18 +127,8 @@ static int tas2781_read_acpi(struct tasdevice_priv *p, const char *hid)
 
 	acpi_dev_free_resource_list(&resources);
 	strscpy(p->dev_name, hid, sizeof(p->dev_name));
-	physdev = get_device(acpi_get_first_physical_node(adev));
 	acpi_dev_put(adev);
 
-	/* No side-effect to the playback even if subsystem_id is NULL*/
-	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
-	if (IS_ERR(sub))
-		sub = NULL;
-
-	p->acpi_subsystem_id = sub;
-
-	put_device(physdev);
-
 	return 0;
 
 err:
diff --git a/sound/soc/codecs/tas2781-comlib.c b/sound/soc/codecs/tas2781-comlib.c
index 5d0e5348b361..3aa81514dad7 100644
--- a/sound/soc/codecs/tas2781-comlib.c
+++ b/sound/soc/codecs/tas2781-comlib.c
@@ -408,7 +408,6 @@ void tasdevice_remove(struct tasdevice_priv *tas_priv)
 {
 	if (gpio_is_valid(tas_priv->irq_info.irq_gpio))
 		gpio_free(tas_priv->irq_info.irq_gpio);
-	kfree(tas_priv->acpi_subsystem_id);
 	mutex_destroy(&tas_priv->codec_lock);
 }
 EXPORT_SYMBOL_GPL(tasdevice_remove);

base-commit: aa0dc84513e94a6ee2df360cf5e3b207abf734e0
-- 
2.43.0

