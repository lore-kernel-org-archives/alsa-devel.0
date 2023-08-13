Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45694C001DB
	for <alsa-devel@archiver.kernel.org>; Sun, 13 Aug 2023 16:09:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66F4B741;
	Sun, 13 Aug 2023 18:08:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66F4B741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691942982;
	bh=4DIM1dy7Cu9/lI8k+bWtJxlM6Fz6R6M5wSlsKGSlN+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VOHl82SOh46tNBU1asJs2Iox/PrRUYHMuiMrkZ6B6aFnRP0dGoN28E/v5u/SPM4SP
	 i5CjzoMgDeNgWpCLrg+0SzrfWVnGlrLgpJ4gYQgWeZ+mddbMySnbZGB69N0ezEPajc
	 AyooG4aWMuw8CcAttENh974PdSN6atMfRAgTMDdk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2FA80F80570; Sun, 13 Aug 2023 18:08:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8CC05F80570;
	Sun, 13 Aug 2023 18:08:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D909F8057B; Sun, 13 Aug 2023 18:08:15 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8A7D6F80570
	for <alsa-devel@alsa-project.org>; Sun, 13 Aug 2023 18:08:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A7D6F80570
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=O456e0us
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 275E2638E7;
	Sun, 13 Aug 2023 16:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76941C433C7;
	Sun, 13 Aug 2023 16:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691942890;
	bh=4DIM1dy7Cu9/lI8k+bWtJxlM6Fz6R6M5wSlsKGSlN+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O456e0usVeZaPqS7RW5x9n74Dc3fAHFryixPerHW7wXWpc95bjn4De0t04ArFLOey
	 yf5wRRhvwRbmsqLxBy1nfxS7H4VzeMwQ8Hd0ylBVScxu8Dt5KdY1nE44uM9fuZZ0VK
	 qfQ0C95HgG7j5H2TyVq3xJ+iqw62QQ7swt/8TM6jgS1pcy1GOAHx4drgnxMpnKYUpu
	 MndPogTtC9hBlmNORgEw8rU0Eb+Q17LjINAg6m8iC557o0RHKNVjijtPz8zBXQhfzR
	 ePnf1d+fJTzE8+yUBi5o+yo5fPuOv6mWtAu7BCOfMB3sS87aNLSKTfdokvB6Z5tsFk
	 5w3PJ69oUxqyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shuming Fan <shumingf@realtek.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.15 19/31] ASoC: rt711-sdca: fix for JD event
 handling in ClockStop Mode0
Date: Sun, 13 Aug 2023 12:05:52 -0400
Message-Id: <20230813160605.1080385-19-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160605.1080385-1-sashal@kernel.org>
References: <20230813160605.1080385-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.126
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NSR3BY7UXCFNBIZUSHM5AFH4JZMFBPTV
X-Message-ID-Hash: NSR3BY7UXCFNBIZUSHM5AFH4JZMFBPTV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NSR3BY7UXCFNBIZUSHM5AFH4JZMFBPTV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Shuming Fan <shumingf@realtek.com>

[ Upstream commit 23adeb7056acd4fd866969f4afb91441776cc4f5 ]

When the system suspends, peripheral SDCA interrupts are disabled.
When system level resume is invoked, the peripheral SDCA interrupts
should be enabled to handle JD events.
Enable SDCA interrupts in resume sequence when ClockStop Mode0 is applied.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Reported-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://lore.kernel.org/r/20230721090711.128247-1-shumingf@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt711-sdca-sdw.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt711-sdca-sdw.c b/sound/soc/codecs/rt711-sdca-sdw.c
index 31e77d462ef34..4faf6b8544ddd 100644
--- a/sound/soc/codecs/rt711-sdca-sdw.c
+++ b/sound/soc/codecs/rt711-sdca-sdw.c
@@ -442,8 +442,16 @@ static int __maybe_unused rt711_sdca_dev_resume(struct device *dev)
 	if (!rt711->first_hw_init)
 		return 0;
 
-	if (!slave->unattach_request)
+	if (!slave->unattach_request) {
+		if (rt711->disable_irq == true) {
+			mutex_lock(&rt711->disable_irq_lock);
+			sdw_write_no_pm(slave, SDW_SCP_SDCA_INTMASK1, SDW_SCP_SDCA_INTMASK_SDCA_0);
+			sdw_write_no_pm(slave, SDW_SCP_SDCA_INTMASK2, SDW_SCP_SDCA_INTMASK_SDCA_8);
+			rt711->disable_irq = false;
+			mutex_unlock(&rt711->disable_irq_lock);
+		}
 		goto regmap_sync;
+	}
 
 	time = wait_for_completion_timeout(&slave->initialization_complete,
 				msecs_to_jiffies(RT711_PROBE_TIMEOUT));
-- 
2.40.1

