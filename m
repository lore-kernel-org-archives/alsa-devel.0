Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B07C25B78
	for <alsa-devel@archiver.kernel.org>; Mon, 27 May 2024 19:42:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E979EC7;
	Mon, 27 May 2024 21:42:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E979EC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1716838952;
	bh=ukarTAUvz5kRDAKuBIB3Tbzq5NS+8cQH9p792UOeg9A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=mX1Jd+YS8ydb1zTu9tOWuUlB9cDXWC4njN+TSj6IpHTmJECosYr373l6BBPXfCsHR
	 Txd6+y6hVdLZhFpEKIFiVMh3ICLEvrZKY9GJIPM4I9zJVJPJpPHyv0S4cBCKgUT7Zp
	 JfHxbf76lMqUUePxN2vBu90Z8hyr2l0TFNoyWnEk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EE28CF806B2; Mon, 27 May 2024 21:39:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 91752F805A1;
	Mon, 27 May 2024 21:39:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CE214F8055C; Mon, 27 May 2024 21:39:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D9AA0F8051E
	for <alsa-devel@alsa-project.org>; Mon, 27 May 2024 21:39:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9AA0F8051E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=TkucMq/H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716838790; x=1748374790;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ukarTAUvz5kRDAKuBIB3Tbzq5NS+8cQH9p792UOeg9A=;
  b=TkucMq/HrneLlttrr9/LXbB5ot9XK2Gto8/5208jRxMmWJIgFLWgYSmO
   WxCcIB5X0376vKmMV9Ot1+G0d9WTYS9zzc/43n8msXydNM8X/AvDqB6rx
   Pw95xrM2zaOvWVwyTKafEuMYmEI4wDv+fKGFOaAYDzlv65373OB45McQ1
   ejPVdCOEohskEKNgHxzcvneV6+mnWUf1H+23cZXUKtH5DQg7EEVWCwnaQ
   IQd0BLdfp5ntE5OeuO4inhxM9df6HyHsfKP58FeC52XN5ZdNYBbyNF8AS
   J5R3PGKANdPIwxhYGB7ylaGNTOfgbpbxBrcqtycGe204Ld7j3H6F3SOap
   g==;
X-CSE-ConnectionGUID: +cJskWD/TkSYql0CqbfoVA==
X-CSE-MsgGUID: Abx9QvAjRuC3kuPwRQaG9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="38550737"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000";
   d="scan'208";a="38550737"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 12:39:46 -0700
X-CSE-ConnectionGUID: AGd9GxHsTy+9Cc27GOdLmg==
X-CSE-MsgGUID: Walrv7KbT4etmdIdH6fuHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000";
   d="scan'208";a="34733865"
Received: from unknown (HELO pbossart-mobl6.lan) ([10.125.110.221])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 12:39:46 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH] ASoC: SOF: Intel: hda: print PCI class info only once
Date: Mon, 27 May 2024 14:39:36 -0500
Message-ID: <20240527193936.165702-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: N5Q7P2HN2G4L6JE66ZAP2SSUIBMHSLJJ
X-Message-ID-Hash: N5Q7P2HN2G4L6JE66ZAP2SSUIBMHSLJJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N5Q7P2HN2G4L6JE66ZAP2SSUIBMHSLJJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

With the deferred probe mechanism used by the gfx/display subsystem,
we see this message repeated for no good reason. Print the information
only once.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index e6a38de0a0aa..541c6052d4ed 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -783,8 +783,8 @@ int hda_dsp_probe_early(struct snd_sof_dev *sdev)
 				pci->class);
 			return -ENODEV;
 		}
-		dev_info(sdev->dev, "DSP detected with PCI class/subclass/prog-if 0x%06x\n",
-			 pci->class);
+		dev_info_once(sdev->dev, "DSP detected with PCI class/subclass/prog-if 0x%06x\n",
+			      pci->class);
 	}
 
 	chip = get_chip_info(sdev->pdata);
-- 
2.43.0

