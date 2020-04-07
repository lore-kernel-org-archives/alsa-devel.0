Return-Path: <SRS0=QmEo=5X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7FFC2BA16
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:45:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59EE820719
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VdVlRKaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59EE820719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9AAAF852;
	Tue,  7 Apr 2020 10:44:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9AAAF852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586249101;
	bh=V6/YnalBLhDl9O1S2d3od2BRPY3nSSzSWsIkB9ZQz8Q=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VdVlRKaq/JGzS1fpqzrIGM//l+DnqIRmlquTtpUpb5Z4BMt/n8KoUjlm8UTt3uPKc
	 9BLpJBwLMB8CbMwR0EdHWfVtzf6NdXY0aQ0hS+PG5AGH2Uni9EEH6xpEeau4SG+mLr
	 KnG/hY+LGX5tAx7xjHkvC/oBAFyNCaEdlG7Z4tD8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B6A3F801D8;
	Tue,  7 Apr 2020 10:44:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9BA77F80213; Tue,  7 Apr 2020 10:44:09 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18680F801D8
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2020 10:44:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18680F801D8
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 264F9AEA3
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2020 08:44:03 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ALSA: hda: Fix potential access overflow in beep helper
Date: Tue,  7 Apr 2020 10:44:01 +0200
Message-Id: <20200407084402.25589-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200407084402.25589-1-tiwai@suse.de>
References: <20200407084402.25589-1-tiwai@suse.de>
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

The beep control helper function blindly stores the values in two
stereo channels no matter whether the actual control is mono or
stereo.  This is practically harmless, but it annoys the recently
introduced sanity check, resulting in an error when the checker is
enabled.

This patch corrects the behavior to store only on the defined array
member.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207139
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_beep.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index f5fd62ed4df5..841523f6b88d 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -290,8 +290,12 @@ int snd_hda_mixer_amp_switch_get_beep(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct hda_beep *beep = codec->beep;
+	int chs = get_amp_channels(kcontrol);
+
 	if (beep && (!beep->enabled || !ctl_has_mute(kcontrol))) {
-		ucontrol->value.integer.value[0] =
+		if (chs & 1)
+			ucontrol->value.integer.value[0] = beep->enabled;
+		if (chs & 2)
 			ucontrol->value.integer.value[1] = beep->enabled;
 		return 0;
 	}
-- 
2.25.0

