Return-Path: <SRS0=uf39=JX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8A8C433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Apr 2021 21:48:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCCDF6127A
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Apr 2021 21:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCDF6127A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0542C16F5;
	Mon, 26 Apr 2021 23:47:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0542C16F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619473697;
	bh=w/Hi/TR0/E79Gv8PRoDo/DUutx4ZKTIwSST9Z28sS9c=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MZkwzS7cLXEBsnHMCyh3ZNPNgOEdlAgrQt1I3gdj30XcnYj4QLIX7QBqHTKV/hIxR
	 BYL7atnb+dkaQS4uiPQ/kYiMm0MqX6HYjXY9GUnsp119qhbrd6g2O1GrkrH9m4lJ0g
	 FYUmihUTue28qpfLAlE8fV7SCnhewZiTi5ogtYE4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D4AEF80224;
	Mon, 26 Apr 2021 23:47:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3B8A6F80165; Mon, 26 Apr 2021 23:47:24 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94C18F8012A
 for <alsa-devel@alsa-project.org>; Mon, 26 Apr 2021 23:47:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94C18F8012A
IronPort-SDR: 2XcfCD2/uKhV9mIDdqW4CR0ptcl1rJXeJsxcBKSoH2xs8YX65cIwa8OmlVMrsWMNFnbWP34myp
 E81921L+NoAA==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="260363940"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; d="scan'208";a="260363940"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2021 14:47:16 -0700
IronPort-SDR: /q3ghw2q9joPXY6snvHv8Qw9e9UFtDwwO3R+xFhy31j9fqnzYkFaAvUS9eNFypquAW5XESJfqT
 T0c3JJ+QQ7/A==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; d="scan'208";a="422810266"
Received: from bcochran-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.24.80])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2021 14:47:15 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/4] ASoC: cppcheck fixes of the week
Date: Mon, 26 Apr 2021 16:46:57 -0500
Message-Id: <20210426214701.235106-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
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

While running some checks on a rebased branch, I realized I missed a
couple of trivial cases on newer code.

Pierre-Louis Bossart (4):
  ASoC: codecs: mt6359-accdet: remove useless initialization
  ASoc: codecs: mt6359: remove useless initializations
  ASoC: codecs: rt1019: clarify expression
  ASoC: fsl: imx-pcm-rpmsg: remove useless initialization

 sound/soc/codecs/mt6359-accdet.c | 2 +-
 sound/soc/codecs/mt6359.c        | 2 +-
 sound/soc/codecs/rt1019.c        | 4 ++--
 sound/soc/fsl/imx-pcm-rpmsg.c    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.25.1

