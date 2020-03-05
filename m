Return-Path: <SRS0=q21C=4W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145B1C3F2CD
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:54:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B4D20732
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Rt40e6ZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B4D20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D33001614;
	Thu,  5 Mar 2020 15:53:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D33001614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583420076;
	bh=apv6s+xcFTVlIy2nUsgDrAqwkxF0dAk3CHX5A0Yf9Nw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Rt40e6ZPmcHL+KrzewuWsQltz+TU5FjCngKq4Dmdn4VU+N4AYuMkF/sgh29I9Kmxn
	 uuVuRQGn4Nw785zX9ImJndoN17wtHPLyucJj/DX4HIpQ0cn8YvIjx3clnQRRoENOSh
	 Ta7HGfA7yD88kJXa8L4zpVHT5kRcPT9Oq9agGNPM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BBFEF8027B;
	Thu,  5 Mar 2020 15:53:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 157F9F8027B; Thu,  5 Mar 2020 15:53:45 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D02C0F800D8
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2020 15:53:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D02C0F800D8
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Mar 2020 06:53:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; d="scan'208";a="352372579"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2020 06:53:35 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/7] ASoC: Intel: Skylake: Fix HDaudio and Dmic
Date: Thu,  5 Mar 2020 15:53:07 +0100
Message-Id: <20200305145314.32579-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, lgirdwood@gmail.com,
 tiwai@suse.com, vkoul@kernel.org, broonie@kernel.org
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

Following is the list of fixes and updates targeting HDaudio +/- Dmic
configuration on Intel DSP platforms.


- ASoC: Intel: Skylake: Remove superfluous chip initialization
  ASoC: Intel: Skylake: Select hda configuration permissively

First patch addresses race condition issue between i915 and hda
controller. This is done by yielding priority to i915 so iDisp codec can
enumerate properly: same codec_mask is now observed regardless of driver
chosen (snd_hda_intel vs snd_soc_skl).

Second patch is a consequence of the first, to prevent driver from
incorrectly aborting probe - rather than reorganizing Skylake's boot
flow, small changed has been proposed.


- ASoC: Intel: Skylake: Shield against no-NHLT configurations

Some hardware has no NHLT exposed by BIOS (or an equivalent). Changes
have been made to ensure driver is shielded against null-dereferences and
such which occur when said table is absent.


- ASoC: Intel: skl_hda_dsp: Enable Dmic configuration

While DMIC is available on some production stuff, Intel platforms with
Skylake driver do not treat it as a valid option if no additional I2S
codec in present onboard. Update skl_hda_dsp board to expose Dmic
connections too.


- ASoC: Intel: Allow for ROM init retry on CNL platforms
  ASoC: Intel: Skylake: Await purge request ack on CNL

Both address rom init timeouts during CNL/ CFL/ CML/ WHL boot up
sequences. These provide retry mechanism and ensure purge request is
acked before proceding with FW load. bxt-sst.c has had these fixes
appended long ago - somehow someone forgotten about CNL family.

*****

Note: topology update is also needed to enable HDA +/- Dmic
configuration as existing ones do not contain any routes or widgets
required to enable it - these care about I2S only. We have prepared
corresponding UCM files too. Will be sharing them shortly.

This patchset has been prepared internally for topmost linux-stable 5.5
and 4.20 (no 4.19 as skl_hda_dsp did not exist there yet).

Apart from our RVPs, we have run tests also on:
- KBL Lenovo Carbon X1
- SKL Dell XPS 9350
- WHL Acer Swift 5

Honestly, I'd see HDaudio related patches being backport as low as 4.20
(although some changes had to be adjusted due to base differences
between 4.20 and 5.5, can share these too). One could argue HDA + Dmic
configuration should be available on 4.19 too - it's an LTS after all.
However, that time, some changes could be counted as "feature" rather
than fixes. Awaiting your replies and thoughts on that.

In consequence, I've appended "Fixes" only for last two patches for now
- once decisions are made, can append adequate tags wherever necessary.

Cezary Rojewski (6):
  ASoC: Intel: Skylake: Remove superfluous chip initialization
  ASoC: Intel: Skylake: Select hda configuration permissively
  ASoC: Intel: Skylake: Enable codec wakeup during chip init
  ASoC: Intel: Skylake: Shield against no-NHLT configurations
  ASoC: Intel: Allow for ROM init retry on CNL platforms
  ASoC: Intel: Skylake: Await purge request ack on CNL

Mateusz Gorski (1):
  ASoC: Intel: skl_hda_dsp: Enable Dmic configuration

 sound/soc/intel/boards/skl_hda_dsp_generic.c |  3 ++
 sound/soc/intel/skylake/bxt-sst.c            |  3 --
 sound/soc/intel/skylake/cnl-sst.c            | 35 ++++++++++++++++----
 sound/soc/intel/skylake/skl-nhlt.c           |  3 +-
 sound/soc/intel/skylake/skl-sst-dsp.h        |  2 ++
 sound/soc/intel/skylake/skl.c                | 29 ++++++++--------
 6 files changed, 48 insertions(+), 27 deletions(-)

-- 
2.17.1

