Return-Path: <SRS0=kxA9=GW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B48AC433E9
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Jan 2021 19:11:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B91A120776
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Jan 2021 19:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91A120776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A69261898;
	Tue, 19 Jan 2021 18:15:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A69261898
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611076594;
	bh=7mAkN3wCnyTtrgST92I872hM/w5s6ylageLNmYqxnZ8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YXlojBk8fDIbQ9QfPBAqVEXaeJp4i3CRVOSDiHSPO+PZlx7kuMGnuYfrh2Ms/P/Zy
	 ODgFMR8vLzlvhD+CkxPqYsB2C6ElqKObV9IbJ/Q+jUdpH/XuYWtr6gS+woxrkOxDVO
	 ivdgYFjIETmLkykDtF8iP5tuktf1ZBIN79nZnNSg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 20123F8026A;
	Tue, 19 Jan 2021 18:15:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F34F9F8026A; Tue, 19 Jan 2021 18:15:41 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18429F80117
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2021 18:15:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18429F80117
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="dWRmY7g7"
Received: by mail-wm1-x32b.google.com with SMTP id i63so473401wma.4
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2021 09:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y8oj8cGn9mIbZbqths5J7fDPRiyZtFwg7oHOszGUJDY=;
 b=dWRmY7g7R0sn1ljP9jrC6zpIY8RtxkFStKEnWrJdql5gbRMchDV/014NahXvy3Q8Iq
 5MCG+TcYNp055gZM9IkHI4cYWQf6Apeo33qyMDrLLjaH1VJIFkY2pJ0XhewrtQXzzW46
 KxZGLPFxYIxiBHiDzVSQLYQ6DtiO8Oaw1XdBWROTD2CwzLV4f4Sv90DpYodKVvas/ivy
 TmR1BwNCBC91EXdpj2RQEfEcGRw2QyX8croN85cfgSvOHwLiiphCk9kfhPJLd42KhIuC
 G+xbXlppXD2w7OQPxZWxdV1Z2SxXHSbrbUBH9/s+LWzS5dlQsTIEo0/xUOnmbw7zWmby
 0mCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y8oj8cGn9mIbZbqths5J7fDPRiyZtFwg7oHOszGUJDY=;
 b=O5JvCq6M+N77HhEdYS8ag/Pm6yLneJz/wNjAGgJU25jmfQLxvyfXqJ19ivj9fFN92o
 CAxdpCAt/98oBodMZWPTPMm5si5QkWQ6w90n3jxgEcduQDlf5qJm0Tf2bTTISP3+YtQx
 OXZ81o3clB/S60hhG3FIR9KAaGd0rgcZ3sSyQi1MbwsmW3Cl7UmeZIO8DdlqNFdcwUam
 MoYYqBOC9mXprWDgYUibndNKAt94p11oq59N6lm5tJR+UsF4Uueln5oi6B5+yHZtXEF+
 I0vK/vgvSsnqh4J5QlEkPCQlaZxJD78xwo6FLk5jQe8ckEY9GNh2SQB0ticIWAKAJX2m
 vuNQ==
X-Gm-Message-State: AOAM532TMHb+BPcbAhpWXtkBpuGEGeZ6kEwTJrW8ZGNp9UYvmFzeg/oh
 X58a32p53XNGUImQE5ZAo5gUEg==
X-Google-Smtp-Source: ABdhPJyzS7DSTvKqHQKvpQlpf20+bKcwMLjG8Wky0b3f6YhsZByy98QUhzCxEcfTRdWzdpsyNBde+w==
X-Received: by 2002:a1c:9dd5:: with SMTP id g204mr582474wme.37.1611076538058; 
 Tue, 19 Jan 2021 09:15:38 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id x18sm41649358wrg.55.2021.01.19.09.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jan 2021 09:15:37 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH v2 0/2] ASoC: qcom: Fix broken lpass driver
Date: Tue, 19 Jan 2021 17:15:25 +0000
Message-Id: <20210119171527.32145-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 srivasam@codeaurora.org, stephan@gerhold.net, lgirdwood@gmail.com,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

LPASS driver is partially broken on DragonBoard DB410c on 5.10 and
its totally broken on other Supported Qualcomm SoCs.

This was due to DAI ids being over written by the SoC specific header files
in the dt-bindings.

Idea of having SoC specific headers is not doable when we are dealing with
a common driver. So this patchset attempts to fix this properly by creating
a common dt-bindings header for lpass which can be updated with new entries
if required. This patchset also add an simple of_xlate function to resolve
the dai names and different SoCs might not have 1:1 mapping for the
dai_driver array with dai ids.


Changes since v1:
	- removed array indexes as suggested by Stephan G.
	- rebased to sound/for-next branch
	- collected Srinivasa tested-by tag for sc7180 platform.

Thanks,
srini

Srinivas Kandagatla (2):
  ASoC: dt-bindings: lpass: Fix and common up lpass dai ids
  ASoC: qcom: Fix broken support to MI2S TERTIARY and QUATERNARY

 include/dt-bindings/sound/apq8016-lpass.h |  7 +++----
 include/dt-bindings/sound/qcom,lpass.h    | 15 +++++++++++++++
 include/dt-bindings/sound/sc7180-lpass.h  |  6 ++----
 sound/soc/qcom/lpass-cpu.c                | 22 ++++++++++++++++++++++
 sound/soc/qcom/lpass-platform.c           | 12 ++++++++++++
 sound/soc/qcom/lpass-sc7180.c             |  9 +++------
 sound/soc/qcom/lpass.h                    |  2 +-
 7 files changed, 58 insertions(+), 15 deletions(-)
 create mode 100644 include/dt-bindings/sound/qcom,lpass.h

-- 
2.21.0

