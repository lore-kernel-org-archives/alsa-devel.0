Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7148BC10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:10:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1EC420409
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XJlgNba/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xNvlGhvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EC420409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C429178D;
	Fri, 13 Mar 2020 08:09:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C429178D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584083435;
	bh=HhSVVPJ3LoI3jQaeENZl2yYG2HKleKcxy4U8f5tiZUg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XJlgNba/Bj6JJGlqVXEBjnoeZEN95T4gHgEfZYABev8SF8wfSodFVwdt3j7V9y3qY
	 Nxr2mnoFPlrlxFgl/vygj32jv8fb46JZv32g03RMQtxffL6pdf//zzhGdFuL2/yhdL
	 MakNtqCvTP1K5SQWVhMenmC1Zbr7mh1bLsgCQd40=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A70ECF8021D;
	Fri, 13 Mar 2020 08:09:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7ECCF80086; Fri, 13 Mar 2020 08:09:15 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D68A0F80086
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 08:09:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D68A0F80086
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="xNvlGhvG"
Received: from localhost.localdomain (unknown [171.76.107.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2DF502073E;
 Fri, 13 Mar 2020 07:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584083346;
 bh=HhSVVPJ3LoI3jQaeENZl2yYG2HKleKcxy4U8f5tiZUg=;
 h=From:To:Cc:Subject:Date:From;
 b=xNvlGhvGjENGkn6kCVs3IdUutTwfk/Ck8XjLki8Z02sThIiSUOziD5xmaAbGwDrOH
 gtAX7mxludvHTFLJhTDoBb+NNsr1N0432nwQsJJiaLJyBM1DmZSvFdMyTEcwj+1XAT
 KaNKPlstFfH3t2yMDQ6lAvLx05VZDxCOx1BkdS6U=
From: Vinod Koul <vkoul@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 0/9] ALSA: compress: Add wma, alac and ape support
Date: Fri, 13 Mar 2020 12:38:38 +0530
Message-Id: <20200313070847.1464977-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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

This series adds more WMA profiles and WMA decoder parameters to UAPI and
then support for these in qcom driver. It also adds FLAC and APE IDs and
decoder parameters to UAPI and then support in qcom driver

This was tested on Dragon board RB3.

Last, bump up the compressed version so that userspace can check for the
support.

Since the series touches compress uapi and asoc, it would make sense to go
thru asoc tree with acks.

Vinod Koul (9):
  ALSA: compress: add wma codec profiles
  ALSA: compress: Add wma decoder params
  ASoC: qcom: q6asm: pass codec profile to q6asm_open_write
  ASoC: qcom: q6asm: add support to wma config
  ASoC: qcom: q6asm-dai: add support to wma decoder
  ALSA: compress: add alac & ape decoder params
  ASoC: qcom: q6asm: add support for alac and ape configs
  ASoC: qcom: q6asm-dai: add support for ALAC and APE decoders
  ALSA: compress: bump the version

 include/uapi/sound/compress_offload.h |   2 +-
 include/uapi/sound/compress_params.h  |  37 +++-
 sound/soc/qcom/qdsp6/q6asm-dai.c      | 136 +++++++++++++-
 sound/soc/qcom/qdsp6/q6asm.c          | 243 +++++++++++++++++++++++++-
 sound/soc/qcom/qdsp6/q6asm.h          |  51 +++++-
 5 files changed, 462 insertions(+), 7 deletions(-)

~Vinod

-- 
2.24.1

