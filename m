Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADA8C352A1
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Dec 2022 09:53:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72FCB18AE;
	Tue,  6 Dec 2022 10:52:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72FCB18AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670320406;
	bh=d/a33XgM9HzAP8+lMgtDkj14R0RyBozaL/xSZ9eD4UY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nsaG7Sce4IN8z+27HEJIAWH34RqFOI1juUIk1Yci1Ydq7s31segt5iWN9j/GZrY+k
	 1Lgq0cDEbEghF8NCVQaytfo/OMWe/cBBUH3XU75VvL6opdeEORpDlawIAJ9M/jE6j7
	 Q4c99Wn9w+bKBvCG31hfvnyeDcoRyBJ5P/7tmtsw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B7CA4F804F2;
	Tue,  6 Dec 2022 10:51:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA243F805AC; Tue,  6 Dec 2022 10:51:00 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ACFFFF804B0
 for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2022 10:50:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ACFFFF804B0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FzKPBybe"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2D4ADB818E8;
 Tue,  6 Dec 2022 09:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF26DC433D6;
 Tue,  6 Dec 2022 09:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670320252;
 bh=d/a33XgM9HzAP8+lMgtDkj14R0RyBozaL/xSZ9eD4UY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FzKPBybeKlNWxsc2ilDpei5R2bbkLnIlRzllHRxR41fzL6T8X4DWhv1kVBn8h8mYv
 pI7GqSnfal49IL9eLwY9bptnCq46tK3gINNdTX414TLhkh2MMV0CJ0Ot8XF1LsTV88
 a3ZRiKPgjFxmDUD4KKbOpBMJynB+ggZnFum5k1WU+3rCcLX6QgruV2Rywo9eqVOjMJ
 06EAQ0seIap5i5ud2pUobuJ66iRvks6IIp8KJhijjxNjnD9v//JyLzhYux9guUI4SN
 4vWmjMXUOpyr3z50uKUXfink6MivFqZimQwJMltfw9jAdeSAW6oq0Bk/MkPF3U/T55
 RDJFZgHA0HHuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 09/10] ASoC: cs42l51: Correct PGA Volume minimum
 value
Date: Tue,  6 Dec 2022 04:50:26 -0500
Message-Id: <20221206095027.987587-9-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221206095027.987587-1-sashal@kernel.org>
References: <20221206095027.987587-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>, tanureal@opensource.cirrus.com,
 patches@opensource.cirrus.com, tiwai@suse.com, lgirdwood@gmail.com,
 david.rhodes@cirrus.com, rf@opensource.cirrus.com,
 Mark Brown <broonie@kernel.org>, james.schulman@cirrus.com
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

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 3d1bb6cc1a654c8693a85b1d262e610196edec8b ]

The table in the datasheet actually shows the volume values in the wrong
order, with the two -3dB values being reversed. This appears to have
caused the lower of the two values to be used in the driver when the
higher should have been, correct this mixup.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20221125162348.1288005-2-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs42l51.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index fc6a2bc311b4..c61b17dc2af8 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -146,7 +146,7 @@ static const struct snd_kcontrol_new cs42l51_snd_controls[] = {
 			0, 0xA0, 96, adc_att_tlv),
 	SOC_DOUBLE_R_SX_TLV("PGA Volume",
 			CS42L51_ALC_PGA_CTL, CS42L51_ALC_PGB_CTL,
-			0, 0x19, 30, pga_tlv),
+			0, 0x1A, 30, pga_tlv),
 	SOC_SINGLE("Playback Deemphasis Switch", CS42L51_DAC_CTL, 3, 1, 0),
 	SOC_SINGLE("Auto-Mute Switch", CS42L51_DAC_CTL, 2, 1, 0),
 	SOC_SINGLE("Soft Ramp Switch", CS42L51_DAC_CTL, 1, 1, 0),
-- 
2.35.1

