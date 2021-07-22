Return-Path: <SRS0=+9Uh=MO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19B0C4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 20:13:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B7160EB5
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 20:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B9B7160EB5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C454916FE;
	Thu, 22 Jul 2021 22:12:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C454916FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626984819;
	bh=ZywefN1YP7yv5/+v36KXPk6IeOYHSGw/79jrXSezMxM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TcjqkQi+iEpWgvxKJ5+Qqdy7iAAo7WAnonTPfD3/pUqvmE5kwxjgJXavO3XfM3O5c
	 X+TAG3LPdZfIuZIxi0V+8F2+BSxQywNGUe04nBskrl4R/I+yYClq0SwC84+bxMuK+Z
	 QIJmyBTgZSgmrqcznplio8qOleufGCf2fCb5T6e0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B3E5F800DA;
	Thu, 22 Jul 2021 22:12:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C945CF80256; Thu, 22 Jul 2021 22:12:02 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F542F800DA
 for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2021 22:11:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F542F800DA
Received: by m.b4.vu (Postfix, from userid 1000)
 id A6B2D61208C0; Fri, 23 Jul 2021 05:41:53 +0930 (ACST)
Date: Fri, 23 Jul 2021 05:41:53 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ALSA: scarlett2: Fix Mute/Dim/MSD Mode control names
Message-ID: <77f1000652c37e3217fb8dad8e156bc6392abc0b.1626959758.git.g@b4.vu>
References: <cover.1626959758.git.g@b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1626959758.git.g@b4.vu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>,
 Vladimir Sadovnikov <sadko4u@gmail.com>
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

Append "Playback Switch" to the names of "Mute" and "Dim" controls,
and append "Switch" to the "MSD Mode" control as per
Documentation/sound/designs/control-names.rst.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index f9d698a37153..347995ea39e4 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -228,7 +228,7 @@ enum {
 };
 
 static const char *const scarlett2_dim_mute_names[SCARLETT2_DIM_MUTE_COUNT] = {
-	"Mute", "Dim"
+	"Mute Playback Switch", "Dim Playback Switch"
 };
 
 /* Description of each hardware port type:
@@ -3455,7 +3455,7 @@ static int scarlett2_add_msd_ctl(struct usb_mixer_interface *mixer)
 
 	/* Add MSD control */
 	return scarlett2_add_new_ctl(mixer, &scarlett2_msd_ctl,
-				     0, 1, "MSD Mode", NULL);
+				     0, 1, "MSD Mode Switch", NULL);
 }
 
 /*** Cleanup/Suspend Callbacks ***/
-- 
2.31.1

