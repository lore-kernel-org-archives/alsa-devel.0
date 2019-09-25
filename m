Return-Path: <SRS0=mf6l=XU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAEEC432C2
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:53:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E33A207E0
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YOcya+Ed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E33A207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EE6A170E;
	Wed, 25 Sep 2019 18:52:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EE6A170E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569430399;
	bh=5CsyJjD8dI8g2vTQpy2QDBwvYixZ4kSV0/UHuKV0cJI=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YOcya+EdsUxNEqAX9mXGA2oNKulPUYTMTPHg4K+oA4JIRHo75Kw+iiD9xvPZpSs8M
	 fSNftaP8c61sltNh+pEdMkxv74PIIcADT5kErNKBMPxFC2OG5c6kNNfLk2je17A0sM
	 7cJwMkTtEzX5HKZgE2v7YUfc5ouVGIxximMIAen8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 206F3F805FC;
	Wed, 25 Sep 2019 18:51:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C82AF8044C; Wed, 25 Sep 2019 18:51:36 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A31DDF8044C
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2019 18:51:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A31DDF8044C
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Sep 2019 09:51:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; d="scan'208";a="203642151"
Received: from unknown (HELO localhost.localdomain) ([10.223.165.177])
 by fmsmga001.fm.intel.com with ESMTP; 25 Sep 2019 09:51:24 -0700
From: sathya.prakash.m.r@intel.com
To: alsa-devel@alsa-project.org
Date: Wed, 25 Sep 2019 22:27:02 +0530
Message-Id: <1569430624-30505-1-git-send-email-sathya.prakash.m.r@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: sathya.prakash.m.r@intel.com, naveen.m@intel.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.de
Subject: [alsa-devel] [PATCH v4 0/2] Add CML M/C for RT5682 and RT1011
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

From: Sathya Prakash M R <sathya.prakash.m.r@intel.com>

The series adds CML m/c driver with RT5682 on SSP0 and
RT1011 on SSP1.
The RT1011 is smart AMP which supports 2 Whoofers and
2 tweeter support.
RT5682 is headset codec supporting playback and record.
The m/c supports HDMI playback and DMIC record.

Naveen Manohar (2):
  ASoC: Intel: boards: Add CML m/c using RT1011 and RT5682
  ASoC: Intel: Add acpi match for rt1011 based m/c driver

 sound/soc/intel/boards/Kconfig                    |  18 +
 sound/soc/intel/boards/Makefile                   |   2 +
 sound/soc/intel/boards/cml_rt1011_rt5682.c        | 473 ++++++++++++++++++++++
 sound/soc/intel/common/soc-acpi-intel-cnl-match.c |   7 +
 4 files changed, 500 insertions(+)
 create mode 100644 sound/soc/intel/boards/cml_rt1011_rt5682.c

--
V3 Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Changes from V3: repost with more recipients and edits to commit messages
Changes from V2: re ordered match table
to ensure non i2c device matches are at the end
Changes from V1:
Addressed comments on 
ASoC: Intel: boards: Add CML m/c using RT1011 and RT5682 
1.9.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
