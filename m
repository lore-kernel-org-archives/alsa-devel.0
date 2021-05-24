Return-Path: <SRS0=TLt2=KT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25084C2B9F7
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 14:57:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E8BC610FC
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 14:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8BC610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3085616E0;
	Mon, 24 May 2021 16:56:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3085616E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621868230;
	bh=03uit3HcRgBQorQUpuon9ip1oRKD6umUP7MMKYqtLKY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hXrDluccZZV8QHl+mz9UQ4xrZHfy3Ny8GeYVaq27oa9ozLYuh2JZEVLpjSdddcdyL
	 K2OcpNLeM6sh18IeJUY4qb+4+QiS8sFHG8J3BH4IOsFFVG0jJiPgk4Rxo7eJLcFho4
	 VEr+SF9LSehGNtM4OXM+PkXy/tlT8uFe8Ckbq5Rs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 112D6F80475;
	Mon, 24 May 2021 16:50:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EC5CFF80475; Mon, 24 May 2021 16:50:23 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41A40F80475
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 16:50:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41A40F80475
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="vErcjlfx"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E6AB61492;
 Mon, 24 May 2021 14:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621867816;
 bh=03uit3HcRgBQorQUpuon9ip1oRKD6umUP7MMKYqtLKY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vErcjlfxXSZknkqa3o/4mxdaf/IEBQZlVhwiDq+kbR3igRJxX0+5+kWHng5Nu4M6k
 k4DlkjhfHeloLFeJlcIQdoIzaBP3eBzhjvxQlxjD2LDe3V3TYQp3cQSu7U/OaPDmpF
 8GP0gj/YkgCLOozl+j7PdRIsx5qQ4iyuy5BqMgJXHbXn19rvrTVu37ZqpcxPUtq73X
 0jakNzDMgFJccRBEtn/Cz9ismMqdqSTnNjzDFdQlEIVz30nI6/zyfbUHZ63cx9HOxU
 2JrfYit6VQhzZy4ESnaHMWST4Z1au8SZWfsRsvUpMd8BTDJ3BTHvhhhY5TkhR0Udxw
 ZadLtSlLm0QcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 06/25] ALSA: sb8: Add a comment note regarding an
 unused pointer
Date: Mon, 24 May 2021 10:49:49 -0400
Message-Id: <20210524145008.2499049-6-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210524145008.2499049-1-sashal@kernel.org>
References: <20210524145008.2499049-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Atul Gopinathan <atulgopinathan@gmail.com>, alsa-devel@alsa-project.org,
 Sasha Levin <sashal@kernel.org>
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

From: Atul Gopinathan <atulgopinathan@gmail.com>

[ Upstream commit a28591f61b60fac820c6de59826ffa710e5e314e ]

The field "fm_res" of "struct snd_sb8" is never used/dereferenced
throughout the sb8.c code. Therefore there is no need for any null value
check after the "request_region()".

Add a comment note to make developers know about this and prevent any
"NULL check" patches on this part of code.

Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Atul Gopinathan <atulgopinathan@gmail.com>
Link: https://lore.kernel.org/r/20210503115736.2104747-36-gregkh@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/isa/sb/sb8.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/isa/sb/sb8.c b/sound/isa/sb/sb8.c
index 1eb8b61a185b..fb59e5179075 100644
--- a/sound/isa/sb/sb8.c
+++ b/sound/isa/sb/sb8.c
@@ -109,7 +109,11 @@ static int snd_sb8_probe(struct device *pdev, unsigned int dev)
 	acard = card->private_data;
 	card->private_free = snd_sb8_free;
 
-	/* block the 0x388 port to avoid PnP conflicts */
+	/*
+	 * Block the 0x388 port to avoid PnP conflicts.
+	 * No need to check this value after request_region,
+	 * as we never do anything with it.
+	 */
 	acard->fm_res = request_region(0x388, 4, "SoundBlaster FM");
 	if (!acard->fm_res) {
 		err = -EBUSY;
-- 
2.30.2

