Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E706BC433E3
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:53:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68FF72067C
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="baFUKzu7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="N36eYJo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FF72067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCB4B16FD;
	Wed, 26 Aug 2020 11:52:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCB4B16FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598435601;
	bh=dRX24YLMKQDuqbKr+tMI9HFp3nsF9wXeGpRHYrMgniw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=baFUKzu7M/eYAMs06o89uaj9NIf9S/Qg0k7WNRoPxHWc7xgCZaJxJGyj0zq0d3xpk
	 SeZ4+Oz09h2ts1JqZfmv8ePYq91Z9L64ugP1QK4X4I7vOmwK6df4sX98spXxa1HUkV
	 zF1pSh6ZQe+p216nQdArzpgU8XNN1aHgGk6fwai8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29EA2F801EC;
	Wed, 26 Aug 2020 11:52:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D725AF801EC; Wed, 26 Aug 2020 11:52:29 +0200 (CEST)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 999C4F800EB
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 11:52:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 999C4F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="N36eYJo9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598435542;
 s=strato-dkim-0002; d=gerhold.net;
 h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=F/c9iaxZixYGzGo5s+iEIuFcmUCvaL5Q1xK1gdH/2pQ=;
 b=N36eYJo9Z9i9emjIdOcu8/E/TPS0SHrNDmRK+5P3P8TiwV8tuy7E//WcPysotvPxaM
 f2nbxIdEQnhSBtdiuw7C3IDT8S4dXxm3jOCkX/1JxiggtKBh6ktqN6pmzz6LSqcCGsDm
 PlM54/9T/Gb+Hsq+/lg5XNJYDYcJLZHOqVdtmEcBx1fm5JJ6+aThw/OkXiFeD4qEJCtb
 xDt9aMyh3SDfyaCIkdid6IbclOgB0A0+H8PN041dfgU27A51nl3KvYnnBtkVKB400eoF
 AWI4mvg+PC9wFKVfqrZSX1HHcSYOOIVgFTfA5Q344E0mri+cjVe4Wj3dt1j7baHH1OwM
 QR5w==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4W6NYn8D"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
 by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
 with ESMTPSA id g0b6c1w7Q9qGl6U
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 26 Aug 2020 11:52:16 +0200 (CEST)
From: Stephan Gerhold <stephan@gerhold.net>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/2] ASoC: qcom: common: Parse auxiliary devices from
 device tree
Date: Wed, 26 Aug 2020 11:51:39 +0200
Message-Id: <20200826095141.94017-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Stephan Gerhold <stephan@gerhold.net>, linux-arm-msm@vger.kernel.org,
 Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
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

In some cases we need to probe additional audio components that do
not appear as part of the DAI links specified in the device tree.
Examples for this are auxiliary devices such as analog amplifiers
or codecs.

The ASoC core provides a way to probe these components by adding
them to snd_soc_card->aux_dev.

This patch set allows specifying them in the device tree through
a new "aux-devs" property.

v1: https://lore.kernel.org/linux-arm-msm/20200819091533.2334-1-stephan@gerhold.net/
Changes in v2:
  - Fix value type in device tree bindings:
    aux-devs should be array of phandles without any arguments, so change
    <phandles with arguments> -> <array of phandles>

Stephan Gerhold (2):
  ASoC: dt-bindings: qcom: Document "aux-devs" property
  ASoC: qcom: common: Parse auxiliary devices from device tree

 .../devicetree/bindings/sound/qcom,apq8016-sbc.txt        | 7 +++++++
 Documentation/devicetree/bindings/sound/qcom,apq8096.txt  | 8 ++++++++
 Documentation/devicetree/bindings/sound/qcom,sdm845.txt   | 8 ++++++++
 sound/soc/qcom/common.c                                   | 4 ++++
 4 files changed, 27 insertions(+)

-- 
2.28.0

