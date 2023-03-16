Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5F7C6FD19
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Mar 2023 14:16:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC49F10E8;
	Thu, 16 Mar 2023 15:15:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC49F10E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678976179;
	bh=H2j4rPsClw0wlaT9DuKihP3ONfe7hZL+W8D2Ecyd3Co=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=MbAw89ss1beFHLv6teXfVPzdRSPIIQ4INX1wKUmH4A3jx0T151wPDUYUJSqIWm+J4
	 YHzh5qrm5HDF6a3vJ89fOp0bcZH17FD4fJxBC7mx1/0kyv9QsrOno6ZG4OOo7j9liG
	 /wsDkIC1U5ckXZjlZZJoRpVniP+8Aa7K3TOIsDxI=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 49441F80425;
	Thu, 16 Mar 2023 15:15:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 290DFF80272; Thu, 16 Mar 2023 15:15:04 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C10F4F80272
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2023 15:15:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C10F4F80272
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bIq91bkO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678976102; x=1710512102;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H2j4rPsClw0wlaT9DuKihP3ONfe7hZL+W8D2Ecyd3Co=;
  b=bIq91bkO2ohVbDatukVu7+2uLqsFCuN3JCSOgPFhsVKPi69/QmDHRI2L
   rC08Uy5ZGIZjRgiLDoq6nvxFv6d5+uWDlyeI7B8PRwQBLeLECYS0KsGy8
   P/mkO4hYvvHmp3JP1fyB4FK5fZ/luhi98TILDZCd2h84OKPUUBucdEiyQ
   4N7EJAhxl/H2u/Q4aFG3ENY/3GPxiprgaDNBuZN2iLjtKlkLvhb7rybCh
   07hsNpOjLTUKiHKdqdAh5aa1sparC+9QR+xjMnAamnYJiihDI0s+pjuH6
   kKYY4s2pUAm4pRC4WNjZh41VxXGyfYGyFgff+RSsIZAqJGxve5G1jymIb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="365690601"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400";
   d="scan'208";a="365690601"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2023 07:14:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009238081"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400";
   d="scan'208";a="1009238081"
Received: from raberjix-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.62.186])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2023 07:14:31 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH 0/2] ASoC: SOF: ipc4: upport multiple configs for BE DAIs
Date: Thu, 16 Mar 2023 16:14:56 +0200
Message-Id: <20230316141458.13940-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: PF2ZFIEUITGINWM5IDJGPSOUV5ZTJVBK
X-Message-ID-Hash: PF2ZFIEUITGINWM5IDJGPSOUV5ZTJVBK
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.com, kai.vehmanen@linux.intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PF2ZFIEUITGINWM5IDJGPSOUV5ZTJVBK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

Backend DAIs may support multiple audio formats. Modify pipeline setup to select
a suitable configuration based on topology and frontend DAI runtime configuration.

The prime use case is BT offload support where we need the abality to select
different configuration on the BE side.

Regards,
Peter
--
Kai Vehmanen (2):
  ASoC: SOF: ipc4-pcm: support multiple configs for BE DAIs
  ASoC: SOF: ipc4-topology: use common helper function in copier prepare

 sound/soc/sof/ipc4-pcm.c      | 66 ++++++++++++++++++++++---
 sound/soc/sof/ipc4-topology.c | 92 ++++++++++++++++++++++++++---------
 2 files changed, 128 insertions(+), 30 deletions(-)

-- 
2.39.2

