Return-Path: <SRS0=/2j+=HM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A5EC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 08:38:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F84C64E08
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 08:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F84C64E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0586916D1;
	Wed, 10 Feb 2021 09:37:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0586916D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612946306;
	bh=4rPDD7ISdXaVU1jUmJxwEPTqvOaFcmYDtt787rh6JAg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rJU9X5lJkv2J3eNWIZo6Ifg39OqIdZzxIt8myRjGMbvOjtAf95dtOUgyJro9XmtmL
	 4Q6c7e3BsOju2fdpn5nFZC7fgn+f2KRbGtLZY1i3fnNGyDNOGoMvgKGiPTjzfP+pB+
	 Ss4j6YqWFzZUXer+9sCt1xrm0S5EAPDRCgrejTp0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73420F80169;
	Wed, 10 Feb 2021 09:37:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE271F8022B; Wed, 10 Feb 2021 09:37:33 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 052F7F800F1
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2021 09:37:21 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id A342DA003E;
 Wed, 10 Feb 2021 09:37:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz A342DA003E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1612946240; bh=2eeytvMzzFItkgFT75jcEK2i8pfBKsGanj2LLO9p3pQ=;
 h=From:To:Cc:Subject:Date:From;
 b=be/WmKOl6d5it2Xz3CWNwuatvIQ3UEMXB+OVGLlO7Xlk/Ve3HgJH+a7i0LbohXGyq
 2nOpyNjCwdbBUI06xtCvrVZhK6/gFKOQRR3kwlXLkEz03rNVF7XcwN6ebKwX7nEkT8
 CfhHO6LVphZhzGepLVvYXgkuCipHvWXG9UclBoAE=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 10 Feb 2021 09:37:16 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Subject: [PATCH] ALSA: core - add missing compress device type to
 /proc/asound/devices
Date: Wed, 10 Feb 2021 09:37:13 +0100
Message-Id: <20210210083713.1034201-1-perex@perex.cz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vkoul@kernel.org>
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

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Cc: Vinod Koul <vkoul@kernel.org>
---
 sound/core/sound.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/sound.c b/sound/core/sound.c
index b75f78f2c4b8..302b6d12ab2b 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -337,6 +337,8 @@ static const char *snd_device_type_name(int type)
 		return "sequencer";
 	case SNDRV_DEVICE_TYPE_TIMER:
 		return "timer";
+	case SNDRV_DEVICE_TYPE_COMPRESS:
+		return "compress";
 	default:
 		return "?";
 	}
-- 
2.29.2
