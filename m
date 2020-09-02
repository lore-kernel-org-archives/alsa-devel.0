Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E37CC433E7
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:32:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94701207EA
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="i6qHrT2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94701207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E96831733;
	Wed,  2 Sep 2020 23:31:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E96831733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599082367;
	bh=cVt1ytwYmi4GRu+YTKWAOYsDWM/+BgJLmEgriDEZ2ow=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i6qHrT2ZEe7uXTurLn/TPefDIjgn/AC33ieqIHmeRhpm9/kbWVP0daZb9yBp5pz9Y
	 ZCOU7XJUpiKKljO4GX6uOhMo16m03HQQuN//ywXlg7X22XlaSfVpyXCjgNd1tOJmgl
	 RZUmmHf0wTlJ5btzqDo0MhdyrjAjAkkeWfnoTplg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D747F8034D;
	Wed,  2 Sep 2020 23:22:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1FA5F802DD; Wed,  2 Sep 2020 23:22:35 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CEC93F802E7
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 23:22:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CEC93F802E7
IronPort-SDR: LvdstWIZb6we3luQEfDAF8f77vd0D56EWl+NMQJVZI6+bvjGpIgVxRiW7+6Wq6SHYPzvt3YOXI
 WrVjGruwcG9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="157482890"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="157482890"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:22:11 -0700
IronPort-SDR: CWNmw4lv8YHkbgCIbG4RKyJ46jaOkkoVX4XN88LaI5e6sppFQawZGTvYAYSNX/UEfNjS1XanPN
 J0XACPa/yKZw==
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="477798294"
Received: from rnagarat-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.56.27])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:22:10 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 15/18] ALSA: rawmidi: (cosmetic) align function parameters
Date: Wed,  2 Sep 2020 16:21:30 -0500
Message-Id: <20200902212133.30964-16-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902212133.30964-1-pierre-louis.bossart@linux.intel.com>
References: <20200902212133.30964-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, vkoul@kernel.org, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

fix cppcheck:

sound/core/rawmidi.c:1711:49: style:inconclusive: Function
'snd_rawmidi_free' argument 1 names different: declaration 'rawmidi'
definition 'rmidi'. [funcArgNamesDifferent]

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/core/rawmidi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 2a688b711a9a..c78720a3299c 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -35,7 +35,7 @@ module_param_array(amidi_map, int, NULL, 0444);
 MODULE_PARM_DESC(amidi_map, "Raw MIDI device number assigned to 2nd OSS device.");
 #endif /* CONFIG_SND_OSSEMUL */
 
-static int snd_rawmidi_free(struct snd_rawmidi *rawmidi);
+static int snd_rawmidi_free(struct snd_rawmidi *rmidi);
 static int snd_rawmidi_dev_free(struct snd_device *device);
 static int snd_rawmidi_dev_register(struct snd_device *device);
 static int snd_rawmidi_dev_disconnect(struct snd_device *device);
-- 
2.25.1

