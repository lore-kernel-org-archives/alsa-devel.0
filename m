Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27E8C43334
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jun 2022 02:21:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 202C9190B;
	Tue, 14 Jun 2022 04:21:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 202C9190B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655173317;
	bh=c3ud9S4vhjy1BsuMLPZWl1hEAv4mc5Zqf23XgggN7A0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qk6kpu5MsvmJQTD9+hMZfxZYa7IVMTuSBp30ieMQOnwu0+/WKKYWwRWLnfZ3dVjtO
	 gVupahmWhttcChdcSTvEE8rbwSBdXuXsMNjRj9UbmtZdIxt8ky8i4HCV59e7Jadtda
	 PdnSV409BeRxMNjNa5j3DSAgnOO6TfTd2weD5QI8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC4B9F80528;
	Tue, 14 Jun 2022 04:10:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21886F805B6; Tue, 14 Jun 2022 04:10:08 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51926F805A9
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2022 04:09:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51926F805A9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="mENqxUgg"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C574360EED;
 Tue, 14 Jun 2022 02:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1E2C3411E;
 Tue, 14 Jun 2022 02:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655172596;
 bh=c3ud9S4vhjy1BsuMLPZWl1hEAv4mc5Zqf23XgggN7A0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mENqxUggdMY7kvtByQycsmNqSpJeoZpvRPfpxe/sNPSue4sdbClf4b5Erye+8N8Gg
 9Ih0JBoEX6Qz7LOQvE5gkUxC/j86h3uLCD0QFq6POqRRlu4Rma0AsTnzycHn+jmF30
 r7HowlGHVHHkj0kGeLmb+cOllFIMhM9YeanA/raL1huIyF/2PzoF1D9lm8fTQG/Tqc
 Qllj5svjRifBH65A7AWVIRQgE2qI+aui8TMywFAweKquZR4VIqrpP4wesU5gJE2UKA
 byRMlBdkSiHCKqxrhrMV6hyHxjv6jg3Hc7euFxv2oqWqX4KwnxoD2uYhxXX6csFHMM
 3kGDqagUWMQeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 02/18] ASoC: cs42l52: Fix TLV scales for mixer
 controls
Date: Mon, 13 Jun 2022 22:09:25 -0400
Message-Id: <20220614020941.1100702-2-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220614020941.1100702-1-sashal@kernel.org>
References: <20220614020941.1100702-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, brian.austin@cirrus.com,
 Charles Keepax <ckeepax@opensource.cirrus.com>, alsa-devel@alsa-project.org,
 tiwai@suse.com, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com,
 Mark Brown <broonie@kernel.org>
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

[ Upstream commit 8bf5aabf524eec61013e506f764a0b2652dc5665 ]

The datasheet specifies the range of the mixer volumes as between
-51.5dB and 12dB with a 0.5dB step. Update the TLVs for this.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20220602162119.3393857-2-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs42l52.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 3d83c1be1292..9a3180e71bd8 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -141,7 +141,7 @@ static DECLARE_TLV_DB_SCALE(mic_tlv, 1600, 100, 0);
 
 static DECLARE_TLV_DB_SCALE(pga_tlv, -600, 50, 0);
 
-static DECLARE_TLV_DB_SCALE(mix_tlv, -50, 50, 0);
+static DECLARE_TLV_DB_SCALE(mix_tlv, -5150, 50, 0);
 
 static DECLARE_TLV_DB_SCALE(beep_tlv, -56, 200, 0);
 
@@ -368,7 +368,7 @@ static const struct snd_kcontrol_new cs42l52_snd_controls[] = {
 			      CS42L52_ADCB_VOL, 0, 0xA0, 0x78, ipd_tlv),
 	SOC_DOUBLE_R_SX_TLV("ADC Mixer Volume",
 			     CS42L52_ADCA_MIXER_VOL, CS42L52_ADCB_MIXER_VOL,
-				0, 0x19, 0x7F, ipd_tlv),
+				0, 0x19, 0x7F, mix_tlv),
 
 	SOC_DOUBLE("ADC Switch", CS42L52_ADC_MISC_CTL, 0, 1, 1, 0),
 
-- 
2.35.1

