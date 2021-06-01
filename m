Return-Path: <SRS0=jKKe=K3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F95C47080
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 10:36:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09D8613AE
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 10:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09D8613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 760681690;
	Tue,  1 Jun 2021 12:35:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 760681690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622543768;
	bh=Pn2+md6aoadgfZarpwfTQwJC2z65PKlQc6+83p5nyWk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hcVJgJPSARszKh6oTLfEnwsxgycFzsKmNbjNLmR4841mpXUo7pkUx3XOz2K5Dxajm
	 Nn6MxX/LqMvwh4op9eXZQBehpPZvi2rfiEf8MuB7N6BiQKOQLpERLkRw+5NXitj+xM
	 MF9KtknOehQu913dQD2oQfD1OdFZ9u6fLF0w6rZk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02687F80253;
	Tue,  1 Jun 2021 12:35:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BAE3BF80141; Tue,  1 Jun 2021 12:35:16 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5881F80141
 for <alsa-devel@alsa-project.org>; Tue,  1 Jun 2021 12:35:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5881F80141
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <colin.king@canonical.com>)
 id 1lo1jm-0000fi-9e; Tue, 01 Jun 2021 10:35:06 +0000
From: Colin King <colin.king@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: topology: Fix spelling mistake "vesion" -> "version"
Date: Tue,  1 Jun 2021 11:35:06 +0100
Message-Id: <20210601103506.9477-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in comments. Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/soc-topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 5e65b72910e9..0a24d0d409d2 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1881,7 +1881,7 @@ static void stream_caps_new_ver(struct snd_soc_tplg_stream_caps *dest,
  * @src: older version of pcm as a source
  * @pcm: latest version of pcm created from the source
  *
- * Support from vesion 4. User should free the returned pcm manually.
+ * Support from version 4. User should free the returned pcm manually.
  */
 static int pcm_new_ver(struct soc_tplg *tplg,
 		       struct snd_soc_tplg_pcm *src,
@@ -2069,7 +2069,7 @@ static void set_link_hw_format(struct snd_soc_dai_link *link,
  * @src: old version of phyical link config as a source
  * @link: latest version of physical link config created from the source
  *
- * Support from vesion 4. User need free the returned link config manually.
+ * Support from version 4. User need free the returned link config manually.
  */
 static int link_new_ver(struct soc_tplg *tplg,
 			struct snd_soc_tplg_link_config *src,
@@ -2380,7 +2380,7 @@ static int soc_tplg_dai_elems_load(struct soc_tplg *tplg,
  * @src: old version of manifest as a source
  * @manifest: latest version of manifest created from the source
  *
- * Support from vesion 4. Users need free the returned manifest manually.
+ * Support from version 4. Users need free the returned manifest manually.
  */
 static int manifest_new_ver(struct soc_tplg *tplg,
 			    struct snd_soc_tplg_manifest *src,
-- 
2.31.1

