Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21710C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 19:04:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9691F61554
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 19:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9691F61554
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A7BD18BB;
	Tue, 11 May 2021 21:03:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A7BD18BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620759866;
	bh=c9M2Y2+yyr+0FJ4tZihcOTGkMl3MfiCdm0Drg1ijW68=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pqwsmY/Gg0A6tIHB5ceyuzTs7mSHKjsaV1KIc7wEiLnUUEc+Bg4XH/H8SvPTY+k57
	 nVYsnGm4zXgjXP0p7HBYnaQOlRskAJiEHb3rjeVuIEVqTchsuwpKna826LDGu992lu
	 rUnyOEQyb59wIQiSs1ZSb2ExsbMPthBDFLYdTRtQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB2B3F800E9;
	Tue, 11 May 2021 21:03:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97BB9F80163; Tue, 11 May 2021 21:03:34 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 23AB3F800E9
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 21:03:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23AB3F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="L91wfspy"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45A9F61554;
 Tue, 11 May 2021 19:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620759804;
 bh=c9M2Y2+yyr+0FJ4tZihcOTGkMl3MfiCdm0Drg1ijW68=;
 h=From:To:Cc:Subject:Date:From;
 b=L91wfspyKgSvXRaYSfuEEXMIpjgMyLa+aCDlqlPGQrSO4vGZDq5zgtd1alFCYxlPO
 kcuTLyM8JRcjN/kS4aq7AMIgPaGaS4XoSGeI/AWaZ51JPjJCSz2xYGPhsSAk/0zuvK
 c1rxojsuO3U4fI+sFH6k060/d9UDB0yZgE7BjUj/HhdKBB2+LCDOgvWJApBXXDIldt
 jyCSlvw/zCDarUpm7A+Nsyy2X+ZjhBKYuaKqHFhl6I/3pG3foh9ogfKH5YAX7PWxiy
 eibuJrZcasmcgZAhNtmqdsQaq2tUc8Hs/7p8HjQU8GUg41zFkiBzRg4CDXISEGaBYh
 75IbiqgYXX3gg==
From: Nathan Chancellor <nathan@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH] Revert "ASoC: q6dsp: q6afe: remove unneeded dead-store
 initialization"
Date: Tue, 11 May 2021 12:03:06 -0700
Message-Id: <20210511190306.2418917-1-nathan@kernel.org>
X-Mailer: git-send-email 2.31.1.527.g2d677e5b15
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, clang-built-linux@googlegroups.com,
 Yang Li <yang.lee@linux.alibaba.com>
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

This reverts commit 5f1b95d08de712327e452d082a50fded435ec884.

The warnings that commit 5f1b95d08de7 ("ASoC: q6dsp: q6afe: remove
unneeded dead-store initialization") was trying to fix were already
fixed in commit 12900bacb4f3 ("ASoC: qcom: q6afe: remove useless
assignments"). With both commits in the tree, port_id is uninitialized,
as pointed out by clang:

sound/soc/qcom/qdsp6/q6afe.c:1213:18: warning: variable 'port_id' is
uninitialized when used here [-Wuninitialized]
        stop->port_id = port_id;
                        ^~~~~~~
sound/soc/qcom/qdsp6/q6afe.c:1186:13: note: initialize the variable
'port_id' to silence this warning
        int port_id;
                   ^
                    = 0
1 warning generated.

Bring back the initialization so that everything works as intended.

Fixes: 5f1b95d08de7 ("ASoC: q6dsp: q6afe: remove unneeded dead-store initialization")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index c5c1818a6f75..729d27da0447 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -1183,7 +1183,7 @@ int q6afe_port_stop(struct q6afe_port *port)
 	struct afe_port_cmd_device_stop *stop;
 	struct q6afe *afe = port->afe;
 	struct apr_pkt *pkt;
-	int port_id;
+	int port_id = port->id;
 	int ret = 0;
 	int index, pkt_size;
 	void *p;

base-commit: 4ac9b48adf4d561d0e33419d548278f205dd70b5
-- 
2.31.1.527.g2d677e5b15

