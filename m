Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64284C433E9
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 08:28:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E91E6148E
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 08:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E91E6148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 05342168C;
	Tue,  2 Mar 2021 09:27:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 05342168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614673702;
	bh=7IELr/ye3VEMFfm+7UYSNs7tWvTjeLaMjyW6kT1clNs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iHmuWS2Fihc/Y6L9JUIfnvlc/EQBqBGymjQyLwv+isjs80bCWBnh+zFV9k2Iix1t9
	 pEoArUUIsrAc9DBM5v29lUQgWeNStMGX9O2Eo4AeTfJTcJesm918xm+WNRENRTtLOs
	 gS98vxCO5EMU2NVHUYAPHraJUzFmACXP7Ul0tjK8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C52DF80269;
	Tue,  2 Mar 2021 09:27:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D4BFF80269; Tue,  2 Mar 2021 09:27:30 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 524F5F80227
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 09:27:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 524F5F80227
IronPort-SDR: XXc0vxxhd59D5TzJxPsGGCT0EjfUaE9t8hMeW2NoXdg17axKN9uiHkt5zr1SgYWrC2SHC2o1nQ
 frnJbHXGTR4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="184302351"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="184302351"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 00:27:23 -0800
IronPort-SDR: FELPuuSxJMRfmBQIfF71vfY8TV+Wl4uWBHOM9QLs+JL1hUuXr3WcQrBBAF9OHmkODhb/knIpE9
 MDiwUHji5Btg==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="406613386"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 00:27:19 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 0/3] soundwire: clear bus clash/parity interrupt before the
 mask is enabled
Date: Tue,  2 Mar 2021 16:27:17 +0800
Message-Id: <20210302082720.12322-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

The SoundWire specification allows a Slave device to report a bus clash
or parity error with the in-band interrupt mechanism.
Unfortunately, on some platforms, these errors are randomly reported and
don't seem to be valid.
This series suggests the addition of a Master level quirk to discard such
interrupts. The quirk should in theory have been added at the Slave level,
but since the problem was detected with different generations of Slave
devices it's hard to point to a specific IP. The problem might also be
board-dependent and hence dealing with a Master quirk is simpler.

v2:
 - Reorder the patches sequence.
 - Add comments about each quirk.
 - Use u64 quirks.


Bard Liao (3):
  soundwire: add master quirks for bus clash and parity
  soundwire: bus: handle master quirks for bus clash and parity
  soundwire: intel: add master quirks for bus clash and parity

 drivers/soundwire/bus.c       | 39 +++++++++++++++++++++++++++++++++++
 drivers/soundwire/intel.c     |  3 +++
 include/linux/soundwire/sdw.h | 22 ++++++++++++++++++++
 3 files changed, 64 insertions(+)

-- 
2.17.1

