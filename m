Return-Path: <SRS0=ybvW=5K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B945C1975A
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:23:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A665820772
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="E3u+6y+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A665820772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E91FF1667;
	Wed, 25 Mar 2020 13:23:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E91FF1667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585139033;
	bh=JyNpmrE/iUVlEmrmAVlZU2wG/9WgEVKx0bQQn5tgp+c=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=E3u+6y+ovsahYP+HW3KhqIS4aYcVond+ddZRk/IhfmDISi7X5S2dGK7mocOOznhH0
	 /LR4GDOnurECmcT1S5yol/wbTcuGTk0MLTeIA7QZ+0FSGhOJiQX60cdSDbZljag7cs
	 5scywWpWqfidipOs8J+nSjttHDWjkxHVZcdNJ2rw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DBF1F8028B;
	Wed, 25 Mar 2020 13:21:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 94E41F8028C; Wed, 25 Mar 2020 13:21:23 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4D57F800EF
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2020 13:21:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4D57F800EF
IronPort-SDR: ecG7zqyp+aCnYGfdLiEIbPvEZFfSp4zpN+XpK0/WYAIxhdB/5fPHRQDCwTkFRpGmGnYw42+KBS
 YVaQnEhu5DRg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 05:21:19 -0700
IronPort-SDR: rrQzIEZPGLFDQhfBDRDyHse7pDdAAgVATCUiXaNY7loUsIwlbdSiuY3q8EOUQ5E6akIcrZW3qf
 GWuzQ722vhyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; d="scan'208";a="238507724"
Received: from mgorski-all-series.igk.intel.com ([10.237.149.201])
 by fmsmga007.fm.intel.com with ESMTP; 25 Mar 2020 05:21:17 -0700
From: Mateusz Gorski <mateusz.gorski@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] Add topologies for generic HDA DSP machine driver 
Date: Wed, 25 Mar 2020 13:21:44 +0100
Message-Id: <20200325122147.12121-1-mateusz.gorski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: Mateusz Gorski <mateusz.gorski@intel.com>, cezary.rojewski@intel.com,
 tiwai@suse.com
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

From: Mateusz Gorski <mateusz.gorski@intel.com>

The set of patches adds 3 topology conf files for HDA DSP generic
machine driver. These topologies cover all three possible
configurations:
	- no DMIC 
	- 2 channel DMIC array
	- 4 channel DMIC array

Mateusz Gorski (3):
  topology: Add topology conf for generic HDA DSP machine driver for
    devices without DMIC array
  topology: Add topology conf for generic HDA DSP machine driver for
    devices with 2 channel DMIC array
  topology: Add topology conf for generic HDA DSP machine driver for
    devices with 4 channel DMIC array

 topology/hdadsp/hda_dsp_DMIC_2ch.conf | 7453 +++++++++++++++++++++++++
 topology/hdadsp/hda_dsp_DMIC_4ch.conf | 7453 +++++++++++++++++++++++++
 topology/hdadsp/hda_dsp_noDMIC.conf   | 6763 ++++++++++++++++++++++
 3 files changed, 21669 insertions(+)
 create mode 100644 topology/hdadsp/hda_dsp_DMIC_2ch.conf
 create mode 100644 topology/hdadsp/hda_dsp_DMIC_4ch.conf
 create mode 100644 topology/hdadsp/hda_dsp_noDMIC.conf

-- 
2.17.1

