Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D556C7EE2F
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Jun 2023 22:27:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 316BC822;
	Wed,  7 Jun 2023 00:26:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 316BC822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686090435;
	bh=RnkxITXVAFQ/wCQH/iGZ4xHnn6sfwUwbi16MdjyQSvk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=pL9bzsft8sxl8K3xdPu7sCZlNgFfB0gQ3JmoOAj/xOWF30T3jA9sMzR3RQwohApjw
	 nj6D22i/Mk8f1wIjoIX6LxhLLq6wY9yDU/nci3wOTbNs/eBC4DY3CHhmV9jDusktU3
	 OAT5+Lkbv7WAhJiA1r37mzCzxnAKNtbLsxw03xaY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1EBEBF80549; Wed,  7 Jun 2023 00:25:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F80AF80290;
	Wed,  7 Jun 2023 00:25:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A276EF80290; Wed,  7 Jun 2023 00:25:52 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BD59DF80155
	for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2023 00:25:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD59DF80155
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=M6nKB9ST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686090345; x=1717626345;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RnkxITXVAFQ/wCQH/iGZ4xHnn6sfwUwbi16MdjyQSvk=;
  b=M6nKB9STNyjfkv49YzzJdF/OgrFLyjF+UOsnSH2KalDKOL4uFcLoqLHz
   OOTlJ32z7HB0d59PPHfF+gqBnA4PAi/rir3USdDnJKT3YcAoTfmolWBZ3
   x61Xbyhnfsv6N7tIY+j7EB5D4TP5QvRKVIgLd78ogza9UXWDT8HGMoFkE
   8KeDIh89d2vEqaCW7sSMg6egfChq3pVUBssE8NeicDLzbBrHwXEqxjiw1
   QzBfb3S8Y3ZxJVBkFosmnqfoytivANdeCboxS88saExIMiXrv9YsRRx8M
   Xsefn3nwhcgZDgBmOV0Lgsii9S9G/CwZSXkwfu1M02wd2AuJR0V0U2XKl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="341465397"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400";
   d="scan'208";a="341465397"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2023 15:25:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="712356549"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400";
   d="scan'208";a="712356549"
Received: from jrmonard-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.150.10])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2023 15:25:36 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/2] ASoC: Intel: HDA: two cleanups
Date: Tue,  6 Jun 2023 17:25:27 -0500
Message-Id: <20230606222529.57156-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3YQHF7P2ZRSGQL6HXT73OGOZDFMN2BMH
X-Message-ID-Hash: 3YQHF7P2ZRSGQL6HXT73OGOZDFMN2BMH
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3YQHF7P2ZRSGQL6HXT73OGOZDFMN2BMH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

One removal of a non-existent Kconfig initialization and one
correction to enable SoundWire link when no HDaudio external codec is
detected. This will generate more information and help resolve cases
where the ACPI information is incorrect.

Pierre-Louis Bossart (2):
  ASoC: SOF: Intel: fix SoundWire/HDaudio mutual exclusion
  ASoC: SOF: Intel: hda-pcm: remove kernel parameter init

 sound/soc/sof/intel/hda-pcm.c |  2 +-
 sound/soc/sof/intel/hda.c     | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.37.2

