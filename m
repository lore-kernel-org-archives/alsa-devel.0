Return-Path: <SRS0=Z19R=PP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABED8C433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 19:10:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BE76044F
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 19:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 68BE76044F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E778169E;
	Wed, 27 Oct 2021 21:09:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E778169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635361800;
	bh=S4l6QXgwpR+ap6FEjSf8z0UBhaHkW1+FoXkUNyVM84U=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=b2ie7eowD6MA14EN8nT1FFRfTBctaZrnn38iOdW2Wj1E/xITphT+N1AfyRc4310oE
	 xcTMxLO7YC6tDWd3flzG0tpRx6FX6K0fRKVMqgUQnwtLUgzXYqPQO9bNHwF8vXDeVR
	 cP7VrkbCvSLuEHEqUwZ0nRGPgrJO1ML80ByMxYLY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DF5AF800FF;
	Wed, 27 Oct 2021 21:09:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 766CFF8025A; Wed, 27 Oct 2021 21:09:08 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7746F8010A
 for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2021 21:08:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7746F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="p3KrmKNJ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97EF860296;
 Wed, 27 Oct 2021 19:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635361735;
 bh=S4l6QXgwpR+ap6FEjSf8z0UBhaHkW1+FoXkUNyVM84U=;
 h=From:To:Cc:Subject:Date:From;
 b=p3KrmKNJLJ1JDfZap2w4kC18EoZv83npg5JRuzMGKZnbm7vQaBY69LhJ/tCdJb9jK
 Ytv5qMdR0ZwqvSVtEVD2aP+/yA5AXC3jlzTv3SWYuQ4oprtm6GMSZiCCuEQpOpr3TS
 cXTMVJgA8ptOtjoirhemKqCzPUf8PGzcISelnnAv+z8wHWWqOp8RpvhXeupK8esC2I
 62uSqkxQyg1tBajZiCpXtj3f0jKVVzt5GyHrz1ITb8AmxOZlxl0cFvZ4s0G2FXr7ii
 01iWCnOP+wbIsHf+iBWfmS+BzjX4iH1dB5uwxIzaPjQ7Py3AWf924SI3h0ngQworoB
 b9zkdu5wLS4Sw==
From: Nathan Chancellor <nathan@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: qdsp6: audioreach: Fix clang -Wimplicit-fallthrough
Date: Wed, 27 Oct 2021 12:08:23 -0700
Message-Id: <20211027190823.4057382-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.1.637.gf443b226ca
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Cc: Nathan Chancellor <nathan@kernel.org>, alsa-devel@alsa-project.org,
 llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
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

Clang warns:

sound/soc/qcom/qdsp6/topology.c:465:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
                default:
                ^
sound/soc/qcom/qdsp6/topology.c:465:3: note: insert 'break;' to avoid fall-through
                default:
                ^
                break;
1 warning generated.

Clang is a little more pedantic than GCC, which permits implicit
fallthroughs to cases that contain just break or return. Clang's version
is more in line with the kernel's own stance in deprecated.rst, which
states that all switch/case blocks must end in either break,
fallthrough, continue, goto, or return. Add the missing break to fix
the warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/1495
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 sound/soc/qcom/qdsp6/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index f31895379925..bd649c232a06 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -461,7 +461,7 @@ static struct audioreach_module *audioreach_parse_common_tokens(struct q6apm *ap
 			break;
 		case AR_TKN_U32_MODULE_DST_IN_PORT_ID:
 			dst_mod_ip_port_id = le32_to_cpu(mod_elem->value);
-
+			break;
 		default:
 			break;
 

base-commit: 1dcc81d95b910dc404c40ff6101bfa2520a3528e
-- 
2.33.1.637.gf443b226ca

