Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F63C4332B
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:41:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1003E2070A
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iSBpjhch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1003E2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 578D311C;
	Fri, 20 Mar 2020 16:40:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 578D311C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584718885;
	bh=LOT2Uo4Hl4IY3//O3oZlLiG330ozWgo1vAHTVG3CpNw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iSBpjhch/nXRwlGm9yBCDHAndfZcKEJ9ZqtkLxaR7UGXpZEEl8hbzsAznzSc6+kkX
	 OriavoAG1In2M3Vf/q5P+dCW/nnrmrSmAWokqvCbJYovRnN7rUuAstIX89iLbparl/
	 WvHEQ+v6evCW1HnpdUU3l05r2fU9NHLU6AfpAnVs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C5CEF80126;
	Fri, 20 Mar 2020 16:40:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9B069F801F9; Fri, 20 Mar 2020 16:40:32 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7AA77F80126;
 Fri, 20 Mar 2020 16:40:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7AA77F80126
IronPort-SDR: VdGhD5F0/oE+SVYgx/+tyDhwywtDNE9u0/JZbdI32FclgRJJTzkCQdbkR9c+p0B2J0RylzWnlb
 OhQul/fEEk5A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 08:40:24 -0700
IronPort-SDR: 96gqMhRKQu2nJ0JqAeU5+ckEz0aAwT2HTpQLrXYYRBbi/DzNIrSR5VEImYcsp/n7aj9QjbXQ1C
 2Y8tgKDQvCkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; d="scan'208";a="237257373"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO
 ubuntu.ger.corp.intel.com) ([10.252.57.199])
 by fmsmga007.fm.intel.com with ESMTP; 20 Mar 2020 08:40:22 -0700
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 00/12] ASoC: SOF DSP virtualisation
Date: Fri, 20 Mar 2020 16:40:09 +0100
Message-Id: <20200320154021.5964-1-guennadi.liakhovetski@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
 Mark Brown <broonie@kernel.org>, sound-open-firmware@alsa-project.org
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

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski at linux.intel.com>

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
 sound/soc/sof/pcm.c              |   15 +-
 sound/soc/sof/pm.c               |    4 +
 sound/soc/sof/sof-audio.c        |   33 +
 sound/soc/sof/sof-audio.h        |   21 +
 sound/soc/sof/sof-priv.h         |   54 ++
 sound/soc/sof/topology.c         |   71 ++-
 sound/soc/sof/vhost-be.c         | 1248 ++++++++++++++++++++++++++++++++++++++
 sound/soc/sof/virtio-fe.c        |  922 ++++++++++++++++++++++++++++
 29 files changed, 3555 insertions(+), 109 deletions(-)
 create mode 100644 drivers/vhost/dsp.c
 create mode 100644 include/sound/sof/virtio.h
 create mode 100644 sound/soc/sof/vhost-be.c
 create mode 100644 sound/soc/sof/virtio-fe.c

-- 
1.9.3

