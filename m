Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C46FC10DC3
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Dec 2023 14:04:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62B14DED;
	Mon, 11 Dec 2023 15:04:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62B14DED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702303452;
	bh=hewV+haqm7iKFmVzteMqLLsZAMWK0d37JQvVNdoChUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Fnen5uXchowk5qHiJxo3K09JSiu6tgiHHUaO6R+5jouUGTtkeaTXUDwAloeLZQ3SQ
	 PHjuHkoGBKicpeXu6ImU9AxEVXbxYMAR5GXV5Hse3ayH8DTSKXuiytsFlKhDItbPHA
	 BP2XXKbk25guI1fBROZBoCCtTT4KYbWNg7EsyN24=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F2562F805ED; Mon, 11 Dec 2023 15:02:53 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 08351F805E4;
	Mon, 11 Dec 2023 15:02:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7613CF805B0; Mon, 11 Dec 2023 15:02:47 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EBCFDF8016E
	for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2023 15:02:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EBCFDF8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QRIi6cKM
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9BA8ECE11FD;
	Mon, 11 Dec 2023 14:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C72AC433CA;
	Mon, 11 Dec 2023 14:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702303353;
	bh=hewV+haqm7iKFmVzteMqLLsZAMWK0d37JQvVNdoChUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QRIi6cKMpWWa1l81MpOs2SbTodyZcmZDmNkcjnp1X8aOjB0xppYUmyjQu8H9RgS7z
	 QldsjxTyaiVdFrSsMZP2FIHKjPfGD6Uwr3hQlh3/nqVZCrPqr9khLtCt+H23TLbYwW
	 1GegbdE5Klqgtu1tDU1jqXL0dcZMD3flSW9jkM1VxJbydAtvRDmFvTdkizpluKV472
	 LGSq5ZHKFKdww4PMcHaMMlYU95Lp5UkVOZvQ3zQIqgWImBVqgfJ+ffQPJ5s7fhGXr6
	 FDpfbb3HgXImtdwZakRoB8fHimkCQUYw/5IWNPQSOZ1OimJNI2LQa3/1Hbk8q3n7WL
	 vlY7ZZTfsuqdg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 04/12] ASoC: cs43130: Fix the position of const
 qualifier
Date: Mon, 11 Dec 2023 09:01:57 -0500
Message-ID: <20231211140219.392379-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211140219.392379-1-sashal@kernel.org>
References: <20231211140219.392379-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.263
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NFCVKGGOUYLN4VYR5Q3Y4UDGPJNAB7WC
X-Message-ID-Hash: NFCVKGGOUYLN4VYR5Q3Y4UDGPJNAB7WC
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

[ Upstream commit e7f289a59e76a5890a57bc27b198f69f175f75d9 ]

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20231117141344.64320-2-mstrozek@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs43130.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 8f70dee958786..285806868c405 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -1683,7 +1683,7 @@ static ssize_t cs43130_show_dc_r(struct device *dev,
 	return cs43130_show_dc(dev, buf, HP_RIGHT);
 }
 
-static u16 const cs43130_ac_freq[CS43130_AC_FREQ] = {
+static const u16 cs43130_ac_freq[CS43130_AC_FREQ] = {
 	24,
 	43,
 	93,
@@ -2364,7 +2364,7 @@ static const struct regmap_config cs43130_regmap = {
 	.use_single_write	= true,
 };
 
-static u16 const cs43130_dc_threshold[CS43130_DC_THRESHOLD] = {
+static const u16 cs43130_dc_threshold[CS43130_DC_THRESHOLD] = {
 	50,
 	120,
 };
-- 
2.42.0

