Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310DBE77360
	for <alsa-devel@archiver.kernel.org>; Sat, 30 Sep 2023 08:16:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73341F9A;
	Sat, 30 Sep 2023 10:15:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73341F9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696061804;
	bh=VI6HYd6UgYicBB5CrODZXk5YP4jf4qxtcgYyDe4zYZ4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=lQMavhRo7C5zU15DKzZB+eyxl57//iTU/4W9OpsSD/M0ur+Li0lc/2QAz6sjBeukg
	 RbnnNQG+dltNAPeDoKRXuPWnHCX6gIFE8amPkANsLPH+UsnqVJFtHsAsQHjvHLZ7LX
	 G4uXpq0ygQWTmnnxN+J2dQ7JrmRHf5St4FHCjIUA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F4E6F8062E; Sat, 30 Sep 2023 10:12:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1014BF80623;
	Sat, 30 Sep 2023 10:12:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8FF8DF80549; Fri, 29 Sep 2023 16:51:39 +0200 (CEST)
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 64933F8007C;
	Fri, 29 Sep 2023 16:51:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64933F8007C
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
Subject: [PATCH v5 00/12] sound: Use -EPROBE_DEFER instead of i915 module
 loading.
Date: Fri, 29 Sep 2023 16:51:14 +0200
Message-Id: <20230929145123.233838-1-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: mlankhorst@mblankhorst.nl
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 63SFEILCDPBPZ5RNAR4EJX3K3MLOUNX7
X-Message-ID-Hash: 63SFEILCDPBPZ5RNAR4EJX3K3MLOUNX7
X-Mailman-Approved-At: Sat, 30 Sep 2023 08:12:27 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/63SFEILCDPBPZ5RNAR4EJX3K3MLOUNX7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

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

Compared to previous version, I added a fix for sof_ops_free() missing call,
renamed probe_no_wq and remove_no_wq to probe_early/probe_late, and fixed
the resulting fallout.

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

Maarten Lankhorst (10):
  ASoC/SOF/core: Ensure sof_ops_free() is still called when probe never
    ran.
  ALSA: hda/intel: Fix error handling in azx_probe()
  ALSA: hda/i915: Allow override of gpu binding.
  ALSA: hda/i915: Add an allow_modprobe argument to snd_hdac_i915_init
  ALSA: hda/i915: Allow xe as match for i915_component_master_match
  ASoC: Intel: avs: Move snd_hdac_i915_init to before probe_work.
  ALSA: hda/intel: Move snd_hdac_i915_init to before probe_work.
  ASoC: Intel: Skylake: Move snd_hdac_i915_init to before probe_work.
  ASoC: SOF: Intel: Move binding to display driver outside of deferred
    probe
  ALSA: hda/i915: Remove extra argument from snd_hdac_i915_init

Pierre-Louis Bossart (2):
  ASoC: SOF: core: Add probe_early and remove_late callbacks
  ASoC: SOF: Intel: hda: start splitting the probe

 sound/hda/hdac_i915.c                | 24 ++++++-----
 sound/pci/hda/hda_intel.c            | 60 ++++++++++++++--------------
 sound/soc/intel/avs/core.c           | 13 ++++--
 sound/soc/intel/skylake/skl.c        | 31 +++++---------
 sound/soc/sof/core.c                 | 17 +++++++-
 sound/soc/sof/intel/hda-common-ops.c |  2 +
 sound/soc/sof/intel/hda.c            | 30 +++++++++-----
 sound/soc/sof/intel/hda.h            |  2 +
 sound/soc/sof/ops.h                  | 16 ++++++++
 sound/soc/sof/sof-priv.h             |  2 +
 10 files changed, 119 insertions(+), 78 deletions(-)

-- 
2.39.2

