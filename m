Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B405BC00A8F
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Oct 2023 07:19:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBEB5A4A;
	Tue, 24 Oct 2023 09:18:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBEB5A4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698131970;
	bh=qDApE+/+Uek8eDNf5MPMzbnznXBBGK+GTzQINyrtSYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MtAQuoOOiPut+4yIuM4pg9BfN+/YJ09Afo1wAFLR0Mc5TVJWmcjYgRNHw/C241Dbc
	 GNlVpjmUG0fysx8el+japrKBVFWiK4bpVaEX9eXGZ00MVJRaCn8dgj7lPAOn3nnCeJ
	 dhQVd2e7dGUpnwP6yZerdgYykhYOmfiGP07e7W+k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0661F80558; Tue, 24 Oct 2023 09:17:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DBB2F8055B;
	Tue, 24 Oct 2023 09:17:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7DC25F8019B; Tue, 24 Oct 2023 09:15:14 +0200 (CEST)
Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com
 [115.124.28.97])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B38AF8014B
	for <alsa-devel@alsa-project.org>; Tue, 24 Oct 2023 09:15:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B38AF8014B
X-Alimail-AntiSpam: 
 AC=CONTINUE;BC=0.3180432|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00854121-0.000347876-0.991111;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.V6azq2U_1698131681;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com
 fp:SMTPD_---.V6azq2U_1698131681)
          by smtp.aliyun-inc.com;
          Tue, 24 Oct 2023 15:14:48 +0800
From: wangweidong.a@awinic.com
To: broonie@kernel.org
Cc: 13916275206@139.com,
	ajye_huang@compal.corp-partner.google.com,
	alsa-devel@alsa-project.org,
	arnd@arndb.de,
	ckeepax@opensource.cirrus.com,
	colin.i.king@gmail.com,
	conor+dt@kernel.org,
	dan.carpenter@linaro.org,
	devicetree@vger.kernel.org,
	harshit.m.mogalapalli@oracle.com,
	herve.codina@bootlin.com,
	krzysztof.kozlowski+dt@linaro.org,
	lgirdwood@gmail.com,
	linus.walleij@linaro.org,
	linux-kernel@vger.kernel.org,
	liweilei@awinic.com,
	perex@perex.cz,
	rf@opensource.cirrus.com,
	robh+dt@kernel.org,
	ryans.lee@analog.com,
	sebastian.reichel@collabora.com,
	shumingf@realtek.com,
	tiwai@suse.com,
	trix@redhat.com,
	wangweidong.a@awinic.com,
	yijiangtao@awinic.com
Subject: [PATCH V2 2/4] ASoC: codecs: Modify max_register usage error
Date: Tue, 24 Oct 2023 15:14:17 +0800
Message-ID: <20231024071419.85647-3-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024071419.85647-1-wangweidong.a@awinic.com>
References: <21bfa0bb-d936-402d-9ca9-6bcf181a0f35@sirena.org.uk>
 <20231024071419.85647-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XOAEYCPGNLARVX7T3WAGGJIHTHUTDFRK
X-Message-ID-Hash: XOAEYCPGNLARVX7T3WAGGJIHTHUTDFRK
X-MailFrom: wangweidong.a@awinic.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XOAEYCPGNLARVX7T3WAGGJIHTHUTDFRK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Weidong Wang <wangweidong.a@awinic.com>

Modify the value of max_register, otherwirse
the AW88261_EFRL1_REG register will not be
accessible.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88261.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index a697b5006b45..0db7a0a3c179 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -20,7 +20,7 @@
 static const struct regmap_config aw88261_remap_config = {
 	.val_bits = 16,
 	.reg_bits = 8,
-	.max_register = AW88261_REG_MAX - 1,
+	.max_register = AW88261_REG_MAX,
 	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
 	.val_format_endian = REGMAP_ENDIAN_BIG,
 };
-- 
2.41.0

