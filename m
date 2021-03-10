Return-Path: <SRS0=4IlU=II=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE18C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 11:30:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A3C64FE1
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 11:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A3C64FE1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9180D1782;
	Wed, 10 Mar 2021 12:29:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9180D1782
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615375818;
	bh=lfITUwJV9tNOR0VL8kVJxYzsYz9bFdzbng4ak0o3bjs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cOhZXS3bVZAOsmQ0DkhQq56TN9TJedFYKl/r6oU2qK6KvwI7y7H9OT6EQfOrfQBsx
	 xzSnMjqLXMSkP9zigx3aeljniCS+40+e1vN3SsJJ1sSu6FqN7CiHJ4l+lQzbFNBc8p
	 FEtmd1qUlsmHqViFzCH19enZQkLnELoXcU+svaNA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE5D9F8028D;
	Wed, 10 Mar 2021 12:28:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7BB98F801ED; Wed, 10 Mar 2021 12:28:31 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB75FF8016C
 for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2021 12:28:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB75FF8016C
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 79FCAAEB9;
 Wed, 10 Mar 2021 11:28:15 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/3] ALSA: hda: Avoid spurious unsol event handling during
 S3/S4
Date: Wed, 10 Mar 2021 12:28:08 +0100
Message-Id: <20210310112809.9215-3-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210310112809.9215-1-tiwai@suse.de>
References: <20210310112809.9215-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Abhishek Sahu <abhsahu@nvidia.com>
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

When HD-audio bus receives unsolicited events during its system
suspend/resume (S3 and S4) phase, the controller driver may still try
to process events although the codec chips are already (or yet)
powered down.  This might screw up the codec communication, resulting
in CORB/RIRB errors.  Such events should be rather skipped, as the
codec chip status such as the jack status will be fully refreshed at
the system resume time.

Since we're tracking the system suspend/resume state in codec
power.power_state field, let's add the check in the common unsol event
handler entry point to filter out such events.

BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1182377
Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
Cc: <stable@vger.kernel.org> # 183ab39eb0ea: ALSA: hda: Initialize power_state
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_bind.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 6a8564566375..17a25e453f60 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -47,6 +47,10 @@ static void hda_codec_unsol_event(struct hdac_device *dev, unsigned int ev)
 	if (codec->bus->shutdown)
 		return;
 
+	/* ignore unsol events during system suspend/resume */
+	if (codec->core.dev.power.power_state.event != PM_EVENT_ON)
+		return;
+
 	if (codec->patch_ops.unsol_event)
 		codec->patch_ops.unsol_event(codec, ev);
 }
-- 
2.26.2

