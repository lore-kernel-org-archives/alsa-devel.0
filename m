Return-Path: <SRS0=j21J=6I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24AAC54FCB
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:29:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4717820776
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UTHWj8Hl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sU4o6L8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4717820776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9EFD016D3;
	Fri, 24 Apr 2020 14:29:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9EFD016D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587731390;
	bh=pMqn90zSLuinAulgtyctkWr6XEJcoU/Ruk4AMucCENI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UTHWj8HlSNiuk4AD++hnB7EVQiWeaUO+4CCAE9jgIMglYVN8ha7WAe8VZ8YQf3XOt
	 hPChqXS2ZlxobYKl2KcrYnk0EvPXOHgOoNNNFwRHsFdLv/Vy2qkWeBnrKjzvqS6rwP
	 PbFw0vA14dpAooDpphnBJ9Tex40K2Wo8lUxKxNwk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EB43F802EB;
	Fri, 24 Apr 2020 14:24:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9776BF802F7; Fri, 24 Apr 2020 14:24:07 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2F97F802E7
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 14:24:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2F97F802E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="sU4o6L8d"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9ABAB2087E;
 Fri, 24 Apr 2020 12:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587731043;
 bh=pMqn90zSLuinAulgtyctkWr6XEJcoU/Ruk4AMucCENI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sU4o6L8dFuEP8os7aFmugsqPnwGw6DNyDupSJqy273VnEy2tRzifai/ICNmYxgZFh
 dBvDPINYlXhgfpagnAj3CAVj+yQshy6sPfwxnm3UnMcPfMJMRDRlkCrYX/jAxTqLAg
 1dsaEqZ1qkamS9j2I3tRXf5DD292CtUA55UsCfJk=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 06/18] ALSA: hda: Explicitly permit using
 autosuspend if runtime PM is supported
Date: Fri, 24 Apr 2020 08:23:43 -0400
Message-Id: <20200424122355.10453-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122355.10453-1-sashal@kernel.org>
References: <20200424122355.10453-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Roy Spliet <nouveau@spliet.org>
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

From: Roy Spliet <nouveau@spliet.org>

[ Upstream commit 3ba21113bd33d49f3c300a23fc08cf114c434995 ]

This fixes runtime PM not working after a suspend-to-RAM cycle at least for
the codec-less HDA device found on NVIDIA GPUs.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207043
Signed-off-by: Roy Spliet <nouveau@spliet.org>
Link: https://lore.kernel.org/r/20200413082034.25166-7-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b993b652ead81..b2b2dba6d5f01 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2476,8 +2476,10 @@ static int azx_probe_continue(struct azx *chip)
 
 	set_default_power_save(chip);
 
-	if (azx_has_pm_runtime(chip))
+	if (azx_has_pm_runtime(chip)) {
+		pm_runtime_use_autosuspend(&pci->dev);
 		pm_runtime_put_autosuspend(&pci->dev);
+	}
 
 out_free:
 	if ((chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
-- 
2.20.1

