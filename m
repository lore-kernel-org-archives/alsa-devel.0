Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0608AC433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:29:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF922082F
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S+hl0CQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF922082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B6781697;
	Wed,  1 Jul 2020 20:28:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B6781697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593628183;
	bh=v1V/hPMjDZuqEnWjkEnwJ9xXcVKQY8I8Nv2dCWsl3UM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S+hl0CQA6NppfV6TFV3NuSBUbq8/zqsRZs9L0lS0qHuWcC/VHAN/Abfm2tJub1kdP
	 A1jMeTkJhAm5yg+HJ7zJRQKUzIa+N1iWZhtTrDM9yJSXgb/8f8DF2pjhG3LKp57BOS
	 P46ve2uTKASsubmm/lINCsEB06XBhE+uRKmRvK+4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C6D44F802E3;
	Wed,  1 Jul 2020 20:25:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 401F5F802EC; Wed,  1 Jul 2020 20:24:57 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3DB0F802E7
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 20:24:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3DB0F802E7
IronPort-SDR: RmeDgAZH1l37Wg3O8IIkCHZXXhF4MEN8qfqCgij8zeyf0gfApZpo/IVzhRKW60I6CPYf11nr+e
 9jfOb71TkHoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="144841760"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; d="scan'208";a="144841760"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 11:24:47 -0700
IronPort-SDR: RKhoIapeEXbHUDtol/rc9p30Z59tFwBT0r+5FvQu69Zw2DYoUnpT4wNrMtSCsE/3B1DlmZYyc3
 ao3TUJ3wRblQ==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; d="scan'208";a="425679612"
Received: from srnatla-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.76.199])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 11:24:47 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 07/11] ASoC: codecs: rt*: fix 'defined but not used' warning
Date: Wed,  1 Jul 2020 13:24:18 -0500
Message-Id: <20200701182422.81496-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
References: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>,
 tiwai@suse.de, open list <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org
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

Fix W=1 warning when ACPI is not defined

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt274.c      | 2 ++
 sound/soc/codecs/rt286.c      | 2 ++
 sound/soc/codecs/rt298.c      | 2 ++
 sound/soc/codecs/rt5660.c     | 2 ++
 sound/soc/codecs/rt5677-spi.c | 2 ++
 5 files changed, 10 insertions(+)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index cbb5e176d11a..40a28fb4fd09 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -1105,12 +1105,14 @@ static const struct i2c_device_id rt274_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt274_i2c_id);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id rt274_acpi_match[] = {
 	{ "10EC0274", 0 },
 	{ "INT34C2", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, rt274_acpi_match);
+#endif
 
 static int rt274_i2c_probe(struct i2c_client *i2c,
 			   const struct i2c_device_id *id)
diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 9593a9a27bf8..89b1c8b68004 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1079,11 +1079,13 @@ static const struct i2c_device_id rt286_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt286_i2c_id);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id rt286_acpi_match[] = {
 	{ "INT343A", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, rt286_acpi_match);
+#endif
 
 static const struct dmi_system_id force_combo_jack_table[] = {
 	{
diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 7fc7d6181630..dc0273a5a11f 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1145,11 +1145,13 @@ static const struct i2c_device_id rt298_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt298_i2c_id);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id rt298_acpi_match[] = {
 	{ "INT343A", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, rt298_acpi_match);
+#endif
 
 static const struct dmi_system_id force_combo_jack_table[] = {
 	{
diff --git a/sound/soc/codecs/rt5660.c b/sound/soc/codecs/rt5660.c
index 78371e51bc34..9e3813f7583d 100644
--- a/sound/soc/codecs/rt5660.c
+++ b/sound/soc/codecs/rt5660.c
@@ -1241,12 +1241,14 @@ static const struct of_device_id rt5660_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rt5660_of_match);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id rt5660_acpi_match[] = {
 	{ "10EC5660", 0 },
 	{ "10EC3277", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, rt5660_acpi_match);
+#endif
 
 static int rt5660_parse_dt(struct rt5660_priv *rt5660, struct device *dev)
 {
diff --git a/sound/soc/codecs/rt5677-spi.c b/sound/soc/codecs/rt5677-spi.c
index 7bfade8b3d6e..95ac12a5cc6b 100644
--- a/sound/soc/codecs/rt5677-spi.c
+++ b/sound/soc/codecs/rt5677-spi.c
@@ -614,11 +614,13 @@ static int rt5677_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id rt5677_spi_acpi_id[] = {
 	{ "RT5677AA", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, rt5677_spi_acpi_id);
+#endif
 
 static struct spi_driver rt5677_spi_driver = {
 	.driver = {
-- 
2.25.1

