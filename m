Return-Path: <SRS0=Aiaa=GV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF0AC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 08:00:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5EA1229C6
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 08:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5EA1229C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 102D817C1;
	Mon, 18 Jan 2021 08:59:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 102D817C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610956816;
	bh=gDyByuXHJu57qkFmcRhG1lVed0JE6iEDxJbpOkJiwYw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ATaXKbmsfzc8EFOR5tkw9PfO/yb4Fy3TRIMb4mKWYSLKl2kTW6pAG0oGschMThqPn
	 /yXBy0VHRmlQjh18dhJxoAhIaQO/1te0RQy082VewGbDgifIr1eHVXkSoChPi/lcHG
	 g9jeS7V9xHtgOcZYacKGX5q6EyiwzPrd+DTSswMU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D68DEF804BD;
	Mon, 18 Jan 2021 08:58:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 49D68F804C2; Mon, 18 Jan 2021 08:58:33 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A2DEF80166
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 08:58:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A2DEF80166
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8D987AC4F;
 Mon, 18 Jan 2021 07:58:19 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/3] ALSA: usb-audio: Set sample rate for all sharing EPs on
 UAC1
Date: Mon, 18 Jan 2021 08:58:15 +0100
Message-Id: <20210118075816.25068-3-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210118075816.25068-1-tiwai@suse.de>
References: <20210118075816.25068-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Franti=C5=A1ek=20Ku=C4=8Dera?= <konference@frantovo.cz>,
 Geraldo <geraldogabriel@gmail.com>
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

The UAC2/3 sample rate setup is based on the clock node, which is
usually shared in the interface, and can't be re-setup without
deselecting the interface once, and that's how the current code
behaves.  OTOH, the sample rate setup of UAC1 is per endpoint, hence
we basically need to call for each endpoint usage even if those share
the same interface.

This patch fixes the behavior of UAC1 to call always
snd_usb_init_sample_rate() in snd_usb_endpoint_configure().

Fixes: bf6313a0ff76 ("ALSA: usb-audio: Refactor endpoint management")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/endpoint.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index fe73fe3ff2bc..8e568823c992 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1252,6 +1252,15 @@ int snd_usb_endpoint_configure(struct snd_usb_audio *chip,
 
 	/* If the interface has been already set up, just set EP parameters */
 	if (!ep->iface_ref->need_setup) {
+		/* sample rate setup of UAC1 is per endpoint, and we need
+		 * to update at each EP configuration
+		 */
+		if (ep->cur_audiofmt->protocol == UAC_VERSION_1) {
+			err = snd_usb_init_sample_rate(chip, ep->cur_audiofmt,
+						       ep->cur_rate);
+			if (err < 0)
+				goto unlock;
+		}
 		err = snd_usb_endpoint_set_params(chip, ep);
 		if (err < 0)
 			goto unlock;
-- 
2.26.2

