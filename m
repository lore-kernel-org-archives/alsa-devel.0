Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4E4C4743C
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:12:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D966115B
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D966115B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61552168E;
	Mon, 21 Jun 2021 20:11:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61552168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624299160;
	bh=2NWQdEnBu1Z5wmVVzxXBr7fWOuY3ZhP69ePPnK/7j08=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dAZ8gK7h7Z55dAEBXb+FUFepgy/ssHNFm/ONDhKptwqwNSU1V+wvFFIpPyuxomuOg
	 /qHtWbAdx0tOH1MuUetF8+qtzB2GnPMX7uib77j919yy7LERJWvr7uKojK+ZEA4hAV
	 AjdZW6JyOXnj0FqxjmCJHDlcDzmIJGtuzKoVZDec=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A7ECF804FC;
	Mon, 21 Jun 2021 20:09:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2FDCF804F2; Mon, 21 Jun 2021 20:09:31 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 591A3F804E7
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 20:09:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 591A3F804E7
Received: by m.b4.vu (Postfix, from userid 1000)
 id DB0CE61E5F00; Tue, 22 Jun 2021 03:39:26 +0930 (ACST)
Date: Tue, 22 Jun 2021 03:39:26 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/31] ALSA: usb-audio: scarlett2: Merge common line in
 capture strings
Message-ID: <d91dce45ac75a541c21f47540ecbda24bd83f68c.1624294591.git.g@b4.vu>
References: <cover.1624294591.git.g@b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1624294591.git.g@b4.vu>
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

Use a common sprintf() format for the mixer element names generated in
scarlett2_add_line_in_ctls() in preparation for more of them.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 4c2ae81f94a8..c401b7d56408 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -1660,10 +1660,11 @@ static int scarlett2_add_line_in_ctls(struct usb_mixer_interface *mixer)
 	const struct scarlett2_device_info *info = private->info;
 	int err, i;
 	char s[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	const char *fmt = "Line In %d %s Capture %s";
 
 	/* Add input level (line/inst) controls */
 	for (i = 0; i < info->level_input_count; i++) {
-		snprintf(s, sizeof(s), "Line In %d Level Capture Enum", i + 1);
+		snprintf(s, sizeof(s), fmt, i + 1, "Level", "Enum");
 		err = scarlett2_add_new_ctl(mixer, &scarlett2_level_enum_ctl,
 					    i, 1, s, NULL);
 		if (err < 0)
@@ -1672,7 +1673,7 @@ static int scarlett2_add_line_in_ctls(struct usb_mixer_interface *mixer)
 
 	/* Add input pad controls */
 	for (i = 0; i < info->pad_input_count; i++) {
-		snprintf(s, sizeof(s), "Line In %d Pad Capture Switch", i + 1);
+		snprintf(s, sizeof(s), fmt, i + 1, "Pad", "Switch");
 		err = scarlett2_add_new_ctl(mixer, &scarlett2_pad_ctl,
 					    i, 1, s, NULL);
 		if (err < 0)
-- 
2.31.1

