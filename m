Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA0FECAAD2
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Sep 2022 01:31:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 811631632;
	Fri,  2 Sep 2022 03:30:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 811631632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662082305;
	bh=5UDGdxBpvs2RB6hwSLIM3RhK700ysbcc8CINd7p6Bu4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BJlvPXe8HvQ/EYtv9dui89q+8qwjWjFCn0UFyNm4wm/54L2Y5UCmElmVoNON5TD2L
	 1cD7oHKIoql4V1TDBubiScOb+pLQcO3aYgGlTIh/TZMjUrhMPkSubWOW1QGh6gptFs
	 J5lND+2GOiBjcXhb55jCnLwjPgHObYOQ9W7Xqlrs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EDFDF8020D;
	Fri,  2 Sep 2022 03:30:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA116F8027B; Fri,  2 Sep 2022 03:30:52 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by alsa1.perex.cz (Postfix) with ESMTP id 3B26AF80154
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2022 03:30:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B26AF80154
Received: from localhost.localdomain (unknown [124.16.138.126])
 by APP-01 (Coremail) with SMTP id qwCowACn_y63XBFjwMtgAA--.5690S2;
 Fri, 02 Sep 2022 09:30:32 +0800 (CST)
From: Jiasheng Jiang <jiasheng@iscas.ac.cn>
To: kuninori.morimoto.gx@renesas.com
Subject: [PATCH v2] ASoC: rsnd: Add check for rsnd_mod_power_on
Date: Fri,  2 Sep 2022 09:30:30 +0800
Message-Id: <20220902013030.3691266-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACn_y63XBFjwMtgAA--.5690S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrykZw1ktF48Xw1DGryxAFb_yoW5WrWrpw
 4kCrWDWryfAa15u3Z5tr4kAF18uay8AFZxtr4F9w1xA3WxKryDWFn7tr15uF45Wryjkrya
 9FyDJrn8Cr1rt3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
 KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
 1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
 64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
 0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
 IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUOMKZDUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 Jiasheng Jiang <jiasheng@iscas.ac.cn>, linux-kernel@vger.kernel.org,
 tiwai@suse.com, broonie@kernel.org
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

As rsnd_mod_power_on() can return negative numbers,
it should be better to check the return value and
deal with the exception.

Fixes: e7d850dd10f4 ("ASoC: rsnd: use mod base common method on SSI-parent")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v1 -> v2:

1. Add check for rsnd_mod_power_on in other files.
---
 sound/soc/sh/rcar/ctu.c | 6 +++++-
 sound/soc/sh/rcar/dvc.c | 6 +++++-
 sound/soc/sh/rcar/mix.c | 6 +++++-
 sound/soc/sh/rcar/src.c | 5 ++++-
 sound/soc/sh/rcar/ssi.c | 4 +++-
 5 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index 6156445bcb69..e39eb2ac7e95 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -171,7 +171,11 @@ static int rsnd_ctu_init(struct rsnd_mod *mod,
 			 struct rsnd_dai_stream *io,
 			 struct rsnd_priv *priv)
 {
-	rsnd_mod_power_on(mod);
+	int ret;
+
+	ret = rsnd_mod_power_on(mod);
+	if (ret < 0)
+		return ret;
 
 	rsnd_ctu_activation(mod);
 
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 5137e03a9d7c..16befcbc312c 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -186,7 +186,11 @@ static int rsnd_dvc_init(struct rsnd_mod *mod,
 			 struct rsnd_dai_stream *io,
 			 struct rsnd_priv *priv)
 {
-	rsnd_mod_power_on(mod);
+	int ret;
+
+	ret = rsnd_mod_power_on(mod);
+	if (ret < 0)
+		return ret;
 
 	rsnd_dvc_activation(mod);
 
diff --git a/sound/soc/sh/rcar/mix.c b/sound/soc/sh/rcar/mix.c
index 3572c2c5686c..1de0e085804c 100644
--- a/sound/soc/sh/rcar/mix.c
+++ b/sound/soc/sh/rcar/mix.c
@@ -146,7 +146,11 @@ static int rsnd_mix_init(struct rsnd_mod *mod,
 			 struct rsnd_dai_stream *io,
 			 struct rsnd_priv *priv)
 {
-	rsnd_mod_power_on(mod);
+	int ret;
+
+	ret = rsnd_mod_power_on(mod);
+	if (ret < 0)
+		return ret;
 
 	rsnd_mix_activation(mod);
 
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 0ea84ae57c6a..f832165e46bc 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -463,11 +463,14 @@ static int rsnd_src_init(struct rsnd_mod *mod,
 			 struct rsnd_priv *priv)
 {
 	struct rsnd_src *src = rsnd_mod_to_src(mod);
+	int ret;
 
 	/* reset sync convert_rate */
 	src->sync.val = 0;
 
-	rsnd_mod_power_on(mod);
+	ret = rsnd_mod_power_on(mod);
+	if (ret < 0)
+		return ret;
 
 	rsnd_src_activation(mod);
 
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 43c5e27dc5c8..7ade6c5ed96f 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -480,7 +480,9 @@ static int rsnd_ssi_init(struct rsnd_mod *mod,
 
 	ssi->usrcnt++;
 
-	rsnd_mod_power_on(mod);
+	ret = rsnd_mod_power_on(mod);
+	if (ret < 0)
+		return ret;
 
 	rsnd_ssi_config_init(mod, io);
 
-- 
2.25.1

