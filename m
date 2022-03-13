Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC2FC433EF
	for <alsa-devel@archiver.kernel.org>; Sun, 13 Mar 2022 08:57:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDF8216CB;
	Sun, 13 Mar 2022 09:56:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDF8216CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647161859;
	bh=fkRPoci9Rw3YfAmFTNDhONZVzqnIc15tyPywRygtNh8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W8VqnahjHFdlciR8eg3kLQhcVfAHtNo4paZewcZWYd/NHgOWEXIP63bcGBAyYiK36
	 BAkE5Bd7GS8pUnT6ho7+YWGm8cibVI7xUL2lttdupCap6bMN68YzAGTzGLCg1+Or9J
	 BK2l5xKgEvhtPxnNaqXNC1TtSa1zO8QaF4heBddU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 600DEF80095;
	Sun, 13 Mar 2022 09:56:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23272F80310; Sun, 13 Mar 2022 09:56:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D34F5F80095
 for <alsa-devel@alsa-project.org>; Sun, 13 Mar 2022 09:56:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D34F5F80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr
 header.b="XrHrNfTD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inria.fr; s=dc;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=p6RhWnOgz5gn6ZKATCVUa/Wp+aXaVj0QweG0UGMuM2M=;
 b=XrHrNfTD7tmUVD3KV5sKgKY2jHOQhL1FgXEuMg11nDFFB+SJHfiZDahv
 YmTzt3nnxfg4ZQYG00cjcwbMllpTZECyJTf0+pahIImsDp0ySt/GWF3dA
 7KpM6yii8IOk2coec+you88s317RvYr6GrIGVmxRLfGcJVfkXrftZI5JX 0=;
Authentication-Results: mail2-relais-roc.national.inria.fr;
 dkim=none (message not signed) header.i=none;
 spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr;
 dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; d="scan'208";a="25843487"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 09:56:40 +0100
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Jaroslav Kysela <perex@perex.cz>,
	Joe Perches <joe@perches.com>
Subject: [PATCH] ALSA: seq: oss: fix typo
Date: Sun, 13 Mar 2022 09:56:35 +0100
Message-Id: <20220313085635.102123-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
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

Fix typo in "announcement".

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---

This applies on top of:

From: Julia Lawall <Julia.Lawall@inria.fr>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>,alsa-devel@alsa-project.org,linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] ALSA: seq: oss: use kzalloc

 sound/core/seq/oss/seq_oss_init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq/oss/seq_oss_init.c b/sound/core/seq/oss/seq_oss_init.c
index 04a3376a6e66..42d4e7535a82 100644
--- a/sound/core/seq/oss/seq_oss_init.c
+++ b/sound/core/seq/oss/seq_oss_init.c
@@ -80,7 +80,7 @@ snd_seq_oss_create_client(void)
 
 	system_client = rc;
 
-	/* create annoucement receiver port */
+	/* create announcement receiver port */
 	strcpy(port->name, "Receiver");
 	port->addr.client = system_client;
 	port->capability = SNDRV_SEQ_PORT_CAP_WRITE; /* receive only */

