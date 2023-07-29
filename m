Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289C6C0015E
	for <alsa-devel@archiver.kernel.org>; Sat, 29 Jul 2023 09:17:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 56BE684D;
	Sat, 29 Jul 2023 11:16:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 56BE684D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690622241;
	bh=ICO4rvgKpiWV0UjPKr6lfVoRO3k4D7grUwUq+M2Ssrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tafewQOmP9vM2lMdkPDPTivHRfxDwbNJ233W4fKLoEcoMSLOs2R1P5l/scdmdOxDN
	 vKgyJ+xz1nhJjx4TAWByKxWFufuy237c6YoHxnWZiK10dlITRGu6UuwAOUeJqUk5zC
	 xYWcQuzYQIt1jzpBW5ciegRSpl1nBccPRI54ZpTc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E303CF80558; Sat, 29 Jul 2023 11:16:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 73036F80558;
	Sat, 29 Jul 2023 11:16:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 63FDBF80551; Sat, 29 Jul 2023 11:16:02 +0200 (CEST)
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com
 [115.124.28.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 71128F80149
	for <alsa-devel@alsa-project.org>; Sat, 29 Jul 2023 11:12:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71128F80149
X-Alimail-AntiSpam: 
 AC=CONTINUE;BC=0.3879003|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.017331-0.000432192-0.982237;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.U3WkWhu_1690621950;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com
 fp:SMTPD_---.U3WkWhu_1690621950)
          by smtp.aliyun-inc.com;
          Sat, 29 Jul 2023 17:12:32 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	rf@opensource.cirrus.com,
	wangweidong.a@awinic.com,
	shumingf@realtek.com,
	ryans.lee@analog.com,
	13916275206@139.com,
	herve.codina@bootlin.com,
	ckeepax@opensource.cirrus.com,
	doug@schmorgal.com,
	fido_max@inbox.ru,
	povik+lin@cutebit.org,
	liweilei@awinic.com,
	yijiangtao@awinic.com,
	colin.i.king@gmail.com,
	trix@redhat.com,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: zhangjianming@awinic.com
Subject: [PATCH V3 1/5] ASoC: dt-bindings: Add schema for "awinic,aw88261"
Date: Sat, 29 Jul 2023 17:12:19 +0800
Message-ID: <20230729091223.193466-2-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230729091223.193466-1-wangweidong.a@awinic.com>
References: <20230729091223.193466-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BA43IEP7HYU5NHIBU2LNYHKB2KHILBSR
X-Message-ID-Hash: BA43IEP7HYU5NHIBU2LNYHKB2KHILBSR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BA43IEP7HYU5NHIBU2LNYHKB2KHILBSR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Weidong Wang <wangweidong.a@awinic.com>

Add the awinic,aw88261 property to the awinic,aw88395.yaml file.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 Documentation/devicetree/bindings/sound/awinic,aw88395.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
index 35eef7d818a2..4051c2538caf 100644
--- a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
+++ b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
@@ -19,7 +19,9 @@ allOf:
 
 properties:
   compatible:
-    const: awinic,aw88395
+    enum:
+      - awinic,aw88395
+      - awinic,aw88261
 
   reg:
     maxItems: 1
-- 
2.41.0

