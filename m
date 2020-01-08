Return-Path: <SRS0=reWy=25=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAC6C282DD
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:59:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3281120720
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VmxEUuBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3281120720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 004BF171F;
	Wed,  8 Jan 2020 13:58:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 004BF171F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578488356;
	bh=lqI9GUmpQTvcCt+IPjJtb/STs0wrfejTnFxRWFdVTIY=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VmxEUuBxbw+fDSIIuE7K3ACj5YzwC11BQeucFGZCr7ZqwL44elGm/RMVhkp5iEIou
	 +1A624Lbwfin6JiudwJ/QgRN5Ett0JpJciIwVhWSpjjRta0lglGW7q4MG0W8YcI/wK
	 M41yRTAtofvyFb+NRQAI62Yk6xDMVZSnNj3jZlN4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7444FF80149;
	Wed,  8 Jan 2020 13:58:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A93DF80159; Wed,  8 Jan 2020 13:58:23 +0100 (CET)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2C520F8010B
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2020 13:58:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C520F8010B
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 17C797F26F29BD2CC0B6;
 Wed,  8 Jan 2020 20:58:14 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 8 Jan 2020
 20:58:07 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <perex@perex.cz>, <tiwai@suse.com>, <rfontana@redhat.com>,
 <allison@lohutok.net>, <hslester96@gmail.com>, <o-takashi@sakamocchi.jp>,
 <kjlu@umn.edu>, <yuehaibing@huawei.com>, <tglx@linutronix.de>
Date: Wed, 8 Jan 2020 20:58:03 +0800
Message-ID: <20200108125803.45584-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH -next] ALSA: pci: echoaudio: remove set but not
	used variable 'chip'
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

sound/pci/echoaudio/echoaudio.c: In function snd_echo_mixer_info:
sound/pci/echoaudio/echoaudio.c:1233:20: warning: variable chip set but not used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_vmixer_info':
sound/pci/echoaudio/echoaudio.c:1300:20: warning: variable 'chip' set but not used [-Wunused-but-set-variable]

commit e67c3f0fd44c ("ALSA: pci: echoaudio: remove usage
of dimen menber of elem_value structure") left behind this
unused variable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/pci/echoaudio/echoaudio.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 07fe0b3..0941a7a 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -1230,9 +1230,6 @@ static const struct snd_kcontrol_new snd_echo_intput_nominal_level = {
 static int snd_echo_mixer_info(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_info *uinfo)
 {
-	struct echoaudio *chip;
-
-	chip = snd_kcontrol_chip(kcontrol);
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
 	uinfo->value.integer.min = ECHOGAIN_MINOUT;
@@ -1300,9 +1297,6 @@ static struct snd_kcontrol_new snd_echo_monitor_mixer = {
 static int snd_echo_vmixer_info(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_info *uinfo)
 {
-	struct echoaudio *chip;
-
-	chip = snd_kcontrol_chip(kcontrol);
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
 	uinfo->value.integer.min = ECHOGAIN_MINOUT;
-- 
2.7.4


_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
