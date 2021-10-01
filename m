Return-Path: <SRS0=FVIg=OV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCA9C433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Oct 2021 08:01:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99DE61261
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Oct 2021 08:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B99DE61261
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ivitera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C896016CB;
	Fri,  1 Oct 2021 10:00:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C896016CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633075300;
	bh=/W0e3wD+UEjSxwz8bPH7TNDprQJwcJtWJdPIx8jyNo0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sVCQ6y4GhNlKvUiyPPExBW3G8vI3tB14PBsbfnVHcY1LQ4yluOCgYExdpdmp/5O0X
	 tf3SA9Nt9GRoRurxXCdq4JiOcyg/UfoihaG2q5Yj1t1rul2nI9f5gfV1rCdNUHCvOG
	 9tK4T7Wr3RyKRxtNsBOSYxrICmVKpOKqiEloMfog=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 206B1F80165;
	Fri,  1 Oct 2021 10:00:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5F6A1F80245; Fri,  1 Oct 2021 10:00:48 +0200 (CEST)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E2CCF80165
 for <alsa-devel@alsa-project.org>; Fri,  1 Oct 2021 10:00:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E2CCF80165
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="LfRFdHqA"; 
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="GmSnL7eO"
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id CDA88A1A3D401;
 Fri,  1 Oct 2021 10:00:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1633075234; bh=/W0e3wD+UEjSxwz8bPH7TNDprQJwcJtWJdPIx8jyNo0=;
 h=From:To:Cc:Subject:Date:From;
 b=LfRFdHqA8HQkj7s2xEsOB2nlcVd7TGpq5n+BWcc9D37csALUPVCSzwwFrGh4+/UA1
 GVdaUYuY5bYFQNWxcWJ7yMsl1b7WhJrlgkTyNPdryvpMn/tEl4ArBFDICCKLzzy+na
 /gFkrMT1rxDkZc+3sa3uBi6UAAF6MEUEUJT3Doj4=
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 60MbxqH4pLOP; Fri,  1 Oct 2021 10:00:29 +0200 (CEST)
Received: from precision.doma (ip28.insite.cz [81.0.237.28])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id 806B6A1A3D400;
 Fri,  1 Oct 2021 10:00:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1633075229; bh=/W0e3wD+UEjSxwz8bPH7TNDprQJwcJtWJdPIx8jyNo0=;
 h=From:To:Cc:Subject:Date:From;
 b=GmSnL7eOkAsSkSfb9NIuGVuidx7G5bfo94rCGJ8dHpj2WZ4xa+NzDeZ2csmNTLEwQ
 HVVDnjkyW05/5ZLAttNrQd61YxvoM4lG7bOWiHnfJ7HM04mt6B49hndzQSlC8ysJYm
 Lvl9ebQ7m8KLoxsVyPEFRLK2szJSk1WKfB0fxrSc=
From: Pavel Hofman <pavel.hofman@ivitera.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] alsaloop: Adding openctl_elem debug log
Date: Fri,  1 Oct 2021 10:00:28 +0200
Message-Id: <20211001080028.6423-1-pavel.hofman@ivitera.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pavel Hofman <pavel.hofman@ivitera.com>
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

When debugging what ctl elem was found and opened (if any) a debug log is
helpful.

Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>
---
 alsaloop/pcmjob.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/alsaloop/pcmjob.c b/alsaloop/pcmjob.c
index 8b72af4..845ab82 100644
--- a/alsaloop/pcmjob.c
+++ b/alsaloop/pcmjob.c
@@ -1191,6 +1191,11 @@ static void openctl_elem(struct loopback_handle *lhandle,
 		if (err < 0) {
 			snd_ctl_elem_value_free(*elem);
 			*elem = NULL;
+		} else {
+			if (verbose)
+				snd_output_printf(lhandle->loopback->output,
+						"Opened PCM element %s of %s, device %d, subdevice %d\n",
+						name, snd_ctl_name(lhandle->ctl), device, subdevice);
 		}
 	}
 }
-- 
2.25.1

