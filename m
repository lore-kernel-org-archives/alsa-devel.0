Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AED5C433EF
	for <alsa-devel@archiver.kernel.org>; Sat, 12 Mar 2022 10:28:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99A0917B4;
	Sat, 12 Mar 2022 11:27:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99A0917B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647080929;
	bh=EMUzluA3XixU0aEfPC4etxSq4T37+srFwqfRwmTkrFc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=otnnkwIpuwp5vuDVcEe5ABuWAOj+O6FRJ6BbXmg5i9RY5MxaxU0f+hGYx6iKd1Y9w
	 G3LiI85oD2YrudO82YzlQVERWGia3g4nZNTqAO0QHbWdg7MkQTGfS9dX01N4xPiOJz
	 1+6M6yJuiefz651OHpoPURywPP7KlQBnqMTRagkA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB501F8027D;
	Sat, 12 Mar 2022 11:27:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC731F801D5; Sat, 12 Mar 2022 11:27:19 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F16BF80171
 for <alsa-devel@alsa-project.org>; Sat, 12 Mar 2022 11:27:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F16BF80171
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr
 header.b="u0u3uhQk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inria.fr; s=dc;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C9vAruW4R//FRSIjiNqYU6Ft3MliOnywc0sb41/n6xw=;
 b=u0u3uhQkEIH037bzpmf6fonLaHE3/dSzkg9XXqDTu8x2VuKpLdMHbZqB
 tLzEawUQRv83wyBHcwa56iojCwJmeRdfcyETYat3e47YCG2zQ38fZVfqh
 XwGnl4PVBwaqecMy6IEwUSiduSNVbB6WOYP8tIqbe53jquEVQeJuR82cc s=;
Authentication-Results: mail2-relais-roc.national.inria.fr;
 dkim=none (message not signed) header.i=none;
 spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr;
 dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,175,1643670000"; d="scan'208";a="25781349"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 11:27:11 +0100
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 3/6] ALSA: seq: oss: use kzalloc
Date: Sat, 12 Mar 2022 11:27:02 +0100
Message-Id: <20220312102705.71413-4-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220312102705.71413-1-Julia.Lawall@inria.fr>
References: <20220312102705.71413-1-Julia.Lawall@inria.fr>
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

Use kzalloc instead of kmalloc + memset.

The semantic patch that makes this change is:
(https://coccinelle.gitlabpages.inria.fr/website/)

//<smpl>
@@
expression res, size, flag;
@@
- res = kmalloc(size, flag);
+ res = kzalloc(size, flag);
  ...
- memset(res, 0, size);
//</smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/core/seq/oss/seq_oss_init.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_init.c b/sound/core/seq/oss/seq_oss_init.c
index 0ee4a5081fd6..04a3376a6e66 100644
--- a/sound/core/seq/oss/seq_oss_init.c
+++ b/sound/core/seq/oss/seq_oss_init.c
@@ -66,7 +66,7 @@ snd_seq_oss_create_client(void)
 	struct snd_seq_port_info *port;
 	struct snd_seq_port_callback port_callback;
 
-	port = kmalloc(sizeof(*port), GFP_KERNEL);
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
 	if (!port) {
 		rc = -ENOMEM;
 		goto __error;
@@ -81,7 +81,6 @@ snd_seq_oss_create_client(void)
 	system_client = rc;
 
 	/* create annoucement receiver port */
-	memset(port, 0, sizeof(*port));
 	strcpy(port->name, "Receiver");
 	port->addr.client = system_client;
 	port->capability = SNDRV_SEQ_PORT_CAP_WRITE; /* receive only */

