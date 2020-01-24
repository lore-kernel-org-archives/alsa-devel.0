Return-Path: <SRS0=dQ5X=3N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7B9C35243
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jan 2020 14:29:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0999D2075D
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jan 2020 14:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LTL/pbUt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0ynLyuMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0999D2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F8C8169A;
	Fri, 24 Jan 2020 15:28:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F8C8169A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579876176;
	bh=NcYqIeHfxRYUeKxNtllvaaZIAfq17shBMI9AE/g1Uns=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LTL/pbUtQWwzn6DnvGfJLA7HlAyrZhXXaXhakrgeBNkwhBKdt9iXrEWCGWz7WRBHA
	 LScEMJ1cNm+LMqaVQcwIQknZe/4pCk1pMkJw+kxghtAKpRoUkC0rBFlIGb2oIoxT6Y
	 DlxPfsCDUKpkTTYiE7Fkv0qXFa22933oAwMMNWOM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F734F8027B;
	Fri, 24 Jan 2020 15:21:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85DB9F8027C; Fri, 24 Jan 2020 15:21:38 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D5EA8F8026F
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2020 15:21:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5EA8F8026F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="0ynLyuMn"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D7B9A22464;
 Fri, 24 Jan 2020 14:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579875694;
 bh=0uOWnKSh83fXudGqMAovmHVwNS2NZDD+nPINkoIHYG4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=0ynLyuMnh93SZdlmlWXK10H1F1EcrxynLxRwZSGGVPtME0SkiIeAm24UrJjZfIlr+
 9IwDZkVCRuvnfRmUQIOs+oCz7CMchWCbsclBUThU+UonKya2Hc7pUmAEL6u9K30CzV
 3Ai7QeXV4d8SkD5tH37iXHLO7UvChgSYE364KsVc=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Fri, 24 Jan 2020 09:21:00 -0500
Message-Id: <20200124142119.30484-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124142119.30484-1-sashal@kernel.org>
References: <20200124142119.30484-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [alsa-devel] [PATCH AUTOSEL 4.14 13/32] ASoC: sti: fix possible
	sleep-in-atomic
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Arnaud Pouliquen <arnaud.pouliquen@st.com>

[ Upstream commit ce780a47c3c01e1e179d0792df6b853a913928f1 ]

Change mutex and spinlock management to avoid sleep
in atomic issue.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Link: https://lore.kernel.org/r/20200113100400.30472-1-arnaud.pouliquen@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sti/uniperif_player.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index d8b6936e544e3..908f13623f8cd 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -226,7 +226,6 @@ static void uni_player_set_channel_status(struct uniperif *player,
 	 * sampling frequency. If no sample rate is already specified, then
 	 * set one.
 	 */
-	mutex_lock(&player->ctrl_lock);
 	if (runtime) {
 		switch (runtime->rate) {
 		case 22050:
@@ -303,7 +302,6 @@ static void uni_player_set_channel_status(struct uniperif *player,
 		player->stream_settings.iec958.status[3 + (n * 4)] << 24;
 		SET_UNIPERIF_CHANNEL_STA_REGN(player, n, status);
 	}
-	mutex_unlock(&player->ctrl_lock);
 
 	/* Update the channel status */
 	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
@@ -365,8 +363,10 @@ static int uni_player_prepare_iec958(struct uniperif *player,
 
 	SET_UNIPERIF_CTRL_ZERO_STUFF_HW(player);
 
+	mutex_lock(&player->ctrl_lock);
 	/* Update the channel status */
 	uni_player_set_channel_status(player, runtime);
+	mutex_unlock(&player->ctrl_lock);
 
 	/* Clear the user validity user bits */
 	SET_UNIPERIF_USER_VALIDITY_VALIDITY_LR(player, 0);
@@ -598,7 +598,6 @@ static int uni_player_ctl_iec958_put(struct snd_kcontrol *kcontrol,
 	iec958->status[1] = ucontrol->value.iec958.status[1];
 	iec958->status[2] = ucontrol->value.iec958.status[2];
 	iec958->status[3] = ucontrol->value.iec958.status[3];
-	mutex_unlock(&player->ctrl_lock);
 
 	spin_lock_irqsave(&player->irq_lock, flags);
 	if (player->substream && player->substream->runtime)
@@ -608,6 +607,8 @@ static int uni_player_ctl_iec958_put(struct snd_kcontrol *kcontrol,
 		uni_player_set_channel_status(player, NULL);
 
 	spin_unlock_irqrestore(&player->irq_lock, flags);
+	mutex_unlock(&player->ctrl_lock);
+
 	return 0;
 }
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
