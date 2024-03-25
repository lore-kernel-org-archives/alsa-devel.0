Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E50C54E58
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Mar 2024 22:19:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9BE9C23E3;
	Mon, 25 Mar 2024 23:19:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9BE9C23E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711405189;
	bh=kd/auYdKSh0XhuIhPDGz+jnB9z4PlnfnynJ81G4qQKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PkJr9h91/BhFKSaKUZcgrLmFZOad1+zy7L5N59J4TTxMRyjGWqXJMAHneFXthPLtO
	 FDlK6+2a7Wl8B5eO2K6X7kCC20/ZR/wrcVaLkUAVfulNN7HlmVVFxjCgT6hHylFX8t
	 Bu3acxLdm/7yoBQHyXzutb+b5VgmF0GIBTGc0MCc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ABFEBF805FF; Mon, 25 Mar 2024 23:18:57 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AEB4AF805F9;
	Mon, 25 Mar 2024 23:18:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A20A4F8059F; Mon, 25 Mar 2024 23:18:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 48DCCF80564
	for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2024 23:18:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48DCCF80564
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kXE3AVfN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711405118; x=1742941118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kd/auYdKSh0XhuIhPDGz+jnB9z4PlnfnynJ81G4qQKc=;
  b=kXE3AVfN3Fqs5GHPtfpohy7+NUB1dxzqyNxwT4l1MBIAUHiZW5OvX5SF
   cvqDAu2oE3r1a2C6VHnrJ+CuUxqgJIJzGWktqL2wsuDBINx8aVj68rQw7
   KnOpsTB5xC23xzP20BFIdTgYLtd4uzE07LBM7i05E9P4hUPLe7vtd6544
   3fcSjOWT+4F1nouDBIwGoKssS/pL0hMdRChAVDMmIlUtpQcPSizSLGmqG
   KfH2ZSYtrLyWhIPnsD5cDkhjpF9dY2s5KGwmV6XpEuyCCoPeyQkfcm04D
   2VmnngB6thYwkI/gGXRIJOer6RppZSA3aGKnwgLJvMnMBY/Yt/dLXEm0G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6300384"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000";
   d="scan'208";a="6300384"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2024 15:18:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000";
   d="scan'208";a="20309648"
Received: from jaimbres-mobl2.amr.corp.intel.com (HELO pbossart-mobl6.lan)
 ([10.212.98.109])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2024 15:18:33 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Chao Song <chao.song@linux.intel.com>
Subject: [PATCH 5/6] ASoC: rt722-sdca-sdw: fix locking sequence
Date: Mon, 25 Mar 2024 17:18:16 -0500
Message-Id: <20240325221817.206465-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240325221817.206465-1-pierre-louis.bossart@linux.intel.com>
References: <20240325221817.206465-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QAJLFWUNGJZMOWHH2MRDK4ZZD27HR24D
X-Message-ID-Hash: QAJLFWUNGJZMOWHH2MRDK4ZZD27HR24D
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QAJLFWUNGJZMOWHH2MRDK4ZZD27HR24D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The disable_irq_lock protects the 'disable_irq' value, we need to lock
before testing it.

Fixes: a0b7c59ac1a9 ("ASoC: rt722-sdca: fix for JD event handling in ClockStop Mode0")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Chao Song <chao.song@linux.intel.com>
---
 sound/soc/codecs/rt722-sdca-sdw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt722-sdca-sdw.c b/sound/soc/codecs/rt722-sdca-sdw.c
index eb76f4c675b6..65d584c1886e 100644
--- a/sound/soc/codecs/rt722-sdca-sdw.c
+++ b/sound/soc/codecs/rt722-sdca-sdw.c
@@ -467,13 +467,13 @@ static int __maybe_unused rt722_sdca_dev_resume(struct device *dev)
 		return 0;
 
 	if (!slave->unattach_request) {
+		mutex_lock(&rt722->disable_irq_lock);
 		if (rt722->disable_irq == true) {
-			mutex_lock(&rt722->disable_irq_lock);
 			sdw_write_no_pm(slave, SDW_SCP_SDCA_INTMASK1, SDW_SCP_SDCA_INTMASK_SDCA_6);
 			sdw_write_no_pm(slave, SDW_SCP_SDCA_INTMASK2, SDW_SCP_SDCA_INTMASK_SDCA_8);
 			rt722->disable_irq = false;
-			mutex_unlock(&rt722->disable_irq_lock);
 		}
+		mutex_unlock(&rt722->disable_irq_lock);
 		goto regmap_sync;
 	}
 
-- 
2.40.1

