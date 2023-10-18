Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D81ACDB47E
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Oct 2023 14:15:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32209E7B;
	Wed, 18 Oct 2023 16:14:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32209E7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697638541;
	bh=1VXI8tYY5fQPj3Zc4Nf2RJAn9k/lpA8N7RoiCiQwoP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=sljBnTXgn8zkfbNZH0mX/OGDsAku2+pN2geT8IWU8l5LbsWPt19ioq/0+i7HruKiq
	 vKM5yqyZOdlcds4Ji8pMXM3/6jtRF4DomQdcVx+DAp2p40d06ysrv4XkpkTnMTf21h
	 e69JfX6aIsQ2qBS8U96nRFasgHESBZuLvcwIdJE8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 97892F805C9; Wed, 18 Oct 2023 16:13:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F142F8057F;
	Wed, 18 Oct 2023 16:13:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C3F55F80567; Wed, 18 Oct 2023 16:13:43 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 03778F8057F
	for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2023 16:13:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03778F8057F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=PIlbqaW8
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 02F0261808;
	Wed, 18 Oct 2023 14:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82812C4339A;
	Wed, 18 Oct 2023 14:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697638415;
	bh=1VXI8tYY5fQPj3Zc4Nf2RJAn9k/lpA8N7RoiCiQwoP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PIlbqaW81XdSf0rsUt3FY5r1L/ZKQByB5z+cN+m9Z72XPvG5OnctaaJFumy6vDBXQ
	 FYneIADrQL8ZawsK+WVwi6cTVWLr8kIUqmAI/R/QRCvhMfXwfLUAp7ZKgw8M/HuCO3
	 acTwKf1oXPd3piTTyteh7+CFm91HWUc7bJhRtpIRjHL6oilvD+iYTKyBm3GtTedF5Y
	 fqkOo8QTAtGxUtQ7js6L+c7sNgxKeJJJWXisKmD92pYXpFts5Bfdo0jhJLsIfAGTbC
	 enHAKRG6szE0Y+VjVh2QsTglO4we7c/6T28mdoSj+ohPcdvC0F1EL+g2/dhsKMKrmx
	 WRFQO+gYw9HvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Antoine Gennart <gennartan@disroot.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 05/19] ASoC: tlv320adc3xxx: BUG: Correct micbias
 setting
Date: Wed, 18 Oct 2023 10:13:07 -0400
Message-Id: <20231018141323.1334898-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141323.1334898-1-sashal@kernel.org>
References: <20231018141323.1334898-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.58
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LBB6XGKQVGQFMFYKVU7MYE5RVI7EATQA
X-Message-ID-Hash: LBB6XGKQVGQFMFYKVU7MYE5RVI7EATQA
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LBB6XGKQVGQFMFYKVU7MYE5RVI7EATQA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Antoine Gennart <gennartan@disroot.org>

[ Upstream commit e930bea4124b8a4a47ba4092d99da30099b9242d ]

The micbias setting for tlv320adc can also have the value '3' which
means that the micbias ouput pin is connected to the input pin AVDD.

Signed-off-by: Antoine Gennart <gennartan@disroot.org>
Link: https://lore.kernel.org/r/20230929130117.77661-1-gennartan@disroot.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tlv320adc3xxx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320adc3xxx.c b/sound/soc/codecs/tlv320adc3xxx.c
index 52bb557247244..6bd6da01aafac 100644
--- a/sound/soc/codecs/tlv320adc3xxx.c
+++ b/sound/soc/codecs/tlv320adc3xxx.c
@@ -293,7 +293,7 @@
 #define ADC3XXX_BYPASS_RPGA		0x80
 
 /* MICBIAS control bits */
-#define ADC3XXX_MICBIAS_MASK		0x2
+#define ADC3XXX_MICBIAS_MASK		0x3
 #define ADC3XXX_MICBIAS1_SHIFT		5
 #define ADC3XXX_MICBIAS2_SHIFT		3
 
@@ -1099,7 +1099,7 @@ static int adc3xxx_parse_dt_micbias(struct adc3xxx *adc3xxx,
 	unsigned int val;
 
 	if (!of_property_read_u32(np, propname, &val)) {
-		if (val >= ADC3XXX_MICBIAS_AVDD) {
+		if (val > ADC3XXX_MICBIAS_AVDD) {
 			dev_err(dev, "Invalid property value for '%s'\n", propname);
 			return -EINVAL;
 		}
-- 
2.40.1

