Return-Path: <SRS0=L/cl=FI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD137C433FE
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Dec 2020 08:37:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8102722525
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Dec 2020 08:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8102722525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F2541856;
	Fri,  4 Dec 2020 09:36:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F2541856
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607071063;
	bh=hXuSJQXu5BVC0QrpobIrIIW0uPk2oAoJcTB8WLSGnUQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mXFekLEY0cziJcbP/ybLQfKzOr1y3JdOiLnGwNiyD3uD20IfBUrrqaZtitT8qrg+F
	 WmjJuOUMvPbU0g1CNM7VUeEfqUFNvfSJ9XxOVRzpGgFKy6L2QOx04+wuyVQv0HmOtS
	 Df9XpvMX5rFDXOh8NToEYmxhn6covX9mYX9WpAT8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1AD9F80273;
	Fri,  4 Dec 2020 09:36:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85283F80273; Fri,  4 Dec 2020 09:36:41 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B3B6F8012A
 for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2020 09:36:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B3B6F8012A
From: Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: Cheng-Yi Chiang <cychiang@chromium.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Benson Leung <bleung@chromium.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH] [v2] ASoC: cros_ec_codec: fix uninitialized memory read
Date: Fri,  4 Dec 2020 09:36:11 +0100
Message-Id: <20201204083624.2711356-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>,
 linux-kernel@vger.kernel.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Guenter Roeck <groeck@chromium.org>, Ard Biesheuvel <ardb@kernel.org>
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

Change the length of the command to only pass down the
part of the structure that has been initialized, as
Tzung-Bi Shih explains that only that member is meant to
be used.

Cc: Tzung-Bi Shih <tzungbi@google.com>
Fixes: 727f1c71c780 ("ASoC: cros_ec_codec: refactor I2S RX")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/cros_ec_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index 58894bf47514..6ec673573c70 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -348,7 +348,7 @@ static int i2s_rx_event(struct snd_soc_dapm_widget *w,
 	}
 
 	return send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
-				    (uint8_t *)&p, sizeof(p), NULL, 0);
+				    &p.cmd, sizeof(p.cmd), NULL, 0);
 }
 
 static struct snd_soc_dapm_widget i2s_rx_dapm_widgets[] = {
-- 
2.27.0

