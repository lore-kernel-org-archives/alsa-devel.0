Return-Path: <SRS0=wrte=AK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B00EC433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:25:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86AD523D20
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QUFaBKud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86AD523D20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E74B847;
	Mon, 29 Jun 2020 14:24:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E74B847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593433547;
	bh=9KC2g38NTxh4qt0fgO9OP4OBEr4lisnr6pywxP7SzAk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QUFaBKud2LWJeHmtZU9snBHTH/6/m7vaNZHy+fLVcRURsFWtN2dA+rPMO5FSYGP8O
	 3quLApw9XHBExbCPMLRO7XaifgZWB/4Pd0cw2mhh9i0rKj7k0QRk9qJ7/Xq8iv/Ebn
	 6w6t4zg5KXNHKkkSQscMhRtG+1k2uoV0iUzQVA20=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2F26F8020C;
	Mon, 29 Jun 2020 14:24:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7225DF80217; Mon, 29 Jun 2020 14:24:55 +0200 (CEST)
Received: from albert.telenet-ops.be (albert.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:1a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6ADF7F800EA
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2020 14:24:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6ADF7F800EA
Received: from ramsan ([IPv6:2a02:1810:ac12:ed20:ddd:9277:6399:6268])
 by albert.telenet-ops.be with bizsmtp
 id x0Qk2200U1qNRsK060QkHJ; Mon, 29 Jun 2020 14:24:47 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jpsq4-0001zq-KF; Mon, 29 Jun 2020 14:24:44 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jpsq4-0005fU-Hy; Mon, 29 Jun 2020 14:24:44 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Patrick Lai <plai@codeaurora.org>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Vinod Koul <vkoul@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH] ASoC: qcom: Drop HAS_DMA dependency to fix link failure
Date: Mon, 29 Jun 2020 14:24:43 +0200
Message-Id: <20200629122443.21736-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-kernel@vger.kernel.org
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

When building on allyesconfig kernel for a NO_DMA=y platform (e.g.
Sun-3), CONFIG_SND_SOC_QCOM_COMMON=y, but CONFIG_SND_SOC_QDSP6_AFE=n,
leading to a link failure:

    sound/soc/qcom/common.o: In function `qcom_snd_parse_of':
    common.c:(.text+0x2e2): undefined reference to `q6afe_is_rx_port'

While SND_SOC_QDSP6 depends on HAS_DMA, SND_SOC_MSM8996 and SND_SOC_SDM845
don't, so the following warning is seen:

    WARNING: unmet direct dependencies detected for SND_SOC_QDSP6
      Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && QCOM_APR [=y] && HAS_DMA [=n]
      Selected by [y]:
      - SND_SOC_MSM8996 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && QCOM_APR [=y]
      - SND_SOC_SDM845 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && QCOM_APR [=y] && CROS_EC [=y] && I2C [=y] && SOUNDWIRE [=y]

Until recently, this warning was harmless (from a compile-testing
point-of-view), but the new user of q6afe_is_rx_port() turned this into
a hard failure.

As the QDSP6 driver itself builds fine if NO_DMA=y, and it depends on
QCOM_APR (which in turns depends on ARCH_QCOM || COMPILE_TEST), it is
safe to increase compile testing coverage.  Hence fix the link failure
by dropping the HAS_DMA dependency of SND_SOC_QDSP6.

Fixes: a2120089251f1fe2 ("ASoC: qcom: common: set correct directions for dailinks")
Fixes: 6b1687bf76ef84cb ("ASoC: qcom: add sdm845 sound card support")
Fixes: a6f933f63f2ffdb2 ("ASoC: qcom: apq8096: Add db820c machine driver")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 sound/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index f51b28d1b94d87b5..92f51d0e9fe2bf02 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -72,7 +72,7 @@ config SND_SOC_QDSP6_ASM_DAI
 
 config SND_SOC_QDSP6
 	tristate "SoC ALSA audio driver for QDSP6"
-	depends on QCOM_APR && HAS_DMA
+	depends on QCOM_APR
 	select SND_SOC_QDSP6_COMMON
 	select SND_SOC_QDSP6_CORE
 	select SND_SOC_QDSP6_AFE
-- 
2.17.1

