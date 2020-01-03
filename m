Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E6DC00523
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:29:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC3520848
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="D8CS8Wsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC3520848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E98A16F4;
	Fri,  3 Jan 2020 09:29:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E98A16F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578040195;
	bh=LRQhTw2aLFv6/NnWD91ARW5YZTThRZr/bV0vf4M8dcE=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D8CS8Wsx6mBMz4ydq/53ZnWBIIDUaKjr/Kd/c7SaGpbVgW1mKeD0a8OvxZDhZhKTh
	 WWLEjWBS0ayfPXsxj9tqLevnPAZ1//Pp3fQUNKbEE/yXMs9gJEyW+9CMOBSfT3UeKL
	 C3qJnNxZcpkRg+gmA1cSRLAqllCc6xgiEG+uqY7o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2283F8036C;
	Fri,  3 Jan 2020 09:18:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A59ADF80336; Fri,  3 Jan 2020 09:17:53 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9A88F8027D
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 09:17:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9A88F8027D
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AFDAAB26B
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 08:17:20 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri,  3 Jan 2020 09:16:39 +0100
Message-Id: <20200103081714.9560-24-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200103081714.9560-1-tiwai@suse.de>
References: <20200103081714.9560-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 23/58] ALSA: ac97: Constify snd_ac97_bus_ops
	definitions
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

Now snd_ac97_bus() takes the const ops pointer, so we can define the
snd_ac97_bus_ops locally as const as well for further optimization.

There should be no functional changes by this patch.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/ac97/snd_ac97_compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/ac97/snd_ac97_compat.c b/sound/ac97/snd_ac97_compat.c
index 715daf141713..d2479bba75bf 100644
--- a/sound/ac97/snd_ac97_compat.c
+++ b/sound/ac97/snd_ac97_compat.c
@@ -53,7 +53,7 @@ static unsigned short compat_ac97_read(struct snd_ac97 *ac97,
 	return actrl->ops->read(actrl, ac97->num, reg);
 }
 
-static struct snd_ac97_bus_ops compat_snd_ac97_bus_ops = {
+static const struct snd_ac97_bus_ops compat_snd_ac97_bus_ops = {
 	.reset = compat_ac97_reset,
 	.warm_reset = compat_ac97_warm_reset,
 	.write = compat_ac97_write,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
