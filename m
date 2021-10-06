Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1DAC433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 16:21:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21F16112D
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 16:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A21F16112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DAF6483A;
	Wed,  6 Oct 2021 18:20:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DAF6483A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633537263;
	bh=BFfut4vidQFbaaIg2zAvPNsYVEQE6EHOLLibzwh2kFY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mBcDySONTVRDHfnU6G/IwyPeJ9/2IsrtsmWZ2x6Zp+a6w/oQYDOAzbsPW2GbU8C8i
	 ez1JRWsc0axVYz0H3VUVUhLoh5J5mkiEaY9qet3cJ/unPCbbDAwsALB2MhOhKclJO8
	 W7orLksaVTFiwQBVLOWPYIzityjkm66xuiccX1pg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57C65F80240;
	Wed,  6 Oct 2021 18:20:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6FFAAF800FE; Wed,  6 Oct 2021 18:20:11 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0593F800FE
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 18:20:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0593F800FE
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="225926606"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; d="scan'208";a="225926606"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 09:20:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; d="scan'208";a="657046588"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.56])
 by orsmga005.jf.intel.com with ESMTP; 06 Oct 2021 09:20:00 -0700
From: Brent Lu <brent.lu@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] Multiple headphone codec driver support
Date: Thu,  7 Oct 2021 00:18:02 +0800
Message-Id: <20211006161805.938950-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Rander Wang <rander.wang@intel.com>,
 Mac Chiang <mac.chiang@intel.com>, Gongjun Song <gongjun.song@intel.com>,
 Bard Liao <bard.liao@intel.com>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
 Yong Zhi <yong.zhi@intel.com>, Charles Keepax <ckeepax@opensource.cirrus.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 Paul Olaru <paul.olaru@oss.nxp.com>, Brent Lu <brent.lu@intel.com>,
 Libin Yang <libin.yang@intel.com>,
 Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Curtis Malainey <cujomalainey@chromium.org>
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

Support multiple headphone drivers in same machine driver. In this
case, both rt5682 and rt5682s are supported and enumerated by different
ACPI HID "10EC5682" and "RTL5682".

Brent Lu (3):
  ASoC: soc-acpi: add alternative id field for machine driver matching
  ASoC: Intel: sof_rt5682: detect codec variant in probe function
  ASoC: Intel: sof_rt5682: use id_alt to enumerate rt5682s

 include/sound/soc-acpi.h                      |  2 ++
 sound/soc/intel/boards/sof_rt5682.c           | 34 +++----------------
 .../intel/common/soc-acpi-intel-adl-match.c   |  8 +++++
 .../intel/common/soc-acpi-intel-byt-match.c   |  6 ++++
 .../intel/common/soc-acpi-intel-cht-match.c   |  6 ++++
 .../intel/common/soc-acpi-intel-cml-match.c   |  8 +++++
 .../intel/common/soc-acpi-intel-icl-match.c   |  6 ++++
 .../intel/common/soc-acpi-intel-jsl-match.c   | 32 +++++------------
 .../intel/common/soc-acpi-intel-tgl-match.c   |  8 +++++
 sound/soc/soc-acpi.c                          | 21 +++++++++++-
 10 files changed, 76 insertions(+), 55 deletions(-)

-- 
2.25.1

