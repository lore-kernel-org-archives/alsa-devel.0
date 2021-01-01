Return-Path: <SRS0=z4jS=GE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B6DC433DB
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Jan 2021 08:40:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6DC21707
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Jan 2021 08:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6DC21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5DBE316A4;
	Fri,  1 Jan 2021 09:39:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5DBE316A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609490399;
	bh=KXCliTDenGFnIpd5YWwkCeNWkEcPEALu9P65yrjuK8w=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VwaTKTYF8SQA5F9fBJHLe4u4/UauJ+AwRWsv/c7cFkVdnTFd0hUDvj7AQk8PURaeB
	 Wi8iexJapXJ6eYBH00zd4enmQcDuFpSp3dWhmuFstkxUhfjLK+lVlkKhLwUvTLLBpo
	 OvzZ+dQSlffP/r5PW1gTPo2r0rk1Lbr8TKbOqbys=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 644C2F801ED;
	Fri,  1 Jan 2021 09:39:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F2027F801F5; Fri,  1 Jan 2021 09:39:04 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88830F8015F
 for <alsa-devel@alsa-project.org>; Fri,  1 Jan 2021 09:38:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 88830F8015F
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9F40FB750;
 Fri,  1 Jan 2021 08:38:53 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/hdmi: Fix incorrect mutex unlock in
 silent_stream_disable()
Date: Fri,  1 Jan 2021 09:38:52 +0100
Message-Id: <20210101083852.12094-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jan Alexander Steffens <heftig@archlinux.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

The silent_stream_disable() function introduced by the commit
b1a5039759cb ("ALSA: hda/hdmi: fix silent stream for first playback to
DP") takes the per_pin->lock mutex, but it unlocks the wrong one,
spec->pcm_lock, which causes a deadlock.  This patch corrects it.

Fixes: b1a5039759cb ("ALSA: hda/hdmi: fix silent stream for first playback to DP")
Reported-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 1e4a4b83fbf6..74d246a0dc6d 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1733,7 +1733,7 @@ static void silent_stream_disable(struct hda_codec *codec,
 	per_pin->silent_stream = false;
 
  unlock_out:
-	mutex_unlock(&spec->pcm_lock);
+	mutex_unlock(&per_pin->lock);
 }
 
 /* update ELD and jack state via audio component */
-- 
2.26.2

