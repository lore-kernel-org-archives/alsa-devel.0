Return-Path: <SRS0=g50q=C3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DFFC43463
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 02:04:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27822311D
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 02:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qbIk91jE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2M8ZSs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27822311D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15EC8168C;
	Fri, 18 Sep 2020 04:03:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15EC8168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600394657;
	bh=kvljy/+dKd5hVOBCgeK3ADPEBHeF/kDaMYGcYzXQcjA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qbIk91jEQC0uKdFkoNV7Z011cy/YzH5QzlhRlGi1jU5Rh+DDGbbE6fVA5AHaZlw/t
	 Iuxste5X7HdQ5UHcX6QvcZOz3yq5m+NE3hZmCBV/xGdTFdw+bBX9xZaGMImLS5h5MY
	 wvfKmdBfL2ytajLWtnDQZ7VZO5PkDKOKsTnXii3A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4EAFAF8015D;
	Fri, 18 Sep 2020 04:02:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CA2ACF802A7; Fri, 18 Sep 2020 04:02:51 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50410F8015C
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2020 04:02:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50410F8015C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="h2M8ZSs8"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 21EF722211;
 Fri, 18 Sep 2020 02:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600394564;
 bh=kvljy/+dKd5hVOBCgeK3ADPEBHeF/kDaMYGcYzXQcjA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h2M8ZSs8dPKaXlTLyyqTSsGcztx/u+DBwbR4YMLdG6fuDvwcK6Kyb+/+SfovXKFu+
 1dOKpJ7jLpcTY4oL1HLSz5LQmjVYeaVhhDfmBe7lsK1M+BqV56oOi5fNwemUKyWuvs
 quve2Hk4vh/sty9gVDcSRF2ljJ5ZPVqmTFNeDGsA=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 077/330] ALSA: hda: enable regmap internal locking
Date: Thu, 17 Sep 2020 21:56:57 -0400
Message-Id: <20200918020110.2063155-77-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918020110.2063155-1-sashal@kernel.org>
References: <20200918020110.2063155-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit 8e85def5723eccea30ebf22645673692ab8cb3e2 ]

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
Link: https://lore.kernel.org/r/20200108180856.5194-1-kai.vehmanen@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/hdac_regmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index 2596a881186fa..49780399c2849 100644
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
2.25.1

