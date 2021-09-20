Return-Path: <SRS0=8ObE=OK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE54BC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Sep 2021 08:36:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F323F60F12
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Sep 2021 08:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F323F60F12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2594168B;
	Mon, 20 Sep 2021 10:36:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2594168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632127011;
	bh=o8WLB8aF6/0Rw3+6O0rXwDavRja1GXoKvyrFndLgQtU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qvOKxUGveOI7EjXveqntwAM4Aik0rrN6LfzHVgK3hG+8bqpiCdq0p6VwSC7yJUVi1
	 0PhCN6j1CHxAfPVvtaR/9zWQYJ9t59PcY2Z2RHp8Uscd5WFT5NX2aSCWGnnWadiFt3
	 kNTv+5QmaqJvn/Il4fzEDutxLlsSqAXexsq5c03o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B66EF80246;
	Mon, 20 Sep 2021 10:36:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5F708F8025D; Mon, 20 Sep 2021 10:35:59 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00224F80124
 for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2021 10:35:50 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id EFA8BA003F;
 Mon, 20 Sep 2021 10:35:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz EFA8BA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1632126949; bh=GMOkvvfrA00rCUBwQxBX0FQ8k7LayGLCnRvI2AllNG8=;
 h=From:To:Cc:Subject:Date:From;
 b=FiKSO8B32F3aUsR149uI1KMYOs5tdUyd6QlFae6FHiQe//aVmscHcIYya4WKxJzYX
 zwX4BCPWke9EDaJG+l8xWfqtdEVKJIV3qlF1ilS4DpwoAhSw6F/KwtGCNvNtxYw8DP
 8szrAUAq0ZhE6q7i8a9bnuQ4aWtMwgaqNGzKXk3Q=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 20 Sep 2021 10:35:43 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Subject: [PATCH] ALSA: rawmidi: introduce SNDRV_RAWMIDI_IOCTL_USER_PVERSION
Date: Mon, 20 Sep 2021 10:35:38 +0200
Message-Id: <20210920083538.128008-1-perex@perex.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, David Henningsson <coding@diwic.se>,
 stable@vger.kernel.org
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

The new framing mode causes the user space regression, because
the alsa-lib code does not initialize the reserved space in
the params structure when the device is opened.

This change adds SNDRV_RAWMIDI_IOCTL_USER_PVERSION like we
do for the PCM interface for the protocol acknowledgment.

Cc: David Henningsson <coding@diwic.se>
Cc: <stable@vger.kernel.org>
Fixes: 08fdced60ca0 ("ALSA: rawmidi: Add framing mode")
BugLink: https://github.com/alsa-project/alsa-lib/issues/178
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 include/sound/rawmidi.h     | 1 +
 include/uapi/sound/asound.h | 1 +
 sound/core/rawmidi.c        | 9 +++++++++
 3 files changed, 11 insertions(+)

diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
index 989e1517332d..7a08ed2acd60 100644
--- a/include/sound/rawmidi.h
+++ b/include/sound/rawmidi.h
@@ -98,6 +98,7 @@ struct snd_rawmidi_file {
 	struct snd_rawmidi *rmidi;
 	struct snd_rawmidi_substream *input;
 	struct snd_rawmidi_substream *output;
+	unsigned int user_pversion;	/* supported protocol version */
 };
 
 struct snd_rawmidi_str {
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 1d84ec9db93b..f906e50a7919 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -784,6 +784,7 @@ struct snd_rawmidi_status {
 
 #define SNDRV_RAWMIDI_IOCTL_PVERSION	_IOR('W', 0x00, int)
 #define SNDRV_RAWMIDI_IOCTL_INFO	_IOR('W', 0x01, struct snd_rawmidi_info)
+#define SNDRV_RAWMIDI_IOCTL_USER_PVERSION _IOW('A', 0x02, int)
 #define SNDRV_RAWMIDI_IOCTL_PARAMS	_IOWR('W', 0x10, struct snd_rawmidi_params)
 #define SNDRV_RAWMIDI_IOCTL_STATUS	_IOWR('W', 0x20, struct snd_rawmidi_status)
 #define SNDRV_RAWMIDI_IOCTL_DROP	_IOW('W', 0x30, int)
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 6c0a4a67ad2e..6f30231bdb88 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -873,12 +873,21 @@ static long snd_rawmidi_ioctl(struct file *file, unsigned int cmd, unsigned long
 			return -EINVAL;
 		}
 	}
+	case SNDRV_RAWMIDI_IOCTL_USER_PVERSION:
+		if (get_user(rfile->user_pversion, (unsigned int __user *)arg))
+			return -EFAULT;
+		return 0;
+
 	case SNDRV_RAWMIDI_IOCTL_PARAMS:
 	{
 		struct snd_rawmidi_params params;
 
 		if (copy_from_user(&params, argp, sizeof(struct snd_rawmidi_params)))
 			return -EFAULT;
+		if (rfile->user_pversion < SNDRV_PROTOCOL_VERSION(2, 0, 2)) {
+			params.mode = 0;
+			memset(params.reserved, 0, sizeof(params.reserved));
+		}
 		switch (params.stream) {
 		case SNDRV_RAWMIDI_STREAM_OUTPUT:
 			if (rfile->output == NULL)
-- 
2.31.1
