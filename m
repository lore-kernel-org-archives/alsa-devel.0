Return-Path: <SRS0=92Yh=F6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C06CC433DB
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Dec 2020 21:40:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D91421E92
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Dec 2020 21:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D91421E92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 300FE17DC;
	Sat, 26 Dec 2020 22:39:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 300FE17DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609018847;
	bh=WL3dvaKnlqF/QmDYOtdc5Jhu6Hl1f+5yb6nuxwse0nI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UpwifQL+vpmpGYhf24LO42CRj3I99Oeyky2cOFdv//QnWrYHeNfd6XVrLOmVfKAai
	 oGw1cNqEpbbt1VgWLQ84f4Gvq2Q1rwrh53wJtm433JQyXWaj4X0jeLHD+AuTsZPmYl
	 LGTviHgJq96bhLPCtQf/+0AoD/Y5dMfoeVvG2MTM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B5888F804EB;
	Sat, 26 Dec 2020 22:36:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7D58F804CB; Sat, 26 Dec 2020 22:36:44 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB83DF80128
 for <alsa-devel@alsa-project.org>; Sat, 26 Dec 2020 22:36:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB83DF80128
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="UORcVBCi"
Received: by mail-pl1-x62d.google.com with SMTP id e2so3786854plt.12
 for <alsa-devel@alsa-project.org>; Sat, 26 Dec 2020 13:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CGMDXHzae7cbtDODzEaOuSaiCvodayE5Yptws/W6AnA=;
 b=UORcVBCiK45lya3zy5POm6OAXP90+Pe7EpeG7Ih0Wp3jw7lcj7v0BalQ1BLw2lTbQW
 rk7gZQP252PTSsNXYKH1HoSoKNXF0d0b8XWpsnofhnNye05EgwYzC6nC2piDSkzrjktO
 AhIeNx+mQqg/HriishHvnuXp7c24ddrU0UkZLte6elllcbBOlCSZ2owRs+m3oCeIzSQn
 5kJ6dzDSa2IuUANFMva/Y1HYdbgcd/4JG5N9Fy0pZJvFdnAdvXo2GkmwPi2mEqgIrjfa
 fM9kvLlTatd5wOeG0gmJGDmWlJK4Wat1JHCfMTbltMszDaNhjAq4nsJMaz7S8VYbb39o
 YQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CGMDXHzae7cbtDODzEaOuSaiCvodayE5Yptws/W6AnA=;
 b=Zlxi81i46KipWOzcQvzj5Dmnu9RjYJgaCI9BfU5MupjVzUexrAjYlSNnAZfZ09D58L
 i7f7/AbKNsezJdDnRD7b3FJpBCiCbeLk3lG69mZNlLUso9PHIMm0+IBSIUmTZbhQq4YQ
 sQSpZNmBA10fnYU5fjMg4qDvddIiII8AF2rhOObqNaSMtwR0+kNPBvGZMAv8zhaEXz4r
 I6OODC210ZsB1JkLWaQZWzcURIcyCsbmaGUaYKbFOxnkZWUMnSV0db/KiBDuuSNybpi4
 MyylQKWDoaHEAWZ3ilhOpPWQWdxxRwhOwVUsWFLL9rXqAbpQz8d02/7seVPfvlQOk1PO
 9xgg==
X-Gm-Message-State: AOAM532awxiRAcqC1eUVmgirEHorX+bHZg38zMUs3eo/nU0OjMSgjMSU
 PDAKYCqlxxkWSPfskN1SLWGLKCimEa1JWw==
X-Google-Smtp-Source: ABdhPJz7VK6+lGQPVIcWmBhIE6nkOYozvGsw9I239hPEr6/aHqux10xuUDfEj8Q3sM7yo35CH3iLPw==
X-Received: by 2002:a17:902:c40c:b029:da:74c9:df4f with SMTP id
 k12-20020a170902c40cb02900da74c9df4fmr13635795plk.68.1609018595652; 
 Sat, 26 Dec 2020 13:36:35 -0800 (PST)
Received: from viper.bn-i.net ([2001:470:b:65c:b92f:8d47:b3dd:6388])
 by smtp.gmail.com with ESMTPSA id b12sm30990560pft.114.2020.12.26.13.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Dec 2020 13:36:35 -0800 (PST)
From: Alex Henrie <alexhenrie24@gmail.com>
To: alsa-devel@alsa-project.org,
	perex@perex.cz,
	tiwai@suse.de
Subject: [PATCH 7/9] pcm_multi: remove dead assignment from _snd_pcm_multi_open
Date: Sat, 26 Dec 2020 14:35:45 -0700
Message-Id: <20201226213547.175071-8-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.29.2.368.ge46b91665e.dirty
In-Reply-To: <20201226213547.175071-1-alexhenrie24@gmail.com>
References: <20201226213547.175071-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Alex Henrie <alexhenrie24@gmail.com>
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

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 src/pcm/pcm_multi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/pcm/pcm_multi.c b/src/pcm/pcm_multi.c
index 53c414d5..5fa09b9b 100644
--- a/src/pcm/pcm_multi.c
+++ b/src/pcm/pcm_multi.c
@@ -1323,7 +1323,6 @@ int _snd_pcm_multi_open(snd_pcm_t **pcmp, const char *name,
 		err = -ENOMEM;
 		goto _free;
 	}
-	idx = 0;
 	for (idx = 0; idx < channels_count; ++idx)
 		channels_sidx[idx] = -1;
 	idx = 0;
-- 
2.29.2.368.ge46b91665e.dirty

