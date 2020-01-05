Return-Path: <SRS0=7vEg=22=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23228C3F68F
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 16:07:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F552465E
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 16:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FuZWix3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F552465E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A20F61823;
	Sun,  5 Jan 2020 16:28:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A20F61823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578238153;
	bh=hR/YQwrUUw7mvgU8jAJvTdTWFwSFq23/QmozWXwGOsY=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FuZWix3/za0Uy0nq9r1VaZNMq9T00bEEa8oMdKCRbVg/T+euZJ/XmY9R0NNiyTF+G
	 GrLjOLNdVSRmTXZOGaLX6zow3wnfwTEup6GfKCGmA7lT8N3k6tx2s8uOgE+Y0esQ6j
	 UUIjD2TxmuCCu9dvJ+eMSaE8g2prRl6OdNo2ixXg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4357BF805C0;
	Sun,  5 Jan 2020 15:50:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50A95F803D1; Sun,  5 Jan 2020 15:49:58 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54E59F802EC
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 15:48:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54E59F802EC
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5594FB2AE
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 14:48:33 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sun,  5 Jan 2020 15:47:50 +0100
Message-Id: <20200105144823.29547-36-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200105144823.29547-1-tiwai@suse.de>
References: <20200105144823.29547-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 35/68] ALSA: es1968: More constifications
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

Apply const prefix to the quirk white/black lists.

Just for minor optimization and no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/es1968.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index affd3e8d7a67..d26004b35a81 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -2631,7 +2631,7 @@ struct ess_device_list {
 	unsigned short vendor;	/* subsystem vendor id */
 };
 
-static struct ess_device_list pm_whitelist[] = {
+static const struct ess_device_list pm_whitelist[] = {
 	{ TYPE_MAESTRO2E, 0x0e11 },	/* Compaq Armada */
 	{ TYPE_MAESTRO2E, 0x1028 },
 	{ TYPE_MAESTRO2E, 0x103c },
@@ -2642,7 +2642,7 @@ static struct ess_device_list pm_whitelist[] = {
 	{ TYPE_MAESTRO2, 0x125d },	/* a PCI card, e.g. SF64-PCE2 */
 };
 
-static struct ess_device_list mpu_blacklist[] = {
+static const struct ess_device_list mpu_blacklist[] = {
 	{ TYPE_MAESTRO2, 0x125d },
 };
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
