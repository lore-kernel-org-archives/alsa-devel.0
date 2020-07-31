Return-Path: <SRS0=4tTe=BK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD035C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 20:17:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A21022B3F
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 20:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AxcbUiM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A21022B3F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA73B1672;
	Fri, 31 Jul 2020 22:16:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA73B1672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596226668;
	bh=w289uh70u7ajEvTz/pDzSqb6CeSG3D3M8kJyB1PPhWA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AxcbUiM17xkVuWSbnkU7jnG5qNZDLQYEWnH29opNZt3RVCZFp6dlQCmVYYvjWrcWy
	 bgYRjt+PTtcdSVt8Qmla9h3q6NWBv746W/q4Z22d+j4hCB03iahgj3GEzrUoHF5hVJ
	 kCFTBxpYYZO2CwzhggO26YDirz6i6COPz74ca0d0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F0C7F8011C;
	Fri, 31 Jul 2020 22:16:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B298F80171; Fri, 31 Jul 2020 22:16:56 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86C99F8011C
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 22:16:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86C99F8011C
X-IronPort-AV: E=Sophos;i="5.75,419,1589234400"; d="scan'208";a="462075490"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256;
 31 Jul 2020 22:16:49 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] ALSA: docs: fix typo
Date: Fri, 31 Jul 2020 21:35:29 +0200
Message-Id: <1596224129-7699-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
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

GFP_KRENEL -> GFP_KERNEL

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 Documentation/sound/kernel-api/writing-an-alsa-driver.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
index fa49688..aa9d5ab 100644
--- a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
+++ b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
@@ -3579,7 +3579,7 @@ dependent on the bus. For normal devices, pass the device pointer
 ``SNDRV_DMA_TYPE_DEV`` type. For the continuous buffer unrelated to the
 bus can be pre-allocated with ``SNDRV_DMA_TYPE_CONTINUOUS`` type.
 You can pass NULL to the device pointer in that case, which is the
-default mode implying to allocate with ``GFP_KRENEL`` flag.
+default mode implying to allocate with ``GFP_KERNEL`` flag.
 If you need a different GFP flag, you can pass it by encoding the flag
 into the device pointer via a special macro
 :c:func:`snd_dma_continuous_data()`.

