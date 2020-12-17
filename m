Return-Path: <SRS0=tU6Y=FV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81246C4361B
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Dec 2020 10:31:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1240923741
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Dec 2020 10:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1240923741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A52FD1859;
	Thu, 17 Dec 2020 11:30:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A52FD1859
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608201076;
	bh=xSniMP1gLZ53erLhY6iOGIpIHzTFTyhD7TeeLpI2nIw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DwwXD1PZVVLm5O+oH9mfcHcJBFvgoE2tCnkJnr6j7K9delMfhq7LxP3+2Dn5OcPzc
	 HBFxC2EJXb8xu94IRtSUTvPCtbheU5g2YrooCnTEgOwbwWNqMz4rmeqz4nV36/mxcE
	 6X/r1ZFRcPM/vrEKtwyQjxGfZ3X4oM4F3hAF2iE0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 38972F8027D;
	Thu, 17 Dec 2020 11:29:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6BA67F8027B; Thu, 17 Dec 2020 11:29:32 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E689F8014B
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2020 11:29:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E689F8014B
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8E596AD5A;
 Thu, 17 Dec 2020 10:29:24 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib 2/2] test/audio_time: Make use of
 SND_PCM_AUDIO_TSTAMP_TYPE constants
Date: Thu, 17 Dec 2020 11:29:21 +0100
Message-Id: <20201217102921.8616-2-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201217102921.8616-1-tiwai@suse.de>
References: <20201217102921.8616-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Alex Moon <alex.r.moon@gmail.com>, David Henningsson <diwic@ubuntu.com>
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

From: David Henningsson <diwic@ubuntu.com>

Also fixup the usage row which seemed wrong to me.

Signed-off-by: David Henningsson <diwic@ubuntu.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 test/audio_time.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/test/audio_time.c b/test/audio_time.c
index 530922d92d43..e4d4a9448c6d 100644
--- a/test/audio_time.c
+++ b/test/audio_time.c
@@ -32,7 +32,7 @@ static void usage(char *command)
 		"-d, --delay             add delay \n"
 		"-D, --device=NAME       select PCM by name \n"
 		"-p, --playback          playback tstamps \n"
-		"-t, --ts_type=TYPE      Default(0),link(1),link_estimated(2),synchronized(3) \n"
+		"-t, --ts_type=TYPE      Compat(0),default(1),link(2),link_absolute(3),link_estimated(4),link_synchronized(5) \n"
 		"-r, --report            show audio timestamp and accuracy validity\n"
 		, command);
 }
@@ -201,17 +201,17 @@ int main(int argc, char *argv[])
 			goto _exit;
 		}
 
-		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_p, 0))
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_p, SND_PCM_AUDIO_TSTAMP_TYPE_COMPAT))
 			printf("Playback supports audio compat timestamps\n");
-		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_p, 1))
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_p, SND_PCM_AUDIO_TSTAMP_TYPE_DEFAULT))
 			printf("Playback supports audio default timestamps\n");
-		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_p, 2))
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_p, SND_PCM_AUDIO_TSTAMP_TYPE_LINK))
 			printf("Playback supports audio link timestamps\n");
-		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_p, 3))
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_p, SND_PCM_AUDIO_TSTAMP_TYPE_LINK_ABSOLUTE))
 			printf("Playback supports audio link absolute timestamps\n");
-		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_p, 4))
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_p, SND_PCM_AUDIO_TSTAMP_TYPE_LINK_ESTIMATED))
 			printf("Playback supports audio link estimated timestamps\n");
-		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_p, 5))
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_p, SND_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED))
 			printf("Playback supports audio link synchronized timestamps\n");
 
 		snd_pcm_sw_params_alloca(&swparams_p);
@@ -269,17 +269,17 @@ int main(int argc, char *argv[])
 			goto _exit;
 		}
 
-		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_c, 0))
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_c, SND_PCM_AUDIO_TSTAMP_TYPE_COMPAT))
 			printf("Capture supports audio compat timestamps\n");
-		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_c, 1))
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_c, SND_PCM_AUDIO_TSTAMP_TYPE_DEFAULT))
 			printf("Capture supports audio default timestamps\n");
-		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_c, 2))
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_c, SND_PCM_AUDIO_TSTAMP_TYPE_LINK))
 			printf("Capture supports audio link timestamps\n");
-		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_c, 3))
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_c, SND_PCM_AUDIO_TSTAMP_TYPE_LINK_ABSOLUTE))
 			printf("Capture supports audio link absolute timestamps\n");
-		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_c, 4))
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_c, SND_PCM_AUDIO_TSTAMP_TYPE_LINK_ESTIMATED))
 			printf("Capture supports audio link estimated timestamps\n");
-		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_c, 5))
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_c, SND_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED))
 			printf("Capture supports audio link synchronized timestamps\n");
 
 		snd_pcm_sw_params_alloca(&swparams_c);
-- 
2.26.2

