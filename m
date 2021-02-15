Return-Path: <SRS0=nH8J=HR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82699C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Feb 2021 15:15:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA0D64D9F
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Feb 2021 15:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA0D64D9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2756B15F2;
	Mon, 15 Feb 2021 16:14:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2756B15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613402125;
	bh=2z65OkD2NDFN8mknRyKCEpSUFU6OpYjSiC3Z0kKToUQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=moaBBjue7iW/S520vWrf0C9COSRF/PSk+hw0CDLggCFBTdSta02cihTIkNrVKG6r8
	 4Ltz0sxGlhxxWYQ2RFZDIFw8Ios3hTP2MNg/Z4NkS1n+Ixg4rnjWXkELCqTNk4f6Fz
	 IsQgHMQq6vRmbCQe5GJVSmP766U4kncloTvSQglo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A13DFF800C1;
	Mon, 15 Feb 2021 16:14:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 67F3BF80258; Mon, 15 Feb 2021 16:14:32 +0100 (CET)
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net
 (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
 by alsa1.perex.cz (Postfix) with SMTP id 38368F80089
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2021 16:14:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38368F80089
Received: from localhost.localdomain (unknown [183.202.157.205])
 by mail-app4 (Coremail) with SMTP id cS_KCgBHTz+3jypgdfp8AQ--.38031S4;
 Mon, 15 Feb 2021 23:14:07 +0800 (CST)
From: Dinghao Liu <dinghao.liu@zju.edu.cn>
To: dinghao.liu@zju.edu.cn,
	kjlu@umn.edu
Subject: [PATCH] ASoC: Intel: Skylake: Fix missing check in skl_pcm_trigger
Date: Mon, 15 Feb 2021 23:13:54 +0800
Message-Id: <20210215151356.15252-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgBHTz+3jypgdfp8AQ--.38031S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1fZr43ZFyxGw17uFy5twb_yoWfArgEgw
 4DWw1rXryUur4Fgr12kr43CF47Zrs7ZFn7KFy5trs0vry3Gr95G3WDury7u3yxWw4Fqa4j
 93ZFqrZrCay8ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbVAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
 Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
 n2IY04v7MxkIecxEwVAFwVW5WwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
 W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
 1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
 IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF
 0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
 VjvjDU0xZFpf9x0JUsZ23UUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0RBlZdtSal9AAAsR
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Tom Rix <trix@redhat.com>, Takashi Iwai <tiwai@suse.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
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

When cmd == SNDRV_PCM_TRIGGER_STOP, we should also check
the return value of skl_decoupled_trigger() just like what
we have done in case SNDRV_PCM_TRIGGER_PAUSE_RELEASE.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 sound/soc/intel/skylake/skl-pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index b1ca64d2f7ea..a5b1f333a500 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -516,6 +516,9 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 			return ret;
 
 		ret = skl_decoupled_trigger(substream, cmd);
+		if (ret < 0)
+			return ret;
+
 		if ((cmd == SNDRV_PCM_TRIGGER_SUSPEND) && !w->ignore_suspend) {
 			/* save the dpib and lpib positions */
 			stream->dpib = readl(bus->remap_addr +
-- 
2.17.1

