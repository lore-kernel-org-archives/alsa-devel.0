Return-Path: <SRS0=JknX=K5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45893C47097
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 17:13:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C838961403
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 17:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C838961403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 662981721;
	Thu,  3 Jun 2021 19:12:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 662981721
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622740418;
	bh=NfkiMjpLjm1upoaebqhjlgKdC7Y0w5nULqzevbB7IeY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D1uUSW8te3LNE9xzGoB3MkkS1DhWkiSQwJPbPldmABYOPvXi8NaYXUGj4U3Yo3XHN
	 20K3X3/xe6hLpnYG3sAMgkjn5kgxOMCjS0NZ4fOvnji8CiuipYYvjrcpejg9bAmE5A
	 EiRgcq9Md3BPNOISQGnL6NiTkauhAVSnf3eJ7ShY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BF749F804C2;
	Thu,  3 Jun 2021 19:09:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3BE81F802E7; Thu,  3 Jun 2021 19:09:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50544F802E7
 for <alsa-devel@alsa-project.org>; Thu,  3 Jun 2021 19:09:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50544F802E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lDe3G1v4"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 927AB613F4;
 Thu,  3 Jun 2021 17:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622740161;
 bh=NfkiMjpLjm1upoaebqhjlgKdC7Y0w5nULqzevbB7IeY=;
 h=From:To:Cc:Subject:Date:From;
 b=lDe3G1v4G+mcX2w1mM7O3bVIzx5caRPMMysABww3Aa1z9VLttIuDvUH1iF8LUN/Az
 BjVSefOP1i9kxMJEWALBXkZfw95O/shZLgHJi/ozm80IdB3ssVYAfpTm9mIcuZthjF
 HfiRIf5kp55A/hzH8lkWGctquvp3vk4cBwi/G38UdsDutJwUzMcgA60g4DGDI+SfDU
 6y9bnZVHf2sSPpxo//xlJOeRH8QcDOevHL6P5q3vAf+k04Lu41eviqPhHwlqs1Mvg0
 29KfgOzzy16m1pxSYcLFjFpC8R+BBF+hUcipDexYB2m7mLJsxk1e5sQC8QWxABiWfm
 d5W7+SSQgUhBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 01/31] ASoC: max98088: fix ni clock divider
 calculation
Date: Thu,  3 Jun 2021 13:08:49 -0400
Message-Id: <20210603170919.3169112-1-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Marco Felsch <m.felsch@pengutronix.de>
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

From: Marco Felsch <m.felsch@pengutronix.de>

[ Upstream commit 6c9762a78c325107dc37d20ee21002b841679209 ]

The ni1/ni2 ratio formula [1] uses the pclk which is the prescaled mclk.
The max98088 datasheet [2] has no such formula but table-12 equals so
we can assume that it is the same for both devices.

While on it make use of DIV_ROUND_CLOSEST_ULL().

[1] https://datasheets.maximintegrated.com/en/ds/MAX98089.pdf; page 86
[2] https://datasheets.maximintegrated.com/en/ds/MAX98088.pdf; page 82

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Link: https://lore.kernel.org/r/20210423135402.32105-1-m.felsch@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/max98088.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index f031d2caa8b7..fa4cdbfd0b80 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -41,6 +41,7 @@ struct max98088_priv {
 	enum max98088_type devtype;
 	struct max98088_pdata *pdata;
 	struct clk *mclk;
+	unsigned char mclk_prescaler;
 	unsigned int sysclk;
 	struct max98088_cdata dai[2];
 	int eq_textcnt;
@@ -998,13 +999,16 @@ static int max98088_dai1_hw_params(struct snd_pcm_substream *substream,
        /* Configure NI when operating as master */
        if (snd_soc_component_read32(component, M98088_REG_14_DAI1_FORMAT)
                & M98088_DAI_MAS) {
+               unsigned long pclk;
+
                if (max98088->sysclk == 0) {
                        dev_err(component->dev, "Invalid system clock frequency\n");
                        return -EINVAL;
                }
                ni = 65536ULL * (rate < 50000 ? 96ULL : 48ULL)
                                * (unsigned long long int)rate;
-               do_div(ni, (unsigned long long int)max98088->sysclk);
+               pclk = DIV_ROUND_CLOSEST(max98088->sysclk, max98088->mclk_prescaler);
+               ni = DIV_ROUND_CLOSEST_ULL(ni, pclk);
                snd_soc_component_write(component, M98088_REG_12_DAI1_CLKCFG_HI,
                        (ni >> 8) & 0x7F);
                snd_soc_component_write(component, M98088_REG_13_DAI1_CLKCFG_LO,
@@ -1065,13 +1069,16 @@ static int max98088_dai2_hw_params(struct snd_pcm_substream *substream,
        /* Configure NI when operating as master */
        if (snd_soc_component_read32(component, M98088_REG_1C_DAI2_FORMAT)
                & M98088_DAI_MAS) {
+               unsigned long pclk;
+
                if (max98088->sysclk == 0) {
                        dev_err(component->dev, "Invalid system clock frequency\n");
                        return -EINVAL;
                }
                ni = 65536ULL * (rate < 50000 ? 96ULL : 48ULL)
                                * (unsigned long long int)rate;
-               do_div(ni, (unsigned long long int)max98088->sysclk);
+               pclk = DIV_ROUND_CLOSEST(max98088->sysclk, max98088->mclk_prescaler);
+               ni = DIV_ROUND_CLOSEST_ULL(ni, pclk);
                snd_soc_component_write(component, M98088_REG_1A_DAI2_CLKCFG_HI,
                        (ni >> 8) & 0x7F);
                snd_soc_component_write(component, M98088_REG_1B_DAI2_CLKCFG_LO,
@@ -1113,8 +1120,10 @@ static int max98088_dai_set_sysclk(struct snd_soc_dai *dai,
         */
        if ((freq >= 10000000) && (freq < 20000000)) {
                snd_soc_component_write(component, M98088_REG_10_SYS_CLK, 0x10);
+               max98088->mclk_prescaler = 1;
        } else if ((freq >= 20000000) && (freq < 30000000)) {
                snd_soc_component_write(component, M98088_REG_10_SYS_CLK, 0x20);
+               max98088->mclk_prescaler = 2;
        } else {
                dev_err(component->dev, "Invalid master clock frequency\n");
                return -EINVAL;
-- 
2.30.2

