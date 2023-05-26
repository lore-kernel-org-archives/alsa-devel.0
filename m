Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB309C77B73
	for <alsa-devel@archiver.kernel.org>; Fri, 26 May 2023 20:43:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDF241F7;
	Fri, 26 May 2023 22:42:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDF241F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685133798;
	bh=EJptgHcHcoAmt8tZxT/c61c0yXme82JPlGkr8cc5fZs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=SKwW0O9zvkt/M+o8aWTXDmH+LtEiGTGyxDbU4Gd3bX2nwIIEmnZo9PU1nNnj3UhIw
	 MAFSHne6M5vfpFirz4n1UO5wskvr50+u8uskm66T/ECO6lf0ZCAsfenrLBAqHPJSOp
	 boUZxu885hs6OoTLaLmltojNEuS4fmgLK1MoPo5o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2203EF80086; Fri, 26 May 2023 22:42:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 65D59F80249;
	Fri, 26 May 2023 22:42:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6EB58F80425; Fri, 26 May 2023 22:42:21 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 33C9BF8001F
	for <alsa-devel@alsa-project.org>; Fri, 26 May 2023 22:42:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33C9BF8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CEbqnuke
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685133732; x=1716669732;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EJptgHcHcoAmt8tZxT/c61c0yXme82JPlGkr8cc5fZs=;
  b=CEbqnuke+lARgUF28bwTv09znARXNraoHwRyf8IayQt26HrNBF9ZN3sf
   BdGvr8VjcxmSpwPaPFDCAYHwOHinngmpBIzTBd21ZjOxCgewUu5Efri2Z
   fMPMDvhwoQ1dK14K+FG0EWw5J69ReZRMcXiUdiGVJfw8cDtoAS1zHW062
   qpmYNDTXnDhyc10u+nqgNQSysJ7p0JyDDEJsA8ASb0IWrJSfNOoaZxeXN
   lbc4WHC52uSTyuq4Y9257IHXD7q8Af2OdVR/n3O6DzReOqb9EUGWOytpV
   9UHxD/qfkBceB+unvxUHEfnWGPfjozKhnslaL/0L6ky2YPpnWq5IgmO4d
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="333926226"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400";
   d="scan'208";a="333926226"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2023 13:41:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="699527107"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400";
   d="scan'208";a="699527107"
Received: from bedriarm-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.48.113])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2023 13:41:58 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/3] ASoC: topology: allow for partial dailink stream_name
 match
Date: Fri, 26 May 2023 15:41:46 -0500
Message-Id: <20230526204149.456068-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4TUBS7EPL6FFBL4SOONSTVYP4XRGKAE5
X-Message-ID-Hash: 4TUBS7EPL6FFBL4SOONSTVYP4XRGKAE5
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4TUBS7EPL6FFBL4SOONSTVYP4XRGKAE5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The topology file and the machine driver rely on common definitions
for the dailink stream_name.  To avoid any backwards-compatibility
problems, the machine driver stream names are set in stone and cannot
be modified.

This is problematic when we try to name some of the topology widgets
after the stream_name, since the widget name is limited to 44
characters

tools/include/uapi/sound/asound.h:#define SNDRV_CTL_ELEM_ID_NAME_MAXLEN 44

Existing examples include "Analog Playback and Capture" for HDaudio
dailinks, which leaves less than 20 chars to identify widgets/controls
with a meaningful name.

Since the 44-char limit is part of the UAPI definitions, we assumed
there is no way to increase it.

This patchset suggests instead a partial match which allows topology
files to use a shorter stream_name, which in turn allows for
self-explanatory widget names that comply with the 44-char limit.

This should not break any existing setup but with the introduction of
a partial match new dailinks should be named carefully to avoid
confusions between e.g. 'link1' and 'link10'. The last patch fixes
such an issue in the 'nocodec' test topology used by Intel.

Ranjani Sridharan (3):
  ASoC: topology: Allow partial matching when finding DAI link
  ASoC: SOF: topology: Use partial match for connecting DAI link and DAI
    widget
  ASoC: SOF: Intel: HDA: Limit the number of dai drivers for nocodec
    mode

 sound/soc/soc-topology.c  | 6 +++---
 sound/soc/sof/intel/hda.c | 6 +++++-
 sound/soc/sof/intel/hda.h | 4 +++-
 sound/soc/sof/topology.c  | 2 +-
 4 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.37.2

