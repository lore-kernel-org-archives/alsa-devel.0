Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D2CC433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Mar 2022 06:29:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE0EE1684;
	Wed,  2 Mar 2022 07:29:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE0EE1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646202594;
	bh=EQGyjjElIr/AxthOCGB2zkT8uao9H4VooG4OpcQNLxY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vgdz8qRTNEpMUHnxJpKGSF4fSUzpTDZ6u4ix2r4bG8CCrURPIYsFAI6ynfva3+I+Y
	 btyYjd0yqAm3gjP/lIVoCKZ3bvDOoavAg+VzY9hlHMGF7/CQZ9E34z5iFBTwP+Txda
	 /d1yvAlQxrtUJpRwyT9Q8suUKcpBrJtYh84sXqRk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CC0CF80171;
	Wed,  2 Mar 2022 07:29:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F547F801D5; Wed,  2 Mar 2022 07:29:02 +0100 (CET)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by alsa1.perex.cz (Postfix) with ESMTP id 33267F80054
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2022 07:28:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33267F80054
Received: from localhost.localdomain (unknown [124.16.138.126])
 by APP-01 (Coremail) with SMTP id qwCowACHjPCeDh9iXMcDAg--.17642S2;
 Wed, 02 Mar 2022 14:28:50 +0800 (CST)
From: Jiasheng Jiang <jiasheng@iscas.ac.cn>
To: kuninori.morimoto.gx@renesas.com
Subject: [PATCH v3] ASoC: fsi: Add check for clk_enable
Date: Wed,  2 Mar 2022 14:28:44 +0800
Message-Id: <20220302062844.46869-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACHjPCeDh9iXMcDAg--.17642S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr47tF15uFW3uw4kKFW7Arb_yoWkuFc_Aa
 1jg39Iqw15urWfCasrJr4UJ34j9r4UZF1UGryIqF1ftayUJr15ur4UZr9Yvrn0qw1a9as3
 A3WDZr4xArW3CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb38FF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
 6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
 Y2ka0xkIwI1lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
 1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
 b7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
 vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI
 42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
 evJa73UjIFyTuYvjfUnuWlDUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Cc: alsa-devel@alsa-project.org, songliubraving@fb.com, bpf@vger.kernel.org,
 daniel@iogearbox.net, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 Jiasheng Jiang <jiasheng@iscas.ac.cn>, john.fastabend@gmail.com,
 tiwai@suse.com, ast@kernel.org, andrii@kernel.org, broonie@kernel.org,
 netdev@vger.kernel.org, kpsingh@kernel.org, yhs@fb.com, f.suligoi@asem.it,
 kafai@fb.com
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

As the potential failure of the clk_enable(),
it should be better to check it and return error
if fails.

Fixes: ab6f6d85210c ("ASoC: fsi: add master clock control functions")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v1 -> v2

* Change 1. Seperate the error handler.

v2 -> v3

* Change 1. Revert disable_xck and disable_ick.
---
 sound/soc/sh/fsi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index cdf3b7f69ba7..e9a1eb6bdf66 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -816,14 +816,27 @@ static int fsi_clk_enable(struct device *dev,
 			return ret;
 		}
 
-		clk_enable(clock->xck);
-		clk_enable(clock->ick);
-		clk_enable(clock->div);
+		ret = clk_enable(clock->xck);
+		if (ret)
+			goto err;
+		ret = clk_enable(clock->ick);
+		if (ret)
+			goto disable_xck;
+		ret = clk_enable(clock->div);
+		if (ret)
+			goto disable_ick;
 
 		clock->count++;
 	}
 
 	return ret;
+
+disable_ick:
+	clk_disable(clock->ick);
+disable_xck:
+	clk_disable(clock->xck);
+err:
+	return ret;
 }
 
 static int fsi_clk_disable(struct device *dev,
-- 
2.25.1

