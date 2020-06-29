Return-Path: <SRS0=wrte=AK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B615C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 03:24:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB203206C0
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 03:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IiXXmTf2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DE01pAvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB203206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62A2086E;
	Mon, 29 Jun 2020 05:23:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62A2086E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593401089;
	bh=GLo2TyclngioM5ejyNuUSGXaY7cT++dGp5711A9S0do=;
	h=To:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IiXXmTf2yafDeiMu3swk8D5QieK+LnxZoeV7pAao/2GqytBmfTwmwWUsCynwu1H7w
	 mTHUTaMyPdRwHjuqsH94U2wEYQJLv6cbFcowO2iksAs1fz2la+LiB9CONpjsHNTJdx
	 ur+KHdmx4SavHZeSlkT/oSuO+0Iaf8hYRYmNnV7M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE369F800BA;
	Mon, 29 Jun 2020 05:23:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 843FEF8020C; Mon, 29 Jun 2020 05:23:56 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7AF5FF800EA
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2020 05:23:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7AF5FF800EA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="DE01pAvH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=blQRyd/HnAyTbWfbQ9xtykWqeCj1aEkm67zC7s9PG2w=; b=DE01pAvHW6rcfid3cvE/jIdTqU
 nqqb9R2nFsmYFIjfnzSXtcbUHQzBQ95NnEZPBuq7UNDzYSHWA5DhHA9ZAUXVOSdrixZqIQdMu0y3S
 v7F9ibuJJoanNGjL1CC9W+CoBW6KsNZoF06HAKqv3EBhpa7G+BCKyzb+ZtxhnV6vxy475Lf5Fl7xV
 75aDqAn1/Bi0T6Z0VxVzxkg6vqZCjEWqcxVBAoBE+Rjus2AeKz+GA8NWMl0lnSIkis89unej4pTSk
 lYmf1ALW0kemIFuM6ca57rm/yYqUy1jDytPH4zD64cjYRGnDME8bc9pdmm+QXInAKpdCC2Y4E/FXf
 2oo5LwhA==;
Received: from [2601:1c0:6280:3f0::19c2]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpkOO-0003eW-BA; Mon, 29 Jun 2020 03:23:37 +0000
To: LKML <linux-kernel@vger.kernel.org>,
 moderated for non-subscribers <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] ASoC: Documentation: fix reference to renamed source
 file
Message-ID: <a9f59f30-8cf2-ea82-567c-1706fd64fe62@infradead.org>
Date: Sun, 28 Jun 2020 20:23:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

From: Randy Dunlap <rdunlap@infradead.org>

sound/soc/soc-io.c was merged into sound/soc/soc-component.c, so fixup
the Documentation to use the updated file name.

Error: Cannot open file ../sound/soc/soc-io.c
WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno ../sound/soc/soc-io.c' failed with return code 1

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>
---
 Documentation/sound/kernel-api/alsa-driver-api.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200626.orig/Documentation/sound/kernel-api/alsa-driver-api.rst
+++ linux-next-20200626/Documentation/sound/kernel-api/alsa-driver-api.rst
@@ -99,7 +99,7 @@ ASoC Core API
 .. kernel-doc:: include/sound/soc.h
 .. kernel-doc:: sound/soc/soc-core.c
 .. kernel-doc:: sound/soc/soc-devres.c
-.. kernel-doc:: sound/soc/soc-io.c
+.. kernel-doc:: sound/soc/soc-component.c
 .. kernel-doc:: sound/soc/soc-pcm.c
 .. kernel-doc:: sound/soc/soc-ops.c
 .. kernel-doc:: sound/soc/soc-compress.c

