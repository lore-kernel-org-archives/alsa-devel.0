Return-Path: <SRS0=RAD+=JT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7AEC433B4
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Apr 2021 13:03:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DF1561424
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Apr 2021 13:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF1561424
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E0F1D1661;
	Thu, 22 Apr 2021 15:02:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E0F1D1661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619096626;
	bh=cin9gJWpwT2vuoElSn2cCxbrF5yxaJWnYc0EpiIpWRI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JdSnZrFF+VgAGG3FCEByhtiA6HNs2H5kIQLrBgTer9XkuF9q93WhD0ZGAVz/+0svP
	 jTaBmwH9rHfRLWG5dsX9eOI4ql4uQ1Wskt+wzIs0L599Mf8qWdg597kzu5jmhUvePF
	 swEd0hc5LpcfriNZxAMIKiR2qnJEub4zUoPg34Cg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 45910F80168;
	Thu, 22 Apr 2021 15:02:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B65CCF80253; Thu, 22 Apr 2021 15:02:51 +0200 (CEST)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9066BF80059
 for <alsa-devel@alsa-project.org>; Thu, 22 Apr 2021 15:02:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9066BF80059
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com
 header.b="lxmk/osZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1619096564;
 x=1650632564;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yepxJq/a08r2JfRzSHmXMki2GuQi2NGqbDta5ykYrPE=;
 b=lxmk/osZ20Qdne6LNkFbn/aNukuy4+ywcLHlg7jC160W8Ir0JMdQurgR
 ti6OTXw8QVpoy+6vHf9X2/yWSKGmHdJMGvEGMj4424mLvTrnkOEK+Fb4z
 TnpA8AjtJ6Tj0qdZ+kgYMVe4AJ07FF40RzMyMv/CiixFOHKVqPYSXy20Q
 NKKPf6bUxuy2RYmU2AT2prmjRUAWYgBKTYtcC1mvJC9/Sea3avg6ooJ8k
 vypm/HFRCNANChjOL2fp/3DB5dFT1+7jfG7/FTXBmw/bSbL/pyRz/najz
 l6iyUohRMz5MtsLQXLD+GSV8aki0qDJ3M3Ynu/p/nCQcBzFnqc2TAYp4r g==;
From: Niklas Carlsson <Niklas.Carlsson@axis.com>
To: Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?q?Nuno=20S=C3=A1?=
 <nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>
Subject: [PATCH] ASoC: adau17x1: Avoid overwriting CHPF
Date: Thu, 22 Apr 2021 15:02:26 +0200
Message-ID: <20210422130226.15201-1-Niklas.Carlsson@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: Niklas Carlsson <niklasc@axis.com>, alsa-devel@alsa-project.org,
 kernel@axis.com, linux-kernel@vger.kernel.org
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

From: Niklas Carlsson <niklasc@axis.com>

Configuring number of channels per LRCLK frame by using e.g.
snd_soc_dai_set_tdm_slot before configuring DAI format was being
overwritten by the latter due to a regmap_write which would write over
the whole register.

Signed-off-by: Niklas Carlsson <niklasc@axis.com>
---
 sound/soc/codecs/adau17x1.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 546ee8178038..8aae7ab74091 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -553,6 +553,7 @@ static int adau17x1_set_dai_fmt(struct snd_soc_dai *dai,
 {
 	struct adau *adau = snd_soc_component_get_drvdata(dai->component);
 	unsigned int ctrl0, ctrl1;
+	unsigned int ctrl0_mask;
 	int lrclk_pol;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -612,8 +613,16 @@ static int adau17x1_set_dai_fmt(struct snd_soc_dai *dai,
 	if (lrclk_pol)
 		ctrl0 |= ADAU17X1_SERIAL_PORT0_LRCLK_POL;
 
-	regmap_write(adau->regmap, ADAU17X1_SERIAL_PORT0, ctrl0);
-	regmap_write(adau->regmap, ADAU17X1_SERIAL_PORT1, ctrl1);
+	/* Set the mask to update all relevant bits in ADAU17X1_SERIAL_PORT0 */
+	ctrl0_mask = ADAU17X1_SERIAL_PORT0_MASTER |
+		     ADAU17X1_SERIAL_PORT0_LRCLK_POL |
+		     ADAU17X1_SERIAL_PORT0_BCLK_POL |
+		     ADAU17X1_SERIAL_PORT0_PULSE_MODE;
+
+	regmap_update_bits(adau->regmap, ADAU17X1_SERIAL_PORT0, ctrl0_mask,
+			   ctrl0);
+	regmap_update_bits(adau->regmap, ADAU17X1_SERIAL_PORT1,
+			   ADAU17X1_SERIAL_PORT1_DELAY_MASK, ctrl1);
 
 	adau->dai_fmt = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 
-- 
2.20.1

