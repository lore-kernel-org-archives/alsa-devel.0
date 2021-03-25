Return-Path: <SRS0=ofI3=IX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE52C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 11:39:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FBE661A0A
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 11:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBE661A0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ECE1F16C6;
	Thu, 25 Mar 2021 12:39:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ECE1F16C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616672391;
	bh=qlNPSD0v2axzEzc7mYlfNmvnClomzy38BEjQdUlMqXY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mSfvQoAvP/6XKt9oDaRYl7VL3DUDq9v4lUh9S/XxDICwvS4S7xpyrLajfyGI74TTb
	 7OzBbAHJlPE4M7dUZJdIkZFZS9O8bClNdiaUzcaOrZ/uLZ8VBNxFCnrUBuo+42BZgW
	 jerWc3dFaQA5gZKYi2ya2O8JoyP+K+sopKdZHiY0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19E07F805D8;
	Thu, 25 Mar 2021 12:27:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A49F9F805D8; Thu, 25 Mar 2021 12:27:42 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BF353F805BA
 for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2021 12:27:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF353F805BA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="f1YCYwGk"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B6F961A33;
 Thu, 25 Mar 2021 11:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616671650;
 bh=qlNPSD0v2axzEzc7mYlfNmvnClomzy38BEjQdUlMqXY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f1YCYwGk7g+e3ognEgjYUm6xJcLHz70/9ohd/O5YByRB1KxhgL274B4yAdeZuktOW
 XPA6i/hO/+uT0g4cRT1zxMlsC9T8rXs5nC6eySSu7bczuczH1DvNRuLDr9IdwLq7u8
 bzC+F00V7Go6aPZJmuMSXz/UaP6z3fIhdhpNoCmmknwpXoqvOIGpzqvuPy62FnyVtU
 2bJeD+BGGIaTa7K1HILutqBdTONsJGABCR86ubR0apScoBh6OqmAMCWsSivTSqYHQt
 wYsExJJzTUULzMAMvdHgb2oqnE3lolwN0bORMvbiV6ImQ6fyI7fBKA574EEytqBF6+
 MWSFrRALFGYjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 04/20] ASoC: rt5651: Fix dac- and adc- vol-tlv
 values being off by a factor of 10
Date: Thu, 25 Mar 2021 07:27:08 -0400
Message-Id: <20210325112724.1928174-4-sashal@kernel.org>
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

[ Upstream commit eee51df776bd6cac10a76b2779a9fdee3f622b2b ]

The adc_vol_tlv volume-control has a range from -17.625 dB to +30 dB,
not -176.25 dB to + 300 dB. This wrong scale is esp. a problem in userspace
apps which translate the dB scale to a linear scale. With the logarithmic
dB scale being of by a factor of 10 we loose all precision in the lower
area of the range when apps translate things to a linear scale.

E.g. the 0 dB default, which corresponds with a value of 47 of the
0 - 127 range for the control, would be shown as 0/100 in alsa-mixer.

Since the centi-dB values used in the TLV struct cannot represent the
0.375 dB step size used by these controls, change the TLV definition
for them to specify a min and max value instead of min + stepsize.

Note this mirrors commit 3f31f7d9b540 ("ASoC: rt5670: Fix dac- and adc-
vol-tlv values being off by a factor of 10") which made the exact same
change to the rt5670 codec driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20210226143817.84287-3-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5651.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 985852fd9723..318a4c9b380f 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -288,9 +288,9 @@ static bool rt5651_readable_register(struct device *dev, unsigned int reg)
 }
 
 static const DECLARE_TLV_DB_SCALE(out_vol_tlv, -4650, 150, 0);
-static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -65625, 375, 0);
+static const DECLARE_TLV_DB_MINMAX(dac_vol_tlv, -6562, 0);
 static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -3450, 150, 0);
-static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -17625, 375, 0);
+static const DECLARE_TLV_DB_MINMAX(adc_vol_tlv, -1762, 3000);
 static const DECLARE_TLV_DB_SCALE(adc_bst_tlv, 0, 1200, 0);
 
 /* {0, +20, +24, +30, +35, +40, +44, +50, +52} dB */
-- 
2.30.1

