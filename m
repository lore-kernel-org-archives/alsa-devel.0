Return-Path: <SRS0=6EJT=2K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE875C43603
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:36:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645E121655
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rhFhJWrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645E121655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ABC87166D;
	Fri, 20 Dec 2019 16:36:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ABC87166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576856216;
	bh=RN0oef/j5MzyGgcc/B42iSPvsFiGjahZHVRBRukJZOc=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rhFhJWrkqbWfSIpDEjMoKS+Tg7DKX9grnxsWx+egUSvlco7YqoOqVDbBk4GHVRMZX
	 r4OQ/4uMxB0B1qqQ1gWTgH4V9JBHMo7SKNEZGQ8rYv8w9xh8Wt/eRsXBNjn4iTW/BX
	 sjZha+DMG9Nr85IczKuz3YvE2Dydd0J0qrAJaT6k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF87BF80269;
	Fri, 20 Dec 2019 16:34:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5096BF80269; Fri, 20 Dec 2019 16:34:29 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48082F80255
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 16:34:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48082F80255
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 34DD4AE87
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 15:34:24 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri, 20 Dec 2019 16:34:12 +0100
Message-Id: <20191220153415.2740-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191220153415.2740-1-tiwai@suse.de>
References: <20191220153415.2740-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 2/5] ALSA: hdsp: Make uapi/hdsp.h compilable
	again
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

Recently alsa-lib updated its content of sound/hdsp.h just by copying
the latest Linus kernel uapi/*.h, and this broke the build of
alsa-tools programs.  We used to modify the headers so that they can
be built without asoundlib.h and linux kernel headers, and the
verbatim copy doesn't work as is.

This patch removes again the linux/types.h inclusion and drop __user
prefix that broke the build and adjusts the corresponding code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/hdsp.h | 4 +---
 sound/pci/rme9652/hdsp.c  | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/uapi/sound/hdsp.h b/include/uapi/sound/hdsp.h
index 5dc0c3db0a4c..88c92a3fb477 100644
--- a/include/uapi/sound/hdsp.h
+++ b/include/uapi/sound/hdsp.h
@@ -20,8 +20,6 @@
  *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/types.h>
-
 #define HDSP_MATRIX_MIXER_SIZE 2048
 
 enum HDSP_IO_Type {
@@ -74,7 +72,7 @@ struct hdsp_config_info {
 #define SNDRV_HDSP_IOCTL_GET_CONFIG_INFO _IOR('H', 0x41, struct hdsp_config_info)
 
 struct hdsp_firmware {
-	void __user *firmware_data;	/* 24413 x 4 bytes */
+	void *firmware_data;	/* 24413 x 4 bytes */
 };
 
 #define SNDRV_HDSP_IOCTL_UPLOAD_FIRMWARE _IOW('H', 0x42, struct hdsp_firmware)
diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 87e60dd13066..b4c42c4fa201 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -4817,7 +4817,7 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 			 "initializing firmware upload\n");
 		firmware = (struct hdsp_firmware __user *)argp;
 
-		if (get_user(firmware_data, &firmware->firmware_data))
+		if (get_user(firmware_data, (__force void __user **)&firmware->firmware_data))
 			return -EFAULT;
 
 		if (hdsp_check_for_iobox (hdsp))
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
