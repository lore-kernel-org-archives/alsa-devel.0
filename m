Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC63C4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:13:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9482207BC
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iXfBLaJ3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iJdkPAuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9482207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 269C21755;
	Mon,  5 Oct 2020 21:12:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 269C21755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601925214;
	bh=DzI6kUPFR+Deij3dd4rqKmeqkVlfgE2/IByLk9NQ4gQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iXfBLaJ3UmAwJnnfxjjWlSBIJIyUpTypS+NzFSrROdFiZK8rki54bxd68ur6qQ7EN
	 DO0HOEOtdTfQj9P2NNsLgq3c2qcKNxk7pNkN9R5l22oihL/2wVe0h//5FKGy0df0SO
	 PdnmHBa6poLcrD/8wJ4oWTs2WqpGI72uXf7DsbK0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E3B5F80245;
	Mon,  5 Oct 2020 21:12:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40457F8025A; Mon,  5 Oct 2020 21:12:41 +0200 (CEST)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E958F800EF
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 21:12:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E958F800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="iJdkPAuE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=6CTiwZikzwOayCgM9BdSR2MAppz360/FLOkaH+kTKSU=; b=iJdkPAuElAvxnFH4lJK4mzijHu
 xdZhrR9d0mF4/UcoP8ijav8lW3aD6kBPrk26VxOU12FmBaYlMNT1rS1n7PTzmfQDL1T1Hf1k0oqGe
 ZIqEQ8xGZYv0q+v+fVwoi/ZLLOUUPwb4I/hnGc+q0a4w0wPygx/8RmJOOhVlie5zSikgI51uLPBIL
 LmxfghuXGgBmRuN9+SbhEpaRkqNKu+g4WMPkY+pMb0i4GGYYWtsAn9R2cFjT1cnA61X8X63kfiClz
 Q468bT2AVVk2H6qJvTgc8lnrzU0I2CzAriAo6cBx5Pn3Z7gsnOu1TGsTNXgfb6Fdc4IZjoG2LUseO
 mV2bFrzA==;
Received: from [2601:1c0:6280:3f0::2c9a] (helo=smtpauth.infradead.org)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPVuO-000774-3v; Mon, 05 Oct 2020 19:12:28 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sound: drivers: portman2x4: fix repeated word 'if'
Date: Mon,  5 Oct 2020 12:12:23 -0700
Message-Id: <20201005191223.21514-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Randy Dunlap <rdunlap@infradead.org>,
 Takashi Iwai <tiwai@suse.com>
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

Correct duplicated word "if" to "if it".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
 sound/drivers/portman2x4.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-59-rc8.orig/sound/drivers/portman2x4.c
+++ lnx-59-rc8/sound/drivers/portman2x4.c
@@ -467,7 +467,7 @@ static int portman_probe(struct parport
 	parport_write_control(p, 0);	/* Reset Strobe=0. */
 
 	/* Check if Tx circuitry is functioning properly.  If initialized 
-	 * unit TxEmpty is false, send out char and see if if goes true.
+	 * unit TxEmpty is false, send out char and see if it goes true.
 	 */
 	/* 8 */
 	parport_write_control(p, TXDATA0);	/* Tx channel 0, strobe off. */
