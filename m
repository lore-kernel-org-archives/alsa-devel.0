Return-Path: <SRS0=wAKr=HN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B839C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Feb 2021 08:32:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D1D64E16
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Feb 2021 08:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D1D64E16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 516D516EB;
	Thu, 11 Feb 2021 09:31:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 516D516EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613032363;
	bh=gv6vkDLHoXakratSTOlyvk7lFesVqTQ2YI4nh6VpW0I=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gS0ICwDfVBBLMP2D9QV+n6fX/owKFjMHVoWcPZ9Inkis91GYV9sYkj5L36b1dd/7J
	 0RJXserLUyADA9AMi/O/2IBimfJt7q+qtB5JovKWHjhf0Z3sLYtOU4q+eOr6THCTLK
	 bHLKovs0m4RoIGf2Cdll6WxEibVKW+kQXxOy3DU8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D0630F8016B;
	Thu, 11 Feb 2021 09:31:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EC95BF801D5; Thu, 11 Feb 2021 09:31:50 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 40C0DF80165
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2021 09:31:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40C0DF80165
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EA3B7AD6A;
 Thu, 11 Feb 2021 08:31:41 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/hdmi: Drop bogus check at closing a stream
Date: Thu, 11 Feb 2021 09:31:39 +0100
Message-Id: <20210211083139.29531-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

Some users reported the kernel WARNING with stack traces from
hdmi_pcm_close(), and it's the line checking the per_cvt->assigned
flag.  This used to be a valid check in the past because the flag was
turned on/off only at opening and closing a PCM stream.  Meanwhile,
since the introduction of the silent-stream mode, this flag may be
turned on/off at the monitor connection/disconnection time, which
isn't always associated with the PCM open/close.  Hence this may lead
to the inconsistent per_cvt->assigned flag at closing.

As the check itself became almost useless and confuses users as if it
were a serious problem, just drop the check.

Fixes: b1a5039759cb ("ALSA: hda/hdmi: fix silent stream for first playback to DP")
Cc: <stable@vger.kernel.org>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=210987
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 97adff0cbcab..e405be7929e3 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2130,7 +2130,6 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
 			goto unlock;
 		}
 		per_cvt = get_cvt(spec, cvt_idx);
-		snd_BUG_ON(!per_cvt->assigned);
 		per_cvt->assigned = 0;
 		hinfo->nid = 0;
 
-- 
2.26.2

