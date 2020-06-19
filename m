Return-Path: <SRS0=ChbS=AA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE380C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:23:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82ACF208D5
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C/HlHMAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82ACF208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E9D01674;
	Fri, 19 Jun 2020 19:22:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E9D01674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592587396;
	bh=fga6MceDVJGFHbVBbatca2gOOAjJV1SWlMb+Rr8S4lk=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=C/HlHMADCuDlklqSjOHDlZX4cx6uGuBcNxe1CbquKSpgiTTlkcapELm4JeQilTa1e
	 KBrfDJdo0LlnGzZe74C2inkBNa5zV87BPb42x3Gzh0WrLrZT77zxl87DyN/ymuNynx
	 isjkiXfXI0PNLD/vYYbpbHct0/VX3amZVBldi+Ps=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DF770F8025F;
	Fri, 19 Jun 2020 19:22:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08A60F80271; Fri, 19 Jun 2020 19:22:20 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 324C8F80245
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2020 19:22:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 324C8F80245
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E33ADAB64
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2020 17:22:12 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib] conf: Add /usr/etc to the default search paths
Date: Fri, 19 Jun 2020 19:22:12 +0200
Message-Id: <20200619172212.26735-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
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

There's been some recent action to move the distribution-default setup
from /etc to /usr/etc, and we should follow that, too.

This patch adds /usr/etc/alsa.conf.d and /usr/etc/alsa.conf to the
default search paths.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/conf/alsa.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/conf/alsa.conf b/src/conf/alsa.conf
index 18427ec6c4c6..aea1fe24f73c 100644
--- a/src/conf/alsa.conf
+++ b/src/conf/alsa.conf
@@ -8,6 +8,8 @@
 	{
 		func load
 		files [
+			"/usr/etc/alsa/conf.d"
+			"/usr/etc/asound.conf"
 			"/etc/alsa/conf.d"
 			"/etc/asound.conf"
 			"~/.asoundrc"
-- 
2.16.4

