Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CEAC2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:21:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229FD22269
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AHF0TGOF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkP2w3zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229FD22269
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 969331704;
	Fri, 20 Nov 2020 17:20:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 969331704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605889269;
	bh=7BJ20HiIHWzZ7e1AQrBa9aWK6V1RKx6mOZWpprT3oG8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AHF0TGOFKq0FqldA/GB6RfDb14dd6gQuwuch7E7nQ60vE3WZcftr35QDHvlXuYdTE
	 onLywRh9JjiR2hrZpJ1Ax//6xyUcXlhiaIC9Oj7IIInxxIfKmqCTpQ0HdhojDL8RBJ
	 AjAkrTw22gGio2PfcB9vOy9sIScIf9eG0SBm1ZdI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 738E9F804E5;
	Fri, 20 Nov 2020 17:18:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5335FF804D6; Fri, 20 Nov 2020 17:18:12 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CBF45F80273
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 17:18:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBF45F80273
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QkP2w3zc"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 361F12245B;
 Fri, 20 Nov 2020 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605889088;
 bh=7BJ20HiIHWzZ7e1AQrBa9aWK6V1RKx6mOZWpprT3oG8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QkP2w3zcdhFoi/8w+5M+3XMvMRMtrqgge7OJl8laZ6rOF/dYyY8XppAr9BlQ1EC1Q
 fRtEBiUgRHOWZGWCYR1vwKhT4f19Ym3RoyvEg3HRrtATAfK1Yh5Evg69UCjs9i2/eZ
 02TojaHKw1cFh6KzO+mdrcR6NhCFvybBOM/0eqAs=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH 06/38] ASoC: kirkwood: armada-370-db: drop of_match_ptr from
 of_device_id table
Date: Fri, 20 Nov 2020 17:16:20 +0100
Message-Id: <20201120161653.445521-6-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.com>, Krzysztof Kozlowski <krzk@kernel.org>
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

  sound/soc/kirkwood/armada-370-db.c:137:34: warning: ‘a370db_dt_ids’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/kirkwood/armada-370-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/armada-370-db.c b/sound/soc/kirkwood/armada-370-db.c
index 8e44ae37ad1e..b12141ad15cb 100644
--- a/sound/soc/kirkwood/armada-370-db.c
+++ b/sound/soc/kirkwood/armada-370-db.c
@@ -143,7 +143,7 @@ MODULE_DEVICE_TABLE(of, a370db_dt_ids);
 static struct platform_driver a370db_driver = {
 	.driver		= {
 		.name	= "a370db-audio",
-		.of_match_table = of_match_ptr(a370db_dt_ids),
+		.of_match_table = a370db_dt_ids,
 	},
 	.probe		= a370db_probe,
 };
-- 
2.25.1

