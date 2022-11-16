Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D47BC4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Nov 2022 11:39:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7C80167F;
	Wed, 16 Nov 2022 12:38:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7C80167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668598779;
	bh=b9JN3t+mtBqJ+4oHOUC8epf3jJZGuRO1PNl0ywa0h1w=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R7rwClxUvo9bIRryIeLRS9Cvgm0KOqDOixEayRrpkOdlAeePv+jh6Ghgb1o9W0rYc
	 uYy+kYebCTfI8ZD4ZJ48MLMXKapFXY1wcmw9QFkj9JriEli3siK7dlkJbd10JETnv4
	 rI+o8QNqZnxb6RVR09v5ot87TYocl6xeGhZ76ucA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F181F80238;
	Wed, 16 Nov 2022 12:38:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D3C0F80169; Wed, 16 Nov 2022 12:38:47 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95C10F800B8
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2022 12:38:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95C10F800B8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="ZLO0htcd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668598725; x=1700134725;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=b9JN3t+mtBqJ+4oHOUC8epf3jJZGuRO1PNl0ywa0h1w=;
 b=ZLO0htcdG9wpIc0Cs+S+MlZskp+PMH8+dsthmc0RA4Q3pHNexDyMAjWa
 n117df5//5gRc8mvGj8ZXYj3LQPKO8JIZHDYWXDvjWE4w/QX+T39oUF8u
 qJ1nwepxz2NACTTWMHArcqwreCAsDuJaS4pJvO5l2Jvel1i8kJ5b5mxfC
 3E9O35hOhj85K2xJn7s5kf+t+/vx2J+rJp1v6XZ5gN45itqULG9uSUHiy
 9qNya+/NbULpdakM0djxzfm/NNaXSGaPI6JI0IcqZKrPsvm/xrHPaabsy
 eVyPsmEBlS05V1DVvFZnmcLEqL2OI8jmJJTxe8SHoAwdKuTKXgdYKDRqv g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="314336789"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; d="scan'208";a="314336789"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2022 03:38:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="764304420"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; d="scan'208";a="764304420"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by orsmga004.jf.intel.com with ESMTP; 16 Nov 2022 03:38:38 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH v3 0/2] ASoC: Intel: avs: DSP recovery and resume fixes
Date: Wed, 16 Nov 2022 12:55:48 +0100
Message-Id: <20221116115550.1100398-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com, hdegoede@redhat.com,
 amadeuszx.slawinski@linux.intel.com
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

Two fixes that are result of the recent discussions [1][2].

First adds missing locking around snd_pcm_stop() while the second fix
sets substream state to DISCONNECTED if any suspend/resume related
operation fails so that userspace has means to be aware that something
went wrong during said operation.

Changes in v3:
- added a comment why non-_irq() locking is used around snd_pcm_stop()

Changes in v2:
- __snd_pcm_set_state() replaced direct assignments of PCM state


[1]: https://lore.kernel.org/alsa-devel/73e6425f-8e51-e26f-ad83-ccc5df517a43@intel.com/
[2]: https://lore.kernel.org/alsa-devel/20221104131244.3920179-1-cezary.rojewski@intel.com/

Cezary Rojewski (2):
  ASoC: Intel: avs: Lock substream before snd_pcm_stop()
  ASoC: Intel: avs: Disconnect substream if suspend or resume fails

 sound/soc/intel/avs/ipc.c |  3 +++
 sound/soc/intel/avs/pcm.c | 10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.25.1

