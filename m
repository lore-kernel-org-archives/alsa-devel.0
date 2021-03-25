Return-Path: <SRS0=ofI3=IX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF38FC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 11:40:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0920561A0A
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 11:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0920561A0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 845EC1679;
	Thu, 25 Mar 2021 12:39:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 845EC1679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616672441;
	bh=H8VK9c4QfGqrxZeHrXB88VlBEU6W2MuiAA/+LW4Iomg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R5JVY/d/nhCeJaH421pklvBth7UE51f9wxPotLxf/mPl/uF59lPCD4sQEe1K+0CqG
	 L5arqF5UNO2OZLHvbltVm6dauG3igW9EDJbRKyzmFfhVZ58gSHG+/HLlvUoeBDkHMC
	 rRd1ZHGfS6j3wV/sOJsFbgqU/O530El6AcR0UQyk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4BCA4F805C4;
	Thu, 25 Mar 2021 12:27:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 310FFF805E5; Thu, 25 Mar 2021 12:27:52 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5603EF805C4
 for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2021 12:27:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5603EF805C4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jCFdTgmi"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 026C561A51;
 Thu, 25 Mar 2021 11:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616671652;
 bh=H8VK9c4QfGqrxZeHrXB88VlBEU6W2MuiAA/+LW4Iomg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jCFdTgmiDyPvcHhmrXpnVTFC3D/lYcyagH/2RfEZzelak7Pbqa+a6GMlUAEi0DHwd
 eFu5uoH3iwzRBpD1xzy4+7TAnxe5oBhWEtOcxyhRNL+jAnPzcModvY506pfx/ciPI/
 K40n+ymOzoZNoB6Rv9vWifwjKvebbrLkYA13kfVG8kX6AXAbAXLgwxoHp6wwzePh0r
 MR3ghTEHb1/cQoqHfXPS7XDIaXklSnh5cYVLy805fwVj2ekBugzGjiDXMLj/B7Ou/F
 Wsyg84jIo1SR08h3JSZFysr+RsSTfJR1jLmXcFRb8Wk8pWSvZzLoIv9r3V4P0E9XFc
 YM9cXnfiP0BpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 06/20] ASoC: es8316: Simplify adc_pga_gain_tlv
 table
Date: Thu, 25 Mar 2021 07:27:10 -0400
Message-Id: <20210325112724.1928174-6-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325112724.1928174-1-sashal@kernel.org>
References: <20210325112724.1928174-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit bb18c678754ce1514100fb4c0bf6113b5af36c48 ]

Most steps in this table are steps of 3dB (300 centi-dB), so we can
simplify the table.

This not only reduces the amount of space it takes inside the kernel,
this also makes alsa-lib's mixer code actually accept the table, where
as before this change alsa-lib saw the "ADC PGA Gain" control as a
control without a dB scale.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20210228160441.241110-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/es8316.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 9ebe77c3784a..57130edaf3ab 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -56,13 +56,8 @@ static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(adc_pga_gain_tlv,
 	1, 1, TLV_DB_SCALE_ITEM(0, 0, 0),
 	2, 2, TLV_DB_SCALE_ITEM(250, 0, 0),
 	3, 3, TLV_DB_SCALE_ITEM(450, 0, 0),
-	4, 4, TLV_DB_SCALE_ITEM(700, 0, 0),
-	5, 5, TLV_DB_SCALE_ITEM(1000, 0, 0),
-	6, 6, TLV_DB_SCALE_ITEM(1300, 0, 0),
-	7, 7, TLV_DB_SCALE_ITEM(1600, 0, 0),
-	8, 8, TLV_DB_SCALE_ITEM(1800, 0, 0),
-	9, 9, TLV_DB_SCALE_ITEM(2100, 0, 0),
-	10, 10, TLV_DB_SCALE_ITEM(2400, 0, 0),
+	4, 7, TLV_DB_SCALE_ITEM(700, 300, 0),
+	8, 10, TLV_DB_SCALE_ITEM(1800, 300, 0),
 );
 
 static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(hpout_vol_tlv,
-- 
2.30.1

