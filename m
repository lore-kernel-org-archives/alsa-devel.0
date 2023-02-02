Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF44C636D3
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Feb 2023 11:12:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D961584A;
	Thu,  2 Feb 2023 12:11:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D961584A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675336340;
	bh=jRUyEIVdpu4MW3dtQd6mL58e4pV4LcYazij3/G6tazU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=RNVz/+0lXRIBTtFuTYxXyX1W4+Ma1Hn+xiQtFoXKi8+Cqa5ShdP22h3nLJfkQiXc6
	 DSseOhs8+99ldh+t3GIIYzYQwyc22Kdj+q87/G70BM1qvwrRofAa3F6ID3cRku6m1V
	 IfFV2nm/yLb/mBpxTSv2SW9Ax9qFKAmhiTL4Qxzc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5FE80F800E3;
	Thu,  2 Feb 2023 12:11:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 744E5F804E0; Thu,  2 Feb 2023 12:11:26 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4F46EF800E3
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2023 12:11:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F46EF800E3
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MeYz02lh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1675336281; x=1706872281;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jRUyEIVdpu4MW3dtQd6mL58e4pV4LcYazij3/G6tazU=;
 b=MeYz02lhjSOxBFcQJc1gA41yL0yDrhqbJVGaZyjMGQXejjIVX1haj1iB
 ACp5iRQXvfWjU56lKX9L2bFTrtj0dcij3YOO3cTdXorEqCo5N3+TvuYjr
 CYzNyhI+cwADifR1KRxZSUDunzHsMSfQztbcrm8zTIgJA+XVdSizCi6ug
 QVpS6EcY/VHHETT91m/rR+4XV5MLY04RV62YPPxNtugMMXNWaqr0BF4ka
 UUyfz6Eq25t/JKXL63+46gm0aqqC8Ukw5PTE7PHlf9GA5w+az0/t5Ea+P
 9dTHz0tXch6CL7knz0i/ajhL6r2gT2oospPPWRnkUd8Mk4N6W6GgCMwkj w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="414625117"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; d="scan'208";a="414625117"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2023 03:11:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="695747659"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; d="scan'208";a="695747659"
Received: from jpdamery-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.1.104])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2023 03:11:13 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz
Subject: [PATCH v2 0/9] ASoC: SOF: core/ipc4/mtl: Add support for PCM delay
 reporting
Date: Thu,  2 Feb 2023 13:11:14 +0200
Message-Id: <20230202111123.25231-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, rander.wang@intel.com,
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

Changes since v1:
- The delay calculation updated to take into account the counter wrapping on both
  ends (host and link side).

The following series adds support for the PCM delay reporting in SOF core level
and implements the needed infrastructure with IPC4 to finally enable it for MTL.

Currently this is only supported on MTL (and via IPC4), but with the
infrastructure in place it will be possible to support other platforms with
DeepBuffer.

Regards,
Peter
---
Rander Wang (9):
  ASoC: SOF: add ipc4_fw_reg header file
  ASoC: SOF: add fw_info_box support
  ASoC: SOF: add time info structure for ipc4 path
  ASoC: SOF: ipc4-pcm: allocate time info for pcm delay feature
  ASoC: SOF: ipc4-pcm: add hw_params
  ASoC: SOF: add delay function support in sof framework
  ASoC: SOF: add get_stream_position ops for pcm delay
  ASoC: SOF: Intel: mtl: add get_stream_position support
  ASoC: SOF: ipc4-pcm: add delay function support

 sound/soc/sof/intel/mtl.c   |  14 +++
 sound/soc/sof/intel/mtl.h   |   6 +
 sound/soc/sof/ipc4-fw-reg.h | 155 ++++++++++++++++++++++++
 sound/soc/sof/ipc4-pcm.c    | 232 ++++++++++++++++++++++++++++++++++++
 sound/soc/sof/ipc4-priv.h   |  15 +++
 sound/soc/sof/ipc4.c        |   3 +
 sound/soc/sof/ops.h         |  10 ++
 sound/soc/sof/pcm.c         |  13 ++
 sound/soc/sof/sof-audio.h   |   6 +
 sound/soc/sof/sof-priv.h    |  10 ++
 10 files changed, 464 insertions(+)
 create mode 100644 sound/soc/sof/ipc4-fw-reg.h

-- 
2.39.1

