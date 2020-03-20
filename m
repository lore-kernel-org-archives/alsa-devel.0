Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4F1C4332D
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:31:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF7A20709
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QIhfv/NL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF7A20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D787E825;
	Fri, 20 Mar 2020 17:30:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D787E825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584721859;
	bh=bR8h3lBd2etbY0IgLUPdUvNkzyAZgZZk+W3i6MfoDuc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QIhfv/NL3/+MxLxH03m99Yg0adyYjIKsCFBq7s/L2gvPeSuUa1OGJrphZ0NTCoXDy
	 8SSHuvd9Zy5s7d2FfQaWU99hmwwndOBEnj60P5aKFPV1yxd5mnxsEMrUskGf42FLSV
	 vMeUq+npVaR4qkTra5VYtB1Q27Fqlx3Lodaxn+FU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED099F80171;
	Fri, 20 Mar 2020 17:30:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48EF8F80162; Fri, 20 Mar 2020 17:30:06 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77F41F800C0
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 17:30:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77F41F800C0
IronPort-SDR: 4fK65Z8aNEMfbRj09yzC+Zh1pwPf1oxF+7hoAGPpkoeudtCpcvX2G64wZ8EpFDuyrWQTZWzymC
 NS87DRc7ZpRA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 09:29:57 -0700
IronPort-SDR: jLQtEbie7YuqwURQm/zDNhY5Oq8+ZRoMQNxb4exNSeTKB4yBnvlWcWS/Txw03CWPHrZfUMgnVz
 EkupLXALqyCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; d="scan'208";a="248930809"
Received: from manallet-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.34.12])
 by orsmga006.jf.intel.com with ESMTP; 20 Mar 2020 09:29:54 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/5] soundwire: add sdw_master_device support on Qualcomm
 platforms
Date: Fri, 20 Mar 2020 11:29:42 -0500
Message-Id: <20200320162947.17663-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

This patchset provides the support for sdw_master_device and
sdw_master_driver reviewed earlier and accepted as 'sane' by Greg KH.

This patchset only focuses on Qualcomm platforms and addresses all
previous comments and objections from Vinod Koul: there is no driver
used and no overhead added by this patchset. Many thanks to Srinivas
Kandagatla for testing these patches on Qualcomm devices and
contributing the missing DT parsing fix.

The transition from platform devices to sdw_master_devices on Intel
platforms was already provided and will be re-sent separately when
this infrastructure change is agreed.

Pierre-Louis Bossart (4):
  soundwire: bus_type: add master_device/driver support
  soundwire: bus_type: protect cases where no driver name is provided
  soundwire: qcom: fix error handling in probe
  soundwire: qcom: add sdw_master_device support

Srinivas Kandagatla (1):
  soundwire: master: use device node pointer from master device

 drivers/soundwire/Makefile         |   2 +-
 drivers/soundwire/bus_type.c       | 143 +++++++++++++++++++++++++++--
 drivers/soundwire/master.c         | 130 ++++++++++++++++++++++++++
 drivers/soundwire/qcom.c           |  49 ++++++++--
 drivers/soundwire/slave.c          |   7 +-
 include/linux/soundwire/sdw.h      |  59 ++++++++++++
 include/linux/soundwire/sdw_type.h |  36 +++++++-
 7 files changed, 407 insertions(+), 19 deletions(-)
 create mode 100644 drivers/soundwire/master.c


base-commit: 1ce7139436603dda9e155df0c3e275c87a725761
-- 
2.20.1

