Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B482C00523
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:55:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6AE222C4
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lQZc12kX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6AE222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3BC9217B6;
	Fri,  3 Jan 2020 09:54:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3BC9217B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578041716;
	bh=mfixm7lMuuWkOxxgoPQlfLReAVLU7+YEituh6jv8VDQ=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lQZc12kXTT79U3ScMzsA88Q94en7Mq4mjaQmCilOADM6ccDVSn2FYogO/45J0tiL2
	 gHKdzDhuM0IGlablT5rUHAMOHvkxgnpw0k0dZ9S2dmLOzeI1yp9LX0eXdFVpiaF5fM
	 r2h01hLQSQz92ogBv6+JGkibA1MA2+p49y7gjBhs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8CF3EF80553;
	Fri,  3 Jan 2020 09:19:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2B94F803DE; Fri,  3 Jan 2020 09:18:58 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52A9DF802EA
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 09:17:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52A9DF802EA
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6C3D2B28C
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 08:17:22 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri,  3 Jan 2020 09:17:12 +0100
Message-Id: <20200103081714.9560-57-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200103081714.9560-1-tiwai@suse.de>
References: <20200103081714.9560-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 56/58] ALSA: fm801: Constify
	snd_fm801_tea575x_gpios
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The snd_fm801_tea575x_gpios table is referred as read-only, hence it
can be declared as const gracefully.

There should be no functional changes by this patch.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/fm801.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 4117a053eb18..40dfad74f8e1 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -724,7 +724,7 @@ struct snd_fm801_tea575x_gpio {
 	char *name;
 };
 
-static struct snd_fm801_tea575x_gpio snd_fm801_tea575x_gpios[] = {
+static const struct snd_fm801_tea575x_gpio snd_fm801_tea575x_gpios[] = {
 	{ .data = 1, .clk = 3, .wren = 2, .most = 0, .name = "SF256-PCS" },
 	{ .data = 1, .clk = 0, .wren = 2, .most = 3, .name = "SF256-PCP" },
 	{ .data = 2, .clk = 0, .wren = 1, .most = 3, .name = "SF64-PCR" },
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
