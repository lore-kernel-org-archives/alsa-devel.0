Return-Path: <SRS0=mEIa=AU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A82C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:27:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E1BE206C3
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LESR8MCS";
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n7ANHiZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1BE206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C04C166E;
	Thu,  9 Jul 2020 16:26:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C04C166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594304852;
	bh=sW7wB6RfM1X6oeDCLmVuGIj7q0qV0hRMxYxbtmEGfUY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LESR8MCSOYoyx97mv8w0TebxmbwgNVEubmtECVT7bRhXXzvZMRrtO6jzmbSZY0zZp
	 SpUTSjp+upkATXJ90ZnaiO4Rd3fe6cmVLDVMvAFY1ne2485NEtLA0FpTg4yEhlBPNA
	 Z3siRoAWsp51TQLovTAd7JC3AWyNwmVdOMtV+A2E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 122E3F802EB;
	Thu,  9 Jul 2020 16:22:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8F201F80216; Thu,  9 Jul 2020 08:24:35 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A3C1F80117
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2020 08:24:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A3C1F80117
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="n7ANHiZq"
Received: by mail-pj1-x1044.google.com with SMTP id t15so637769pjq.5
 for <alsa-devel@alsa-project.org>; Wed, 08 Jul 2020 23:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ISVrga0MeVBVXV8tJBayYVEwtzPtNSsjsn+D36ztbxU=;
 b=n7ANHiZqo/wP2MDSrherNcYw1BUKu8Uq6Awo8ruGxtg+2ETagSmoLQSO2SSsGSu4KZ
 G7C5E7cSeNca0JzgbhSCUEpIzghk+/M9RR3c4RjASh5yMvYPi7xqKjj5+UjkFjFHqoG4
 mRFmsOMYmyYn5iIkFJu0bImrpDOuEKpTn0ACs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ISVrga0MeVBVXV8tJBayYVEwtzPtNSsjsn+D36ztbxU=;
 b=CEBr30qOxMwxz4ec2x54WyB3an1iujVS3eiw4mTInfOTqoeBratCBVTo/4dlHQ/Ihj
 Kxrq9ldHADXtX/8Q3EiWxXtSMuRtKLJ+785p8IT8CsuFJ+XDje+JZvgYr2DUxXmAqJS8
 4AY/QOwqUYaQMM2liEINvoijNxBpT1CZZC9hTp05v86FF3sVfKlhXjgm4j5ELyS4Gvj2
 r+s0Z/TY+m4ZVrO+xP0hGSWsFONoHpJjhrE7YxNFUQWwf891haHBhnsZTOgukXysGfm+
 LXNYKn3CLSi/s7xe6yKp57vm+rVGAZIsrohfN6KHzkgGDiMVCMU0l4CMt17H75SjjCOT
 k5/Q==
X-Gm-Message-State: AOAM530uyaO/Y5abPd3gsU/wu1Lz5/a24O++0ezrjFe0OYxh0W8GG44V
 fh16gPg7DHkeCWL7owe4QXCZhgwaHMo=
X-Google-Smtp-Source: ABdhPJzYosWzubJZKdoWZDKknfAjejUTHH+OI0IBRNHH1fOWIhc6CatpPJY06MaYy0C86GBzRqC3rA==
X-Received: by 2002:a17:902:968b:: with SMTP id
 n11mr51872444plp.331.1594275856750; 
 Wed, 08 Jul 2020 23:24:16 -0700 (PDT)
Received: from cyueh-p920.tpe.corp.google.com
 ([2401:fa00:1:10:f693:9fff:fef4:4e95])
 by smtp.gmail.com with ESMTPSA id d4sm1646846pgf.9.2020.07.08.23.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 23:24:16 -0700 (PDT)
From: Cheng Yueh <cyueh@chromium.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH] alsaucm: Fix ending with quotes commands
Date: Thu,  9 Jul 2020 14:24:12 +0800
Message-Id: <20200709062412.348-1-cyueh@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2020 16:22:25 +0200
Cc: Cheng Yueh <cyueh@chromium.org>
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

If we use 'alsaucm -n -b -' with 'get "CapturePCM/Internal Mic"' then
the alsaucm will report error and stop immediately. The reason is that
the parse_line in usecase.c appends an empty argument if a command ends
with quotes.

This change adds a patch to fix the parse_line function in usecase.c.

Signed-off-by: Cheng Yueh <cyueh@chromium.org>
---
 alsaucm/usecase.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/alsaucm/usecase.c b/alsaucm/usecase.c
index 1ed91ea..d39a159 100644
--- a/alsaucm/usecase.c
+++ b/alsaucm/usecase.c
@@ -130,6 +130,8 @@ static int parse_line(struct context *context, char *line)
 							*line == '\n'))
 			line++;
 		c = *line;
+		if (c == '\0')
+			return 0;
 		if (c == '\"' || c == '\'') {
 			start = ++line;
 			while (*line && *line != c)
-- 
2.26.2

