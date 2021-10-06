Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6E8C433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 14:18:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0F660EFF
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 14:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B0F660EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E63983A;
	Wed,  6 Oct 2021 16:17:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E63983A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633529901;
	bh=l7GGW3iLzR7LPoUeuM1dvSJBvtLinqYtf1VtXdDIf+E=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Y2n6IffAnXU1wc9ocdpYA+OvhZVNQbol/0zQjklBwREaAsy4q7U6GSgIzs5CskrwU
	 sJwPvZXRaowHXvo92GVMnL4nTQizFOyLdLR8ag/hYdr0daj3zK7qaGvSdwt+S+g9c5
	 f+YELFchlLn/wWmGjq/FnrINq55qYRqZrM6R0VdI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04DD4F80229;
	Wed,  6 Oct 2021 16:17:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9A9B5F80240; Wed,  6 Oct 2021 16:17:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EF418F800FE
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 16:17:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF418F800FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="ZufR0IpI"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="VhzBF41H"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D337F22457;
 Wed,  6 Oct 2021 14:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1633529839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=65N9x4deL2hWmwGA0Y5ITV+4Bu+XGLDjMJZEnztugwA=;
 b=ZufR0IpI4mF7CTgXNtcgVUCSBmXSoYit5Q5RhfTBisXOKQxvu18qMHy2tVli29K1j1AYGQ
 VZ3BOl1zZCDq+fxrOruLcr3uLYkKLLvNKwoP2EgbDFWz/Hz3jKVIKj/OcyAhCmaq6opKIg
 hWIqP46imZkvT4yk6QiabUL56tMp1bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1633529839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=65N9x4deL2hWmwGA0Y5ITV+4Bu+XGLDjMJZEnztugwA=;
 b=VhzBF41HjBTcffkG6rt1K1Z2JMe7PsU4cCXOV8RyxsuAy1z+KwlUu/pzqk0hxE8wSdefno
 hPJ4owA0Mg3KZjAw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id C1BD7A3BC7;
 Wed,  6 Oct 2021 14:17:19 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: DAPM: Fix missing kctl change notifications
Date: Wed,  6 Oct 2021 16:17:12 +0200
Message-Id: <20211006141712.2439-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
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

The put callback of a kcontrol is supposed to return 1 when the value
is changed, and this will be notified to user-space.  However, some
DAPM kcontrols always return 0 (except for errors), hence the
user-space misses the update of a control value.

This patch corrects the behavior by properly returning 1 when the
value gets updated.

Reported-and-tested-by: Hans de Goede <hdegoede@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-dapm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7b67f1e19ae9..59d07648a7e7 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2561,6 +2561,7 @@ static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
 				const char *pin, int status)
 {
 	struct snd_soc_dapm_widget *w = dapm_find_widget(dapm, pin, true);
+	int ret = 0;
 
 	dapm_assert_locked(dapm);
 
@@ -2573,13 +2574,14 @@ static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
 		dapm_mark_dirty(w, "pin configuration");
 		dapm_widget_invalidate_input_paths(w);
 		dapm_widget_invalidate_output_paths(w);
+		ret = 1;
 	}
 
 	w->connected = status;
 	if (status == 0)
 		w->force = 0;
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -3583,14 +3585,15 @@ int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 	const char *pin = (const char *)kcontrol->private_value;
+	int ret;
 
 	if (ucontrol->value.integer.value[0])
-		snd_soc_dapm_enable_pin(&card->dapm, pin);
+		ret = snd_soc_dapm_enable_pin(&card->dapm, pin);
 	else
-		snd_soc_dapm_disable_pin(&card->dapm, pin);
+		ret = snd_soc_dapm_disable_pin(&card->dapm, pin);
 
 	snd_soc_dapm_sync(&card->dapm);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_pin_switch);
 
@@ -4023,7 +4026,7 @@ static int snd_soc_dapm_dai_link_put(struct snd_kcontrol *kcontrol,
 
 	rtd->params_select = ucontrol->value.enumerated.item[0];
 
-	return 0;
+	return 1;
 }
 
 static void
-- 
2.26.2

