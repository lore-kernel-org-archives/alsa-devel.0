Return-Path: <SRS0=JMHt=2M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBED1C2D0C3
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Dec 2019 02:56:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D9C206EF
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Dec 2019 02:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="unax5jqm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2Yv7qzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D9C206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 153DD15F8;
	Sun, 22 Dec 2019 03:55:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 153DD15F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576983361;
	bh=MkHhxdXmfT6N/6smI31dzA8nx1xOl1ShK3/kwFjONg0=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=unax5jqm2vwRMUMaXjMFWy/z3WGmqvAoECe6bg2vaezrgAb5WM9NKGe1RwpeBAs83
	 zboY+wh01OLhVQsH6AduQ/U9SOvDPsfskvlkzucsyNgwo8m17RoKXclRU161psRCra
	 dHl+ad1xEeWOBQ5WgbkyYq6547FWSp2SWonXYgJQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B615F80087;
	Sun, 22 Dec 2019 03:55:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23565F80136; Sun, 22 Dec 2019 03:55:08 +0100 (CET)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 142CBF800BC
 for <alsa-devel@alsa-project.org>; Sun, 22 Dec 2019 03:55:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 142CBF800BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="G2Yv7qzo"
Received: by mail-pg1-x544.google.com with SMTP id x7so6991549pgl.11
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2019 18:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b5apHG++cG39Pi15oENNaiAHtTdpi8QsUhfOBCjK38Q=;
 b=G2Yv7qzo8jQbnXHUZEQ40SwZ9jsSTYWF65WyvHEjBNiMCxcRBW9gydtHpNA6ESW/NN
 SJATn7HsDde43lqfGq+L6CmhoIwcVBgfGUlGdlxoAXjBWdZ2rERKYUWTMueLgtViVgrT
 y5sgkjXJqOg3P9iWaOUbInf53yAb2CbqAGasyrC0kmjrUa7ZWp0h+6ss0q3SkOzfnPrB
 Pcyz1JMFBFywIvpDNp3KBiBPirefDrUepULu03uFJKU8DJGiVW2Zw2ZqGDhPX+E9jRN0
 oUPTlUzhazrdpGrSfa9M4D7KZb9WLYOHp2AG+pZSqJQMpHqL9hcLnXR9iBJD+Fgxcvnl
 5goQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b5apHG++cG39Pi15oENNaiAHtTdpi8QsUhfOBCjK38Q=;
 b=uDVcFWt7FkujUkeZNTSHgxiQEkLFdE0nRbaguolz6Q0YgT1i71LMmQkUsbHH4nLyZd
 bU14t7VhZeVMbgSmNAJwTiRudxy7ALy/it7fN9o6+pOfI6ZE6UnAi3hMzJB+dYMI1l8U
 uMx61Su4G2Yr/A8XFG4mPBGwQQMZyog6gbNCOo+v2wXcTOiUPH+wrDlrqHJwlJduWKHr
 MFbSBZ4gtuxgjS4cYkz66kwBoRujqOhI5hKY1PqTVppVAVPAz7DjYKVFw9Mban/kVxI0
 oVFdvmXlqkueUAIHCn1kHpcEgjnEqd63Z17x9NA0FnL88SrnVmYVIF3Q8IqNFu2IkFwT
 hnVg==
X-Gm-Message-State: APjAAAUnfZ6dUEDosREvBWjVzmS8asEb2/7FPVDANTVinZy03+KihsFA
 1YIUXbVrRfu+nUZWTZfyp7Xvf6OsR58=
X-Google-Smtp-Source: APXvYqxwhSc6k+k0Ihhttkdxhl3pRiE3+k9J63gvw2Ai+LdOZ1NUCkOy26RnzdwSUA/0gvrVT6Khrw==
X-Received: by 2002:a63:510e:: with SMTP id f14mr24294693pgb.35.1576983302069; 
 Sat, 21 Dec 2019 18:55:02 -0800 (PST)
Received: from mangix-trapnet.lan ([69.42.0.214])
 by smtp.gmail.com with ESMTPSA id a10sm18853534pfc.35.2019.12.21.18.55.01
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Dec 2019 18:55:01 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: alsa-devel@alsa-project.org
Date: Sat, 21 Dec 2019 18:54:58 -0800
Message-Id: <20191222025458.745140-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Subject: [alsa-devel] [PATCH] xfer-opitons: Fix -Wformat=2 warnings
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

Allows the compiler to check types.

format string functions expect constant expressions, not constant
variables.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 axfer/xfer-options.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/axfer/xfer-options.c b/axfer/xfer-options.c
index 3740b16..d4e5ff2 100644
--- a/axfer/xfer-options.c
+++ b/axfer/xfer-options.c
@@ -422,8 +422,6 @@ static int generate_path_with_suffix(struct xfer_context *xfer,
 				     const char *template, unsigned int index,
 				     const char *suffix)
 {
-	static const char *const single_format = "%s%s";
-	static const char *const multiple_format = "%s-%i%s";
 	unsigned int len;
 
 	len = strlen(template) + strlen(suffix) + 1;
@@ -435,10 +433,10 @@ static int generate_path_with_suffix(struct xfer_context *xfer,
 		return -ENOMEM;
 
 	if (xfer->path_count == 1) {
-		snprintf(xfer->paths[index], len, single_format, template,
+		snprintf(xfer->paths[index], len, "%s%s", template,
 			 suffix);
 	} else {
-		snprintf(xfer->paths[index], len, multiple_format, template,
+		snprintf(xfer->paths[index], len, "%s-%i%s", template,
 			 index, suffix);
 	}
 
@@ -449,8 +447,6 @@ static int generate_path_without_suffix(struct xfer_context *xfer,
 				        const char *template,
 					unsigned int index, const char *suffix)
 {
-	static const char *const single_format = "%s";
-	static const char *const multiple_format = "%s-%i";
 	unsigned int len;
 
 	len = strlen(template) + 1;
@@ -462,9 +458,9 @@ static int generate_path_without_suffix(struct xfer_context *xfer,
 		return -ENOMEM;
 
 	if (xfer->path_count == 1) {
-		snprintf(xfer->paths[index], len, single_format, template);
+		snprintf(xfer->paths[index], len, "%s", template);
 	} else {
-		snprintf(xfer->paths[index], len, multiple_format, template,
+		snprintf(xfer->paths[index], len, "%s-%i", template,
 			index);
 	}
 
-- 
2.24.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
