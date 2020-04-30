Return-Path: <SRS0=nm6W=6O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3080BC83001
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:27:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B197B2073E
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IgAum2fW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bV+QKGRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B197B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13E5C1673;
	Thu, 30 Apr 2020 10:27:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13E5C1673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588235274;
	bh=5fB3+K47H7NlKHeXFfwi1dM8Q0oNd8xdDPgWa4m/H54=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IgAum2fWOJCi28lYSbXl8CJT2jLcO78GgoSrrAVrRIQPXcPRD/XUg9La02VF2jxxx
	 zueu0kp6IT7MMLQ13Et9qEe8NwytUeCH9uK+nD6QPPG094g6KyCNKQbE9mpzYvid/5
	 OAqyrHmQKwrsqWk1SYXxZ4MPqpDVAOos2lFKsOk4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08253F802DF;
	Thu, 30 Apr 2020 10:23:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 443E0F802E0; Thu, 30 Apr 2020 10:23:09 +0200 (CEST)
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com
 [IPv6:2607:f8b0:4864:20::f4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 90D20F802BC
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2020 10:23:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90D20F802BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="bV+QKGRA"
Received: by mail-qv1-xf4a.google.com with SMTP id bm3so5674943qvb.0
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2020 01:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=XVssmcUVddcBidhvz5kFSAVQSpL+gm7QgTGDD8dkeuQ=;
 b=bV+QKGRAgD3aTwZRxOJpx3+9xfL9bC88uaMWDnd9v4pn2gNkJRF/bautGarRcwtA23
 non5+DCQWOabmRRz4IGKFh0upYvXOl92UNQgid7P0K9U8aFexNEUFqZkVYDeE+yBNGk2
 1UlqKBU6c7xQ46pDM8/8fgjLpq+WPF4ewv2ly/QNKt3hkY8GYphOtMjogV1L4kh3Z78B
 eNZf1KEirM+r6saILEIQITdHxmOhEbJPAcaJnm/I9VfU7Hg07Alo+ZZax94FhG+JeFiE
 bm4cVSwGuzPuj/dESojXrL2kTzsOSuDQknPwVbnNKT/6smsLuIjYhsYEE8TqrFCPQ3ln
 W2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=XVssmcUVddcBidhvz5kFSAVQSpL+gm7QgTGDD8dkeuQ=;
 b=ssuGm72EQalDYSaAZVC2O+EiIhnq4hV3U99TehstNrO7nu88x77V9sznsAuhg4Wprr
 wZH67RRiETYq9DqmUpNJk6nrXsyoPaHQwLA2D/oxx/GY12ofBUgs2ubD/qOOpegDqOVk
 BIHEAFgDrhCyuj4L0ohsmj++YSsNdKtfeHjNESifYLcdUhiLElC3wU3D1nhMXETe4VKT
 g/k510yatgVZMzE8nB07y3KqYsU5lqOr+L6bfrFUAWezdh8fpoy1R4nq+d1wim5n8+/9
 XQDH5ns4Fsr1XILPyEW+rfzWhi0YvnFLyL5KCx6Qh676SSsxc26ameuD9AIXQENalOyq
 +8Ug==
X-Gm-Message-State: AGi0PuaWoFPiwquT7oQES9bcwKDu/BdLz9KGMduET4ziXTchXwATgabG
 L6z+ydRWIEhHtEweJvbRRww0FTG7eau+
X-Google-Smtp-Source: APiQypLxXBaRVULdlxMtwVhZe0TJmdqYrYQDwkLoSJiaL4kVNuo+i6gaQe0cDELTFhIaZnSenPmb1wUGeGen
X-Received: by 2002:a0c:f1d1:: with SMTP id u17mr1870971qvl.146.1588234981615; 
 Thu, 30 Apr 2020 01:23:01 -0700 (PDT)
Date: Thu, 30 Apr 2020 16:22:31 +0800
In-Reply-To: <20200430082231.151127-1-tzungbi@google.com>
Message-Id: <20200430082231.151127-7-tzungbi@google.com>
Mime-Version: 1.0
References: <20200430082231.151127-1-tzungbi@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 6/6] ASoC: rt5682: remove unwanted btn_type assignment
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

The following dev_err() is intended to print unexpected btn_type.
Removes the unwanted btn_type assignment.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/codecs/rt5682.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 19fb9f1d8f49..5d3b11756a34 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -1134,7 +1134,6 @@ static void rt5682_jack_detect_handler(struct work_struct *work)
 			case 0x0000: /* unpressed */
 				break;
 			default:
-				btn_type = 0;
 				dev_err(rt5682->component->dev,
 					"Unexpected button code 0x%04x\n",
 					btn_type);
-- 
2.26.2.303.gf8c07b1a785-goog

