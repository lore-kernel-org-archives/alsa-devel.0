Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD390C2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:21:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B301422269
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WmDhOIWw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oyp1w20K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B301422269
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C703171E;
	Fri, 20 Nov 2020 17:20:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C703171E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605889277;
	bh=J7blZK/cQ3ZmyizEP/d5i6nwcrycLSH9do8+EQTrnvs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WmDhOIWwyPH2Ioip5xBYmeVWbfsu2YyzaSo5kmTd9OM27I49S9yJ8vlw25Fe4mTnD
	 WQcsEQbSrg1KjH+lK+Q006FjabhKlTeM6nleYydODmMtoD/CcxJCPgnJgqGy8OD7Ja
	 AD/Hst719xtIRiGgfegdLUZyQjG8Oze5+xFn4m3Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95311F804EB;
	Fri, 20 Nov 2020 17:18:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 624FEF804E4; Fri, 20 Nov 2020 17:18:15 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF72FF804DF
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 17:18:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF72FF804DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Oyp1w20K"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E05472245F;
 Fri, 20 Nov 2020 16:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605889091;
 bh=J7blZK/cQ3ZmyizEP/d5i6nwcrycLSH9do8+EQTrnvs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Oyp1w20Kw1+RhiKRTJPAXIyfn0T8xpfiE5F4+TNUDI/oON7uP3oNzlHQaE0wUt8aH
 00Dd7UYt0uF1WEEnTeh3YxFTn5Ck23fO2C4IPlPQOSw9tQsxKnMz+moFwx1oJfqapx
 nV9LNOrMbRA/oVCrOIHlP6+oXLzAicRUdmSARDhk=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH 07/38] ASoC: meson: t9015: drop of_match_ptr from of_device_id
 table
Date: Fri, 20 Nov 2020 17:16:21 +0100
Message-Id: <20201120161653.445521-7-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Neil Armstrong <narmstrong@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Takashi Iwai <tiwai@suse.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
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

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).  This fixes
compile warning (!CONFIG_OF on x86_64):

  sound/soc/meson/t9015.c:315:34: warning: ‘t9015_ids’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/meson/t9015.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/t9015.c b/sound/soc/meson/t9015.c
index 56d2592c16d5..0532a2b8c240 100644
--- a/sound/soc/meson/t9015.c
+++ b/sound/soc/meson/t9015.c
@@ -321,7 +321,7 @@ MODULE_DEVICE_TABLE(of, t9015_ids);
 static struct platform_driver t9015_driver = {
 	.driver = {
 		.name = "t9015-codec",
-		.of_match_table = of_match_ptr(t9015_ids),
+		.of_match_table = t9015_ids,
 	},
 	.probe = t9015_probe,
 };
-- 
2.25.1

