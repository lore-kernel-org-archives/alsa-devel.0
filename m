Return-Path: <SRS0=reWy=25=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5CEC282DD
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jan 2020 18:10:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC3F20656
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jan 2020 18:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="M/DhpoHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC3F20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9529E174D;
	Wed,  8 Jan 2020 19:09:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9529E174D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578506999;
	bh=tm3DC72KQUTnm618pTXABN5kZHKF9Cs6t5TTKTTU0aQ=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=M/DhpoHNohW6gFK3faMTk00kXieqK/ERdyjfPJnOAm9qRkYPeC4VnXpS6PBH45/kR
	 wI+xHJ0ZqmRVCAJ0kOyj1uhIyDAlJbvX2e0wA8OLCap5FELExca0wxmt3qsE9ETiwT
	 Qwy9VikA61GwP7rDERLyGDf+Gp4Pp8SbVIQQaRy0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01A18F80159;
	Wed,  8 Jan 2020 19:09:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1FC4F80116; Wed,  8 Jan 2020 19:09:06 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 034E3F80116
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2020 19:09:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 034E3F80116
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Jan 2020 10:09:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; d="scan'208";a="218134343"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga008.fm.intel.com with ESMTP; 08 Jan 2020 10:08:59 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Wed,  8 Jan 2020 20:08:56 +0200
Message-Id: <20200108180856.5194-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: tiwai@suse.de, kai.vehmanen@linux.intel.com
Subject: [alsa-devel] [PATCH] ALSA: hda: enable regmap internal locking
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

This reverts commit 42ec336f1f9d ("ALSA: hda: Disable regmap
internal locking").

Without regmap locking, there is a race between snd_hda_codec_amp_init()
and PM callbacks issuing regcache_sync(). This was caught by
following kernel warning trace:

<4> [358.080081] WARNING: CPU: 2 PID: 4157 at drivers/base/regmap/regcache.c:498 regcache_cache_only+0xf5/0x130
[...]
<4> [358.080148] Call Trace:
<4> [358.080158]  snd_hda_codec_amp_init+0x4e/0x100 [snd_hda_codec]
<4> [358.080169]  snd_hda_codec_amp_init_stereo+0x40/0x80 [snd_hda_codec]

Suggested-by: Takashi Iwai <tiwai@suse.de>
BugLink: https://gitlab.freedesktop.org/drm/intel/issues/592
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/hda/hdac_regmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index 906b1e20bae0..286361ecd640 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -363,7 +363,6 @@ static const struct regmap_config hda_regmap_cfg = {
 	.reg_write = hda_reg_write,
 	.use_single_read = true,
 	.use_single_write = true,
-	.disable_locking = true,
 };
 
 /**
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
