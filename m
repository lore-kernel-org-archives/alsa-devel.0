Return-Path: <SRS0=bL7i=LQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32FDC2B9F4
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 17:07:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E036054E
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 17:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E036054E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C17661658;
	Tue, 22 Jun 2021 19:06:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C17661658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624381627;
	bh=bMDdhjT4S3Hs5YCmOGFzVrJSJCDaM2pn166I0ErcFSU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KzXbba6qHERov0sOBhcWTnpiErSAOPRnchQXA/xJCqMPv0kaHBwszQagW4m8V73Zq
	 KeIy9e90Zv0tT24iynw+sojVAVd0xR2oLMH68VCbnD9b9FsojSUCkwIafm83VUBta/
	 RIjGyZ6ofslQmEK8KpBOL7USaTt0wOeuO1T0UYEQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EBD70F80519;
	Tue, 22 Jun 2021 19:03:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35CD9F8051A; Tue, 22 Jun 2021 19:03:50 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1AE0F804DF
 for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2021 19:03:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1AE0F804DF
Received: by m.b4.vu (Postfix, from userid 1000)
 id 30BC961E286D; Wed, 23 Jun 2021 02:33:45 +0930 (ACST)
Date: Wed, 23 Jun 2021 02:33:45 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/17] ALSA: usb-audio: scarlett2: Add sw_hw_ctls and mux_ctls
Message-ID: <269d89181bf29dbea80ba6f8cfff84fb23b77f86.1624379707.git.g@b4.vu>
References: <cover.1624379707.git.g@b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1624379707.git.g@b4.vu>
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

Save the struct snd_kcontrol pointers for the sw_hw and mux controls.
This is in preparation for speaker switching support which needs to be
able to update those controls.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 37e35016db12..b3e1cb943c3c 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -394,12 +394,14 @@ struct scarlett2_data {
 	struct snd_kcontrol *sync_ctl;
 	struct snd_kcontrol *master_vol_ctl;
 	struct snd_kcontrol *vol_ctls[SCARLETT2_ANALOGUE_MAX];
+	struct snd_kcontrol *sw_hw_ctls[SCARLETT2_ANALOGUE_MAX];
 	struct snd_kcontrol *mute_ctls[SCARLETT2_ANALOGUE_MAX];
 	struct snd_kcontrol *dim_mute_ctls[SCARLETT2_DIM_MUTE_COUNT];
 	struct snd_kcontrol *level_ctls[SCARLETT2_LEVEL_SWITCH_MAX];
 	struct snd_kcontrol *pad_ctls[SCARLETT2_PAD_SWITCH_MAX];
 	struct snd_kcontrol *air_ctls[SCARLETT2_AIR_SWITCH_MAX];
 	struct snd_kcontrol *phantom_ctls[SCARLETT2_PHANTOM_SWITCH_MAX];
+	struct snd_kcontrol *mux_ctls[SCARLETT2_MUX_MAX];
 	struct snd_kcontrol *direct_monitor_ctl;
 	u8 mux[SCARLETT2_MUX_MAX];
 	u8 mix[SCARLETT2_INPUT_MIX_MAX * SCARLETT2_OUTPUT_MIX_MAX];
@@ -2558,7 +2560,8 @@ static int scarlett2_add_line_out_ctls(struct usb_mixer_interface *mixer)
 				 i + 1);
 			err = scarlett2_add_new_ctl(mixer,
 						    &scarlett2_sw_hw_enum_ctl,
-						    i, 1, s, NULL);
+						    i, 1, s,
+						    &private->sw_hw_ctls[i]);
 			if (err < 0)
 				return err;
 		}
@@ -2876,7 +2879,8 @@ static int scarlett2_add_mux_enums(struct usb_mixer_interface *mixer)
 
 			err = scarlett2_add_new_ctl(mixer,
 						    &scarlett2_mux_src_enum_ctl,
-						    i, 1, s, NULL);
+						    i, 1, s,
+						    &private->mux_ctls[i]);
 			if (err < 0)
 				return err;
 		}
-- 
2.31.1

