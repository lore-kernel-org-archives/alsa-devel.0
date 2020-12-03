Return-Path: <SRS0=z1YM=FH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF75DC433FE
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 22:56:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46822247F
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 22:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46822247F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 613DB1849;
	Thu,  3 Dec 2020 23:55:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 613DB1849
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607036166;
	bh=URV65CG+N2q0i+BQnHcEgOxT/lqRzKzs3xx0w5c7VkY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TSKOyL8vwOnpY6OKLYi7jxFclhTlAiqDpyar8D0iNHcjyz3ZhvexU5UX/ZHtDJUnr
	 FAhjfP9kCpfNWkBQTCMOpR+ML+uNkkWMN7U6jfqfFNcr1qBHwLRnn2aVIUsGN1UgD7
	 9sKUiuwRcwOP6pDZGgdvJAbdu3b0rQO+e4EpCmko=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E00C1F800E8;
	Thu,  3 Dec 2020 23:55:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7DCE0F8016D; Thu,  3 Dec 2020 23:55:14 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E40BF800E8
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2020 23:55:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E40BF800E8
From: Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: Cheng-Yi Chiang <cychiang@chromium.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Benson Leung <bleung@chromium.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH] ASoC: cros_ec_codec: fix uninitialized memory read
Date: Thu,  3 Dec 2020 23:54:41 +0100
Message-Id: <20201203225458.1477830-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guenter Roeck <groeck@chromium.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
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

From: Arnd Bergmann <arnd@arndb.de>

gcc points out a memory area that is copied to a device
but not initialized:

sound/soc/codecs/cros_ec_codec.c: In function 'i2s_rx_event':
arch/x86/include/asm/string_32.h:83:20: error: '*((void *)&p+4)' may be used uninitialized in this function [-Werror=maybe-uninitialized]
   83 |   *((int *)to + 1) = *((int *)from + 1);

Initialize all the unused fields to zero.

Fixes: 727f1c71c780 ("ASoC: cros_ec_codec: refactor I2S RX")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/cros_ec_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index 58894bf47514..f33a2a9654e7 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -332,7 +332,7 @@ static int i2s_rx_event(struct snd_soc_dapm_widget *w,
 		snd_soc_dapm_to_component(w->dapm);
 	struct cros_ec_codec_priv *priv =
 		snd_soc_component_get_drvdata(component);
-	struct ec_param_ec_codec_i2s_rx p;
+	struct ec_param_ec_codec_i2s_rx p = {};
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-- 
2.27.0

