Return-Path: <SRS0=RGWB=OY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1798C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 21:29:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3605261526
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 21:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3605261526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0F881660;
	Mon,  4 Oct 2021 23:28:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0F881660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633382981;
	bh=V6MMJvI2YqWqkJBFQB2VvTmYRUjzQlUoC50cmNhr1rg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Tj9uziKC1Olvg4CLoPQnR6sU/S1CvbR9M+vSbAMqp0tGpgVtU6jqF+bioNJxiF12e
	 raHHmf6ZLM7QTfO/AnKWfMsj7j0vEhyNa5xrblFEDxoHaOLJ/gJxoI3YS4cqonIVQN
	 JBefiEPDmACu3PnILILahsqOguPKPEBCMqqCSQ4o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CBC8F80249;
	Mon,  4 Oct 2021 23:27:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6AE9F804E2; Mon,  4 Oct 2021 23:27:54 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94C54F80229
 for <alsa-devel@alsa-project.org>; Mon,  4 Oct 2021 23:27:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94C54F80229
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="206410594"
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; d="scan'208";a="206410594"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2021 14:27:37 -0700
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; d="scan'208";a="521586219"
Received: from ksgonzal-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.181.38])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2021 14:27:36 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ASoC: SOF: topology: minor updates
Date: Mon,  4 Oct 2021 16:27:26 -0500
Message-Id: <20211004212729.199550-1-pierre-louis.bossart@linux.intel.com>
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

Two patches to visualize settings and override dynamic pipelines + one
correction for errors on connections.

Pierre-Louis Bossart (2):
  ASoC: SOF: topology: show clks_control value in dynamic debug
  ASoC: SOF: topology: allow for dynamic pipelines override for debug

Ranjani Sridharan (1):
  ASoC: SOF: topology: return error if sof_connect_dai_widget() fails

 sound/soc/sof/sof-priv.h |  6 ++++++
 sound/soc/sof/topology.c | 24 +++++++++++++++---------
 2 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.25.1

