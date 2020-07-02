Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3A4C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:43:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62FE8208B8
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eawxvd0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FE8208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EFBA316FB;
	Thu,  2 Jul 2020 21:42:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EFBA316FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593718999;
	bh=nyD54Yr9W2dZbdGgX7hGxPss+qZcWNnzaqXvbLfsrDs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eawxvd0NyrabLVmEmx/9cA/QWOphFWUSI17ri3H8vbHU0kYtTV+/h/C6gMlFDwX7I
	 bPeJe0KyT86cGX6PTvS0e50sgO1vrnH1Q1+j4iw+Brn6ZbQeJn2dDUHaElvMtF5dFH
	 uyJc8oGH6AkpQRJCvsoJE+sbCrPIdwpo/3VgoRIc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 675D7F802F9;
	Thu,  2 Jul 2020 21:37:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A6BCF80305; Thu,  2 Jul 2020 21:36:52 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65591F802C2
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 21:36:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65591F802C2
IronPort-SDR: o4vrAy0WYiTbDQUlYbBQdXdlLGScMEFcLUBJqS/8lR6fmml7bg/1S7cyFEPI+dCVSbJAs8nNdD
 WDHQnbinLgKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="148549352"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="148549352"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:36:24 -0700
IronPort-SDR: zJwd1DeUHkJugSns9KT6jYKfp9UuvoyxI4BnZIJSk/vjR0upE20eCoSmORF6ylLkg/HHSEAa1I
 8BZbt3QcUeSg==
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="482116377"
Received: from dhprice-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.75.219])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:36:24 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 11/23] ASoC: pci/emu10k1: remove "set but not used'
 warnings
Date: Thu,  2 Jul 2020 14:35:52 -0500
Message-Id: <20200702193604.169059-12-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702193604.169059-1-pierre-louis.bossart@linux.intel.com>
References: <20200702193604.169059-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Fix W=1 warnings. Mark variables used for reads as __always_unused.

sound/pci/emu10k1/emu10k1_main.c: In function
‘snd_emu10k1_cardbus_init’:
sound/pci/emu10k1/emu10k1_main.c:626:15: warning: variable ‘value’ set
but not used [-Wunused-but-set-variable]
  626 |  unsigned int value;
      |               ^~~~~
sound/pci/emu10k1/emu10k1_main.c: In function
‘snd_emu1010_load_firmware_entry’:
sound/pci/emu10k1/emu10k1_main.c:656:15: warning: variable
‘write_post’ set but not used [-Wunused-but-set-variable]
  656 |  unsigned int write_post;
      |               ^~~~~~~~~~

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/emu10k1/emu10k1_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 6ff581733a19..bd70e112ffd7 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -623,7 +623,7 @@ static int snd_emu10k1_ecard_init(struct snd_emu10k1 *emu)
 static int snd_emu10k1_cardbus_init(struct snd_emu10k1 *emu)
 {
 	unsigned long special_port;
-	unsigned int value;
+	__always_unused unsigned int value;
 
 	/* Special initialisation routine
 	 * before the rest of the IO-Ports become active.
@@ -653,7 +653,7 @@ static int snd_emu1010_load_firmware_entry(struct snd_emu10k1 *emu,
 	int n, i;
 	int reg;
 	int value;
-	unsigned int write_post;
+	__always_unused unsigned int write_post;
 	unsigned long flags;
 
 	if (!fw_entry)
-- 
2.25.1

