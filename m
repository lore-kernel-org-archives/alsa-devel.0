Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C54BC001B0
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Aug 2023 10:39:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43A1ADF0;
	Tue,  8 Aug 2023 12:38:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43A1ADF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691491142;
	bh=ovjxjtHlsMtsvzS7QajayAePZY7oJlhE++JOL5IqTUE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=du0YEwFJiE9MsOQsHTZIH4VL1HXfGLBB1JuSd9zaHQyrlumiwyznR/0k7vfF4Yiv/
	 SoAf7h7j5H4ybanPGS3r6H5s2hO2cndsyLPOv6FPrF8phgMFMvXE3WY2ulBNmqFaj3
	 MgJUTroFKVNk+4mS+ieoxd+SGSiaV3j0GfSv08o4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 539A9F805EA; Tue,  8 Aug 2023 12:35:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EEB76F805E0;
	Tue,  8 Aug 2023 12:35:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 56657F8016D; Mon,  7 Aug 2023 11:01:14 +0200 (CEST)
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1D9ABF80116;
	Mon,  7 Aug 2023 11:01:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D9ABF80116
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: Maarten Lankhorst <dev@lankhorst.se>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	linux-kernel@vger.kernel.org,
	sound-open-firmware@alsa-project.org
Subject: [PATCH v3 0/9] sound: Use -EPROBE_DEFER instead of i915 module
 loading.
Date: Mon,  7 Aug 2023 11:00:36 +0200
Message-Id: <20230807090045.198993-1-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: mlankhorst@mblankhorst.nl
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: THUJIPM63AANVAQRHWBIMZM5T4WXBXQ5
X-Message-ID-Hash: THUJIPM63AANVAQRHWBIMZM5T4WXBXQ5
X-Mailman-Approved-At: Tue, 08 Aug 2023 10:35:26 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/THUJIPM63AANVAQRHWBIMZM5T4WXBXQ5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Maarten Lankhorst <dev@lankhorst.se>

Explicitly loading i915 becomes a problem when upstreaming the new intel driver
for Tiger Lake and higher graphics (xe). By loading i915, it doesn't wait for
driver load of xe, and will fail completely before it loads.

-EPROBE_DEFER has to be returned before any device is created in probe(),
otherwise the removal of the device will cause EPROBE_DEFER to try again
in an infinite loop.

The conversion is done in gradual steps. First I add an argument to
snd_hdac_i915_init to allow for -EPROBE_DEFER so I can convert each driver
separately. Then I convert each driver to move snd_hdac_i915_init out of the
workqueue. Finally I drop the ability to choose modprobe behavior after the
last user is converted.

I suspect the avs and skylake drivers used snd_hdac_i915_init purely for the
modprobe, but I don't have the hardware to test if it can be safely removed.
It can still be done easily in a followup patch to simplify probing.

---
Changes since previous version:
- Keep the workqueue for soc/sof/intel, instead only move out
  snd_hdac_i915_init. (Patch 8/9) Rest of patches unchanged.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Cc: sound-open-firmware@alsa-project.org

Maarten Lankhorst (9):
  ALSA: hda/intel: Fix error handling in azx_probe()
  ALSA: hda/i915: Allow override of gpu binding.
  ALSA: hda/i915: Add an allow_modprobe argument to snd_hdac_i915_init
  ALSA: hda/i915: Allow xe as match for i915_component_master_match
  ASoC: Intel: avs: Move snd_hdac_i915_init to before probe_work.
  ASoC: Intel: Skylake: Move snd_hdac_i915_init to before probe_work.
  ALSA: hda/intel: Move snd_hdac_i915_init to before probe_work.
  ASoC: SOF: Intel: Move binding to display driver outside of deferred
    probe
  ALSA: hda/i915: Remove extra argument from snd_hdac_i915_init

 sound/hda/hdac_i915.c         | 25 ++++++++-------
 sound/pci/hda/hda_intel.c     | 60 ++++++++++++++++++-----------------
 sound/soc/intel/avs/core.c    | 13 +++++---
 sound/soc/intel/skylake/skl.c | 31 ++++++------------
 sound/soc/sof/core.c          | 19 ++++-------
 5 files changed, 70 insertions(+), 78 deletions(-)

-- 
2.39.2

