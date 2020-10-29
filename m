Return-Path: <SRS0=XEtc=EE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F171DC2D0A3
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:54:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26DAD2151B
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="g6vHWdcU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdYT7RCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DAD2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5936E168C;
	Thu, 29 Oct 2020 08:54:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5936E168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603958093;
	bh=OwiIhAML4zA3HbWp93vzpABDWcLSvS5lfwUHPew2Xss=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g6vHWdcUPwtam9DG9wAlp3PzTAE7107y3bY4TsTS8U9u0zO+c7xTsHscvNcWfIQVa
	 Ge7wiAvF5vcJc5lNQyZazdSAc9zkQcNZWgcvHi+XOol8us0mo/qXuWBbRlVUhnk+bX
	 2q1s8DWJAoDPLPGuPCODK++UIkFif3Ugau6kh8x0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04FD0F804FF;
	Thu, 29 Oct 2020 08:50:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D3E81F80217; Thu, 29 Oct 2020 08:44:24 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15BDFF800FF
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 08:44:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15BDFF800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="bdYT7RCK"
Received: by mail-pf1-x442.google.com with SMTP id e15so1646178pfh.6
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 00:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OYt9DPsIOPNIqy5dqkJ5lCLLGf00bKzjgHV7/FKrm30=;
 b=bdYT7RCKiIF5bBkrbTYntlKdOqtia2YZXQxKoyrwimF4rI/i2LTRqUQwxtRz0JGJOK
 pJRd47FrtAMSOfTJ2MDoZXbTvtK/dw/1a/SMrHOhliTQlsu7NLGPDe6FLeTDqqVW7Zwd
 /u5vQxnES6QQW3KTbWdE8TQmp5yzB9TOuVCV3+wQNH26bIe0mim3pCggXrQDZPepbrDj
 239M/hFcPQOtqluGwkNXrQv286qOU6i4dX4LxERLdXOOYNY6SiEjhAywks7briuClUVH
 t2adBUU0kc1uK5VE5F5nq3FcryezcqR2epcnnBlciA/4MSZsn0D9Xrcl4vkglSHi7Slh
 KLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OYt9DPsIOPNIqy5dqkJ5lCLLGf00bKzjgHV7/FKrm30=;
 b=Mx90f7xbFZXqjiD1y3oBGUPVa9jCKcYW62+sxyZxpDm7eeqNde+CxenTVl3IFi4MnL
 OB/bAwbHA0SvMZNCJTT7hHfh8Q8HCFmotQL8nuCCM8Wfu2hX40DJnh6zOEkHIQdhxat4
 88U+SasXC99XD6f5HjZH8U1+bF6cIn0nQ07ggjWBzrhw+SW3FEI5UzwwBjR70Qz8kXeE
 gLmbgqn8/h+7+FneIKOH7ChTTsGq3sJ7yTkkebAkKpuAgV2UTCs+MXzrOsw59SVvQJ9s
 7+WerIlsnj+3gTkIa/+hTiRUGw5wZUqz3sp0ROCPC6JoeuWaFvNEnxZMpCjXvbUh7/tE
 U1uw==
X-Gm-Message-State: AOAM5301I3e61KIGqn5aWL6UIb1dSfAGOOkam9Vyk1OhIDtpw7pi75OU
 cKDMChehsoSx3c9ARcmDjWo=
X-Google-Smtp-Source: ABdhPJzgm6erpGiPMEQPgP+rXdOPNC3MCgogID7xTCjo1ei4Pu9gFwMcSe9ios3QobaPjrqK6DtEcw==
X-Received: by 2002:aa7:815a:0:b029:164:cc2e:2c56 with SMTP id
 d26-20020aa7815a0000b0290164cc2e2c56mr447859pfn.21.1603957460017; 
 Thu, 29 Oct 2020 00:44:20 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
 by smtp.gmail.com with ESMTPSA id f8sm1541140pga.78.2020.10.29.00.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 00:44:19 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 11/25] ASoC: hdac: remove unnecessary CONFIG_PM_SLEEP
Date: Thu, 29 Oct 2020 15:42:47 +0800
Message-Id: <20201029074301.226644-11-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029074301.226644-1-coiby.xu@gmail.com>
References: <20201029074301.226644-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2020 08:49:55 +0100
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
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

SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 sound/soc/intel/skylake/skl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 8b993722f74e..da32d68080be 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -322,7 +322,6 @@ static int _skl_resume(struct hdac_bus *bus)
 }
 #endif
 
-#ifdef CONFIG_PM_SLEEP
 /*
  * power management
  */
@@ -400,7 +399,6 @@ static int skl_resume(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_PM
 static int skl_runtime_suspend(struct device *dev)
-- 
2.28.0

