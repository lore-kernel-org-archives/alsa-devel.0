Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D58C25B67
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Oct 2023 18:07:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 030A0A4D;
	Thu, 26 Oct 2023 20:06:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 030A0A4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698343660;
	bh=A7g++7MmHeakfIWdu8Bsiz3vVlF8JnKzBYBXufhHHPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=I+J4+1n1id2krfbgV5gnyrRIH1t/DVn5hrBw9zUSyBVeLatnjGj8MtYGz/vqPNOOz
	 SYQriHyySUJyVtDXisYYKnoWl7oO8y5tPr94wFpODLxGvoDs5vwwBFb1pydQ30//ld
	 uP/M7LNlsK55HIk8rsa0aFjKlj63ZB52nV3hfSEU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 99D0AF8055C; Thu, 26 Oct 2023 20:06:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 40CCCF8055B;
	Thu, 26 Oct 2023 20:06:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 23813F8055B; Thu, 26 Oct 2023 20:06:23 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 83138F8019B
	for <alsa-devel@alsa-project.org>; Thu, 26 Oct 2023 20:06:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83138F8019B
Received: by m.b4.vu (Postfix, from userid 1000)
	id 854BC604F28E; Fri, 27 Oct 2023 04:36:16 +1030 (ACDT)
Date: Fri, 27 Oct 2023 04:36:16 +1030
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Subject: [PATCH 4/5] ALSA: scarlett2: Allow passing any output to
 line_out_remap()
Message-ID: <3b70267931f5994628ab27306c73cddd17b93c8f.1698342632.git.g@b4.vu>
References: <cover.1698342632.git.g@b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698342632.git.g@b4.vu>
Message-ID-Hash: LQ34FDGOFLBZWMYORPPXOW6B4AO5XMTF
X-Message-ID-Hash: LQ34FDGOFLBZWMYORPPXOW6B4AO5XMTF
X-MailFrom: g@b4.vu
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LQ34FDGOFLBZWMYORPPXOW6B4AO5XMTF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Line outputs 3 & 4 on the Gen 3 18i8 are internally the analogue 7 and
8 outputs, and this renumbering is hidden from the user by
line_out_remap(). By allowing higher values (representing non-analogue
outputs) to be passed to line_out_remap(), repeated code from
scarlett2_mux_src_enum_ctl_get() and scarlett2_mux_src_enum_ctl_put()
can be removed.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett2.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index 9badb08177b5..48cd765cf36d 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -2026,9 +2026,16 @@ static int scarlett2_master_volume_ctl_get(struct snd_kcontrol *kctl,
 static int line_out_remap(struct scarlett2_data *private, int index)
 {
 	const struct scarlett2_device_info *info = private->info;
+	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
+	int line_out_count =
+		port_count[SCARLETT2_PORT_TYPE_ANALOGUE][SCARLETT2_PORT_OUT];
 
 	if (!info->line_out_remap_enable)
 		return index;
+
+	if (index >= line_out_count)
+		return index;
+
 	return info->line_out_remap[index];
 }
 
@@ -3513,14 +3520,7 @@ static int scarlett2_mux_src_enum_ctl_get(struct snd_kcontrol *kctl,
 	struct usb_mixer_elem_info *elem = kctl->private_data;
 	struct usb_mixer_interface *mixer = elem->head.mixer;
 	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
-	int line_out_count =
-		port_count[SCARLETT2_PORT_TYPE_ANALOGUE][SCARLETT2_PORT_OUT];
-	int index = elem->control;
-
-	if (index < line_out_count)
-		index = line_out_remap(private, index);
+	int index = line_out_remap(private, elem->control);
 
 	mutex_lock(&private->data_mutex);
 	if (private->mux_updated)
@@ -3537,16 +3537,9 @@ static int scarlett2_mux_src_enum_ctl_put(struct snd_kcontrol *kctl,
 	struct usb_mixer_elem_info *elem = kctl->private_data;
 	struct usb_mixer_interface *mixer = elem->head.mixer;
 	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
-	int line_out_count =
-		port_count[SCARLETT2_PORT_TYPE_ANALOGUE][SCARLETT2_PORT_OUT];
-	int index = elem->control;
+	int index = line_out_remap(private, elem->control);
 	int oval, val, err = 0;
 
-	if (index < line_out_count)
-		index = line_out_remap(private, index);
-
 	mutex_lock(&private->data_mutex);
 
 	oval = private->mux[index];
-- 
2.41.0

