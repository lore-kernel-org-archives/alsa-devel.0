Return-Path: <SRS0=LtCP=G4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32A5C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 08:35:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4B122CAD
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 08:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4B122CAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F29C1821;
	Mon, 25 Jan 2021 09:34:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F29C1821
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611563713;
	bh=OcTjrcHcPykren1SaEfZGH9N/JimYDydXahUm775f1c=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZpCllbn8+VKpHmf+W+3rfMZtjZ9a7l10GXk9OqC0lFtPwABt+Uf/m//54zmL0FH0i
	 aYjtOIuD+rj5n5x1JC+AJ0WA6c5S5mTErJohJvYyZPvha51bTpYhVwB+aDtvxCnzWS
	 Z5ei2nqt2Hdhxpz/F9Syjomj91bE/208JU/C1izE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A13B7F80218;
	Mon, 25 Jan 2021 09:34:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57CDCF80259; Mon, 25 Jan 2021 09:34:20 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D265FF8012D
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2021 09:34:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D265FF8012D
IronPort-SDR: sMjJHJqDyxXzhW2fcQ39m1KpIJ7w1P+KRNp1GH/Vtx/1tq3nyaV31gBSKblXIjg2kpHoOq4Xsx
 druyMLUwFI+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="167362441"
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; d="scan'208";a="167362441"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2021 00:34:07 -0800
IronPort-SDR: pa12ZA2desGrSylV5Sr/Y1HkE1sX0NKAeb8WdvC/S58/Mv43AD6dqubZIW4853tWwJzDNfFYyj
 R44aIbrRwZ9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; d="scan'208";a="361281050"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga008.fm.intel.com with ESMTP; 25 Jan 2021 00:34:03 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH] ALSA: hda: intel-dsp-config: add PCI id for TGL-H
Date: Mon, 25 Jan 2021 10:30:51 +0200
Message-Id: <20210125083051.828205-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Libin Yang <libin.yang@intel.com>, Xiuli Pan <xiuli.pan@intel.com>,
 Bard Liao <bard.liao@intel.com>, kai.vehmanen@linux.intel.com
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

From: Bard Liao <bard.liao@intel.com>

Adding PCI id for TGL-H. Like for other TGL platforms, SOF is used if
Soundwire codecs or PCH-DMIC is detected.

Signed-off-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Xiuli Pan <xiuli.pan@intel.com>
Reviewed-by: Libin Yang <libin.yang@intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/hda/intel-dsp-config.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 6a0d070c60c9..c45686172517 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -307,6 +307,10 @@ static const struct config_entry config_table[] = {
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = 0xa0c8,
 	},
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = 0x43c8,
+	},
 #endif
 
 /* Elkhart Lake */
-- 
2.29.2

