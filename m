Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65673C433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:58:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4507206F6
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ic5wTU+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4507206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E1EA166E;
	Tue,  7 Jul 2020 22:58:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E1EA166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594155532;
	bh=A1hr6BPyyEig0lirfHmmRfglflHwXfCMfCwaeniKt4s=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ic5wTU+0WMVvsGh38otovs11OOARi19VdvfWU0fGde637OQ8uXs7E4bIPqmsPljyC
	 L0ONm45wY506TDq+K+3ghHHuAqaykY1kvRPDZuFNxvi+0PXUuaYs5Whd6GrPlqkyUx
	 9gJzjnyMhZYXXlhMsfzyUw/+toMlGexcprMW1tUA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EA44F8027C;
	Tue,  7 Jul 2020 22:58:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69171F800DF; Tue,  7 Jul 2020 22:58:00 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0002F800DF
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 22:57:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0002F800DF
IronPort-SDR: vFeUpOjZzuMPPZpcO3dxhjLcbM+zK03LyseX9pnNyhpgSmEUDG3asKlRTXOCS9pAdlXTVh/J1C
 62/4ln20sS/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="146762909"
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; d="scan'208";a="146762909"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 13:57:51 -0700
IronPort-SDR: GKFApGQ5OBB5nNRkJpE6CZVlVAt9uFrfkbkLwMwxbjOOY/NR6Zdf8Ru+SxG5hj/kC50oxrkOpd
 LO4hzsCejYrQ==
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; d="scan'208";a="305796636"
Received: from colvinch-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.229.3])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 13:57:50 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 0/6] ASoC: codecs: add MAX98373 Soundwire driver
Date: Tue,  7 Jul 2020 15:57:34 -0500
Message-Id: <20200707205740.114927-1-pierre-louis.bossart@linux.intel.com>
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

V2 with a number of cleanups:
split between I2C and SoundWire modes, as done for rt5682, and updated
Kconfigs.
removed useless initializations common to both modes
removed idle_bias on
fixed register classified as volatile in error
fixed SPDX comments

Pierre-Louis Bossart (2):
  ASoC: codecs: max98373: split I2C and common parts
  ASoC: Intel: sof-sdw: add MAX98373 I2C dependencies

Ryan Lee (2):
  ASoC: codecs: max98373: Removed superfluous volume control from chip
    default
  ASoC: codecs: max98373: add SoundWire support

randerwang (2):
  ASoc: codecs: max98373: remove Idle_bias_on to let codec suspend
  ASoC: Intel: sdw_max98373: add card_late_probe support

 sound/soc/codecs/Kconfig                  |  20 +-
 sound/soc/codecs/Makefile                 |   4 +
 sound/soc/codecs/max98373-i2c.c           | 612 +++++++++++++++
 sound/soc/codecs/max98373-sdw.c           | 887 ++++++++++++++++++++++
 sound/soc/codecs/max98373-sdw.h           |  72 ++
 sound/soc/codecs/max98373.c               | 619 +--------------
 sound/soc/codecs/max98373.h               |  17 +-
 sound/soc/intel/boards/Kconfig            |   7 +-
 sound/soc/intel/boards/sof_sdw.c          |  19 +-
 sound/soc/intel/boards/sof_sdw_common.h   |   6 +
 sound/soc/intel/boards/sof_sdw_max98373.c |  12 +
 11 files changed, 1668 insertions(+), 607 deletions(-)
 create mode 100644 sound/soc/codecs/max98373-i2c.c
 create mode 100644 sound/soc/codecs/max98373-sdw.c
 create mode 100644 sound/soc/codecs/max98373-sdw.h


base-commit: a5911ac5790acaf98c929b826b3f7b4a438f9759
-- 
2.25.1

