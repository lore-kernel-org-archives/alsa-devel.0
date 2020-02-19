Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1927C34047
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:51:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24F31206E2
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LGIji6PG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QlJeS/Ww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F31206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54A15167E;
	Wed, 19 Feb 2020 12:51:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54A15167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582113113;
	bh=QSheAr0rnsJS0OFGkttvIsPH2y/HkRubJ3us6eLT5Eo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LGIji6PGfbavSYBy9Yc5om0wpUXZ4jF76CJre0bM5ctv8tL1SjKW3xb451MDGGwu3
	 mllg5ro/C3wJdYXL+cDOuiInSAVGmVQs8xO+WyuSo4sHyrhE3SjGd9TFH6VBTsh88j
	 0Vz5byVJ0nRlWpzWU/be8gUh8cc5BKRbNnMQCmuI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD472F801F5;
	Wed, 19 Feb 2020 12:51:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C280F80273; Wed, 19 Feb 2020 12:51:00 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A993FF801F5
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 12:50:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A993FF801F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="QlJeS/Ww"
Received: by mail-wm1-x344.google.com with SMTP id t23so315888wmi.1
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 03:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=13koyGRfSI36B094w+YJ/HafK6KqgQmhuR18/pfh9NY=;
 b=QlJeS/WwAZ1oyQx8kTcmP7FFIOZmvhu6bpQ73FDD+kRCkIqNiJoQWbCB1lILOHaNdX
 ccRBFDlCOD4z6eUkgQPmhe4ShjrQSjlX1OaoICSfj2gEuySpV1cyuxEPx9SVXpmJoCu6
 K7b5s7pQAW9gEQTl5I6OH9RDtlv8q0M6Iw7AM+H0PsYr1yCvVUIkcGWEw+l6BaiAp99A
 w8JaRcOjStRwOSkvHv/CYTuoO5fNxKGLAi3MKbZv7+ZzH/amgBY14OdfFcKtX3qKttH8
 Bb62rS9cUFOStgbqNjeuQKnZ0M2mbQhcVwUVm4jpomvXs+RakwNcdWz3+vq7yu/keYvQ
 cj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=13koyGRfSI36B094w+YJ/HafK6KqgQmhuR18/pfh9NY=;
 b=IeCEsofoTZseW8lN2xwQA0D6Jpmv+MuHh1Sr+OClrK8XeIJxsU2A+T6Z3eJEZVGn2+
 V6Svws1+g820E4GcKabeH2S5qtOhyZ5rvyHN5nLjtYISyVNIpDyM1g62cIleQtxHA7vx
 NB6cIP7WXaxD26uBAKpcj69XrtgTyavaeAJBGrHD3VCx8pOpMnaPO1SQKA5vRlGOXk+2
 UJK0pkCIaKaxS4pWzkyBO+/84fFNSZX8V8ARyxufcBpLIqbQ3cqLteCG/W4PKyKLFjLk
 CCaGq/1tbYgoi826d2ocVA8qxx/pNicN/RBKWo5r60ytn2CcdUzVwt8T9FAVJ8xXpJtf
 ayXQ==
X-Gm-Message-State: APjAAAWM6AW55ptsEDJ9Dra10iGonon1pRlJPle2r+ETM/x2+eD51Px8
 y3+gMIX1ZYH2lxgffpsG6MUxeQ==
X-Google-Smtp-Source: APXvYqzQI4jfpHJN/5WPr1SSQOvLgeK/S64Itpix079YcW1KNtXmMgZuqHhXGf/bMC11dLJcOMSu6w==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr9808280wmb.32.1582113056786;
 Wed, 19 Feb 2020 03:50:56 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net.
 [82.243.161.21])
 by smtp.googlemail.com with ESMTPSA id b10sm2628851wrw.61.2020.02.19.03.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 03:50:56 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: dpcm: remove confusing trace in dpcm_get_be()
Date: Wed, 19 Feb 2020 12:50:48 +0100
Message-Id: <20200219115048.934678-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Jerome Brunet <jbrunet@baylibre.com>
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

Now that dpcm_get_be() is used in dpcm_end_walk_at_be(), it is not a error
if this function does not find a BE for the provided widget. Remove the
related dev_err() trace which is confusing since things might be working
as expected.

When called from dpcm_add_paths(), it is an error if dpcm_get_be() fails to
find a BE for the provided widget. The necessary error trace is already
done in this case.

Fixes: 027a48387183 ("ASoC: soc-pcm: use dpcm_get_be() at dpcm_end_walk_at_be()")
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-pcm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 63f67eb7c077..aff27c8599ef 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1270,9 +1270,7 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 		}
 	}
 
-	/* dai link name and stream name set correctly ? */
-	dev_err(card->dev, "ASoC: can't get %s BE for %s\n",
-		stream ? "capture" : "playback", widget->name);
+	/* Widget provided is not a BE */
 	return NULL;
 }
 
-- 
2.24.1

