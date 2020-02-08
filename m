Return-Path: <SRS0=oFba=34=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DECC35242
	for <alsa-devel@archiver.kernel.org>; Sat,  8 Feb 2020 22:21:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F9A2082E
	for <alsa-devel@archiver.kernel.org>; Sat,  8 Feb 2020 22:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uApuIZ3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F9A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88B111699;
	Sat,  8 Feb 2020 23:20:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88B111699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581200465;
	bh=GZud4VVNxESDohXqxYu2G3d8MOQ82Rer4cXuFM4ql+M=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uApuIZ3Sa0jmcCAaWKX5eFr3Otgqe3AiNQNWtR58c5Pw6yWeJC1sD2ljgVx4jp4l6
	 c7I7E34iR5QFKEiMqoOONJ6og9Fb1bG0hmU1SOh5PZeUYWZrWlTw9SFopi7N9ep6pL
	 R6Z5ILgWYUveS5nEpxr1kYWY+YTlvjSwKWn52SDM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E738F8015B;
	Sat,  8 Feb 2020 23:20:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B7DAF80162; Sat,  8 Feb 2020 23:20:13 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5874F80085
 for <alsa-devel@alsa-project.org>; Sat,  8 Feb 2020 23:20:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5874F80085
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1j0YSM-00012H-9J; Sat, 08 Feb 2020 22:20:06 +0000
From: Colin King <colin.king@canonical.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Date: Sat,  8 Feb 2020 22:20:06 +0000
Message-Id: <20200208222006.37376-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH] ALSA: hdsp: remove redundant assignment to
	variable err
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

From: Colin Ian King <colin.king@canonical.com>

Variable err is being assigned with a value that is never read, it is
assigned a new value in the next statement. The assignment is redundant
and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/rme9652/hdsp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index cc06f0a1a7e4..227aece17e39 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -3353,7 +3353,8 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 				return;
 			}
 		} else {
-			int err = -EINVAL;
+			int err;
+
 			err = hdsp_request_fw_loader(hdsp);
 			if (err < 0) {
 				snd_iprintf(buffer,
-- 
2.25.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
