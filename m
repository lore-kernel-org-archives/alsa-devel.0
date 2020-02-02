Return-Path: <SRS0=WHla=3W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D51C35240
	for <alsa-devel@archiver.kernel.org>; Sun,  2 Feb 2020 09:08:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC84206D3
	for <alsa-devel@archiver.kernel.org>; Sun,  2 Feb 2020 09:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EAMLJzZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC84206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76B001677;
	Sun,  2 Feb 2020 10:07:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76B001677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580634501;
	bh=0hqja6bNPgcJI+K4I00MZNV8Ssu91/lReGWmzd3euVE=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EAMLJzZBokiNN/EKunXTuD7yii56xqFjajTtwjmibyEMFBK8BzdUuHSOV7NJ746yD
	 68I8tr5lab6CfvF6oRTBFUtOSOqxP/Z7YB92nP44/qh2jJ8VPgGGUFogpsij5bxGrX
	 N5S8+vNHF55p+1UgoTFU2x380J8A9t6D/9GEzBcw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CC0FDF8015A;
	Sun,  2 Feb 2020 10:07:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE694F80162; Sun,  2 Feb 2020 10:07:29 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0137BF800B8
 for <alsa-devel@alsa-project.org>; Sun,  2 Feb 2020 10:07:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0137BF800B8
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AC734AF32
 for <alsa-devel@alsa-project.org>; Sun,  2 Feb 2020 09:07:25 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sun,  2 Feb 2020 10:07:24 +0100
Message-Id: <20200202090724.18232-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200202090724.18232-1-tiwai@suse.de>
References: <20200202090724.18232-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 2/2] ALSA: hdsp: Make the firmware loading
	ioctl a bit more readable
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

The firmware loading ioctl that is implemented for hdsp hwdep device
takes the reference of the address pointer, hence the current code is
rather confusing.  Also, due to the recent change in uapi header,
sparse also complains about the cast.

This patch tries to improve the readability by converting the
straightforward copy_from_user of the whole struct (which contains
only the pointer).

Fixes: d63e63d42107 ("ALSA: hdsp: Make uapi/hdsp.h compilable again")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme9652/hdsp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index ba2a47dd384c..25b3c5697343 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -4802,7 +4802,7 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 		break;
 	}
 	case SNDRV_HDSP_IOCTL_UPLOAD_FIRMWARE: {
-		struct hdsp_firmware __user *firmware;
+		struct hdsp_firmware firmware;
 		u32 __user *firmware_data;
 		int err;
 
@@ -4815,10 +4815,9 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 
 		dev_info(hdsp->card->dev,
 			 "initializing firmware upload\n");
-		firmware = (struct hdsp_firmware __user *)argp;
-
-		if (get_user(firmware_data, (__force void __user **)&firmware->firmware_data))
+		if (copy_from_user(&firmware, argp, sizeof(firmware)))
 			return -EFAULT;
+		firmware_data = (u32 __user *)firmware.firmware_data;
 
 		if (hdsp_check_for_iobox (hdsp))
 			return -EIO;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
