Return-Path: <SRS0=ZrTp=W5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1E5C3A5A4
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 01:23:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E11721874
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 01:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iEFI2zBi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiXRaQYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E11721874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 017741677;
	Mon,  2 Sep 2019 03:22:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 017741677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567387410;
	bh=ARfo589B2cCkD8drnGPBjwq+QpX240ph+nYFJK+/Hv0=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iEFI2zBiUP4EOd8x22/7ub2OvNqSUTNEzzZsLXB6CWZ75UVKVFZgj24uZmkuXiEu8
	 nSq/BN0Fz5xpbSE5/sphVS9OcU6Gla4Kh4sf25Qk/ohhWkABZDJqy5N7adSUO5b/pQ
	 RIQIfiIpxbQ+2MULhfEFeiaic20i2/VMFo7srqu4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 60011F803D6;
	Mon,  2 Sep 2019 03:22:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1239FF803D7; Mon,  2 Sep 2019 03:22:37 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5DF07F80306
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2019 03:22:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5DF07F80306
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="CiXRaQYR"
Received: by mail-pl1-x644.google.com with SMTP id f19so5889998plr.3
 for <alsa-devel@alsa-project.org>; Sun, 01 Sep 2019 18:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id;
 bh=wCVrQb5TM1mDlXfTTV0rUtK8a/1Pk2/VY9ZxSmumEmE=;
 b=CiXRaQYRbz0uMiF8bTPhc5Nb/5khZIiuQum1tOJvlrCczE7Zncjz//w3MjEIDNc6w7
 MbvCsrrXFV+xTGszv0zfzSJYV7Ed5KK+GJym9jfpROM7hnjMqOuT09I0o/1MBM2JPmkF
 OeszwPdBA2rUYfVGIEJFlyqxacpwegdg+FUkVSzaYxFzC3ScU06c/OnQTwBkJVZ7vSP/
 oT1cjJkltSIN4I40m5fWKsg5DvJC14ygF7F2vayRmSNBhz6PbMvk3Aefqz9i8zLBaaY7
 RrwRGl6fuXC2WsZuCefM/3lJRVOc4X1KssJRjwwYUFHrgO8MxArDmKlAtyZaq7ErnkzQ
 Z2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=wCVrQb5TM1mDlXfTTV0rUtK8a/1Pk2/VY9ZxSmumEmE=;
 b=ngZ7FMdI1SLSNgC7dX1lcc4HLJ1Ubyb0h9qMVvMPkRujxREpouT+vMWGh/cshwnhM5
 MOvT7wqwUjiI1uywiAKQr9Rn7rtco6+hhWlzP1kSYVrKB+ljnYKO8ppKusd6JBKZ6GaO
 Q1K4kS3WX3uncXfPa7Bb6nepB0JvArAY8LhAxSG07DlWAavfIZGqZKhxy5c5A/QAc1K1
 nBQ4ppOUV6r5k7p/78iBg8RXbaFxm9UfdoepuoDfkaFrkUVgJvV0fJMD4qSfmEpv4jKM
 8T9Fpw2gS8/K8CGU5glCr7qA8X/tmO2zev3xOgX0nW93TmofmE1lhdnaOWGFAK4xVimN
 31hg==
X-Gm-Message-State: APjAAAUcpxX4prVghwGdoQscbVgZGX1ggjhUIuShR1WMHvCJYAobGUe1
 k8K4HkanO+b5o8zlnBuac8rYzPps5uc=
X-Google-Smtp-Source: APXvYqyYZGDYBto+20x4r+zQJO3Wmtgy6iqdz/0TMdwEN87PIFYDCYSyf1lBcw6ZOiqgyIY7rzxCJQ==
X-Received: by 2002:a17:902:7085:: with SMTP id
 z5mr27574842plk.102.1567387351259; 
 Sun, 01 Sep 2019 18:22:31 -0700 (PDT)
Received: from localhost.localdomain (76-14-106-55.rk.wavecable.com.
 [76.14.106.55])
 by smtp.gmail.com with ESMTPSA id n9sm3373173pfa.154.2019.09.01.18.22.30
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2019 18:22:30 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: alsa-devel@alsa-project.org
Date: Sun,  1 Sep 2019 18:22:29 -0700
Message-Id: <20190902012229.15796-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [alsa-devel] [PATCH] alsamixer: Remove exp10 usage
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
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Message-ID: <20190902012229.LLfYlbe1acrzn63jgAVo3Blzia56xIbLPyIWGS8K4Jg@z>

exp10 is a GNU extension and not available everywhere (eg. uClibc-ng).

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 alsamixer/volume_mapping.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/alsamixer/volume_mapping.c b/alsamixer/volume_mapping.c
index 48cfbe2..29ab061 100644
--- a/alsamixer/volume_mapping.c
+++ b/alsamixer/volume_mapping.c
@@ -108,9 +108,9 @@ static double get_normalized_volume(snd_mixer_elem_t *elem,
 	if (use_linear_dB_scale(min, max))
 		return (value - min) / (double)(max - min);
 
-	normalized = exp10((value - max) / 6000.0);
+	normalized = pow(10, (value - max) / 6000.0);
 	if (min != SND_CTL_TLV_DB_GAIN_MUTE) {
-		min_norm = exp10((min - max) / 6000.0);
+		min_norm = pow(10, (min - max) / 6000.0);
 		normalized = (normalized - min_norm) / (1 - min_norm);
 	}
 
@@ -143,7 +143,7 @@ static int set_normalized_volume(snd_mixer_elem_t *elem,
 	}
 
 	if (min != SND_CTL_TLV_DB_GAIN_MUTE) {
-		min_norm = exp10((min - max) / 6000.0);
+		min_norm = pow(10, (min - max) / 6000.0);
 		volume = volume * (1 - min_norm) + min_norm;
 	}
 	value = lrint_dir(6000.0 * log10(volume), dir) + max;
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
