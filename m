Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E386C2D0C5
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 09:12:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C3992073B
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 09:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YKXh6lIC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIheWze8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3992073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63F4B165D;
	Tue, 10 Dec 2019 10:11:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63F4B165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575969168;
	bh=rM4MU5l+MH/8WQM2LPiULoqpHSfSnV4L7rPgYlUDY/Q=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YKXh6lICD3P+WLvNDYmfMnHUM6anFGpfnEaaNxfz/D7esXK3/yQlt+sy5aWda0SPK
	 XuWfCbAHOaN0OdcVGnutc3BlyxKluzYTOgqDNu6EeuIYLZAGaeQiRQsEU1pEYUXmvE
	 ZMSCXprLvBM7YvOqK3SvT79o9fztqvXRm8cTRnJo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F2269F80257;
	Tue, 10 Dec 2019 10:11:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3868EF8024A; Tue, 10 Dec 2019 10:10:58 +0100 (CET)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6693F801D8
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 10:10:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6693F801D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="LIheWze8"
Received: by mail-pf1-x443.google.com with SMTP id h14so8731009pfe.10
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 01:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/2bb85NdiLVYQHcFIrkxh6hcV2+mLDZuC89mTaxdlY0=;
 b=LIheWze8tbYJDsMbadKe3DsTV+4N3yyJWAvlHK+8/SC/KqUeg0tMNtXW02MDDOuZXw
 bmHuhCcoU8+0HAFdFvIXF4G0HSxYi8Fu7Y0pWHyPI7Mj4kA6kncA30LmUJhzpunQ0SyN
 d0HvfPPrNr7mpWA6Mtq8kvA8NpNko4egWlmDIqU/Vd5V8i4v/VWSfJKrAe1kkP8Ki6i3
 pHeG8fAxeWK7OKtUaFCjKeQYiyEPQ/GWAqxebxGsABr1yP9LtI/xW9A6qgE486sPqA5M
 uJVfiBEz1wx1DmeYIyvX9ZF5pwp116FW5K3Wku+byQAHFuFLup+y0PF780F72rlUOVb5
 cHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/2bb85NdiLVYQHcFIrkxh6hcV2+mLDZuC89mTaxdlY0=;
 b=eTbtEWnfKRPRmRXc/Hlp4gFccIk4wKOCyERiBpdKJVC8AijcyiXsiu8/KlzeDcenjS
 Sc2M5OP3kN7W9IPceVuFa3t0e/Gku7GVCkX7zOYPI4fB8kRWOCE6PDnuAPhxf14v+ME8
 kDEwfXva4ZU+aoWUskRyO7amzSYT8dembWZ8mdTZ+sk5IKzpM43PMcib+xN9nd2P6F8a
 mWi+mUH1gq7hryovUyyzoqMmj8B+WV3Mg7y5LVvqsV2wavcqouI/o1WOvJTkWoPH/RBM
 vVPJ/NRiwKTQTBjrLCWQyLfGiHlGQbyIObjBSvdUoKZuxif3+FgHX5jlF0Ue5q7BYI0U
 IXxA==
X-Gm-Message-State: APjAAAUcKu8LNqAHMUb8KusvwsDsq3+J2mRxWlR34WTBU5iDgFv2aHGW
 T7hHHKId8N4WLPLiifqE+k2bJhDGJws=
X-Google-Smtp-Source: APXvYqx7lu59NgGKrpzMGjUrwf9Ly2xTpuj0urQbNrkKFRsc7eVpDY1AhiPxBHAiGUExo9RaMG86SQ==
X-Received: by 2002:a63:d041:: with SMTP id s1mr23809454pgi.363.1575969050886; 
 Tue, 10 Dec 2019 01:10:50 -0800 (PST)
Received: from localhost.localdomain ([69.42.0.214])
 by smtp.gmail.com with ESMTPSA id d14sm2140551pjz.12.2019.12.10.01.10.49
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 01:10:49 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: alsa-devel@alsa-project.org
Date: Tue, 10 Dec 2019 01:10:46 -0800
Message-Id: <20191210091047.143081-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210091047.143081-1-rosenp@gmail.com>
References: <20191210091047.143081-1-rosenp@gmail.com>
MIME-Version: 1.0
Subject: [alsa-devel] [PATCH 2/3] topology/builder: Fix absolute value
	warning
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

next_hdr_pos is unsigned and promotes offset as such. This makes
the abs call useless.

Changed the abs call to labs and the offset to off_t to avoid this.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 src/topology/builder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/topology/builder.c b/src/topology/builder.c
index 3adbad45..98956dac 100644
--- a/src/topology/builder.c
+++ b/src/topology/builder.c
@@ -45,7 +45,7 @@ static int write_block_header(snd_tplg_t *tplg, unsigned int type,
 {
 	struct snd_soc_tplg_hdr hdr;
 	size_t bytes;
-	int offset = lseek(tplg->out_fd, 0, SEEK_CUR);
+	off_t offset = lseek(tplg->out_fd, 0, SEEK_CUR);
 
 	memset(&hdr, 0, sizeof(hdr));
 	hdr.magic = SND_SOC_TPLG_MAGIC;
@@ -64,7 +64,7 @@ static int write_block_header(snd_tplg_t *tplg, unsigned int type,
 			" offset 0x%x is %s by %d bytes\n",
 			tplg->next_hdr_pos, offset,
 			(unsigned int)offset > tplg->next_hdr_pos ? "ahead" : "behind",
-			abs(offset - tplg->next_hdr_pos));
+			labs(offset - (off_t)tplg->next_hdr_pos));
 		exit(-EINVAL);
 	}
 
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
