Return-Path: <SRS0=eFJe=6V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB379C38A2A
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 14:32:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4924E208D6
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 14:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aP9Pc9yW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1P6sq5A4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4924E208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4951181E;
	Thu,  7 May 2020 16:31:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4951181E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588861923;
	bh=mEmtLHs1NDv9zuIsYLPG4t4VA1VthP+g89wF5PD8Z2A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aP9Pc9yWCxSCymtFnebxaZZefo5X9SwmdEeSTYAmwNaTqT8aZgKlHswPLQxREb+/s
	 CzsK/pEYhL4XHzG8KrjF1kSCnDgRMS+7xwha8N6UOly2mzljzdDniv2RW19nfgfsXx
	 vKBvkkCzGLtnZK6m/E1Zj8n9QfWPTTFxI7Jf8Thw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E040F802A7;
	Thu,  7 May 2020 16:29:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A6BC3F802BE; Thu,  7 May 2020 16:29:08 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 727A6F802A7
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2020 16:29:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 727A6F802A7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="1P6sq5A4"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2DDCE20870;
 Thu,  7 May 2020 14:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588861739;
 bh=mEmtLHs1NDv9zuIsYLPG4t4VA1VthP+g89wF5PD8Z2A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=1P6sq5A4z+Zo9QMcYEJD//9oaTBxeGzEE97IivzEMF/hYRy8WV53bTzsbtVsfe4fW
 gyBzCvUGN0LB8K9i/J8JgNJ1s+rOKUhUdADrw2xzMKyJC79T8RhWuS29myOUCokk4m
 EQjHDf+Gfh9QLEgo/YnHrYc9sdJ0+BlEAOO570zA=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 23/35] ALSA: hda/hdmi: fix race in monitor
 detection during probe
Date: Thu,  7 May 2020 10:28:17 -0400
Message-Id: <20200507142830.26239-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507142830.26239-1-sashal@kernel.org>
References: <20200507142830.26239-1-sashal@kernel.org>
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

[ Upstream commit ca76282b6faffc83601c25bd2a95f635c03503ef ]

A race exists between build_pcms() and build_controls() phases of codec
setup. Build_pcms() sets up notifier for jack events. If a monitor event
is received before build_controls() is run, the initial jack state is
lost and never reported via mixer controls.

The problem can be hit at least with SOF as the controller driver. SOF
calls snd_hda_codec_build_controls() in its workqueue-based probe and
this can be delayed enough to hit the race condition.

Fix the issue by invalidating the per-pin ELD information when
build_controls() is called. The existing call to hdmi_present_sense()
will update the ELD contents. This ensures initial monitor state is
correctly reflected via mixer controls.

BugLink: https://github.com/thesofproject/linux/issues/1687
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://lore.kernel.org/r/20200428123836.24512-1-kai.vehmanen@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index f1febfc47ba60..4493427f324e4 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2232,7 +2232,9 @@ static int generic_hdmi_build_controls(struct hda_codec *codec)
 
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
 		struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
+		struct hdmi_eld *pin_eld = &per_pin->sink_eld;
 
+		pin_eld->eld_valid = false;
 		hdmi_present_sense(per_pin, 0);
 	}
 
-- 
2.20.1

