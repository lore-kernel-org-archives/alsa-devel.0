Return-Path: <SRS0=zNzy=JG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A60EC433ED
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 21:47:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D421061165
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 21:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D421061165
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 715AC165E;
	Fri,  9 Apr 2021 23:46:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 715AC165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618004861;
	bh=RhCrKmOUrCbiW8OPSk9AMAV2tgmgNC1DVJQpPLgZBY8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VZY4sblEKab78TziBLjxZjVJITMiJ5NX7UtUxwJN4CUp+aNjCYE839I8BxZA33u/Q
	 aj+kJcSYlSE/ZIQ++owA4Vv4nn6uBv7jEYxxwHfM7xKoU5eNNrAdc/2X3T7n010dNg
	 TAC5+xUNJptN7JyX0VtjNXFueGkI4PKRwcZ05BBU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5EF4F80168;
	Fri,  9 Apr 2021 23:46:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07C49F8016A; Fri,  9 Apr 2021 23:46:49 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 871B4F80162
 for <alsa-devel@alsa-project.org>; Fri,  9 Apr 2021 23:46:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 871B4F80162
IronPort-SDR: bOSN5VXJ8F19UZREtaZO+FbbS1m2FSMHNcedWMAwTqPnxFhM5+0kxdoFaaOI+PmsXs2fZh3AOQ
 ZvYUv+C06APg==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="214282866"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; d="scan'208";a="214282866"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 14:46:25 -0700
IronPort-SDR: CBhPTMpUnqqR9m7kMhjsv+++p2eAwUPmGt5eFQfFj6jF4qFn1OQa4pfJjwsENZraHlHqKMVdqB
 LEOEX6eXYY0A==
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; d="scan'208";a="531138879"
Received: from drlopezi-mobl2.amr.corp.intel.com (HELO
 rsridh-mobl1.localdomain) ([10.255.64.121])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 14:46:25 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: HDA: Add access description in __snd_hda_add_vmaster
Date: Fri,  9 Apr 2021 14:46:16 -0700
Message-Id: <20210409214616.1539685-1-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

Add description for access parameter in __snd_hda_add_vmaster()
to prevent the compilation warning:
warning: Function parameter or member 'access' not described in '__snd_hda_add_vmaster'

Fixes: e65bf99718b5 ("ALSA: HDA - remove the custom implementation for the audio LED trigger")
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/pci/hda/hda_codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index e54e39b35709..a31009afc025 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1938,6 +1938,7 @@ static int add_follower(struct hda_codec *codec,
  * @followers: follower control names (optional)
  * @suffix: suffix string to each follower name (optional)
  * @init_follower_vol: initialize followers to unmute/0dB
+ * @access: kcontrol access rights
  * @ctl_ret: store the vmaster kcontrol in return
  *
  * Create a virtual master control with the given name.  The TLV data
-- 
2.25.1

