Return-Path: <SRS0=iKRb=DH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8E7C47426
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:25:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB7A2071E
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IbL5l8pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB7A2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EAB861819;
	Wed, 30 Sep 2020 17:24:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EAB861819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601479536;
	bh=V0prXMvgb0aPLSLnPxmjhq3JXIOnu4lxDGepBJ4Yd5k=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IbL5l8pkjVXC8CQlB4hqz44D4FLW82yDohNqtaqcvkToDDXTewODPAy6dcL5xyECC
	 6FbMqXmHF2x5Kfk7K8JyPJ1bo+2uai9nRsvvsa0QRK8eObqwc439ICKhU6GuuphYtD
	 Nwv265JtSa3qoyvgTTOnXUNr6zmJko/IbFHtA3NU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A83CF80247;
	Wed, 30 Sep 2020 17:24:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 46E45F8023F; Wed, 30 Sep 2020 17:24:43 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7E9FBF800AB
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2020 17:24:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E9FBF800AB
IronPort-SDR: XFHzTgWstKAMYIWQod6cT3HKh3ujQTTaChdWsAn7zoBOaevwYzeBRJx7Gcw8/Cu7BpWxDKIpbb
 aE7VW9G9A0FA==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="150130896"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="150130896"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 08:22:07 -0700
IronPort-SDR: M6++MO4HPGSuPL3t59HK6XpicdD/zKmNlQf35Imgi5Pjmu7Y+SgMsM9XYt3CgAMFTm/n+7+NjV
 RpCJJwRr9Heg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="515114047"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga005.fm.intel.com with ESMTP; 30 Sep 2020 08:22:05 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 0/4] ASoC: SOF: cleanups for 5.10
Date: Wed, 30 Sep 2020 18:20:22 +0300
Message-Id: <20200930152026.3902186-1-kai.vehmanen@linux.intel.com>
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

Series with multiple code cleanups, plus one fix to remove
unnecessary kernel warnings related to firmware loading.

Bard Liao (1):
  ASoC: SOF: loader: handle all SOF_IPC_EXT types

Pierre-Louis Bossart (3):
  ASoC: SOF: control: remove const in sizeof()
  ASoC: SOF: topology: remove const in sizeof()
  ASoC: SOF: sof-audio: remove goto used for force-nocodec support

 sound/soc/sof/control.c   | 20 ++++++++++----------
 sound/soc/sof/loader.c    |  5 +++++
 sound/soc/sof/sof-audio.c | 10 +++-------
 sound/soc/sof/topology.c  |  2 +-
 4 files changed, 19 insertions(+), 18 deletions(-)

-- 
2.27.0

