Return-Path: <SRS0=30sX=ZH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A27C432C3
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:47:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CEF32072D
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sbWFzZNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEF32072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F190167A;
	Fri, 15 Nov 2019 13:46:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F190167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573822054;
	bh=p5yh3iVJiXk/j7970wUfDeC1eGv8JIA4EEwwmleuHtQ=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sbWFzZNkLhShB8aVlncSMU8011KxvoEZt1KKMq7SLIIil7AXq4SSB6YyhgF/MVDdD
	 EgbHtZcs8f871YSe+KbVEirC426ExoD4Lg/16zIKDXRDE20z/iOWSpz3F8+6z5hXv2
	 dHYXDDB1JRl+V4JlhXGn1rOjiiax/ndxLe45VI1I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28397F8010C;
	Fri, 15 Nov 2019 13:45:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F1BFF8010A; Fri, 15 Nov 2019 13:45:05 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37E65F80103
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2019 13:45:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37E65F80103
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Nov 2019 04:44:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; d="scan'208";a="214772944"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2019 04:44:57 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Date: Fri, 15 Nov 2019 14:44:48 +0200
Message-Id: <20191115124449.20512-3-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115124449.20512-1-kai.vehmanen@linux.intel.com>
References: <20191115124449.20512-1-kai.vehmanen@linux.intel.com>
Cc: yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 kai.vehmanen@linux.intel.com
Subject: [alsa-devel] [PATCH 2/3] ALSA: hda: hdmi - remove redundant code
	comments
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Remove unnecessary comments related to pin mapping on
Intel platforms.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index dec90f931bae..d3768767625e 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2655,7 +2655,7 @@ static int intel_pin2port(void *audio_ptr, int pin_nid)
 		base_nid = intel_base_nid(codec);
 		if (WARN_ON(pin_nid < base_nid || pin_nid >= base_nid + 3))
 			return -1;
-		return pin_nid - base_nid + 1; /* intel port is 1-based */
+		return pin_nid - base_nid + 1;
 	}
 
 	/*
@@ -2667,7 +2667,6 @@ static int intel_pin2port(void *audio_ptr, int pin_nid)
 			return i;
 	}
 
-	/* return -1 if pin number exceeds our expectation */
 	codec_info(codec, "Can't find the HDMI/DP port for pin %d\n", pin_nid);
 	return -1;
 }
@@ -2680,7 +2679,6 @@ static int intel_port2pin(struct hda_codec *codec, int port)
 		/* we assume only from port-B to port-D */
 		if (port < 1 || port > 3)
 			return 0;
-		/* intel port is 1-based */
 		return port + intel_base_nid(codec) - 1;
 	}
 
@@ -2856,7 +2854,6 @@ static int patch_i915_tgl_hdmi(struct hda_codec *codec)
 	return intel_hsw_common_init(codec, 0x02, map, ARRAY_SIZE(map));
 }
 
-
 /* Intel Baytrail and Braswell; with eld notifier */
 static int patch_i915_byt_hdmi(struct hda_codec *codec)
 {
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
