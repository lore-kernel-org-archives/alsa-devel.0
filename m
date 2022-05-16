Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9EBC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 16 May 2022 08:20:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 142D016BE;
	Mon, 16 May 2022 10:19:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 142D016BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652689218;
	bh=St/NUTPbZDtXW1c3PGYHWFvpvozC74+q0Vgdyb9XA8g=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FMnYn7okNIE70flsbH0zBk4uGsSjTcW2Uo7qMXiZCanOGVun3ZxiktNxhgp6FDuSe
	 tBjFFxUdmNw0SlJ5+zq2+g+tgWMxpiiFlu3a/z6bPTK7w6cT/M43tm++Ybr4gF+99S
	 C4pbi9/KNsFcgCZY7e2kZdJl1w+sefjg5UstB9/M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D7E82F8051C;
	Mon, 16 May 2022 10:18:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4EFE6F8014B; Mon, 16 May 2022 10:18:52 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5F302F8012C
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2022 10:18:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F302F8012C
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7083D1A0473;
 Mon, 16 May 2022 10:18:43 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 394351A0470;
 Mon, 16 May 2022 10:18:43 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AD80E180219B;
 Mon, 16 May 2022 16:18:41 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ASoC: fsl_sai: Add support for i.MX8MM, MP, ULP
Date: Mon, 16 May 2022 16:06:09 +0800
Message-Id: <1652688372-10274-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

ASoC: fsl_sai: Add support for i.MX8MM, MP, ULP platforms

Shengjiu Wang (3):
  ASoC: fsl_sai: Add support for i.MX8MM
  ASoC: fsl_sai: Add support for i.MX8M Plus
  ASoC: fsl_sai: Add support for i.MX8ULP

 sound/soc/fsl/fsl_sai.c | 43 ++++++++++++++++++++++++++++++++++++++++-
 sound/soc/fsl/fsl_sai.h |  1 +
 2 files changed, 43 insertions(+), 1 deletion(-)

-- 
2.17.1

