Return-Path: <SRS0=JS7s=PG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C0EC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 19:45:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB7B610C9
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 19:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1FB7B610C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4732820;
	Mon, 18 Oct 2021 21:44:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4732820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634586323;
	bh=tUP+jz+lH0E5yXRLwAKM5umc97qUKn0tUZf6sJd638Y=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CgnatuS/ru3e9Ly63uG3PD6Eu26EqWJ+nc5nZOnKlG/8q0EI5VfJKeWitPKpIvGK/
	 +sK0btSZKt+QJRRQ4KhhTt7S6I0QzpQSp927yCChDxeLwbQ1Go831FX+s2/vsOQKSR
	 e5UsGict0z6i31oAnE997te92IAnlHCCyJd0nmc4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4330FF80217;
	Mon, 18 Oct 2021 21:44:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39413F80224; Mon, 18 Oct 2021 21:44:31 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr
 [80.12.242.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73943F801DB
 for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2021 21:44:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73943F801DB
Received: from pop-os.home ([92.140.161.106]) by smtp.orange.fr with ESMTPA
 id cYYUmZVOg1UGBcYYUmpEyj; Mon, 18 Oct 2021 21:44:22 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 18 Oct 2021 21:44:22 +0200
X-ME-IP: 92.140.161.106
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 kuninori.morimoto.gx@renesas.com, mikhail_durnev@mentor.com,
 joe@perches.com, pierre-louis.bossart@linux.intel.com
Subject: [PATCH] ASoC: rsnd: Fix an error handling path in 'rsnd_node_count()'
Date: Mon, 18 Oct 2021 21:44:16 +0200
Message-Id: <4c0e893cbfa21dc76c1ede0b6f4f8cff42209299.1634586167.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
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

If we return before the end of the 'for_each_child_of_node()' iterator, the
reference taken on 'np' must be released.

Add the missing 'of_node_put()' call.

Fixes: c413983eb66a ("ASoC: rsnd: adjust disabled module")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/sh/rcar/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 978bd0406729..6a8fe0da7670 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1225,6 +1225,7 @@ int rsnd_node_count(struct rsnd_priv *priv, struct device_node *node, char *name
 		if (i < 0) {
 			dev_err(dev, "strange node numbering (%s)",
 				of_node_full_name(node));
+			of_node_put(np);
 			return 0;
 		}
 		i++;
-- 
2.30.2

