Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B22DC43463
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:43:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89ED12076B
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Z7/XIQXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89ED12076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7EFD516D8;
	Mon, 21 Sep 2020 11:42:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7EFD516D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600681388;
	bh=B3qHzv8jepTqqtjcUxVken1ow7lYiFfz/kOfXkxpVy0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Z7/XIQXao7YxngPnRm67ACTGLK4LhOE9j0+9Vl9S1wcGkq1tiWS+Lv0HRPssClq7e
	 B30vOMwOwnnnDs2ylpmJXXukClqwaqHw1MoOXgT9vaaxf+G56jU/zTyiihhQrIUjX4
	 zzpzjyNyC7RyWP/Q1QAz5ndmBYNonwNl1pRdFybI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0FAA5F80161;
	Mon, 21 Sep 2020 11:42:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 168CCF80162; Mon, 21 Sep 2020 11:42:17 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CFF3FF800B2;
 Mon, 21 Sep 2020 11:42:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CFF3FF800B2
IronPort-SDR: GFq13eg7KolFXSrIFA0rbQnApGQ8claLHbx7JwHOgWyuQo2CMHwekTH2Tq1hjN1poAuPbblVRq
 KzDHdBneXAng==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="160396196"
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="160396196"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 02:42:03 -0700
IronPort-SDR: fhVbYOG2nYAfy4JXaW2Rc5wOkcpbs+PxrMAFXRZtxS3V/EVp29TXKz6SpjLYXJdao2tmz5OdZW
 QZ+BvV+Ib7Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="509914950"
Received: from pharlozi-hp-elitedesk.igk.intel.com ([10.237.149.38])
 by fmsmga006.fm.intel.com with ESMTP; 21 Sep 2020 02:42:01 -0700
From: Pawel Harlozinski <pawel.harlozinski@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 1/1] ALSA: hda: Refactor calculating SDnFMT according to
 specification
Date: Mon, 21 Sep 2020 11:42:00 +0200
Message-Id: <20200921094200.10126-1-pawel.harlozinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: cezary.rojewski@intel.com, patch@alsa-project.org,
 kai.vehmanen@linux.intel.com, tiwai@suse.de, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, broonie@kernel.org,
 amadeuszx.slawinski@linux.intel.com,
 Pawel Harlozinski <pawel.harlozinski@linux.intel.com>
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

Fix setting SDnFMT based on High Definition Audio Specification Rev. 1.0a page 48.

Bits per Sample (BITS):
000 = 8 bits. The data will be packed in memory in 8-bit containers on 16-bit boundaries.
001 = 16 bits. The data will be packed in memory in 16-bit containers on 16-bit boundaries.
010 = 20 bits. The data will be packed in memory in 32-bit containers on 32-bit boundaries.
011 = 24 bits. The data will be packed in memory in 32-bit containers on 32-bit boundaries.
100 = 32 bits. The data will be packed in memory in 32-bit containers on 32-bit boundaries.
101-111 = Reserved

Set SDnFMT depending on which format was given.
Henceforth split cases for formats 20, 24, 32 bits,
but leave constraints to maxbps.

Change-Id: I97771b16da14e85b7f35372f5dfc87bb13bb5ce0
Signed-off-by: Pawel Harlozinski <pawel.harlozinski@linux.intel.com>
---
 sound/hda/hdac_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 3e9e9ac804f6..ccc47a10ba63 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -764,7 +764,14 @@ unsigned int snd_hdac_calc_stream_format(unsigned int rate,
 		val |= AC_FMT_BITS_16;
 		break;
 	case 20:
+		val |= AC_FMT_BITS_20;
+		break;
 	case 24:
+		if (maxbps >= 24)
+			val |= AC_FMT_BITS_24;
+		else
+			val |= AC_FMT_BITS_20;
+		break;
 	case 32:
 		if (maxbps >= 32 || format == SNDRV_PCM_FORMAT_FLOAT_LE)
 			val |= AC_FMT_BITS_32;
-- 
2.17.1

