Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D5AC43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:46:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18676207FF
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="O4cPqDLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18676207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D7101658;
	Tue, 10 Dec 2019 16:45:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D7101658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575992797;
	bh=6VE0JR+mjEpN7EEdTUqU3UL8QKiHSCnW21X48jSRQPM=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O4cPqDLzTl4v0p2FOnUF4440yc4QkaJ08Yw+7bsW0bM0UDV7RaxJ57T5+ze1pLeTS
	 rMFM3UDcQe65wXYQcPyNAcn8QD9hRn+Q+ZRa7WrZY244IINOmt+i1BNlNgqZV+ccq/
	 f2OAjL9xK3TI7GVY0lu8DKdKAmGsV/JegdgLQZb4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F7CCF801D8;
	Tue, 10 Dec 2019 16:45:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18117F80248; Tue, 10 Dec 2019 16:45:45 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35959F800B4
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 16:45:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35959F800B4
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2451EB19D;
 Tue, 10 Dec 2019 15:45:41 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: dri-devel@lists.freedesktop.org
Date: Tue, 10 Dec 2019 16:45:36 +0100
Message-Id: <20191210154536.29819-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210154536.29819-1-tiwai@suse.de>
References: <20191210154536.29819-1-tiwai@suse.de>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>, alsa-devel@alsa-project.org,
 Jonas Karlman <jonas@kwiboo.se>, Neil Armstrong <narmstrong@baylibre.com>,
 Russell King <linux@armlinux.org.uk>, Andrzej Hajda <a.hajda@samsung.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: [alsa-devel] [PATCH for-5.6 2/2] drm/bridge: dw-hdmi: Drop
	superfluous ioctl PCM ops
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

PCM core deals the empty ioctl field now as default.
Let's kill the redundant lines.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
index ab8d16b3b78d..4bb365cd24f0 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
@@ -498,7 +498,6 @@ static snd_pcm_uframes_t dw_hdmi_pointer(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops snd_dw_hdmi_ops = {
 	.open = dw_hdmi_open,
 	.close = dw_hdmi_close,
-	.ioctl = snd_pcm_lib_ioctl,
 	.prepare = dw_hdmi_prepare,
 	.trigger = dw_hdmi_trigger,
 	.pointer = dw_hdmi_pointer,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
