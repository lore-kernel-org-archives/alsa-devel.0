Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5802FC43334
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jul 2022 12:59:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F391171E;
	Wed, 20 Jul 2022 14:58:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F391171E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658321946;
	bh=EDqE5DGnQOdwB7O3igmek0CCkZB1hGt8gzAGeShPI7U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L8Aacq0M0nsTYGuWgqFHX6kHZyu7hCzuDcqHGHOOzsI5PrDVMNC5CiLo3i42qqFNE
	 IBo5JmB5mL4qKW+O3iwC2FIbyE6RYD4YsNW/tLWcLbjNqrhdSdIdIakefGbxEYNcN/
	 x6/utN5SXLhWZiTwTlG1ARuit71yQ2Pou8rO9uAQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50016F8028B;
	Wed, 20 Jul 2022 14:57:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7CAF4F80139; Wed, 20 Jul 2022 14:57:17 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66DA4F80139
 for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2022 14:57:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66DA4F80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="R8VsPIBG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1658321831; x=1689857831;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EDqE5DGnQOdwB7O3igmek0CCkZB1hGt8gzAGeShPI7U=;
 b=R8VsPIBG79jUyFHvzNKQyllJhYaSksKOu8qfy6/2Ipr3GVGErICTwuqJ
 2L0SBMEn8LIZNGvXbTkzgxKCNavxMRsDzK/l3kxeY7I/E0LxJxQsYlZ4M
 QMeBUqHCMXCm584AyAwLxotoPs+5BrK4HsPNl/g4XAUX35fvVion5t4DN
 Pf4dIqjAOMBIYF33F3yziXrpcUVAKgAa7JecWAnc9hfsKsG+43s5P5I3l
 d6dVNx/eNtqXS9uLKmOI9mbHfScRzoUrsb091mxxxac5ncIjluPijveE/
 o9hYX0vY+O38ADj3uR3FcIrwqDnlaQOxnQG+c79OdtuGIxrUinyLma3vQ Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="269797841"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; d="scan'208";a="269797841"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2022 05:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; d="scan'208";a="656259032"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga008.fm.intel.com with ESMTP; 20 Jul 2022 05:57:05 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	tiwai@suse.com
Subject: [PATCH 3/4] ALSA: hda: Always free codec on the device release
Date: Wed, 20 Jul 2022 15:06:21 +0200
Message-Id: <20220720130622.146973-4-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720130622.146973-1-cezary.rojewski@intel.com>
References: <20220720130622.146973-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, kai.vehmanen@linux.intel.com,
 yung-chuan.liao@linux.intel.com, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
 ranjani.sridharan@linux.intel.com, amadeuszx.slawinski@linux.intel.com,
 peter.ujfalusi@linux.intel.com
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

With all HDAudio drivers aligned to make use of the same constructor,
have codec freed on the device release regardless of its type.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/pci/hda/hda_codec.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 7b2e62fa82d5..44395b1b734b 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -883,13 +883,7 @@ static void snd_hda_codec_dev_release(struct device *dev)
 	snd_hda_sysfs_clear(codec);
 	kfree(codec->modelname);
 	kfree(codec->wcaps);
-
-	/*
-	 * In the case of ASoC HD-audio, hda_codec is device managed.
-	 * It will be freed when the ASoC device is removed.
-	 */
-	if (codec->core.type == HDA_DEV_LEGACY)
-		kfree(codec);
+	kfree(codec);
 }
 
 #define DEV_NAME_LEN 31
-- 
2.25.1

