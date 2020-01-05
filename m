Return-Path: <SRS0=7vEg=22=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320CFC33C9A
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 16:02:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A2D222C4
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 16:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="D2gxNTGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A2D222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1BC81839;
	Sun,  5 Jan 2020 16:25:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1BC81839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578237993;
	bh=uzXdw1ohwJjKWAs8lW88kbHZr5bvQHQSWjO0Bd7u4Qk=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D2gxNTGfyhIkpFEhjZQdH4tiPXFw0qSJSRmV7uCmaPwhUX3u/lWHuagkRJbvQ+t2+
	 fFm8+3QaxVYdi6tpEtvTPQqK9tDcymV2fjAZakwj+7ddQQYwkLe2fjHq40U0BZ99r8
	 j6hDuImfAQGr1brmPsfRG5jHepubYHB8kXWV5mfk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64D85F8055B;
	Sun,  5 Jan 2020 15:50:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9AE6AF803D1; Sun,  5 Jan 2020 15:49:53 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BECD4F802E9
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 15:48:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BECD4F802E9
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 50253B2C3
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 14:48:34 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sun,  5 Jan 2020 15:48:09 +0100
Message-Id: <20200105144823.29547-55-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200105144823.29547-1-tiwai@suse.de>
References: <20200105144823.29547-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 54/68] ALSA: aw2: More constifications
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Apply const prefix to the static parameter tables.

Just for minor optimization and no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/aw2/aw2-tsl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/aw2/aw2-tsl.c b/sound/pci/aw2/aw2-tsl.c
index 41fed546ea14..2f35b08809a3 100644
--- a/sound/pci/aw2/aw2-tsl.c
+++ b/sound/pci/aw2/aw2-tsl.c
@@ -59,7 +59,7 @@
     /*      SD3:          >-------<_4-L___>-------<_4-R___> */
     /*      WS4:          -------\_______________/--------- */
 
-static int tsl1[8] = {
+static const int tsl1[8] = {
 	1 * TSL_SDW_A1 | 3 * TSL_BSEL_A1 |
 	0 * TSL_DIS_A1 | 0 * TSL_DOD_A1 | TSL_LF_A1,
 
@@ -85,7 +85,7 @@ static int tsl1[8] = {
 	0 * TSL_DOD_A1 | TSL_WS1 | TSL_WS0 | TSL_SF_A1 | TSL_EOS,
 };
 
-static int tsl2[8] = {
+static const int tsl2[8] = {
 	0 * TSL_SDW_A2 | 3 * TSL_BSEL_A2 | 2 * TSL_DOD_A2 | TSL_LF_A2,
 	0 * TSL_SDW_A2 | 2 * TSL_BSEL_A2 | 2 * TSL_DOD_A2,
 	0 * TSL_SDW_A2 | 3 * TSL_BSEL_A2 | 2 * TSL_DOD_A2,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
