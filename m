Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B420EB64DC
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Jul 2023 08:25:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4EA6210;
	Thu, 20 Jul 2023 10:24:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4EA6210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689841510;
	bh=UN5MfoQiMH0kLMy0KAHvDzXDdJPeAmYI3cXUkN5nFsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=TbwPfDv29AOM65VapyI+O8cOLwBSEObRbv6ju1v8mOLVIGCOfocVyB0NpSOqYcJ3o
	 QCenIe8GGiX+s/j1SRJcMtGJ0cS+ECa30G5hUHnICqMocfhx1ONHH7Cu75OOASfuC3
	 Q04O/ktzMNxjPSft/cx2XeBqa1tBI7NUdXoXZO0I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D9308F80153; Thu, 20 Jul 2023 10:23:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 76AEEF800D2;
	Thu, 20 Jul 2023 10:23:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C67CF8032D; Thu, 20 Jul 2023 10:23:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DE0B9F80578
	for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2023 10:21:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE0B9F80578
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=XIhJsYut;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=2EahGONB
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 46C252059F;
	Thu, 20 Jul 2023 08:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1689841277;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9GcxqEYpMX1bdRnBZr6GKoehA9jvtDPge/h0IwWcis=;
	b=XIhJsYutg0d4EzqNFwdgoWFFsiPIY6OFSRsPfnHYpkyGE7VVQ/5moadKKSQTD2MqHSTnvZ
	bxzgiz4u0pM1F+hGvzMx7vVOX0IWyeZsFBqUuwZQ+1VcGROMRAFlpQ+YRioCZZEg9FPfvu
	igZiS/fMRZmJoxlqT8Fkrri2bdyiUzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689841277;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9GcxqEYpMX1bdRnBZr6GKoehA9jvtDPge/h0IwWcis=;
	b=2EahGONBEHoH+FDCEaxkwR8Mf8DDkttFPanVyloQHWOggOix3fhz1e6Rk2O6L5k7AIJJc2
	YOgbYiGmXIy8/SBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23521133DD;
	Thu, 20 Jul 2023 08:21:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id CHzJB33uuGQmIgAAMHmgww
	(envelope-from <tiwai@suse.de>); Thu, 20 Jul 2023 08:21:17 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Trevor Wu <trevor.wu@mediatek.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 10/11] ASoC: mediatek: mt8188: Simplify with
 snd_ctl_find_id_mixer()
Date: Thu, 20 Jul 2023 10:21:07 +0200
Message-Id: <20230720082108.31346-11-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230720082108.31346-1-tiwai@suse.de>
References: <20230720082108.31346-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IEAS6A2MGGIOFPPVFAH3IHD6LPF3ICLH
X-Message-ID-Hash: IEAS6A2MGGIOFPPVFAH3IHD6LPF3ICLH
X-MailFrom: tiwai@suse.de
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IEAS6A2MGGIOFPPVFAH3IHD6LPF3ICLH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Replace an open code with the new snd_ctl_find_id_mixer().
There is no functional change.

Cc: Trevor Wu <trevor.wu@mediatek.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/mediatek/mt8188/mt8188-mt6359.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index ac69c23e0da1..6ebcc9497ea0 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -969,16 +969,6 @@ static struct snd_soc_dai_link mt8188_mt6359_dai_links[] = {
 	},
 };
 
-static struct snd_kcontrol *ctl_find(struct snd_card *card, const char *name)
-{
-	struct snd_ctl_elem_id sid;
-
-	memset(&sid, 0, sizeof(sid));
-	strcpy(sid.name, name);
-	sid.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-	return snd_ctl_find_id(card, &sid);
-}
-
 static void mt8188_fixup_controls(struct snd_soc_card *card)
 {
 	struct mt8188_mt6359_priv *priv = snd_soc_card_get_drvdata(card);
@@ -995,7 +985,7 @@ static void mt8188_fixup_controls(struct snd_soc_card *card)
 			snd_soc_dapm_free_widget(w);
 		}
 
-		kctl = ctl_find(card->snd_card, "Headphone Switch");
+		kctl = snd_ctl_find_id_mixer(card->snd_card, "Headphone Switch");
 		if (kctl)
 			snd_ctl_remove(card->snd_card, kctl);
 		else
-- 
2.35.3

