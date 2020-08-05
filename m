Return-Path: <SRS0=cqJl=BP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0727C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:54:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63ECB2076E
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TooGKQcx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BWBMWt6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63ECB2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 674AB1669;
	Wed,  5 Aug 2020 11:53:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 674AB1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596621282;
	bh=2bufS4QL/WSzPhgO2bDyW+E2dnqpRdje1tx7oAgaQw0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TooGKQcxpp0vZYwxdeWilOqM6e/Ok3R8GpjnC7oo9d7+YUeIbO6QY18PfvxmK/6lV
	 LmLoHMWPG0Vh5p5yeQSciYrZ4iUCLDGNfzjBnRNYL8ga95zfOMnOt4C86vFLg7bCDE
	 Mo1vT8z840nRSmQizvsvAwjlfyWZ/6T2UQjXV/MQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00764F80249;
	Wed,  5 Aug 2020 11:53:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8CFDF80259; Wed,  5 Aug 2020 11:52:56 +0200 (CEST)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0FF5F801F7
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2020 11:52:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0FF5F801F7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="BWBMWt6Q"
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f2a815f0000>; Wed, 05 Aug 2020 02:52:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 05 Aug 2020 02:52:45 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 05 Aug 2020 02:52:45 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Aug
 2020 09:52:45 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 5 Aug 2020 09:52:44 +0000
Received: from mkumard.nvidia.com (Not Verified[10.24.34.162]) by
 hqnvemgw03.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5f2a816a0000>; Wed, 05 Aug 2020 02:52:44 -0700
From: Mohan Kumar <mkumard@nvidia.com>
To: <tiwai@suse.com>, <perex@perex.cz>
Subject: [PATCH v2 0/3]  Tegra Specific fixes
Date: Wed, 5 Aug 2020 15:22:18 +0530
Message-ID: <20200805095221.5476-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1596621151; bh=n1dlz8iyQVQn9u37McbzKI0W09GdeF2ZXWm7kj2D8ro=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Type;
 b=BWBMWt6QVMLMuh32CQv7EbgOGFYLt4B1kJkv4Q2FjTIqnRzzSczyZt51aN0DmDSUG
 W00eF6NWgZc4saNzaisPb8Lx/k7wsfXRUw6zDcunG2jTPLThr/hBmWiHj8Q8ZOLOiX
 SEpA0QeeFRYq6GWyI0aNR3+3O+iJF90IgwuU9IPxSxNRsT7QihuaXdKuXSoKSpz0co
 QrS92fAO+DLM3SQSwaI/jTG5Umc/uY77DjaEYnR7eWjsUHWqAlLZzYZExDXEQcjCFg
 PKEln59tCG4H/vRBp2C0Bj/FSYPX9c+CSbTVAXUXw79wwtmMofbUPXq/udTPZr2aor
 fvgTSksTu8scA==
Cc: alsa-devel@alsa-project.org, spujar@nvidia.com, jonathanh@nvidia.com,
 linux-tegra@vger.kernel.org, treding@nvidia.com,
 Mohan Kumar <mkumard@nvidia.com>
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

This series proposes following fixes to Tegra HDA driver.
* Align the buffer to 128 bytes for Tegra.
* Add new behavior flag dma_stop_delay in hdac_bus structure.
* Add 100us as dma stop delay for Tegra.


Mohan Kumar (3):
  ASoC: hda/tegra: Set buffer alignment to 128 bytes
  ALSA: hda: Add dma stop delay variable
  ALSA: hda/tegra: Add 100us dma stop delay

 include/sound/hdaudio.h   | 3 +++
 sound/hda/hdac_stream.c   | 7 +++++++
 sound/pci/hda/hda_tegra.c | 3 +++
 3 files changed, 13 insertions(+)

-- 
2.17.1

