Return-Path: <SRS0=+eNr=5T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49235C43331
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:15:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44A8206B8
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jVxug+A4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44A8206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DADED1658;
	Fri,  3 Apr 2020 11:14:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DADED1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585905318;
	bh=vdYfIrD89VyW8x6aSFUVqbXJlo9ZLqCdswU5StNKJ4s=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jVxug+A4wxwZDFMxc0Rds0oV42SWNgCCx/0YHtlYKO1iuRPMOWyuFXtnz6hsNvMaa
	 Q9VUS9nvM78WAoFwXYntP9Ot8uGUvxmbeMdVO4Rn6WMVFpaaOo++qCe4eEGsEyYoy7
	 +0xeWhqFSbMd1GXuxWuq4ZUlc2XA6YGw8CmsLA0Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 411AFF8022D;
	Fri,  3 Apr 2020 11:14:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2AB4BF80268; Fri,  3 Apr 2020 11:14:26 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D5003F80141;
 Fri,  3 Apr 2020 11:14:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5003F80141
IronPort-SDR: IYrG0kFOaWibhgA9OuwtcRqvvAUt0IkNHWZ//hhBR07+il83X3nVrcl5EqU98oWInyzeP4FjIs
 EfR3OisORS/w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2020 02:14:09 -0700
IronPort-SDR: I8NYR4KiiYPSWbESOQDqDylSL/RVUGHhPwsa56RJQ8/Ool6yJVG4GqA6vKW6tMvZwoNQY5XuTT
 B4YdP0rePYoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,339,1580803200"; d="scan'208";a="451234915"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO
 ubuntu.ger.corp.intel.com) ([10.249.36.113])
 by fmsmga006.fm.intel.com with ESMTP; 03 Apr 2020 02:14:07 -0700
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 00/12] [RESEND] ASoC: SOF DSP virtualisation
Date: Fri,  3 Apr 2020 11:13:54 +0200
Message-Id: <20200403091406.22381-1-guennadi.liakhovetski@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 sound-open-firmware@alsa-project.org
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

This patch series extends the SOF driver to add support for DSP
virtualisation to ASoC. It is built on top of VirtIO, contains a
guest driver and a vhost in-kernel guest driver. This version
supports a single playback and a single capture interface on the
guest. The specific guest audio topology is supplied by the host
from a file, specified on the QEMU command line. This solution is
designed to use advanced DSP functionality, available on the host.
In case no DSP is available on the host, a fall-back should be
provided in the future to the pure audio virtualisation standard,
currently developed by OASIS.

Extensive documentation is available at [1].

I'd like to have at least a tentative approval on this series to send 
vhost patches 3 and 9 to virtualisation lists / maintainers for 
review and eventual merging.

v2: one patch merged, one patch resubmitted separately, otherwise 
no changes.

[1] https://thesofproject.github.io/latest/developer_guides/virtualization/virtualization.html

Guennadi Liakhovetski (12):
  ASoC: add function parameters to enable forced path pruning
  ASoC: SOF: extract firmware-related operation into a function
  ASoC: SOF: VirtIO: make a function global
  vhost: convert VHOST_VSOCK_SET_RUNNING to a generic ioctl
  ASoC: SOF: support IPC with immediate response
  ASoC: SOF: add a power status IPC
  ASoC: SOF: add two helper lookup functions
  ASoC: SOF: add a VirtIO DSP driver
  ASoC: SOF: add a vhost driver: sound part
  vhost: add an SOF DSP driver
  ASoC: SOF: VirtIO: free guest pipelines upon termination
  ASoC: SOF: VirtIO: enable simultaneous playback and capture

 drivers/vhost/Kconfig            |    7 +
 drivers/vhost/Makefile           |    5 +
 drivers/vhost/dsp.c              |  731 ++++++++++++++++++++++
 include/sound/soc-dpcm.h         |   28 +-
 include/sound/soc-topology.h     |    3 +
 include/sound/sof.h              |    4 +
 include/sound/sof/header.h       |    3 +
 include/sound/sof/topology.h     |    1 +
 include/sound/sof/virtio.h       |  206 +++++++
 include/uapi/linux/vhost.h       |    9 +-
 include/uapi/linux/vhost_types.h |    7 +
 include/uapi/linux/virtio_ids.h  |    1 +
 sound/soc/soc-compress.c         |    2 +-
 sound/soc/soc-dapm.c             |    8 +-
 sound/soc/soc-pcm.c              |   98 ++-
 sound/soc/sof/Kconfig            |    8 +
 sound/soc/sof/Makefile           |    8 +
 sound/soc/sof/core.c             |  114 ++--
 sound/soc/sof/ipc.c              |   39 +-
 sound/soc/sof/loader.c           |    4 +
 sound/soc/sof/ops.h              |   10 +-
 sound/soc/sof/pcm.c              |   13 +-
 sound/soc/sof/pm.c               |    4 +
 sound/soc/sof/sof-audio.c        |   33 +
 sound/soc/sof/sof-audio.h        |   21 +
 sound/soc/sof/sof-priv.h         |   52 ++
 sound/soc/sof/topology.c         |   71 ++-
 sound/soc/sof/vhost-be.c         | 1248 ++++++++++++++++++++++++++++++++++++++
 sound/soc/sof/virtio-fe.c        |  922 ++++++++++++++++++++++++++++
 29 files changed, 3552 insertions(+), 108 deletions(-)
 create mode 100644 drivers/vhost/dsp.c
 create mode 100644 include/sound/sof/virtio.h
 create mode 100644 sound/soc/sof/vhost-be.c
 create mode 100644 sound/soc/sof/virtio-fe.c

-- 
1.9.3

