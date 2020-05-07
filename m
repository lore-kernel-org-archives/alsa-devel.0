Return-Path: <SRS0=eFJe=6V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF253C38A2A
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 14:37:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7980B2184D
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 14:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mJew1OpQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLzD8TTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7980B2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDB731851;
	Thu,  7 May 2020 16:36:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDB731851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588862260;
	bh=6wr9dxPNpn+5weQd7EyxLtOcjVWhTIZMw/zZ48GgtnU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mJew1OpQ7sB0ZX/Y7/6nuq2gxXbXSUW99RjNR4lJR2KHzCtnTIDu6wl0gglj2pDY6
	 smVIzyi2eO8c8q3IKdlXDg5/M54axL8ElZnwz9/nkN7k+2l4XsJot5JzS/LfwNScne
	 NvUkKumIWB04NPSuX4qfHR5JCiTCFeOmuXCRJuAY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CC99F80322;
	Thu,  7 May 2020 16:30:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 441FEF80303; Thu,  7 May 2020 16:30:24 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED89EF80303
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2020 16:30:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED89EF80303
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MLzD8TTh"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CDA052073A;
 Thu,  7 May 2020 14:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588861813;
 bh=6wr9dxPNpn+5weQd7EyxLtOcjVWhTIZMw/zZ48GgtnU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MLzD8TThIA5rgL37dbe9e93veTJFJ1dbGAF6nEK1yl/ulQXcHcEOBzkIwKxUnZx9s
 dYb90ZXUNGQd9WUcfYLDEuopLVwcDXrIZetlAR0Whj7m9c0zCo/Bb6Iyun4zN4lJL9
 +WuaeHoj4sJbGkMx/wtzH1J607IHA6YuoCc1ar+U=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 08/11] ALSA: hda/hdmi: fix race in monitor
 detection during probe
Date: Thu,  7 May 2020 10:30:00 -0400
Message-Id: <20200507143003.27047-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507143003.27047-1-sashal@kernel.org>
References: <20200507143003.27047-1-sashal@kernel.org>
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
index 7a2943a338bff..40b4f23693ec3 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2042,7 +2042,9 @@ static int generic_hdmi_build_controls(struct hda_codec *codec)
 
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
 		struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
+		struct hdmi_eld *pin_eld = &per_pin->sink_eld;
 
+		pin_eld->eld_valid = false;
 		hdmi_present_sense(per_pin, 0);
 	}
 
-- 
2.20.1

