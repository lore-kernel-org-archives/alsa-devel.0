Return-Path: <SRS0=riU+=6C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4E6C38A29
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Apr 2020 14:54:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2B221D7E
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Apr 2020 14:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iz6kKK6C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPH3ixIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2B221D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A572A169C;
	Sat, 18 Apr 2020 16:53:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A572A169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587221682;
	bh=FpU1OozTsJtqNFfTodp2T7zS+DybVqAT+kDFNdaMpGw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iz6kKK6Ck1jWPfj78poR+xC5AuU+4a6hZR9uicvnHreHnPT9Wa9S5d3NNo36xyGlW
	 pcVGwiTME0ogXKARxz/PsRdfJc+5+joU/fHSzA6+QeCaZiVfDHNnvUKAIsYuOa+3n9
	 qTtaaYRz2Q8qwKldzB3BDunJONf9agtvQ2vSrPpI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73859F802BD;
	Sat, 18 Apr 2020 16:43:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 530E0F80346; Sat, 18 Apr 2020 16:43:45 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89B1BF802BE
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2020 16:43:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89B1BF802BE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MPH3ixIK"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4D4D52072B;
 Sat, 18 Apr 2020 14:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587221018;
 bh=FpU1OozTsJtqNFfTodp2T7zS+DybVqAT+kDFNdaMpGw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MPH3ixIKiRm/AGdC7oOjKMg44cxgL6RJKCHdtLuKaJ38Fa7pvc3Ya22hxBQXThoy1
 CS89lq6DubPIoMAjAJ5jCnkTEzvvt79uEZtvrtmdpOKauAGY+yxbXSdsTjodxhikc5
 0Cx9xtvKrNyWkyeh+dtilRpTDUa/oVVq+02eOFMY=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 08/28] ASoC: dpcm: allow start or stop during
 pause for backend
Date: Sat, 18 Apr 2020 10:43:08 -0400
Message-Id: <20200418144328.10265-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144328.10265-1-sashal@kernel.org>
References: <20200418144328.10265-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>,
 =?UTF-8?q?=EC=9D=B4=EA=B2=BD=ED=83=9D?= <gt82.lee@samsung.com>,
 Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 alsa-devel@alsa-project.org
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

From: 이경택 <gt82.lee@samsung.com>

[ Upstream commit 21fca8bdbb64df1297e8c65a746c4c9f4a689751 ]

soc_compr_trigger_fe() allows start or stop after pause_push.
In dpcm_be_dai_trigger(), however, only pause_release is allowed
command after pause_push.
So, start or stop after pause in compress offload is always
returned as error if the compress offload is used with dpcm.
To fix the problem, SND_SOC_DPCM_STATE_PAUSED should be allowed
for start or stop command.

Signed-off-by: Gyeongtaek Lee <gt82.lee@samsung.com>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/004d01d607c1$7a3d5250$6eb7f6f0$@samsung.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-pcm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index e75822dd9930f..fd4b71729eedd 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2048,7 +2048,8 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 		switch (cmd) {
 		case SNDRV_PCM_TRIGGER_START:
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
-			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
 				continue;
 
 			ret = dpcm_do_trigger(dpcm, be_substream, cmd);
@@ -2078,7 +2079,8 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_STOP:
-			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
+			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
 				continue;
 
 			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
-- 
2.20.1

