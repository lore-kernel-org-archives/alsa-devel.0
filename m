Return-Path: <SRS0=CIz3=4U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F50C3F2CD
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Mar 2020 11:06:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1087A2083E
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Mar 2020 11:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GkZmo+fw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1087A2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C6491662;
	Tue,  3 Mar 2020 12:05:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C6491662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583233577;
	bh=gC3Q8kx/jzj7i0FVNHlIeLOgiFhvUBVLwsqS3eBHg/Q=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GkZmo+fwGwdelpbUx1MQGTYGACyXpbx8BiGAu6oXALq7XbD79obDpQHzf4vvnjAdg
	 PQb85xO4uYbhQbMWU3rVUKGCg4g9rDj/hgIZgkvNrf99PnqWxjVqyif6rHSKaje0kY
	 HxwTHk4SzIrmPpobBurx9+Dbpr8ll8Yzau/lOgoE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DD9EEF80245;
	Tue,  3 Mar 2020 12:05:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B09D8F8025F; Tue,  3 Mar 2020 12:05:25 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03190F8012D
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2020 12:05:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03190F8012D
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: eballetbo) with ESMTPSA id 091D52919DF
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: AMD RV RT5682 should depends on CROS_EC
Date: Tue,  3 Mar 2020 12:05:14 +0100
Message-Id: <20200303110514.3267126-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, YueHaibing <yuehaibing@huawei.com>,
 Takashi Iwai <tiwai@suse.com>, Akshu Agrawal <akshu.agrawal@amd.com>,
 Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Collabora Kernel ML <kernel@collabora.com>
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

If SND_SOC_AMD_RV_RT5682_MACH=y, below kconfig and build errors can be seen:

 WARNING: unmet direct dependencies detected for SND_SOC_CROS_EC_CODEC
 WARNING: unmet direct dependencies detected for I2C_CROS_EC_TUNNEL

 ld: drivers/i2c/busses/i2c-cros-ec-tunnel.o: in function `ec_i2c_xfer':
 i2c-cros-ec-tunnel.c:(.text+0x2fc): undefined reference to `cros_ec_cmd_xfer_status'
 ld: sound/soc/codecs/cros_ec_codec.o: in function `wov_host_event':
 cros_ec_codec.c:(.text+0x4fb): undefined reference to `cros_ec_get_host_event'
 ld: sound/soc/codecs/cros_ec_codec.o: in function `send_ec_host_command':
 cros_ec_codec.c:(.text+0x831): undefined reference to `cros_ec_cmd_xfer_status'

This is because it will select SND_SOC_CROS_EC_CODEC and I2c_CROS_EC_TUNNEL but
both depends on CROS_EC.

Fixes: 6b8e4e7db3cd ("ASoC: amd: Add machine driver for Raven based platform")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 sound/soc/amd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index b29ef1373946..bce4cee5cb54 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -33,6 +33,6 @@ config SND_SOC_AMD_RV_RT5682_MACH
 	select SND_SOC_MAX98357A
 	select SND_SOC_CROS_EC_CODEC
 	select I2C_CROS_EC_TUNNEL
-	depends on SND_SOC_AMD_ACP3x && I2C
+	depends on SND_SOC_AMD_ACP3x && I2C && CROS_EC
 	help
 	 This option enables machine driver for RT5682 and MAX9835.
-- 
2.25.1

