Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397F0C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:13:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B598F20772
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oNDtr8QC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B598F20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C98016D1;
	Thu,  2 Jul 2020 16:12:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C98016D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593699194;
	bh=ibpvHxY1I7PbGIZgAKEqIXxctXvODLjXFGwHGyxDGNM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oNDtr8QCfC0+gz47r+aWo2lCWEPKKSb3wHE4JYB8Vl7KAGpiqG9kDsc78WGnbBzjX
	 HSHIXqKcLnkkt+ZZw9W16EwY0CU+05YsECd/qk+5WrnKVKWwJH47LThVm9GXpXNpn7
	 8SmB/gW+2n5Ow9yRBcRWzug/qsh4huLdCjh/N41s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CC0DEF800C1;
	Thu,  2 Jul 2020 16:12:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 825A5F80247; Thu,  2 Jul 2020 16:12:22 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 905FAF800ED
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 16:12:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 905FAF800ED
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:315a:ecf0:6250:a3ed])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: aferraris)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D7F002A5EC2;
 Thu,  2 Jul 2020 15:12:17 +0100 (BST)
From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
To: 
Subject: [PATCH 0/2] ASoC: fsl-asoc-card: add support for generic codecs
Date: Thu,  2 Jul 2020 16:11:13 +0200
Message-Id: <20200702141114.232688-1-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, kernel@collabora.com,
 Fabio Estevam <festevam@gmail.com>
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

fsl-asoc-card currently only works with AC97 or a selection of codecs,
although the hardware is capable of more.

Supporting generic codecs when acting as I2S slave (codec is master)
would be useful, especially when using Bluetooth audio, as these are
generally simple I2S devices not controlled by the sound subsystem.

This will allow using simple/dummy codecs along with ASRC.

Arnaud Ferraris (2):
  dt-bindings: sound: fsl-asoc-card: add new compatible for I2S slave
  ASoC: fsl-asoc-card: add support for generic I2S slave use-case

 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 23 ++++++++++++++++++++++-
 sound/soc/fsl/fsl-asoc-card.c                             | 46 +++++++++++++++++++++++++++++++++++-----------
 2 files changed, 57 insertions(+), 12 deletions(-)
