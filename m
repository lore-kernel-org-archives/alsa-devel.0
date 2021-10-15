Return-Path: <SRS0=/1nv=PD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8D3C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 13:36:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB37E6115C
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 13:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB37E6115C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B990010E;
	Fri, 15 Oct 2021 15:35:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B990010E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634304986;
	bh=Jfdr7yQfgMhpLh9jKiKNdtlf2IOA8lkNH03elRFkYXY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GgPzKyW+2pynU8XuzupeUMGENUTDWUfDFIw3N6BufDE8ORNIH86n11FsBO4aHAQBK
	 RkaSwb0C4zLrXoxRGVLVUuDYB5er80P4MfIkygU8zDAqtPKSiFoAURCGgzDEdotlZ4
	 ITrArqUQaj9SzJTZNzpW6va7IR5n2QUKJ7XI6MtE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C05FF8025B;
	Fri, 15 Oct 2021 15:35:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86E37F80269; Fri, 15 Oct 2021 15:35:34 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9313F80167
 for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2021 15:35:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9313F80167
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="kUfr5mjM"
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7AD5340060
 for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2021 13:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1634304924;
 bh=Y4U/fJqXuLgg52bUOfbV+iRZ91dG+diGxyV+QIZgnxY=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=kUfr5mjMpWFC5fPiFxCb6T4BMnjK/15PB3L6/VqLFx4Jcsw8pzdkje5TEy9oCjoSY
 ik63wXBH1BOXootrUfRGy7XVQfF7qgUMxZc6EqozPrKCj82Q8bXmxylmkEWUMp2KaZ
 X9SAUI69iSEbyLPBD87pa2s97+Kl/TgjdbSGyGujbD/mlkS0ld45Yfw7RK4ZA791xy
 j6TE4JljXWNsToaiE2m5udve/Vwh0EZcFEIB1K/d8n+efMcm2TsPdGqy2tit5XpheK
 MUyBWJ6SNSoZ//QEoa1qu+vZQdFesyMMei3BslhKXnsFXBHN++akZaJHhbTcnUZY4K
 GFZYNokAGAGJA==
Received: by mail-pj1-f69.google.com with SMTP id
 my5-20020a17090b4c8500b001a0bf4025c1so5316772pjb.8
 for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2021 06:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y4U/fJqXuLgg52bUOfbV+iRZ91dG+diGxyV+QIZgnxY=;
 b=5fl+p4imEwQkOVTTOBu8TXgr7K0wL9ULGQmyArZV8VVHZIEkAKMzHc0oBBALbYZjCj
 7hE65SCULrjA/Yt7W0htV4J1zaHb9jP68tbDQxqUQoBEPxVIy3Yza2r7CdNubBIL9Kyn
 sDlkI9iW6BnV+B2Reh0u2pEv3Rg9375P6qnemuJfaUQ8w1WweULwRJS3ziTqqY0Kjquq
 WkyI0iaanQAMZ/7/0n6AYL7z+LWSn78l+OYGtvAMSNe7feCaWRPOO+n6/MouEKfTRxFB
 PysLvfU4B7W5feyWFXVxfHmZqrujabTa6LKTdP5TJ94y+9JOefF33Ax7COjY1qHOjOo5
 aIvw==
X-Gm-Message-State: AOAM531QYpJATVufADa66fQAGjRbDGM5z6GrR7VQa81DmVow8CD4GnuC
 /vfnjNJNYuQbzRF+CsbObt12fp36KpTBP5kFcBktHKfGyD6VIjrRRccvubDaGxcDN8rbPnJV6GE
 eBCMzBgMgMENtJaV/j6U3F+zkQSniZjoT2ubFc7kc
X-Received: by 2002:a62:e90d:0:b0:44d:35a1:e5a0 with SMTP id
 j13-20020a62e90d000000b0044d35a1e5a0mr11806359pfh.54.1634304922960; 
 Fri, 15 Oct 2021 06:35:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz07OGlC4jPnkxjhJx1/FXGc+HkyjOrYc/PtEHciW7RhWaLFxsvrbGwzHFbiuv9FCIULMRE8Q==
X-Received: by 2002:a62:e90d:0:b0:44d:35a1:e5a0 with SMTP id
 j13-20020a62e90d000000b0044d35a1e5a0mr11806331pfh.54.1634304922600; 
 Fri, 15 Oct 2021 06:35:22 -0700 (PDT)
Received: from localhost.localdomain
 (2001-b011-3814-7c46-b875-7e50-69b7-4e53.dynamic-ip6.hinet.net.
 [2001:b011:3814:7c46:b875:7e50:69b7:4e53])
 by smtp.gmail.com with ESMTPSA id y8sm5143327pfe.217.2021.10.15.06.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Oct 2021 06:35:22 -0700 (PDT)
From: Chris Chiu <chris.chiu@canonical.com>
To: cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
 liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
 broonie@kernel.org, tiwai@suse.com
Subject: [PATCH] ASoC: Intel: sof_sdw: Initialize the sof_sdw_quirk with
 RT711_JD_NULL
Date: Fri, 15 Oct 2021 21:34:24 +0800
Message-Id: <20211015133424.494463-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Chris Chiu <chris.chiu@canonical.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

The jd_src of RT711 which is initialized in rt711/rt711_sdca_init
will be overridden by rt711/rt711_sdca_add_codec_device_props when
the sof_sdw_quirk is not RT711_JD_NULL. It will force the JD mode
to RT711_JD1 and cause confusion while debugging the JD mode of
the boards without quirk. Initialize sof_sdw_quirk with RT711_JD_NULL
to honor the jd_src value in rt711/rt711_sdca init.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 sound/soc/intel/boards/sof_sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 6b06248a9327..d05c0565e09c 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -15,7 +15,7 @@
 #include "sof_sdw_common.h"
 #include "../../codecs/rt711.h"
 
-unsigned long sof_sdw_quirk = RT711_JD1;
+unsigned long sof_sdw_quirk = RT711_JD_NULL;
 static int quirk_override = -1;
 module_param_named(quirk, quirk_override, int, 0444);
 MODULE_PARM_DESC(quirk, "Board-specific quirk override");
-- 
2.20.1

