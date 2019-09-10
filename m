Return-Path: <SRS0=R5RK=XF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E17DC49ED9
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Sep 2019 18:30:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B49C2082C
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Sep 2019 18:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZtL0sgVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B49C2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 087B41680;
	Tue, 10 Sep 2019 20:29:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 087B41680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568140226;
	bh=Hva9cU4V+iplIxBGs6J9iJZkFJVFcy4sO4AT+mn+9/s=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZtL0sgVop5Hv//P7x1tmHnpB/L92hI8M2f4b+j8jbns3UJtxgOLGWSSw1+aDIb3W+
	 ip3NEwPqJSNpHtLpnoXSVJe14DCaDJ161HZk9gYnDoDoeZutCdD/VTYIU9CYfeEMSX
	 bZpcb/tzNnBjWQ69vdWdSFqjFSkBO5P/O6InERIk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7090BF80321;
	Tue, 10 Sep 2019 20:29:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5EB98F8036F; Tue, 10 Sep 2019 20:29:32 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E57CF800C9
 for <alsa-devel@alsa-project.org>; Tue, 10 Sep 2019 20:29:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E57CF800C9
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Sep 2019 11:29:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,490,1559545200"; d="scan'208";a="200339996"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by fmsmga001.fm.intel.com with ESMTP; 10 Sep 2019 11:29:22 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Date: Tue, 10 Sep 2019 21:29:06 +0300
Message-Id: <20190910182916.29693-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: libin.yang@intel.com, pierre-louis.bossart@linux.intel.com,
 kai.vehmanen@linux.intel.com
Subject: [alsa-devel] [PATCH v3 00/10] adapt SOF to use snd-hda-codec-hdmi
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi all,

here's the third round for this series that adapts SOF to use
snd-hda-codec-hdmi (patch_hdmi.c) codec driver instead of hdac_hdmi
(soc/codecs/hdac_hdmi.c). The primary goal is to unify the HDMI codec
implementation between DSP and non-DSP HDA configurations, offer same
interface to user-space and reduce maintenance load for all.

This is now first series without the RFC tag. The series has
all machine drivers converted that are directly impacted.

v3 changes:
- Merged two mst_no_extra_pcms patches (Takashi's feedback).
- Use mach_params instead of module name lookups to
  determine which codec driver is used at runtime (Pierre's feedback).
- Extended machine driver support to four more drivers. This
  includes now all machine drivers which are used with SOF and
  which support HDMI audio. With this patchset, the machine
  drivers continue to work with both SOF and SST DSP drivers,
  and can be configured to use hdac-hdmi also with SOF (via
  kernel module parameter -> this is for distros to provide
  backwards compatibility for UCM files).
- Various smaller cleanups across the patchset.

Feature and testing info:

 - Tested on multiple Intel platforms supported by SOF.
 - Tested with ALSA console tools as well as with Pulseaudio.
      - requires Pulseaudio 12.x or newer, see
        https://lists.freedesktop.org/archives/pulseaudio-discuss/2019-August/031358.html
 - HDMI, DP, DP-MST with multi-monitor use-scenarios work ok.
 - New feature for SOF: ELD /proc fs works just like in
   DSP-less mode.
 - New feature for SOF: jack detection works out-of-the-box
   with Pulseaudio (no need for card specific UCM for HDMI)

Kai Vehmanen (10):
  ALSA: hda/hdmi - implement mst_no_extra_pcms flag
  ALSA: hda/hdmi - allow control creation without a linked pcm
  ASoC: hdac_hda: add support for HDMI/DP as a HDA codec
  ASoC: SOF: Intel: add support for snd-hda-codec-hdmi
  ASoC: Intel: skl-hda-dsp-generic: use snd-hda-codec-hdmi
  ASoC: Intel: skl-hda-dsp-generic: fix include guard name
  ASoC: Intel: bxt-da7219-max98357a: common hdmi codec support
  ASoC: Intel: glk_rt5682_max98357a: common hdmi codec support
  ASoC: intel: sof_rt5682: common hdmi codec support
  ASoC: Intel: bxt_rt298: common hdmi codec support

 include/sound/hda_codec.h                     |  1 +
 include/sound/soc-acpi.h                      |  2 +
 sound/pci/hda/patch_hdmi.c                    | 23 +++--
 sound/soc/codecs/hdac_hda.c                   | 95 ++++++++++++++++---
 sound/soc/codecs/hdac_hda.h                   | 12 ++-
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 11 +++
 sound/soc/intel/boards/bxt_rt298.c            | 11 +++
 sound/soc/intel/boards/glk_rt5682_max98357a.c | 11 +++
 sound/soc/intel/boards/hda_dsp_common.h       | 87 +++++++++++++++++
 sound/soc/intel/boards/skl_hda_dsp_common.c   | 10 +-
 sound/soc/intel/boards/skl_hda_dsp_common.h   | 27 +++++-
 sound/soc/intel/boards/skl_hda_dsp_generic.c  |  1 +
 sound/soc/intel/boards/sof_rt5682.c           | 11 +++
 sound/soc/sof/intel/Kconfig                   | 10 ++
 sound/soc/sof/intel/hda-codec.c               | 19 +++-
 sound/soc/sof/intel/hda.c                     |  6 ++
 sound/soc/sof/intel/hda.h                     |  6 +-
 17 files changed, 315 insertions(+), 28 deletions(-)
 create mode 100644 sound/soc/intel/boards/hda_dsp_common.h

-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
