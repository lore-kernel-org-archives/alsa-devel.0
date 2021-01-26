Return-Path: <SRS0=d1MO=G5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48BBC433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Jan 2021 21:21:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 882E222240
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Jan 2021 21:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882E222240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3685E1710;
	Tue, 26 Jan 2021 22:20:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3685E1710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611696087;
	bh=9OjtP0DIc/CCEucNkZDeEY4Efwk+TJzw7kAlZSR8d7Y=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qa13IZ+oUnfHtG68axG5waKdcdjSu8q4yU7PBL3dC7Hqlc3L/rOIKdoXGrb6aklVv
	 e9ZvV9MVU85cwtpYxdrv2rWnhmRTk25pfcDqDFDAdEAtiiU4ucI7onoBv56DFr/DcW
	 OkpUoDBqBd0pmZJYRx1e7CNnmdeIIiemMudw8KlI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95C17F80158;
	Tue, 26 Jan 2021 22:20:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 023E0F80158; Tue, 26 Jan 2021 22:20:34 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A59E1F8011C
 for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2021 22:20:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A59E1F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="EOpDSe6S"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37B7622240;
 Tue, 26 Jan 2021 21:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611696028;
 bh=9OjtP0DIc/CCEucNkZDeEY4Efwk+TJzw7kAlZSR8d7Y=;
 h=From:To:Cc:Subject:Date:From;
 b=EOpDSe6SsgvSSsQxpqwxDcm8oG2MzJOj3VVvo2GfeLqo0/2pevZ7Qw/OoDahSEhxe
 6Lf3WM84cJI1JxZ1S5mO97iSDEHjetNoIlU5+M1eZVZ8uOWMeYlNuWbFQcohilmBkY
 8O4z6jC8cgn7DeNRH2qul5/TrrgzeRQwl7vd9FIAH4lFXJ4FNbfhjoWFD/wdYPu1PO
 mPgizZHHcWDf0cbJcdZyh2BJiL+h/qNAp3cUskMNGZYvPZNet2CsduM8VTR5C8pE8Q
 v5f9imc++R+RGt8qBhk/zxS4bbNsXoQWWHXf8bogise8Vn1vF9JIXbK/rHzikKAKJf
 4w8s+zMRsWjlQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Patrick Lai <plai@codeaurora.org>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: q6asm: fix 'physical' typos
Date: Tue, 26 Jan 2021 15:20:23 -0600
Message-Id: <20210126212023.2921168-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Bjorn Helgaas <bhelgaas@google.com>, alsa-devel@alsa-project.org
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

From: Bjorn Helgaas <bhelgaas@google.com>

Fix misspellings of "physical".

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 sound/soc/qcom/qdsp6/q6asm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index a6618efe22f2..36bf8bd4edd7 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -491,7 +491,7 @@ static int __q6asm_memory_map_regions(struct audio_client *ac, int dir,
  *
  * @dir: direction of audio stream
  * @ac: audio client instanace
- * @phys: physcial address that needs mapping.
+ * @phys: physical address that needs mapping.
  * @period_sz: audio period size
  * @periods: number of periods
  *
-- 
2.25.1

