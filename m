Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85066C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Feb 2022 11:48:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC7DF950;
	Mon,  7 Feb 2022 12:47:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC7DF950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1644234483;
	bh=Owlu12yi87amPZy/3tplWsUxgkUasdrX4Gbdkr3KnWw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=slrfR+6aD42dBpIr2D5KqV5MTlFNJz2Z7xph5khdL1IzJ/zMpSt9dbZ6OP3r58O0u
	 Dr+5l0Q6uEjVtdc/ds8kXHOikwiijHueDaTZhTTfJdBpOxgnSKxMIlQ605jDC9qtk7
	 yYMdcyByf72JSQe/FpjhBAPzuJsLmqYgwUDwnDSo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6AA36F804A9;
	Mon,  7 Feb 2022 12:47:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7216F800F5; Mon,  7 Feb 2022 12:47:09 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD709F800F5
 for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2022 12:47:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD709F800F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="IFEboydn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644234427; x=1675770427;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Owlu12yi87amPZy/3tplWsUxgkUasdrX4Gbdkr3KnWw=;
 b=IFEboydnHXbvzoVEkli7L1+Eyvhvpqa5FhSpkRsEp0y5Xb1rlR5HBRCV
 aemAwhMMXzpOOGJ5FjJLvmpBMrkRdRD3gKM5q80UFHDzoBwZ711tGdDAV
 1B7UQpWmh5aF0HXdTiXzc5QXeLPTH3/oD3L9swkAs315qoHb7VNxSTkI1
 KBL4Culs34s6qMtjVWWKeD7t5bq3TA3GopXLEO/MR6b46psje2fgD13LQ
 BKdG+EUo3AQglEKSs42nQUp9Isg+cMBBqAdKFvYSRCvoy4RWZq3dnUfjD
 RNgeL2oL3ledJidNzn99SnrrUk9V+IcRyHsxylvuKFSog0aX86DIF5f0L w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="273217735"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="273217735"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 03:46:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="484394873"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by orsmga006.jf.intel.com with ESMTP; 07 Feb 2022 03:46:56 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/4] ALSA: hda: Expose codec organization functions
Date: Mon,  7 Feb 2022 12:49:02 +0100
Message-Id: <20220207114906.3759800-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, upstream@semihalf.com,
 harshapriya.n@intel.com, rad@semihalf.com, tiwai@suse.com, hdegoede@redhat.com,
 broonie@kernel.org, cujomalainey@chromium.org, lma@semihalf.com
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

Changes expose several function that are currently unavailable for
HDA-DSP drivers for use. Those functions are:

snd_hda_codec_cleanup_for_unbind()
snd_hda_codec_set_power_save()
snd_hda_codec_register()
snd_hda_codec_unregister()
snd_hda_codec_device_init()

This allows upcoming AVS driver [1] to re-use even mode of HDA related
code that is currently available in sound/pci/hda and sound/hda and
prevent any code duplication within avs-driver that would otherwise had
to happen.

Last patch in the series provides snd_hdac_ext_bus_link_at() - a helper
function which allows for retrieval of HDA segment (link) based on codec
address directly. This is simpler than parsing codec-name first to
extract the address what is the case for snd_hdac_ext_bus_get_link().
The latter function is updated to re-use newly added one so core logic
is not duplicated after the addition.

[1]: https://lore.kernel.org/all/20211208111301.1817725-1-cezary.rojewski@intel.com/


Cezary Rojewski (4):
  ALSA: hda: Add snd_hdac_ext_bus_link_at() helper
  ALSA: hda: Update and expose snd_hda_codec_device_init()
  ALSA: hda: Update and expose codec register procedures
  ALSA: hda: Expose codec cleanup and power-save functions

 include/sound/hda_codec.h           | 11 +++-
 include/sound/hdaudio_ext.h         |  1 +
 sound/hda/ext/hdac_ext_controller.c | 31 +++++++---
 sound/pci/hda/hda_codec.c           | 94 ++++++++++++++++++++---------
 sound/pci/hda/hda_local.h           |  2 -
 sound/soc/codecs/hdac_hda.c         |  2 +-
 6 files changed, 100 insertions(+), 41 deletions(-)

-- 
2.25.1

