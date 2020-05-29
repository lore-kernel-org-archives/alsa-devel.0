Return-Path: <SRS0=qQ1O=7L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95216C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 17:34:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F3A2072D
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 17:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uLO0rc6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F3A2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bollie.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E8BA1762;
	Fri, 29 May 2020 19:33:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E8BA1762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590773652;
	bh=Nyj1wEZ4VBa6F7GDK+qz0CPVXigRNQdEEEFcXe0PuzA=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uLO0rc6sQuiiW89CGkQcnCeSoJJjkDhWE6JEOBovAIIsj7BTbY2ldJPM/H80V/V/O
	 GsjvIQIy4/N57F+cZnlc0i5YszMHy06gf4R/t+5fvM+ZIggA4HTvnRaodNUZQMqWFY
	 hRRcbC1qERV9PDlCdZdESxXZNvT4PKaGd1Yeka2o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CDE44F80149;
	Fri, 29 May 2020 19:33:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3FF5CF8014E; Fri, 29 May 2020 19:33:20 +0200 (CEST)
Received: from bollie.ca9.eu (bollie.ca9.eu
 [IPv6:2a01:238:439b:aa00:6132:efc3:700a:5a2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96E7FF80107
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2020 19:33:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96E7FF80107
Received: by bollie.ca9.eu (Postfix, from userid 1000)
 id E0A04C616F; Fri, 29 May 2020 19:32:56 +0200 (CEST)
Date: Fri, 29 May 2020 19:32:56 +0200
From: Thomas Ebeling <penguins@bollie.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: Fixing usage of plain int instead of NULL
Message-ID: <20200529173248.zzawijfvw73kzjxt@bollie.ca9.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Cc: Takashi Iwai <tiwai@suse.com>
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

As reported by kbuild test robot, mixer quirks for RME Babyface
Pro used plain integer instead of NULL.

Signed-off-by: Thomas Ebeling <penguins@bollie.de>
Reported-by: kbuild test robot <lkp@intel.com>
---
 sound/usb/mixer_quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index aad2683ff793..b6bcf2f92383 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -2255,7 +2255,7 @@ static int snd_bbfpro_ctl_update(struct usb_mixer_interface *mixer, u8 reg,
 	err = snd_usb_ctl_msg(chip->dev,
 			      usb_sndctrlpipe(chip->dev, 0), usb_req,
 			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			      usb_val, usb_idx, 0, 0);
+			      usb_val, usb_idx, NULL, 0);
 
 	snd_usb_unlock_shutdown(chip);
 	return err;
@@ -2394,7 +2394,7 @@ static int snd_bbfpro_vol_update(struct usb_mixer_interface *mixer, u16 index,
 			      SND_BBFPRO_USBREQ_MIXER,
 			      USB_DIR_OUT | USB_TYPE_VENDOR |
 			      USB_RECIP_DEVICE,
-			      usb_val, usb_idx, 0, 0);
+			      usb_val, usb_idx, NULL, 0);
 
 	snd_usb_unlock_shutdown(chip);
 	return err;
-- 
2.26.2

