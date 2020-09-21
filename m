Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE47C43465
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:12:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E5A207BC
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="o2iwdoTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E5A207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE0DE16A9;
	Mon, 21 Sep 2020 13:11:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE0DE16A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600686761;
	bh=V9b67/XPeAY4sr5uUnYGNbc5y8AohP5eCXW09vtdBtI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=o2iwdoTTDO5gFmhRUK05mKcNZ6ekW8prtkn/c10ZtsDwA8g3ZkaEbxo6xPGwjmdRH
	 QGP9u44s3yx2GuRFcrEQaPWu7cak9BJGjCPT2LsPF9LW1iza4+2BTOuOojDiXFMYKo
	 qlyLK/ckH9n81VGUByjm4UboPOD5HgQQIHHRJZd8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 283EDF801EC;
	Mon, 21 Sep 2020 13:10:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7D866F8020B; Mon, 21 Sep 2020 13:10:14 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A264F80161
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 13:10:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A264F80161
IronPort-SDR: NAfxP6zIF0ImX/WJEQhw0Qi7RbzrYdQL8LOK1FpT5nI/aLbcQdESOeieH2SU4t08pJz72x6DwZ
 6RKlqFQYnDVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="148011220"
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="148011220"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 04:09:55 -0700
IronPort-SDR: KeDa2tIkV4o3f/+fJ/TvkT7CCVYot5WG2/0fY6KqO/xc4pD0rW3lF9FniMHX5/Kcm1U33LbuCx
 IAA6sBBdAT7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="321730190"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga002.jf.intel.com with ESMTP; 21 Sep 2020 04:09:53 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 0/5] ASoC: SOF: fix kcontrol size checks
Date: Mon, 21 Sep 2020 14:08:09 +0300
Message-Id: <20200921110814.2910477-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: lgirdwood@gmail.com, daniel.baluta@nxp.com,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com
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

Series that fixes checks for 'size' in kcontrol get/put ext_bytes methods
for SOF. The gaps in these checks were discovered via cppcheck warnings
on unused variable values.

Pierre-Louis Bossart (5):
  ASoC: SOF: control: fix size checks for ext_bytes control .get()
  ASoC: SOF: control: fix size checks for volatile ext_bytes control
    .get()
  ASoC: SOF: control: add size checks for ext_bytes control .put()
  ASoC: SOF: control: remove const in sizeof()
  ASoC: SOF: topology: remove const in sizeof()

 sound/soc/sof/control.c  | 53 +++++++++++++++++++++++++++++++---------
 sound/soc/sof/topology.c |  2 +-
 2 files changed, 43 insertions(+), 12 deletions(-)

-- 
2.27.0

