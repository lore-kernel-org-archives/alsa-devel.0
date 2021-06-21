Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ED9C48BC2
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:21:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD147611CE
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD147611CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 36CB5174E;
	Mon, 21 Jun 2021 20:20:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 36CB5174E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624299665;
	bh=wpRxZMuofkDNnw4WeDCTuEGnPy9h5qWxJ39QtcmvWb4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NxzaMgoGwEIyqSI2yP3k41SiVFEfNs3D8+6K638/n5fJDOoXiD6VsY2wZhsCsclcq
	 b/KxvJ+jFDw1jeQXwpAkv5NN0tYoF+4u7Xlytk7lvc+MDEdwsh3dwIApT0oOfGEBsW
	 itu+uZ2gCbsuwo8K3N2ge4t7RgbWXOrl8SBN1HHQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A4810F805E2;
	Mon, 21 Jun 2021 20:10:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74C15F805C9; Mon, 21 Jun 2021 20:10:19 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B08BEF8057D
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 20:10:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B08BEF8057D
Received: by m.b4.vu (Postfix, from userid 1000)
 id 37B8061E2871; Tue, 22 Jun 2021 03:40:10 +0930 (ACST)
Date: Tue, 22 Jun 2021 03:40:10 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 28/31] ALSA: usb-audio: scarlett2: Update mux controls to
 allow updates
Message-ID: <3aaee481c6aeb5e9005d56fc94b0079ba094c00e.1624294591.git.g@b4.vu>
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

Enabling/disabling speaker switching will update the mux
configuration. To prepare for this, add a private->mux_updated flag
and update the scarlett2_mux_src_enum_ctl_get() callback to check it.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index efa65bdb48c8..dce40d2e0ba6 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -378,6 +378,7 @@ struct scarlett2_data {
 	u8 vol_updated;
 	u8 input_other_updated;
 	u8 monitor_other_updated;
+	u8 mux_updated;
 	u8 sync;
 	u8 master_vol;
 	u8 vol[SCARLETT2_ANALOGUE_MAX];
@@ -1446,6 +1447,8 @@ static int scarlett2_usb_get_mux(struct usb_mixer_interface *mixer)
 
 	__le32 data[SCARLETT2_MUX_MAX];
 
+	private->mux_updated = 0;
+
 	req.num = 0;
 	req.count = cpu_to_le16(count);
 
@@ -2794,7 +2797,8 @@ static int scarlett2_mux_src_enum_ctl_get(struct snd_kcontrol *kctl,
 					  struct snd_ctl_elem_value *ucontrol)
 {
 	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct scarlett2_data *private = elem->head.mixer->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
 	const struct scarlett2_device_info *info = private->info;
 	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
 	int line_out_count =
@@ -2804,7 +2808,12 @@ static int scarlett2_mux_src_enum_ctl_get(struct snd_kcontrol *kctl,
 	if (index < line_out_count)
 		index = line_out_remap(private, index);
 
+	mutex_lock(&private->data_mutex);
+	if (private->mux_updated)
+		scarlett2_usb_get_mux(mixer);
 	ucontrol->value.enumerated.item[0] = private->mux[index];
+	mutex_unlock(&private->data_mutex);
+
 	return 0;
 }
 
-- 
2.31.1

