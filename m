Return-Path: <SRS0=4IlU=II=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2323BC433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 10:32:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2262C64F74
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 10:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2262C64F74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83DFC1784;
	Wed, 10 Mar 2021 11:32:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83DFC1784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615372374;
	bh=FHMC6WnsPdk2eris0NqojsZqlAhnk0uNsirQL0nbgpg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AEM2ET8ivizItY4YlHW+nFvdChDykoaGae2SI/dZqAob0V1c5HW7rnKgwkNMYW8Yz
	 uwUIVKKhucwD5+ws7L2MCk6RogLxdz4ClJXdmLE6gseqlPYUJu69xRnHKdKFY3hp2N
	 gosoGHySeprX+c92P2rFWdJyqzDA0Rdo//UjKtmE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CCB3F8042F;
	Wed, 10 Mar 2021 11:30:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3230F801D8; Wed, 10 Mar 2021 07:34:50 +0100 (CET)
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4F2C7F8014E
 for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2021 07:34:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F2C7F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=163.com header.i=@163.com
 header.b="WCkF0VsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FWnKs
 CUy6cUI+NQNYYrDcV9vQ3AY9aZlJaHYCSPCKeg=; b=WCkF0VsDBxFn3oRN33tSH
 CY6PbhFmDu2ZL1Tzl32Wk5XEfK9Dk764AJEgifohAqOYyPb37+1VMQERKFFVV9gt
 BGmnsjpWeI7Px0EwmMMG0fQpa/sTxXbzU+aeJfFsKTUlPix6kT+0HhN8PteZvSLu
 buANWjYuROzB9bsMPh1ZOk=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
 by smtp9 (Coremail) with SMTP id DcCowABnIgB1aEhglJboAQ--.42166S2;
 Wed, 10 Mar 2021 14:34:32 +0800 (CST)
From: zuoqilin1@163.com
To: tiwai@suse.com, lars@metafoo.de, joe@perches.com, broonie@kernel.org,
 perex@perex.cz
Subject: [PATCH] sound: Remove redundant steps
Date: Wed, 10 Mar 2021 14:34:26 +0800
Message-Id: <20210310063426.524-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowABnIgB1aEhglJboAQ--.42166S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7GF1DAFWkJFyxZw17tF4ruFg_yoW8JrWkpF
 1kur1UtFW0q3yDuF1UAryvvF1rKayDAa9rG393Z3y3JFWSvrWFvas3KF10vrWv9ayvkrZF
 qFyDKr1DArn8JwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jVbyZUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/xtbBRRhRiVPAKa57sgAAsY
X-Mailman-Approved-At: Wed, 10 Mar 2021 11:30:10 +0100
Cc: zuoqilin <zuoqilin@yulong.com>, alsa-devel@alsa-project.org
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

From: zuoqilin <zuoqilin@yulong.com>

If kzalloc fail,not need free it,so just return
-ENOMEM when kzalloc fail.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 sound/core/oss/mixer_oss.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index bec9283..eec61dc 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -800,8 +800,7 @@ static int snd_mixer_oss_get_recsrc2(struct snd_mixer_oss_file *fmixer, unsigned
 	uinfo = kzalloc(sizeof(*uinfo), GFP_KERNEL);
 	uctl = kzalloc(sizeof(*uctl), GFP_KERNEL);
 	if (uinfo == NULL || uctl == NULL) {
-		err = -ENOMEM;
-		goto __free_only;
+		return -ENOMEM;
 	}
 	down_read(&card->controls_rwsem);
 	kctl = snd_mixer_oss_test_id(mixer, "Capture Source", 0);
@@ -851,8 +850,7 @@ static int snd_mixer_oss_put_recsrc2(struct snd_mixer_oss_file *fmixer, unsigned
 	uinfo = kzalloc(sizeof(*uinfo), GFP_KERNEL);
 	uctl = kzalloc(sizeof(*uctl), GFP_KERNEL);
 	if (uinfo == NULL || uctl == NULL) {
-		err = -ENOMEM;
-		goto __free_only;
+		return -ENOMEM;
 	}
 	down_read(&card->controls_rwsem);
 	kctl = snd_mixer_oss_test_id(mixer, "Capture Source", 0);
-- 
1.9.1


