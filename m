Return-Path: <SRS0=+QmS=EH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44C4C4742C
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Nov 2020 17:18:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 379572236F
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Nov 2020 17:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RZ6GQybp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izooxtrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379572236F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 974C616A3;
	Sun,  1 Nov 2020 18:18:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 974C616A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604251134;
	bh=t6aOa5vI6ary+V1xAIVjlPhxY/xvtz0XBJnUDOWyP30=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RZ6GQybp4FW7LLDJeSJFfXS3izpAY2YfAC5T9VGcG9wuZAfIb6TeOrVkTv7/zbzKV
	 q8t2/VfdFlG54HeGiAiTShAKuIOOUCU9nB65RRtBddTGof8M2hnvPiD48TOqecqRze
	 hU2DY7LcSz0GJ89inY5PNDhyaGpVUkfgl9bhGEts=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F0C57F8015F;
	Sun,  1 Nov 2020 18:18:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85AD2F8012B; Sun,  1 Nov 2020 18:18:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5CEB8F8012B
 for <alsa-devel@alsa-project.org>; Sun,  1 Nov 2020 18:17:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5CEB8F8012B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="izooxtrs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604251075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=uuly4wAr/fzdpk263kpsg6J+QT6BwsiMCrn9kjrT59M=;
 b=izooxtrs/adL2fuXV3ORk1nyt2k/pv7qEwb0smzDMTwtPW+6Evz8UNGyW2qLr7ZRCYrJ/L
 BDzb4b8Uu7HMQ5ea82oM/IoQy3rDEVa9q1tyE/rSnQ9PjN7GagEJiKI+Uai51Xbb+luUXT
 Mc51id8lhODpUebLA91GnSuVeLJS6k8=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-ulZhmaiMMSSsQV2_r2Abhw-1; Sun, 01 Nov 2020 12:17:54 -0500
X-MC-Unique: ulZhmaiMMSSsQV2_r2Abhw-1
Received: by mail-ot1-f71.google.com with SMTP id h7so5278795otn.10
 for <alsa-devel@alsa-project.org>; Sun, 01 Nov 2020 09:17:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=uuly4wAr/fzdpk263kpsg6J+QT6BwsiMCrn9kjrT59M=;
 b=AyKgSe0OyghHZtvk14qbgfdeYblsdBg4SSg9QBiEkXKmXQ0Cg3SvdYNYC9BfZU4JC4
 GYOGLbBo5sFjSuKvQCYBFwFflPE7hzkp8evTjbw7jmx6B2qNqnKOOab88vowMQnJRlMB
 GVo6tIDN3mgOKjids351kpq2H/0wCS2wB1hrhqIP1U9VXqgo/3aXtfDsULiy+C1WGc3i
 1roziPwzoyO13ZxbQVz4sVLkW2NaqZVD0kG1Ro98+aSdxOzipp5P9ggEkpBwWeAYv8iV
 VYy9AADffL6hAjkOjn4Ndztw94+ldRnnuMcxKIpH9WZbLNxAUUPLYwO/WlDwPTwsxcER
 zj1g==
X-Gm-Message-State: AOAM530tMJJQXQVy03ZZZVPqPZSmfylLNrO3JZH+sne4FOAUFAq0svYS
 ijU7Jlbbrc6ACEWysJUQLjOmH6u7qbJCDWmWmfB76l2ul3jA6w2nQdvc0jprsOUaJNHA+0BbgcZ
 OBkQf/ZrUu280AWW8GOpd0YE=
X-Received: by 2002:a9d:3b84:: with SMTP id k4mr9883722otc.4.1604251073725;
 Sun, 01 Nov 2020 09:17:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQAVwtMBSipzPXHNXt3pGMhJq+m1IeDnexyQWxCJE3lz4owlX6fp7o5zeMAYeycBXI6n1i4A==
X-Received: by 2002:a9d:3b84:: with SMTP id k4mr9883697otc.4.1604251073213;
 Sun, 01 Nov 2020 09:17:53 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id t83sm2883674oie.58.2020.11.01.09.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2020 09:17:52 -0800 (PST)
From: trix@redhat.com
To: steven.eckhoff.opensource@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Subject: [PATCH] ASoC: TSCS454: remove unneeded semicolon
Date: Sun,  1 Nov 2020 09:17:42 -0800
Message-Id: <20201101171742.2304458-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Cc: Tom Rix <trix@redhat.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/soc/codecs/tscs454.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tscs454.c b/sound/soc/codecs/tscs454.c
index d0af16b4db2f..cd1f1a592386 100644
--- a/sound/soc/codecs/tscs454.c
+++ b/sound/soc/codecs/tscs454.c
@@ -177,7 +177,7 @@ static bool tscs454_volatile(struct device *dev, unsigned int reg)
 		return true;
 	default:
 		return false;
-	};
+	}
 }
 
 static bool tscs454_writable(struct device *dev, unsigned int reg)
@@ -197,7 +197,7 @@ static bool tscs454_writable(struct device *dev, unsigned int reg)
 		return false;
 	default:
 		return true;
-	};
+	}
 }
 
 static bool tscs454_readable(struct device *dev, unsigned int reg)
@@ -217,7 +217,7 @@ static bool tscs454_readable(struct device *dev, unsigned int reg)
 		return false;
 	default:
 		return true;
-	};
+	}
 }
 
 static bool tscs454_precious(struct device *dev, unsigned int reg)
@@ -246,7 +246,7 @@ static bool tscs454_precious(struct device *dev, unsigned int reg)
 		return true;
 	default:
 		return false;
-	};
+	}
 }
 
 static const struct regmap_range_cfg tscs454_regmap_range_cfg = {
-- 
2.18.1

