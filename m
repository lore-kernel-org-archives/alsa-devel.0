Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D42CC25B0E
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Aug 2022 17:46:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61DC0163F;
	Tue, 16 Aug 2022 19:45:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61DC0163F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660671984;
	bh=gaUSa9q8U7xxGFnynif5W6VhybmtT9hMXOCvQ+F0yIw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lDNZHNnlARQCZ7/O3CaUKaL1rJN/vPtJwI+zaAZGXAH1e5MwPgdcJ0P1NStJc8SgJ
	 PQ7hgskkjO4YEb8JxBMYhtcMz8f3N8AWwOpV5I6w/FgIU96Ij1Y75suxtH1QgKRaM5
	 N1adt6QOesfxCZ9VbC1XOzuQ8y9x/MomOGhl7SYY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB49CF80238;
	Tue, 16 Aug 2022 19:45:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9D2EF8032D; Tue, 16 Aug 2022 19:45:31 +0200 (CEST)
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91EE6F80095
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2022 19:45:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91EE6F80095
X-QQ-mid: bizesmtp75t1660671914tscq1yef
Received: from harry-jrlc.. ( [182.148.12.144])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Aug 2022 01:45:03 +0800 (CST)
X-QQ-SSF: 0100000000200060D000B00A0000020
X-QQ-FEAT: DBLGDch1WOQHRlio3CcgavgMVmbBqFrToEHP8hQ7JKFA9hsvvdsKnfKjex2vX
 QoNcNnTbSgoT0VmpS68DcU3PbL2m3952p1S4L1eCy1GD7ahpnMFPKfzV2r1/AN9lRan2oFr
 GZ6mi9qx/9EhrqPVX/I568VMhki1EQHPGlijpju6TF1n6jk99XXCRUDdQ9RmJq3pifPQ3mx
 olLpixG1t2lJJFb6MKM06k+XbXkQ80qTZigm6yupBYH/1599YzcaSI3sV51sK7aQLWwW7hV
 +nmbMY8715HfDdMoLMBTOqCPBeROxmuVBjyZeP3DkFz9KP0UatOiGMinOXZPMf9ZtZXbqRY
 +NsMyKiwy9ENMcGHnnP7xZlKSJNKdPBeCQzNKz8g6sPgtdRs0bHRUYmKJxKJQ==
X-QQ-GoodBg: 0
From: Xin Gao <gaoxin@cdjrlc.com>
To: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH] ASoC: Variable type completion
Date: Wed, 17 Aug 2022 01:45:02 +0800
Message-Id: <20220816174502.7902-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com,
 Xin Gao <gaoxin@cdjrlc.com>, linux-kernel@vger.kernel.org
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

'unsigned int' is better than 'unsigned'.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 sound/soc/codecs/pcm3008.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/pcm3008.h b/sound/soc/codecs/pcm3008.h
index f7f4fbbd89db..45270bcf1c02 100644
--- a/sound/soc/codecs/pcm3008.h
+++ b/sound/soc/codecs/pcm3008.h
@@ -10,10 +10,10 @@
 #define __LINUX_SND_SOC_PCM3008_H
 
 struct pcm3008_setup_data {
-	unsigned dem0_pin;
-	unsigned dem1_pin;
-	unsigned pdad_pin;
-	unsigned pdda_pin;
+	unsigned int dem0_pin;
+	unsigned int dem1_pin;
+	unsigned int pdad_pin;
+	unsigned int pdda_pin;
 };
 
 #endif
-- 
2.30.2

