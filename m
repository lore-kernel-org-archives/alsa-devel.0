Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83046C4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Nov 2022 20:09:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC1761DA;
	Tue, 22 Nov 2022 21:09:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC1761DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669147793;
	bh=B09zuvJyHafn/HUu2zNVb/nEhooqB58FmlcG9lyxNug=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=t9boJC4/kdNUIODePE1HbyUmcKZVWNx3vAW47EdwJHG6NRn4hWkmKW1/ew8lvPpqA
	 m1gbL+fn/tPrqkSoC/rl4bfI5novC0nk+lTNhjG+yYgkvkmyYLv5RBh4MJ19nLQbvz
	 +KENidn0cYIZJLA2cM+myIicIzC8NEGOw7tO/uHY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A939F8026A;
	Tue, 22 Nov 2022 21:09:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E32EF80149; Tue, 22 Nov 2022 21:09:01 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17C57F80149
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2022 21:08:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17C57F80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="cl6HAHsy"
Received: by mail-lj1-x236.google.com with SMTP id z24so19181503ljn.4
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2022 12:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sXUW0a6Ff8psj/R6aZYguKr5STKCT04i6o2Czkyr1nI=;
 b=cl6HAHsy3tjvvd4e4yK9SmzUE3tr+Gk6oNXpZw1qroE9OvLHrPAkJ7i2yJ+gyYrynr
 3nX7GZat+e7v8Oj4Vj5/OxigiF2xNhYpwoB+U5NNn6egDKIc+cDavlJAOsqJirmlSJEa
 nVIVPLrOE00b08L3kFOA5w2X1R8VJ1YNfdJlvEzThE9ofWGO8evDtb9tN7+pK5o/qBYu
 Kj+VbqfXpOdWcrsoELjgX75ZRqLsxHvx/bcIjL7YNio+fE6TubHnAZa4g41q3X66KGO1
 QM7EW+XeC2wdPzk5axmFu5e1KNzER+wDJcPqEz9RNjVlMDLBChG0M8HeYiugMbbUqklA
 CAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sXUW0a6Ff8psj/R6aZYguKr5STKCT04i6o2Czkyr1nI=;
 b=3q4YbC8jF7BPdw5b0s1t0UOUbf3i6hH+hNtlvxtL1SV+oz5MDC5RXLfWVIQdEzp7nV
 LIX0EK7O8Ad0SGfAzuS4oxJI0M7NYSZJOE7ymRcbh8AtdEEqMQkdPH2qMDYoe7fDKKwY
 gCF11CF08AsWdFK9lntxGRqMqHOsDmJi9nNi0V+GfrHz6IPBvPjA9ig9brxBcNWvTVYw
 vp5byivwtvippxCF5QucvMsqcFYm+2BG80N/y/5i2/shRT8wjoQ3Lkqdz1luHMLwray5
 DJ8UHjTXcPZGIeqWvYkGhqeWIlr6s6gZfzBDCtRL0L/MzmbumFWVx7obP7blNPJhVa6n
 9gxQ==
X-Gm-Message-State: ANoB5pmGsmEMbVlSt5QY4o4Glu0GN0J0mF7s3jIbzd/t3/r1jKZxm2NY
 c/ywdlZ0qPNCdgPqhmu4X38=
X-Google-Smtp-Source: AA0mqf7+Auws5Fe5VM1larsYdpz+GpM8nruuKW0Ba5lB/mRlJZvW4hmmdtILhMBj0v/rBA9j/qikLQ==
X-Received: by 2002:a2e:be04:0:b0:267:9d30:5ba with SMTP id
 z4-20020a2ebe04000000b002679d3005bamr7874525ljq.284.1669147734075; 
 Tue, 22 Nov 2022 12:08:54 -0800 (PST)
Received: from localhost.localdomain ([2.56.241.21])
 by smtp.gmail.com with ESMTPSA id
 z19-20020a056512371300b004b4e6dab30esm59977lfr.222.2022.11.22.12.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Nov 2022 12:08:53 -0800 (PST)
From: Xiaolong Huang <butterflyhuangxx@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH] ALSA: rawmidi: fix infoleak in
 snd_rawmidi_ioctl_status_compat64
Date: Wed, 23 Nov 2022 04:08:41 +0800
Message-Id: <20221122200841.1026335-1-butterflyhuangxx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Xiaolong Huang <butterflyhuangxx@gmail.com>, alsa-devel@alsa-project.org,
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

The compat_status is declared off of the stack, so it needs to
be zeroed out before copied back to userspace to prevent any
unintentional data leakage.

Signed-off-by: Xiaolong Huang <butterflyhuangxx@gmail.com>
---
 sound/core/rawmidi_compat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/rawmidi_compat.c b/sound/core/rawmidi_compat.c
index 68a93443583c..6afa68165b17 100644
--- a/sound/core/rawmidi_compat.c
+++ b/sound/core/rawmidi_compat.c
@@ -80,6 +80,7 @@ static int snd_rawmidi_ioctl_status_compat64(struct snd_rawmidi_file *rfile,
 	if (err < 0)
 		return err;
 
+	memset(&compat_status, 0, sizeof(compat_status));
 	compat_status = (struct compat_snd_rawmidi_status64) {
 		.stream = status.stream,
 		.tstamp_sec = status.tstamp_sec,

base-commit: eb7081409f94a9a8608593d0fb63a1aa3d6f95d8
-- 
2.25.1

