Return-Path: <SRS0=5/d5=AO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8C4C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:40:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38AC32088E
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QZAm1JrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AC32088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7617B16D0;
	Fri,  3 Jul 2020 17:39:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7617B16D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593790841;
	bh=molUF03mWRvXdel02GNQ2lC7qogfqF7DoNmjHKBEV/M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QZAm1JrMwrmt6WHMnGH3uXR0YBZvSq4zZPQym5NLYcNwY3nIlgix+Z1A41LsCcJ9h
	 hrT+Iq1KQ+HgGktiFO6BneUnJ+Fl72Ohgc6V8L1CQ1eB964csG04NiiMJgt07H0a3I
	 +tA/7NxZmxAyj+JynyYT8eXCPed8+DJOB+1gp5jo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86C32F8025F;
	Fri,  3 Jul 2020 17:39:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6A25F800ED; Fri,  3 Jul 2020 17:38:58 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82E8BF800ED
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2020 17:38:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82E8BF800ED
IronPort-SDR: 90ijNyic57t6faDWorbyVuNuRKthp1DrCxRbks1VHxCeBNWXeea2/kevW577rs0z75yktx5ZjP
 1fpzcxGboBYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9671"; a="126772414"
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; d="scan'208";a="126772414"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2020 08:38:49 -0700
IronPort-SDR: Vdnf19Fhe+WO5OXgDLZelzv/X75fG7m4dPIApunDOVmYp8vq3VCZMaa4pmnj38Md9qUGsglk54
 oUge4GT/FXfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; d="scan'208";a="282322758"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga006.jf.intel.com with ESMTP; 03 Jul 2020 08:38:48 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH 2/2] ALSA: hda/hdmi: improve debug traces for stream lookups
Date: Fri,  3 Jul 2020 18:38:18 +0300
Message-Id: <20200703153818.2808592-2-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703153818.2808592-1-kai.vehmanen@linux.intel.com>
References: <20200703153818.2808592-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: libin.yang@linux.intel.com,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 kai.vehmanen@linux.intel.com,
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

The HDMI codec driver has two debug traces printed from different
functions but with identical message content:

"HDMI: hinfo 000000006a6b84d9 not registered"

Fix this duplication and also add a bit more context in addition to raw
object pointer, to help analysis of kernel logs.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 295cc5a989d5..41eaa89660c3 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -259,7 +259,7 @@ static int hinfo_to_pcm_index(struct hda_codec *codec,
 		if (get_pcm_rec(spec, pcm_idx)->stream == hinfo)
 			return pcm_idx;
 
-	codec_warn(codec, "HDMI: hinfo %p not registered\n", hinfo);
+	codec_warn(codec, "HDMI: hinfo %p not tied to a PCM\n", hinfo);
 	return -EINVAL;
 }
 
@@ -277,7 +277,8 @@ static int hinfo_to_pin_index(struct hda_codec *codec,
 			return pin_idx;
 	}
 
-	codec_dbg(codec, "HDMI: hinfo %p not registered\n", hinfo);
+	codec_dbg(codec, "HDMI: hinfo %p (pcm %d) not registered\n", hinfo,
+		  hinfo_to_pcm_index(codec, hinfo));
 	return -EINVAL;
 }
 
-- 
2.27.0

