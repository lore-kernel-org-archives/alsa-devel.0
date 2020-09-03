Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC508C433E9
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:46:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A4CF206EB
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="d1TKtNna";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwWZs5xu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4CF206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A2C4E18B5;
	Thu,  3 Sep 2020 13:45:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A2C4E18B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599133581;
	bh=X9kU0LEJm1P4PY/yoSWd8AzDqFeRBLYLY94wkbU9bAI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=d1TKtNnapEImB4NjI7nvu+fyeMuBUoCzXYIPMTHcf7XruRJO/2iCtxExSXkqy4Zr1
	 4w+OF6V5ZWUQA3Dp+HoSBDPzOnmZosMpmRR1ntXKgVT1kskbWsXCC0kcev+JPSQhuF
	 pQhKo+feoCUfInlENkm415RA33NoVcwZ3rtpImdw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2D48F8021D;
	Thu,  3 Sep 2020 13:45:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BEFABF8025F; Thu,  3 Sep 2020 13:45:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91733F801DA
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 13:45:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91733F801DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="nwWZs5xu"
Received: from localhost.localdomain (unknown [122.171.179.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C7EF220709;
 Thu,  3 Sep 2020 11:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599133518;
 bh=X9kU0LEJm1P4PY/yoSWd8AzDqFeRBLYLY94wkbU9bAI=;
 h=From:To:Cc:Subject:Date:From;
 b=nwWZs5xud/NZDk+yzGss4gX9AfQ0B3NyQivPQlEdQ0ootmZd5l2xFD8/6Ixy5wG6a
 VnPJ0Z/7loWe6pQf4fY3bXzJAvKs2TpCEb2b75iOUMFcATnlncsAvUZt7Rd83q6JpV
 yyatyM6bqMW6VVucEoQ+a+6BbgiDvHdtqcNQlJMo=
From: Vinod Koul <vkoul@kernel.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 0/9] soundwire: use FIELD_{GET|PREP} in subsystem
Date: Thu,  3 Sep 2020 17:14:55 +0530
Message-Id: <20200903114504.1202143-1-vkoul@kernel.org>
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

Use the FIELD_{GET|PREP} in soundwire subsytem and remove the local
SDW_REG_SHIFT().  This makes code IMO look much neater

Tested this on db845c board

Changes in v2:
 - fold in fixes provided by Bard and Pierre
 - Use GENMAS_ULL for addr
 - rebase to next and fold in new intel change

Vinod Koul (9):
  soundwire: define and use addr bit masks
  soundwire: bus: use FIELD_GET()
  soundwire: slave: use SDW_DISCO_LINK_ID()
  soundwire: stream: use FIELD_{GET|PREP}
  soundwire: qcom : use FIELD_{GET|PREP}
  soundwire: cadence: use FIELD_{GET|PREP}
  soundwire: intel: use FIELD_{GET|PREP}
  soundwire: intel_init: use FIELD_{GET|PREP}
  soundwire: remove SDW_REG_SHIFT()

 drivers/soundwire/bus.c                 |  6 +--
 drivers/soundwire/cadence_master.c      | 61 +++++++++++--------------
 drivers/soundwire/intel.c               | 52 ++++++++-------------
 drivers/soundwire/intel_init.c          |  2 +-
 drivers/soundwire/qcom.c                | 22 +++------
 drivers/soundwire/slave.c               |  2 +-
 drivers/soundwire/stream.c              | 13 ++----
 include/linux/soundwire/sdw.h           | 21 ++++++---
 include/linux/soundwire/sdw_registers.h |  7 ---
 9 files changed, 75 insertions(+), 111 deletions(-)

-- 
2.26.2

