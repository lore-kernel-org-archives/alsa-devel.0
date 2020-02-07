Return-Path: <SRS0=rQAG=33=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676FDC2BA83
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Feb 2020 18:56:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C3621775
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Feb 2020 18:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CiS4YOSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C3621775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B22D16CF;
	Fri,  7 Feb 2020 19:55:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B22D16CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581101801;
	bh=hlIWTn6YQQ3007KXfReXcvwe/KZdudCdLXwl93kqr9o=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CiS4YOSbQyz4KqRgfBUcHXvdtMLyO2bfx3Gb0yKW0lmzMHmUbogYAyzsxQSoStClo
	 U56argnWYT084W6GJddp4Oiqd8tyuvu9TYT9PHR4LYdnhRjrO4m6Gu+MxutK17qI0R
	 kXbjjVQXVOEvWqcLzqmHDQR8zL67R8RheUaUy+QQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D2A9F80278;
	Fri,  7 Feb 2020 19:54:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A0AE9F80142; Fri,  7 Feb 2020 19:54:09 +0100 (CET)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86041F800AB
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2020 19:54:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86041F800AB
IronPort-SDR: rw4iGKdpLjMBcEGPDDnzjZ0EejeIdSL+BwXtcPxLHbcVUIFQO5Oy4QPB0eCXuhBSpz/wFpEu00
 L1CQVrU1vM+qmjMalxfc7HWMXuq6yegEIxmzRKpE4HEt5H8y1fi37OdSBccAcDSWE/weYaleXQ
 W6ejQZfFYa2uA2Uh+W2q/dRBP/pDbUaBkhGMqdrqyOtnbXzl1bc953gVKDpFPj1W+jvCS8L6zA
 4soPrQK/gFR5i73RFjbXsF2Mujq/ieZgozN69hn9mExqKPmMSIdGsdxhShbCovwNPU9RVozWNU
 OsM=
X-IronPort-AV: E=Sophos;i="5.70,414,1574150400"; d="scan'208";a="45570440"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa2.mentor.iphmx.com with ESMTP; 07 Feb 2020 10:54:03 -0800
IronPort-SDR: D8WspUu5GRJUOHRPjtLHtz9FdtjmNZzLhNVQRqv/eC+AHkPXirh8XXLnHZNQk2QTI30hOXgY/f
 nOFk8Q1SKq6+gTbSJbaSzKUFLsRrrj1IP57CBHofehkJJHz/TUAoAUJNgtrV2pWjaCzQu58Rle
 fsfGuntvyw4+9BKhnpnpkUA09/YoVzWpLQX+Ju1jXTjK/C9iGxwHSlfGOzoPzGrQcxzXYrjpwj
 pH4q6bbYHcMVnsbdDRxL3Mb5jJEvBhAtsY3IJcUJCWy1suNEmPfurpyhwspGMdt1xFjJMfVPX2
 3qQ=
From: Dragos Tarcatu <dragos_tarcatu@mentor.com>
To: <alsa-devel@alsa-project.org>
Date: Fri, 7 Feb 2020 20:53:24 +0200
Message-ID: <20200207185325.22320-2-dragos_tarcatu@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207185325.22320-1-dragos_tarcatu@mentor.com>
References: <20200207185325.22320-1-dragos_tarcatu@mentor.com>
MIME-Version: 1.0
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, mengdong.lin@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com, broonie@kernel.org
Subject: [alsa-devel] [PATCH 1/2] ASoC: topology: Fix memleak in
	soc_tplg_link_elems_load()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

If soc_tplg_link_config() fails, _link needs to be freed in case of
topology ABI version mismatch. However the current code is returning
directly and ends up leaking memory in this case.
This patch fixes that.

Fixes: 593d9e52f9bb ("ASoC: topology: Add support to configure existing physical DAI links")
Signed-off-by: Dragos Tarcatu <dragos_tarcatu@mentor.com>
---
 sound/soc/soc-topology.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index d2ee6ad20e83..69069f70e745 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2377,8 +2377,11 @@ static int soc_tplg_link_elems_load(struct soc_tplg *tplg,
 		}
 
 		ret = soc_tplg_link_config(tplg, _link);
-		if (ret < 0)
+		if (ret < 0) {
+			if (!abi_match)
+				kfree(_link);
 			return ret;
+		}
 
 		/* offset by version-specific struct size and
 		 * real priv data size
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
