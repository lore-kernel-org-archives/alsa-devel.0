Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23D5C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:50:04 +0000 (UTC)
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4B2206E0
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4B2206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B962A822;
	Tue, 10 Dec 2019 01:49:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B962A822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575939002;
	bh=iW/UbvHgXudzI0U1UPDF0BRPkwaxVxsFYy+Gq6BsjJM=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QB+sQP8zyau3gok+NsL8e8cXKDiuOr8rG5riZgFdku27AoH62vXjoUlyhSgZs3BR1
	 JLpymMyZ7DacgUvC3yfRyP8DKV2RERauqkzvk8y2ix6bAoi36Yq5E/6bZRVkX/ErO2
	 NCRMVNcQ7p3DgwxKM/+cNEL1ha5xlt3Be7ApR940=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4691F80240;
	Tue, 10 Dec 2019 01:49:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E6DCF8023F; Tue, 10 Dec 2019 01:49:10 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 469D2F8011E
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 01:49:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 469D2F8011E
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 16:49:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,297,1571727600"; d="scan'208";a="215398944"
Received: from sneuhier-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.188.78])
 by orsmga003.jf.intel.com with ESMTP; 09 Dec 2019 16:49:03 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 18:48:46 -0600
Message-Id: <20191210004854.16845-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 0/8] ASoC: SOF: improvements for v5.6
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Mix of new interfaces for firmware functionality (channel map, ASRC),
corrections to loader code, BYT/CHT improvements w/ BYT-CR support,
HDaudio codec mask and CometLake machine driver detection.

Amery Song (1):
  ASoC: Intel: common: work-around incorrect ACPI HID for CML boards

Curtis Malainey (1):
  ASoC: SOF: Intel: split cht and byt debug window sizes

Kai Vehmanen (1):
  ASoC: SOF: Intel: add codec_mask module parameter

Karol Trzcinski (2):
  ASoC: SOF: loader: snd_sof_fw_parse_ext_data log warning on unknown
    header
  ASoC: SOF: loader: fix snd_sof_fw_parse_ext_data

Pierre-Louis Bossart (1):
  ASoC: SOF: Intel: byt: fixup topology filename for BYT-CR

Seppo Ingalsuo (1):
  ASoC: SOF: Add asynchronous sample rate converter topology support

Slawomir Blauciak (1):
  ASoC: SOF: ipc: channel map structures

 include/sound/sof/channel_map.h               | 61 +++++++++++++++
 include/sound/sof/topology.h                  | 27 +++++++
 include/uapi/sound/sof/abi.h                  |  2 +-
 include/uapi/sound/sof/tokens.h               |  6 ++
 .../intel/common/soc-acpi-intel-cml-match.c   | 41 ++++++----
 sound/soc/sof/intel/byt.c                     | 54 ++++++++++++-
 sound/soc/sof/intel/hda-ctrl.c                | 13 ++++
 sound/soc/sof/loader.c                        |  7 +-
 sound/soc/sof/topology.c                      | 78 +++++++++++++++++++
 9 files changed, 265 insertions(+), 24 deletions(-)
 create mode 100644 include/sound/sof/channel_map.h

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
