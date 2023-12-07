Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F50C4167B
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Dec 2023 00:07:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 49D4DDF8;
	Thu,  7 Dec 2023 01:06:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 49D4DDF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701907622;
	bh=KQqS10tn9IyZPkx8LGsVlc5cVqbzFuCuYupcYLSkBGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=o3pKUlaH8FW2oNTxq/LuAbPoBnzJkdEoGIBCCiD/b0xVWsCqey2XzOTHR+HYANsiw
	 VKfE5uwoDitCVBu3BDbR1A/iBzQLuaLmFSppkdz5FLMmUOSgZj3ZG6rod9emQ5erzg
	 ksFq8ptga400vFjCG649UOi9LkXmwbRzHHeYuG2Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 05F9AF806AB; Thu,  7 Dec 2023 01:05:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AFC20F806B3;
	Thu,  7 Dec 2023 01:05:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 01249F805B3; Thu,  7 Dec 2023 01:04:55 +0100 (CET)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id 76012F80615
	for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2023 01:04:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76012F80615
Received: from fedori.lan (51b690cd.dsl.pool.telekom.hu
 [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000071705.0000000065710C17.00119103;
 Thu, 07 Dec 2023 01:04:38 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
  Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
  Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 15/16] ALSA: hda/tas2781: reset the amp before component_add
Date: Thu,  7 Dec 2023 01:04:31 +0100
Message-ID: 
 <e8d1ba79b6135d6f19441d461ec62add302a6b36.1701906455.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701906455.git.soyer@irl.hu>
References: <cover.1701906455.git.soyer@irl.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
Message-ID-Hash: UPBQ7SXL3MG4KZA2KGM56F7XUBSKIIXQ
X-Message-ID-Hash: UPBQ7SXL3MG4KZA2KGM56F7XUBSKIIXQ
X-MailFrom: soyer@irl.hu
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
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UPBQ7SXL3MG4KZA2KGM56F7XUBSKIIXQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Prevent race to make the init reliable.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index cb8872e15bb0..f72e0beab1fb 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -800,14 +800,14 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 
 	pm_runtime_put_autosuspend(tas_hda->dev);
 
+	tas2781_reset(tas_hda->priv);
+
 	ret = component_add(tas_hda->dev, &tas2781_hda_comp_ops);
 	if (ret) {
 		dev_err(tas_hda->dev, "Register component failed: %d\n", ret);
 		pm_runtime_disable(tas_hda->dev);
 		goto err;
 	}
-
-	tas2781_reset(tas_hda->priv);
 err:
 	if (ret)
 		tas2781_hda_remove(&clt->dev);
-- 
2.43.0

