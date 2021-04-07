Return-Path: <SRS0=4JIF=JE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046C9C433B4
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 07:35:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113C961245
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 07:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113C961245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C97A166F;
	Wed,  7 Apr 2021 09:34:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C97A166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617780908;
	bh=HB0JUqa6NvWONCnqAxk3Hw2vd5KDxuCzCqtbZJtQhm8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=M+Fhs7HJV4B6DhRcThqiZ/qM6O8PfDvtfupu6fA2hrcwbNhTDwhry+zMKraVixSPn
	 ZPHKs24HZ42eB8o4UYJWyi1oLCENZlUA4njSCzLkgRmIjkwtyUAy6Jnz964d6UeoyT
	 trde8zDPQTCszX0knJ83VMVU5IFZcSaPzTD3giDc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8744DF800BD;
	Wed,  7 Apr 2021 09:34:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AC6DEF8016A; Wed,  7 Apr 2021 09:34:15 +0200 (CEST)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A3FBF800BD
 for <alsa-devel@alsa-project.org>; Wed,  7 Apr 2021 09:34:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A3FBF800BD
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FFbgQ34kCz94FV;
 Wed,  7 Apr 2021 15:31:46 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 15:33:50 +0800
From: Ye Bin <yebin10@huawei.com>
To: <yebin10@huawei.com>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH -next] ASoC: codecs: lpass-va-macro: constify static struct
 snd_soc_dai_ops
Date: Wed, 7 Apr 2021 15:42:18 +0800
Message-ID: <20210407074218.3051979-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Cc: Hulk Robot <hulkci@huawei.com>, alsa-devel@alsa-project.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

The snd_soc_dai_ops structures is only stored in the ops field of a
snd_soc_dai_driver structure, so make the snd_soc_dai_ops structure
const to allow the compiler to put it in read-only memory.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 sound/soc/codecs/lpass-va-macro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index 3d6976a3d9e4..5294c57b2cd4 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -894,7 +894,7 @@ static int va_macro_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
 	return 0;
 }
 
-static struct snd_soc_dai_ops va_macro_dai_ops = {
+static const struct snd_soc_dai_ops va_macro_dai_ops = {
 	.hw_params = va_macro_hw_params,
 	.get_channel_map = va_macro_get_channel_map,
 	.mute_stream = va_macro_digital_mute,

