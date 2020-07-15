Return-Path: <SRS0=Rw3p=A2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5775DC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:58:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C66EF2064C
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="llFF9TSZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGivZ6c5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66EF2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62740845;
	Wed, 15 Jul 2020 11:57:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62740845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594807094;
	bh=HXp/0XEEVTqH0xfMOc8VdBJLSdPJrdSwmX52IFqiuEE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=llFF9TSZ/xBeyOtZQuMvmGHeOfq8D6YOZ9fjmPvaV9uGtMVwiQ6yTLZtqh8K+mTGO
	 68iqBJMrpQGrDJ8DoMSXyY1kVQmIxt5D0hdsXUgodwvJtxxz6OcYKjd0zXWULKtp/7
	 jt2gQJ+f8knxu9UgIfzETBA9/60WmI6sUVXQVorQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3205F8014E;
	Wed, 15 Jul 2020 11:57:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 04D86F80113; Wed, 15 Jul 2020 11:57:21 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CAEE8F80113
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2020 11:57:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CAEE8F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KGivZ6c5"
Received: from localhost.localdomain (unknown [122.171.202.192])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9D0C62064C;
 Wed, 15 Jul 2020 09:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594807032;
 bh=HXp/0XEEVTqH0xfMOc8VdBJLSdPJrdSwmX52IFqiuEE=;
 h=From:To:Cc:Subject:Date:From;
 b=KGivZ6c5RWhjMCle4+iH/Z4+9Kofy0yS/Z9YPq2WKZSMUtproW/DPnsbphjyvRkEq
 xPKHQVEgdiP0i2QffgDrs7xjWrzhrGCiCS1cj1KaU+ePuOBlEpG5wbYNAR4OO9Z6bl
 lBIOmytsLfda2/HXUWQNV6UwpRkT/tOq8HGkheVQ=
From: Vinod Koul <vkoul@kernel.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH] soundwire: fix the kernel-doc comment
Date: Wed, 15 Jul 2020 15:27:02 +0530
Message-Id: <20200715095702.1519554-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Vinod Koul <vkoul@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

sdw_startup_stream() and sdw_shutdown_stream() argument has been updated
but not the comments, so update these as well to fix warning with W=1

drivers/soundwire/stream.c:1859: warning: Function parameter or member 'sdw_substream' not described in 'sdw_startup_stream'
drivers/soundwire/stream.c:1859: warning: Excess function parameter 'stream' description in 'sdw_startup_stream'
drivers/soundwire/stream.c:1903: warning: Function parameter or member 'sdw_substream' not described in 'sdw_shutdown_stream'
drivers/soundwire/stream.c:1903: warning: Excess function parameter 'stream' description in 'sdw_shutdown_stream'

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 6bc2ff29c202..37290a799023 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1851,7 +1851,7 @@ static int set_stream(struct snd_pcm_substream *substream,
 /**
  * sdw_startup_stream() - Startup SoundWire stream
  *
- * @stream: Soundwire stream
+ * @sdw_substream: Soundwire stream
  *
  * Documentation/driver-api/soundwire/stream.rst explains this API in detail
  */
@@ -1895,7 +1895,7 @@ EXPORT_SYMBOL(sdw_startup_stream);
 /**
  * sdw_shutdown_stream() - Shutdown SoundWire stream
  *
- * @stream: Soundwire stream
+ * @sdw_substream: Soundwire stream
  *
  * Documentation/driver-api/soundwire/stream.rst explains this API in detail
  */
-- 
2.26.2

