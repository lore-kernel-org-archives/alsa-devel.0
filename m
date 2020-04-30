Return-Path: <SRS0=nm6W=6O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042B9C83001
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:24:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853F02073E
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ROwmux/Q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="CNB9+TKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853F02073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8ABB1693;
	Thu, 30 Apr 2020 10:23:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8ABB1693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588235063;
	bh=t15x5Vb4DTvKP5MHJMOItoN1DowY80RmVr3Rid133gc=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ROwmux/Qu2FLyXRwQkosB3oeoCvcjTOTnZ3WehEs7Esmnx+sq9LPpfIgEjCVIHc9l
	 H+win8lzClv3ht/9hwu25YsAM+mWdPKf8Y2oU1pdCFb30d1wCU8cy5s/gNtexNpZBj
	 Vy5C4Vj/yOqHwAlZCdV+16blqy4p3bmoT5ZY8FVw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B6EBBF801EB;
	Thu, 30 Apr 2020 10:22:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 186D9F801F7; Thu, 30 Apr 2020 10:22:46 +0200 (CEST)
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com
 [IPv6:2607:f8b0:4864:20::849])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9B71F801EB
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2020 10:22:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9B71F801EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="CNB9+TKO"
Received: by mail-qt1-x849.google.com with SMTP id x7so6175118qtv.23
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2020 01:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=1+GEtmVFuX/2EXcfu2CNuJAhwznrW7W2shal2KNKf4U=;
 b=CNB9+TKOKXQ/5/0uH/nkpXmSJ9ypm/qhcK5DttdMyunrYumKR7tULVzVeWynb0luYw
 9cuI2fHrTXEJr6utz2SuCLBLA8vU3SZLcZvmwn6tw58ITtOMiWDiyNtbqMylie+g4PY6
 RbNime1t0LAKPDdboYzaXqgSNNQIi/BhOfm+2E9HNaF/RWzSMQEgPRhtKryFd3Whp6HV
 xZn/Par9HXPUcSTv2aZdDJunbQKS+DbAWyFIffBNBXgwjtrpS+XjIoRnjuF9HX886im3
 aCz1zcTF2KK7B/8d+HaGPrIiHZu7qTF5CAoBcGbUkatnaJpDNNTo3yy8tf0OSvj5NSTV
 eWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=1+GEtmVFuX/2EXcfu2CNuJAhwznrW7W2shal2KNKf4U=;
 b=gPdVvRAEz5CRO4yBXPMOOOqjmZH8oagaaahshBugeyLn1Mbn6aRX+w4/JGAfqxpQgc
 FqzKPD62wMi3Ek3wnR6XDlMvAA8w7nBf1aDnjTbjsH3Hma3hayr2cLOgPMrptMUIoRdQ
 a1D4NutajS2NhdV3n1jX7hy92+AKLAbnkxLSgX/oZky4SrubrH8HfQXFJ5IeP6y6RIRy
 r+rMeelsurhxQ5vBdQQDgA5f/PUQ1cJbMDz71uXdkSUCDFuabtY3HIHF2d9sJWtbH2pd
 jzbFh2a1mzVS7+L1NVdjOlseZ+CLNQOiysOa4u+XQys5llqGAxItW4pGcF8x+++a9kRq
 urhg==
X-Gm-Message-State: AGi0PubLed+XRoN86zTytCj+DhncL6r1zzhcM8Qmh5NviH5s8CpnxTkh
 Nz7kQGiJ7y1/docrH1zDZAGt5QTkkgM3
X-Google-Smtp-Source: APiQypJxOgB1DhHa3WPp5+/isZqPO9vC/p/vFV9YVW6y00EVs9ikoiiE0yJLuTLpd3KeJffkUIwqg1u1IgVj
X-Received: by 2002:ad4:4e83:: with SMTP id dy3mr1862442qvb.1.1588234959917;
 Thu, 30 Apr 2020 01:22:39 -0700 (PDT)
Date: Thu, 30 Apr 2020 16:22:25 +0800
Message-Id: <20200430082231.151127-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 0/6] ASoC: rt5682: apply some refactors
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

The series tries to refactor the coding style to follow most conventions.

The 4th patch converts pr_() to dev_().
(https://mailman.alsa-project.org/pipermail/alsa-devel/2020-March/164849.html)

The 6th patch changes the behavior a bit to restore its original intent.

Tzung-Bi Shih (6):
  ASoC: rt5682: simplify assertions
  ASoC: rt5682: fix space issues
  ASoC: rt5682: remove empty default case
  ASoC: rt5682: replace message printing from pr_() to dev_()
  ASoC: rt5682: remove duplicate rt5682_reset() calls
  ASoC: rt5682: remove unwanted btn_type assignment

 sound/soc/codecs/rt5682.c | 198 ++++++++++++++++----------------------
 1 file changed, 84 insertions(+), 114 deletions(-)

-- 
2.26.2.303.gf8c07b1a785-goog

