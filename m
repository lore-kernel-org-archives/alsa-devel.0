Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286ABC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Apr 2022 16:59:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 920A6167A;
	Thu, 21 Apr 2022 18:58:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 920A6167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650560371;
	bh=n894kBvzy6AW4s5goGIwnwnyNLp1gNayJwliZiha2vk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sqCPzbcoZobGVbJ3ub17ZK258KSnwOoJ4j6AA3ez/V4TMfypxbU89Rt3+9J9nNyvk
	 OikeX9ibg01hGvJdQAjy+hGBE62pdOpBwzGll9xygk53qRzCUI9r+h+OwASR4fn9v+
	 gHTvtRl4Lx/cNaxghQLe+VXN5OgJlWUtZDKKby+E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 195C5F8047D;
	Thu, 21 Apr 2022 18:58:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A64FFF8047D; Thu, 21 Apr 2022 18:58:39 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA669F800F4
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2022 18:58:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA669F800F4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="DCi3A0C+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650560317; x=1682096317;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=n894kBvzy6AW4s5goGIwnwnyNLp1gNayJwliZiha2vk=;
 b=DCi3A0C+/Pr8tFSok0LDLh7MM4/pyI0ULA/CxiEdScwA+aauWPAUUUIf
 ik39cPtRrTnryrqmiAV9XrFxzBEHNnC2PrXpZnak06td9L5Rs5WJru5Dm
 74OKX9PY1aGuk30KCTrSJ0VTfjVx+GIVZkUyiN/eJv17uGDRjuhfEgokR
 3jf1Zz2wr/JuvaNu47VLwxcgoPExQxS/7xFLku5cTPJobkrkhA1sUibTf
 dxfPdbd70qst1tXP6hJwfT4hRAl1QvY8lOtK5XvcMvD31ltJv3P3gASZ6
 F3e40p1r5CCKJr+aRyNudDuG0Pfxz/JusHpH51prU0XM8Svtg6DWuskcO Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="246317728"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; d="scan'208";a="246317728"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 09:58:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; d="scan'208";a="530390021"
Received: from qingsu-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.148.250])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 09:58:30 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 0/2] ASoC: SOF: AMD updates
Date: Thu, 21 Apr 2022 11:58:18 -0500
Message-Id: <20220421165820.337207-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

these patches were originally submitted in the "ASoC: SOF:
AMD/Mediatek updates" series, but there was a bisect
issue on the first patch.

sound/soc/sof/amd/acp.c:176:29: error: unused variable ‘sdev’
[-Werror=unused-variable]

resubmitting as v2 with each patch compiling without warning.

Ajit Kumar Pandey (2):
  ASoC: SOF: amd: Add psp_mbox_ready() and psp_send_cmd() callback
  ASoC: SOF: amd: Use dedicated MBOX for ACP and PSP communication

 sound/soc/sof/amd/acp.c | 66 ++++++++++++++++++++++++++++++++++++-----
 sound/soc/sof/amd/acp.h |  6 ++--
 2 files changed, 63 insertions(+), 9 deletions(-)

-- 
2.30.2

