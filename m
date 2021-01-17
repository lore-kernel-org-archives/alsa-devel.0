Return-Path: <SRS0=1bGq=GU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AFDC433E0
	for <alsa-devel@archiver.kernel.org>; Sun, 17 Jan 2021 07:14:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE70230FE
	for <alsa-devel@archiver.kernel.org>; Sun, 17 Jan 2021 07:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE70230FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 323481714;
	Sun, 17 Jan 2021 08:13:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 323481714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610867662;
	bh=cPE05zM88uiHs+BuzoYZq+w4JtSPuhm34rtk2srotxM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W1MPsxgBc2h/VMxZGAawgZ17WwCIJ+tXnxnEcDIjrjCqTq3J1HYLAvn7sh/hye4kr
	 igVYc8Ijic2+Haaux8jkH8n2sPV/qtY5uO88qQqg+uX/FIJajdJgT25Bh0yQgNCIL+
	 MeC76LBTFi1dtH/lgHFlRW3GgSZgeGRUzAFNtjlM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95DF4F80115;
	Sun, 17 Jan 2021 08:13:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3DF4AF80257; Sun, 17 Jan 2021 08:13:27 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82D69F80115
 for <alsa-devel@alsa-project.org>; Sun, 17 Jan 2021 08:13:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82D69F80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qdIyvgEp"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F91B230FE;
 Sun, 17 Jan 2021 07:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610867594;
 bh=cPE05zM88uiHs+BuzoYZq+w4JtSPuhm34rtk2srotxM=;
 h=From:To:Cc:Subject:Date:From;
 b=qdIyvgEpINtMeD47DJQgtXAbfz655bH8pn7f3zVruY7x7M82LvMDzAobGrVaD8VMt
 54+IAv2FvuH4FJtd9hQ9vXNoPG5GmdSgeSqvKF0luo9LdKmEhYQBVDgQsZJy1Byz0x
 YiwTSv0e2JvbKY+si9pJ7SZNVtEZc6wAvqhiiHvUjHwb+GqM+TIrAJNIqpGmI85P/R
 OWfxPN8bd82dVsnZL6qHWSlZBzcKWLFgpAPLazq9ZBwauOsJv9sIimwewEzzuJlTqV
 CYsk9ATu8z+Or6oMRhGFGi4UgBkwxVUWsU/tNJtHRCCKQPLUswNDtU7UszaiTWKQKA
 /5KAiVtnlPOIQ==
From: Vinod Koul <vkoul@kernel.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH] MAINTAINERS: soundwire: Add soundwire tree
Date: Sun, 17 Jan 2021 12:42:58 +0530
Message-Id: <20210117071258.2541484-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>
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

Somehow the soundwire MAINTAINERS did not have the tree details, so add
it.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 546aa66428c9..10b234688f22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16654,6 +16654,7 @@ R:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
 R:	Sanyog Kale <sanyog.r.kale@intel.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git
 F:	Documentation/driver-api/soundwire/
 F:	drivers/soundwire/
 F:	include/linux/soundwire/
-- 
2.26.2

