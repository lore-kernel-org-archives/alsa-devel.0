Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A91C56201
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:18:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27D9A24073
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IGoUCL/f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBJpufyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D9A24073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC72A16F2;
	Fri, 20 Nov 2020 17:17:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC72A16F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605889120;
	bh=6crPrNanCPybdIoCOUE0EQqvWG11iCTFahxPBw6lnv0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IGoUCL/fAf7tLatjVlgvJeBbHFVtE/EEforws8cNJvObmtIyZV4lIoHcdLjC8w6Rk
	 t2fz3rIe7oY1XKoIIBGy56aCjjOcqHT734tGLv6ZhI1qUkz5clw56iFZ7BQbcy4sW/
	 RF+QVZ4ESCk3pGuzO0ZT5qmRV/32rryRM2bkK5Mw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 60219F800F3;
	Fri, 20 Nov 2020 17:17:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C9B61F8016C; Fri, 20 Nov 2020 17:17:47 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3367F800F3
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 17:17:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3367F800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HBJpufyX"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 18542223BE;
 Fri, 20 Nov 2020 16:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605889057;
 bh=6crPrNanCPybdIoCOUE0EQqvWG11iCTFahxPBw6lnv0=;
 h=From:To:Cc:Subject:Date:From;
 b=HBJpufyXc3DBA/oH7WTc5JtitlxByPOEhplD3rghF59ynLElTFbo+CIqKKlCMb3Ce
 LXbSCcB8O5cHpg/3+E00aER2ZgdP/lN8uzlty5liGSt4rC7rIDUY15fdXoYCKQIpNE
 HwHpuXK0D4GXGdba1nE/5kmodRdIH9OO5EWscNx8=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH 01/38] ASoC: ak5558: drop of_match_ptr from of_device_id table
Date: Fri, 20 Nov 2020 17:16:15 +0100
Message-Id: <20201120161653.445521-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
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

  sound/soc/codecs/ak5558.c:418:34: warning: ‘ak5558_i2c_dt_ids’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/ak5558.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index 2f076d5ee284..427d7d51bf53 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -423,7 +423,7 @@ static const struct of_device_id ak5558_i2c_dt_ids[] = {
 static struct i2c_driver ak5558_i2c_driver = {
 	.driver = {
 		.name = "ak5558",
-		.of_match_table = of_match_ptr(ak5558_i2c_dt_ids),
+		.of_match_table = ak5558_i2c_dt_ids,
 		.pm = &ak5558_pm,
 	},
 	.probe_new = ak5558_i2c_probe,
-- 
2.25.1

