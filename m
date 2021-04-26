Return-Path: <SRS0=uf39=JX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F18DC433B4
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Apr 2021 15:59:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13220610FA
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Apr 2021 15:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13220610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98DD416BA;
	Mon, 26 Apr 2021 17:58:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98DD416BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619452766;
	bh=2eiY5L+vGtzUomQ4o9qF+N1jhfLW76Wfmw9j3He9grE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OiRiMGFY0Vigd7oJEWTtsC+3UpYi70bUdUkOxD+p5tAsLx4tyangpy/8OlM5PipVc
	 Mt6Yib3Afi6K4WwTgm6LuH4l4nnyI9mF6lu1QsvN89/e8/89SEWTXp/L4pa96YbFmS
	 xdVMhz82vbfrbJ+kzxBoIiwNbLAJ2w5Z4glkRdpk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EFB06F800F0;
	Mon, 26 Apr 2021 17:58:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C2BBAF8016C; Mon, 26 Apr 2021 15:11:52 +0200 (CEST)
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
 by alsa1.perex.cz (Postfix) with ESMTP id C7360F8012A
 for <alsa-devel@alsa-project.org>; Mon, 26 Apr 2021 15:11:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7360F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn
 header.b="agRAkd43"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-Id:MIME-Version:Content-Transfer-Encoding; bh=/QgKBQKtpH
 CTSvscT6d11VmXDT/YU2J4lEji1c+nLKI=; b=agRAkd43E1+ljApbRU9ji1JzSs
 nAy+//8teGIC/w6QUrixXVcOC3bKV/ADfzNqGW7czIgXo/lUbZ6YkWO3D/3/aYt1
 zap7/zbvSdWsyspZhBkb/4UHK2bDGJiVI9itJxZ1K+KWixkDbFCPHTj4RNBaeHkz
 5r65lv8APeX/b+NEk=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
 by newmailweb.ustc.edu.cn (Coremail) with SMTP id
 LkAmygC3vp4DvIZgpu5KAA--.5537S4; 
 Mon, 26 Apr 2021 21:11:31 +0800 (CST)
From: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH] sound/isa/sb/emu8000: Fix a use after free in
 snd_emu8000_create_mixer
Date: Mon, 26 Apr 2021 06:11:29 -0700
Message-Id: <20210426131129.4796-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygC3vp4DvIZgpu5KAA--.5537S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WF47KF4kCrWkuw1kuw1rJFb_yoW8Gr4fpr
 WkJa129ay8Jrs0vFnFvrnrKr1fuanagFnrCw4DC3Zxur13Jr1j9ryxJr4akay5CFn8uanx
 ur1UJr93tanxG3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
 648v4I1lc2xSY4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
 x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAI
 cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
 nxnUUI43ZEXa7VUjkhLUUUUUU==
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
X-Mailman-Approved-At: Mon, 26 Apr 2021 17:58:34 +0200
Cc: alsa-devel@alsa-project.org, Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
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

Our code analyzer reported a uaf.

In snd_emu8000_create_mixer, the callee snd_ctl_add(..,emu->controls[i])
calls snd_ctl_add_replace(.., kcontrol,..). Inside snd_ctl_add_replace(),
if error happens, kcontrol will be freed by snd_ctl_free_one(kcontrol).
Then emu->controls[i] points to a freed memory, and the execution comes
to __error branch of snd_emu8000_create_mixer. The freed emu->controls[i]
is used in snd_ctl_remove(card, emu->controls[i]).

My patch set emu->controls[i] to NULL if snd_ctl_add() failed to avoid
the uaf.

Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 sound/isa/sb/emu8000.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/isa/sb/emu8000.c b/sound/isa/sb/emu8000.c
index 0aa545ac6e60..1c90421a88dc 100644
--- a/sound/isa/sb/emu8000.c
+++ b/sound/isa/sb/emu8000.c
@@ -1029,8 +1029,10 @@ snd_emu8000_create_mixer(struct snd_card *card, struct snd_emu8000 *emu)
 
 	memset(emu->controls, 0, sizeof(emu->controls));
 	for (i = 0; i < EMU8000_NUM_CONTROLS; i++) {
-		if ((err = snd_ctl_add(card, emu->controls[i] = snd_ctl_new1(mixer_defs[i], emu))) < 0)
+		if ((err = snd_ctl_add(card, emu->controls[i] = snd_ctl_new1(mixer_defs[i], emu))) < 0) {
+			emu->controls[i] = NULL;
 			goto __error;
+		}
 	}
 	return 0;
 
-- 
2.25.1


