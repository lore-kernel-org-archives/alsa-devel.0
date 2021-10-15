Return-Path: <SRS0=/1nv=PD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA08C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 08:15:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D30D6108B
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 08:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D30D6108B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9AC6E169D;
	Fri, 15 Oct 2021 10:14:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9AC6E169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634285706;
	bh=HLIorxZDAdMo7td1ElrvgUjqV44JVAr8Kh3xz2oCPDQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=q3VTkcn1vsHIQ6RnYHlFrgl5P4Ti29Z5j1CKPgrLxlQUM7RDtdLRfgF9atef1GeYf
	 FtM9yorGrbMH9nUv0hDwqNK5vDi+NNxwk0zjhKXR6go/D0W7aNDguN3rGie+W/GbBI
	 AbtYbt9hDN3l47eevTKTo7+Bn6Bdi9hT1iekIjOA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29614F8025B;
	Fri, 15 Oct 2021 10:14:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AC93BF8025B; Fri, 15 Oct 2021 10:14:14 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by alsa1.perex.cz (Postfix) with ESMTP id E17FBF8028D
 for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2021 10:14:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E17FBF8028D
Received: from localhost.localdomain (unknown [124.16.138.128])
 by APP-01 (Coremail) with SMTP id qwCowAAXHAhCOGlhinkUBA--.25093S2;
 Fri, 15 Oct 2021 16:13:54 +0800 (CST)
From: Jiasheng Jiang <jiasheng@iscas.ac.cn>
To: vkoul@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
 tiwai@suse.com
Subject: [PATCH v2] ASoC: soc-compress: prevent the potentially use of null
 pointer
Date: Fri, 15 Oct 2021 08:13:53 +0000
Message-Id: <1634285633-529368-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowAAXHAhCOGlhinkUBA--.25093S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4kKFW8Kr4xAFy3Jr1kZrb_yoW8KF1Upr
 s7WrZ7tFyfJr4Ivw1rA3yF9F1fGryxuF409w1aq34xAr43XFsxWr1UtrWvyFy7ArZ8t34D
 X3sFv3y7X3Z8AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8ZwCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
 1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
 cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUeHUDDUUUU
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Cc: alsa-devel@alsa-project.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
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

There is one call trace that snd_soc_register_card()
->snd_soc_bind_card()->soc_init_pcm_runtime()
->snd_soc_dai_compress_new()->snd_soc_new_compress().
In the trace the 'codec_dai' transfers from card->dai_link,
and we can see from the snd_soc_add_pcm_runtime() in
snd_soc_bind_card() that, if value of card->dai_link->num_codecs
is 0, then 'codec_dai' could be null pointer caused
by index out of bound in 'asoc_rtd_to_codec(rtd, 0)'.
And snd_soc_register_card() is called by various platforms.
Therefore, it is better to add the check in the case of misusing.
And because 'cpu_dai' has already checked in soc_init_pcm_runtime(),
there is no need to check again.
Adding the check as follow, then if 'codec_dai' is null,
snd_soc_new_compress() will not pass through the check 
'if (playback + capture != 1)', avoiding the leftover use of
'codec_dai'.

Fixes: 467fece ("ASoC: soc-dai: move snd_soc_dai_stream_valid() to soc-dai.c")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 sound/soc/soc-compress.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index b4f5935..67c3df1 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -535,12 +535,14 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 	}
 
 	/* check client and interface hw capabilities */
-	if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_PLAYBACK) &&
-	    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_PLAYBACK))
-		playback = 1;
-	if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_CAPTURE) &&
-	    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_CAPTURE))
-		capture = 1;
+	if (codec_dai) {
+		if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_PLAYBACK) &&
+		    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_PLAYBACK))
+			playback = 1;
+		if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_CAPTURE) &&
+		    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_CAPTURE))
+			capture = 1;
+	}
 
 	/*
 	 * Compress devices are unidirectional so only one of the directions
-- 
2.7.4

