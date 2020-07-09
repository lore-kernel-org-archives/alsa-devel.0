Return-Path: <SRS0=mEIa=AU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3F8C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:26:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC532074B
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KtvSGndT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Jfb4IgnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC532074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D98915E0;
	Thu,  9 Jul 2020 14:25:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D98915E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594297598;
	bh=qoOAg7ch7muNeH92NWlyT5ZLa8rWX7q7dL8EsCCK4N8=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KtvSGndTFS9SWsDxV5kx0C7NBFgmULZFMevePt91HIVbJ3atxJ4vG08PrHq4nMPF0
	 mNjlDcYDReMRhsmvhfSGXSodfa/aGhIRYlSQdqoZh8G+4nUQE/6OQiucZb35DAvIng
	 6xHy4Msk5B3KWwPEgqpCCx+jc6iWCmJhvbCZqNUQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D624F802A0;
	Thu,  9 Jul 2020 14:25:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 826F8F8025A; Thu,  9 Jul 2020 14:25:06 +0200 (CEST)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8708F80117
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2020 14:24:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8708F80117
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="Jfb4IgnK"
Received: by mail-yb1-xb4a.google.com with SMTP id 132so2672554ybg.8
 for <alsa-devel@alsa-project.org>; Thu, 09 Jul 2020 05:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=qCyFeC980jB+4SOM6Rks3z7aJS41ao21bCwAzdZGowU=;
 b=Jfb4IgnKeJnYuvXPKmDYfSfTYZ43Hmd6XjY6GowlvqO0n2MoejSc6ooMJog3/X9S3/
 hnUX9OKXF9LMNFpb1q7lXjNQzV9xLoZd3RenRkteQe2/up+rOIF4GOPacWXh8xgzz1BH
 tPMYIvT0cz0nwQ3Z85jCytxLFFj/lDEL+kzYr5GbgfNDMox5zt+zB8YmgqiDZllGJZoX
 lf+1XTB/lisFmQVB3D00wtQyp7Pud2apJBM3tci/cpAuOsEufdWtE6CRSg1uGjwIilIx
 Ar2qGeFwWSR2RPZA8BUre0fe32solrpYvlWYW/BNYdhaEgp23z2zUiaDVZ8QmiQVAaRT
 ZSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=qCyFeC980jB+4SOM6Rks3z7aJS41ao21bCwAzdZGowU=;
 b=MtXMdPb6LgdnUAUC/rwxqoGOlbygbKSe9m5QwXgwkbw7zBkWdC7nV2CSASG9hooTIk
 L13qwBkkWD5VD0CDv+0tKQ37VHm50B6MfeEud/KPqpet6+UuvdGvqdZ5ySPbo91vzsN+
 G2AEA7AEpygFEw5loNgQl+37/ymYATz6gDAwDAoWSMud/1TkfeQQFeCXIe3dLmBByPxh
 XDe/WqVQ49cCIhglc5WcFRO9osmvAUQoIAwKiw+uzzK59n5M4FxMYcZdhVm2sQdElO+1
 VWkB3DpmNF2urt1jlbEd6AYyVGCkGPNxhcVRAp7pBspEfjiK3v82ckPy7reR2GhSIpa3
 ZsZg==
X-Gm-Message-State: AOAM533QE7BHPr/daO+mD5T+OatDxG/ZaVjKy5PC5oLJ0G6ptTYTWyaY
 JspyHC01YvDShKe3x0JIPYz3HW4SjvuA
X-Google-Smtp-Source: ABdhPJxbPyQCYnast7EOHjo8ITrS6x8hHFOr+PwGzmqFMNxhvDM4ikb45Utp+ivtBSrP9F59hBv0P/DR6YXa
X-Received: by 2002:a25:9782:: with SMTP id i2mr16925318ybo.277.1594297496655; 
 Thu, 09 Jul 2020 05:24:56 -0700 (PDT)
Date: Thu,  9 Jul 2020 20:24:41 +0800
In-Reply-To: <20200709122445.1584497-1-tzungbi@google.com>
Message-Id: <20200709122445.1584497-2-tzungbi@google.com>
Mime-Version: 1.0
References: <20200709122445.1584497-1-tzungbi@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH 1/5] ASoC: mediatek: mt8183-da7219: sort header inclusions in
 alphabetical
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org
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

Sorts header inclusions in alphabetical.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index b61bb2de4ec3..4cffe7daf33c 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -13,9 +13,9 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include "mt8183-afe-common.h"
 #include "../../codecs/da7219-aad.h"
 #include "../../codecs/da7219.h"
+#include "mt8183-afe-common.h"
 
 struct mt8183_da7219_max98357_priv {
 	struct snd_soc_jack headset_jack;
-- 
2.27.0.383.g050319c2ae-goog

