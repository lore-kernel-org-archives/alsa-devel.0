Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC34C433E3
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:26:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3CA8207F5
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uy3VpIko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CA8207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3CC251686;
	Wed,  1 Jul 2020 20:25:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3CC251686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593627981;
	bh=YioSQtzrEbR23s+WIUMX9a9l7dKRTxoWp8bnW0Cx8Bs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uy3VpIkoGIKumfQViCDzIbN50Ram3yPvWcsSNAuhwdxbA2rGjHcgkHXC5GQWGRy6D
	 yv4EHUaDc9FVi4oIGfuXhYQ/IkQgwKVGvbHTgCn2yf1FS7Zt7clilHB/dEALXXZD8k
	 o0LVFg8Fq1ZksfdxkfEDUcUc8D6HgUGbSuSnunzg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74538F8021D;
	Wed,  1 Jul 2020 20:24:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7DE9F802A9; Wed,  1 Jul 2020 20:24:41 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 419D9F800C1
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 20:24:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 419D9F800C1
IronPort-SDR: aNX42aKopuEk0rUSp3igsBvna8G0tLyzwWXP10tT+hO4nYlgIe1VOKXAXu7g1MJ6SO6cLhA8iU
 B6rzqncWxUQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="208189491"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; d="scan'208";a="208189491"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 11:24:32 -0700
IronPort-SDR: NIIw/zf3C8OyfzjlujKT+eGzVitbSQdmGzUb5SHtDo5hNNeSBqUlKHH8ZNtmcsHEY66LToFgI9
 e3+HJun+yxEA==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; d="scan'208";a="425679553"
Received: from srnatla-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.76.199])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 11:24:31 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 02/11] ASoC: codecs: cros_ec_codec: fix 'defined but not used'
 warning
Date: Wed,  1 Jul 2020 13:24:13 -0500
Message-Id: <20200701182422.81496-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
References: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, open list <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Guenter Roeck <groeck@chromium.org>,
 broonie@kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Benson Leung <bleung@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>
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

fix W=1 warning

sound/soc/codecs/cros_ec_codec.c:1056:36: warning:
'cros_ec_codec_acpi_id' defined but not used
[-Wunused-const-variable=]
 1056 | static const struct acpi_device_id cros_ec_codec_acpi_id[] = {
      |                                    ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/cros_ec_codec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index 8d45c628e988..f23956cf4ed8 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -1053,11 +1053,13 @@ static const struct of_device_id cros_ec_codec_of_match[] = {
 MODULE_DEVICE_TABLE(of, cros_ec_codec_of_match);
 #endif
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id cros_ec_codec_acpi_id[] = {
 	{ "GOOG0013", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, cros_ec_codec_acpi_id);
+#endif
 
 static struct platform_driver cros_ec_codec_platform_driver = {
 	.driver = {
-- 
2.25.1

