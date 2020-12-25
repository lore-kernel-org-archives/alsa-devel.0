Return-Path: <SRS0=e5Na=F5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9340FC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Dec 2020 03:10:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8551622DFB
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Dec 2020 03:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8551622DFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 856E31830;
	Fri, 25 Dec 2020 04:09:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 856E31830
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608865803;
	bh=Q1W/lNtVL2WpFC9bCcbOCo7iTX8Nnd/prn66FvjrHLI=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FL+lDqK46tElxmohyuM8EHGwzls9bwACd+2v1djxMC5Z0sPD6tHHS8uq0JKH+wAR/
	 zKM39hvr6DCiq7XEotNumKUeV2l75VMtTKBT9gaDOjdYo7LVIZbrh2r8aJkuxxHQm6
	 rm+ZNubZopN/gN+4oMwBoL9O0TgaJX95KgPppm4g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F580F80168;
	Fri, 25 Dec 2020 04:09:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2BA02F801D5; Fri, 25 Dec 2020 04:09:10 +0100 (CET)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5D534F80113
 for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2020 04:08:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D534F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="pOsu6x47"
Received: by mail-pf1-x44a.google.com with SMTP id e4so1635422pfc.11
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2020 19:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=m1f650izI/LeLsnEP7GH72CBiLW+VmowxZPawxvaOUA=;
 b=pOsu6x47U6Nw2Cg16giR1ckL+cmccTldKv+jyb4DHkSrR5aI2Qu0on8Uo+pVKKPyaK
 Aai7cUpUjdJXIEvjfoYUEVzntgR0smGbl11SV0kEnSq2DJ/iWePy4YG07fIs9Wfm97eh
 VoDv5NdTJuVzU+yh/QrOAVPP6ab7RbJOCNkcFjaQS1BsmHGYfpXVfA0I1tsZleRPLi88
 A2q1rwGHW9nN2LRjhwucZrXBogVnXSunNTglJtgX+PtOCHd7Oth2e16h3OBCsEO5ZdDI
 eAkmmyuekwKLF7mYp9tPJqCD/PgspJyRez9WyMSuVI7k54OKT/mgN/xAtM+GEyvrR1zP
 IUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=m1f650izI/LeLsnEP7GH72CBiLW+VmowxZPawxvaOUA=;
 b=pf8zOWW8J9smkZcVick7KFuR/0NYvyzUE8rbkrutQpsx79oTeWEy6rkmMHQL7qQVsl
 xTfw0gwD2YltkFhZ4fECVFUNUR8gyUM3hr1yaeH3Jql9gL+lRBIi/Hi9q2Eaysf34oJI
 FSZ4QHfN9odjwQha/9JrkjPzbvwl+t4saBQiOJa12xwwwbY15j0aZvIr3I5sv4+3FBU6
 9tV4Q4TpsMZsdLaygfHWO9ieMMiQGAdJ2xxWM6IC3lpgq5jruf1s4qXgscYom2/zsBgI
 1NjzQcgZMKab25JkufGdp482sc5hrCi53QDx9ugQuVi3GI6Jta+9ztGPwhZ+hBaRvpS+
 zBjw==
X-Gm-Message-State: AOAM531QVbafVoZx3VP06jWeDVSRAj3UJPiFZJ94UafKnFEzLRkzrAvK
 kqiGGL8uVDbnC8ow/+kSfdo0VwZIQDpG
X-Google-Smtp-Source: ABdhPJzv25Mr0hyjqFrkWj8Jc2rAoPQg9urIMQwtyyyJDDb6EhfuHoGMEZSrmo4z4YG9rldqPJwj17jvQyV4
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:725a:fff:fe41:c6a5])
 (user=tzungbi job=sendgmr) by 2002:a62:b410:0:b029:1a4:7868:7e4e with SMTP id
 h16-20020a62b4100000b02901a478687e4emr30769104pfn.62.1608865735820; Thu, 24
 Dec 2020 19:08:55 -0800 (PST)
Date: Fri, 25 Dec 2020 11:08:45 +0800
Message-Id: <20201225030845.4138497-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH] ASoC: rt1015: re-calibrate again when resuming
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org
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

Assuming the calibration state gets lost after system suspend.
Re-calibrates again when resuming.

The rt1015_priv is alloced by kzalloc.  No need to initialize cali_done
to 0 in component probe callback.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
The idea is inspired from previous discussion:
https://mailman.alsa-project.org/pipermail/alsa-devel/2020-December/178229.html

The patch applies after the series:
https://mailman.alsa-project.org/pipermail/alsa-devel/2020-December/178608.html

v1 attempt:
https://mailman.alsa-project.org/pipermail/alsa-devel/2020-December/178614.html

 sound/soc/codecs/rt1015.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index 4a9e2eaebe30..3b06eaddccaf 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -1055,7 +1055,6 @@ static int rt1015_probe(struct snd_soc_component *component)
 
 	rt1015->component = component;
 	rt1015->bclk_ratio = 0;
-	rt1015->cali_done = 0;
 
 	INIT_DELAYED_WORK(&rt1015->flush_work, rt1015_flush_work);
 
@@ -1113,6 +1112,10 @@ static int rt1015_resume(struct snd_soc_component *component)
 
 	regcache_cache_only(rt1015->regmap, false);
 	regcache_sync(rt1015->regmap);
+
+	if (rt1015->cali_done)
+		rt1015_calibrate(rt1015);
+
 	return 0;
 }
 #else
-- 
2.29.2.729.g45daf8777d-goog

