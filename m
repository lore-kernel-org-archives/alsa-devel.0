Return-Path: <SRS0=rQAG=33=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A39C2BA83
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Feb 2020 18:55:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD9A20726
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Feb 2020 18:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CG9da6jY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD9A20726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B5B016A3;
	Fri,  7 Feb 2020 19:54:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B5B016A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581101700;
	bh=aveCbwu79n/fo+/mjbF+qRdIVLek1m8mGgHsknz4SLg=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CG9da6jYp7zkehZlqGOZoPUG70dVddmDIJPqgBqcJ0OED8nYCD1aNcaxOeowFueKt
	 uFqWitjvlXDK8oVG2aeEbM3yESiZtjyzh6al2bEBr1821nqM0UlieXg7IMssCndaVt
	 2tPvIQn43nExYnrWFbpAMW/RJla0fXKkariiJ6QI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ADAADF80148;
	Fri,  7 Feb 2020 19:54:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B3D77F8014C; Fri,  7 Feb 2020 19:54:07 +0100 (CET)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9872EF800B2
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2020 19:54:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9872EF800B2
IronPort-SDR: ulpmZ4+r0LaYy8ce/Ho2/JqwAkcERHIzdIeRieAVQTopNoA6HkZn1Mshqhy7LB1K3XaPISxA7S
 G6cCtDrZFTNcbpYg78CHWKcdlFLRNiW7WBoRS0usNuBfqW5ACJWxmsCtzkk5rBHXE1PXvrIjWU
 JdZ5cD29veQzfw+ThLwR/GIJP1bfPwWs3pCyGX3+zpDlC0Z5y8FxtQvF0AodtEihcyyGTW1Bea
 sdjBD2BbJ9h82lpFCS0X5EsMdpcXgWj1QS11HV6savA5d9Huyk/v6HfqGbX/dhcdWgXZcgSgij
 rgs=
X-IronPort-AV: E=Sophos;i="5.70,414,1574150400"; d="scan'208";a="45570438"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa2.mentor.iphmx.com with ESMTP; 07 Feb 2020 10:54:02 -0800
IronPort-SDR: yTuOF55mrXM+aMk8u7Z7l/MLRmLU3hFUTB+JGG/7r/3KJ2uNDt/Krh03/zfPu0qutsbLUgMNgW
 eyhLX+uMLmcfnne7T9H8BORxJXJ0YIe35zVX2goIoYwGNB5IxZFXLP4rvGKvC/O0OOXgaPRSoh
 MKUmbfQRVVTMG9XEhlnJn1nEtk4zbEya2JBzKlofUHXlOdYnc+TQ+pbC5Q41KQEaNSGp6bKNqw
 hrp8b/oSsg9zv26xyLHAr1Vta5/fB7pY+HNuQArlBw8wnrxTgF8sqdjsFOhIAQTterby3HUea2
 CzY=
From: Dragos Tarcatu <dragos_tarcatu@mentor.com>
To: <alsa-devel@alsa-project.org>
Date: Fri, 7 Feb 2020 20:53:23 +0200
Message-ID: <20200207185325.22320-1-dragos_tarcatu@mentor.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, mengdong.lin@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com, broonie@kernel.org
Subject: [alsa-devel] [PATCH 0/2] ASoC: topology: Fix memory leaks with ABI
	version mismatch
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

The topology loader in soc-topology.c is currently accepting ABI
version mismatches for some topology components in order to keep
backwards compatibility with ABIv4. When dealing with these ABI
mismatch situations, temporary copies of the v4 objects are
allocated and passed on to the right driver topology handlers.
After that they're supposed to be freed.

However, memory leaks are currently possible in
soc_tplg_link_elems_load() and also soc_tplg_manifest_load().

These patches fix these.

I've originally created a PR on github for SOF at:
   https://github.com/thesofproject/linux/pull/1771
as my impression was this can affect older SOF toplogies.

But as it turns out this may impact Skylake instead.

Dragos Tarcatu (2):
  ASoC: topology: Fix memleak in soc_tplg_link_elems_load()
  ASoC: topology: Fix memleak in soc_tplg_manifest_load()

 sound/soc/soc-topology.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
