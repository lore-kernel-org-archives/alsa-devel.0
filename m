Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0CEF54AD9
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:38:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 418EB601F3;
	Tue, 24 Mar 2026 17:38:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 418EB601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774370303;
	bh=yi4Fvg7FkqCtqvd+hXTce1vKAWL/DOSxHSGVeeD7pIo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=otuomT1ZWBRX1HlWLcg4vaERvWtg4sBNZUy/8i+bboAoUncumeaqkWt6xmJHG+mgG
	 BsGcNib4gZCI97fqv38iEHcsNreQPWnyY2Gcwhp+2uvr8/POzJoqFMsV7hospZiRpa
	 gUOJKxKrzb7ob1LfcFBiIreyoRaAi+wHd41+oWI0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08C6DF805F1; Tue, 24 Mar 2026 17:37:49 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CE23F805F4;
	Tue, 24 Mar 2026 17:37:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A11DCF805BA; Tue, 24 Mar 2026 17:37:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1FB73F8011B
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2026 17:37:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1FB73F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SzX4blyn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774370259; x=1805906259;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yi4Fvg7FkqCtqvd+hXTce1vKAWL/DOSxHSGVeeD7pIo=;
  b=SzX4blynZi9QYFAStLn74WppmIsCHfq2FSzL5dncM6gq0+g+Lm2M3Aa5
   oWjDskAaMo5hjOXDsn6pXlnRS8nJdA4Tcue5uWrHcriSXHOq0p8dlpcKo
   lb1OvcKJ/j1krJZ47XkWU5T5IGZQTK5mpB2Mb7mVVp7J4/ZzAOl4ajSg4
   QV/RsaDicv+71r64AYSviufns4LYhtruyzjFyladtStU0G18KWqVJSHM2
   UvNj1SNx+n49wDya/D2pRcNqD+kFEcHisxSNibrJjhNapphtKG6jC3VbV
   6dRJG3IhL/RvBol0HX41h3ynKUd88k1kff+RyxNA1aTo2Fx9TLaaGC5on
   Q==;
X-CSE-ConnectionGUID: 0ZOFytpRRpGZz22tUle8zA==
X-CSE-MsgGUID: W2PfV8P3TQi6OavSU0U56w==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="62945783"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000";
   d="scan'208";a="62945783"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 09:37:33 -0700
X-CSE-ConnectionGUID: +tI5957mRkWd/rySzSs9HQ==
X-CSE-MsgGUID: QLPb9+6hTMqV4BuZjTrICA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000";
   d="scan'208";a="229322971"
Received: from jpp-desktop.igk.intel.com ([10.91.221.24])
  by orviesa005.jf.intel.com with ESMTP; 24 Mar 2026 09:37:32 -0700
From: Sachin Mokashi <sachin.mokashi@intel.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	Sachin Mokashi <sachin.mokashi@intel.com>
Subject: [PATCH] ASoC: Intel: ehl_rt5660: remove unused macro definitions
Date: Tue, 24 Mar 2026 12:34:00 -0400
Message-Id: <20260324163400.1276247-1-sachin.mokashi@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 5TXGHWX666NDFLU4J2QODTI37XBCD6CX
X-Message-ID-Hash: 5TXGHWX666NDFLU4J2QODTI37XBCD6CX
X-MailFrom: sachin.mokashi@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5TXGHWX666NDFLU4J2QODTI37XBCD6CX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

DUAL_CHANNEL and NAME_SIZE macros are not being used (anymore) but the
macros are still defined. Remove them to clean up dead code.

Signed-off-by: Sachin Mokashi <sachin.mokashi@intel.com>
---
 sound/soc/intel/boards/ehl_rt5660.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/boards/ehl_rt5660.c b/sound/soc/intel/boards/ehl_rt5660.c
index 5c7b218f22b7..ec4825064436 100644
--- a/sound/soc/intel/boards/ehl_rt5660.c
+++ b/sound/soc/intel/boards/ehl_rt5660.c
@@ -23,10 +23,8 @@
 #include "hda_dsp_common.h"
 #include "../../codecs/rt5660.h"
 
-#define DUAL_CHANNEL 2
 #define HDMI_LINK_START 3
 #define HDMI_LINE_END 6
-#define NAME_SIZE	32
 #define IDISP_CODEC_MASK	0x4
 
 struct sof_card_private {
-- 
2.34.1

Intel Deutschland GmbH
Registered Address: Dornacher Strasse 1, 85622 Feldkirchen, Germany
Tel: +49 89 991 430, www.intel.de
Managing Directors: Harry Demas, Jeffrey Schneiderman, Yin Chong Sorrell
Chairperson of the Supervisory Board: Nicole Lau
Registered Seat: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

