Return-Path: <SRS0=iKRb=DH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16767C4727E
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:44:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7004120709
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EnvDYAe4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7004120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 984F51794;
	Wed, 30 Sep 2020 13:43:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 984F51794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601466265;
	bh=twqUpTxZci2uOQTKtVtjdM37BKM14hD5984TfzMBctQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EnvDYAe47kPw7bp38bC+AzCAgY9uoQ4XDrtWzjwz4jgY4/+RH7BBhU+MtyGq1uph2
	 mSVvMbTh5wP7ppGFH2ixamTtK2q4fE6HPHoELse4E9yYJZjul2/3Lomw4ezACf0xgY
	 GZwIJRBLhE2HGQK3T+twf00t2zzFqRk3MQkrslSg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13EAEF801ED;
	Wed, 30 Sep 2020 13:43:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9A194F801F9; Wed, 30 Sep 2020 13:43:33 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D4E9F800AB
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2020 13:43:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D4E9F800AB
IronPort-SDR: 4ACROZrZ3ZPNtYW2hcghhhENh0Fkc7z1dR1n8w46aYnaCJ2FmdqH9qumxmXG1sifIwVI03uoqF
 7Wf2hTmb1/Wg==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="224022337"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="224022337"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 04:43:22 -0700
IronPort-SDR: n6UZrsaP8FnimsXMw/3ShBOL6JeIg5jbHmRggZeXuSQiyV7+16NxlGZ54INZqWMT9FeeU1zZCi
 RNkYF+uma8PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="294582987"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga008.fm.intel.com with ESMTP; 30 Sep 2020 04:43:18 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org
Subject: [PATCH v2 0/2] ALSA: HDA: Early Forbid of runtime PM
Date: Wed, 30 Sep 2020 14:41:38 +0300
Message-Id: <20200930114140.3839617-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: cezary.rojewski@intel.com, kailang@realtek.com,
 kai.vehmanen@linux.intel.com, harshapriya.n@intel.com,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
 emmanuel.jillela@intel.com
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

Fix a race with runtime PM enabled during codec initialization.

For snd-hda-intel, no changes are needed in controller code, but
to not break ASoC controller drivers, this V2 series adds
an additional change in ASoC hdac_hda to allow runtime pm again
at end of probe.

Harsha Priya (1):
  ALSA: HDA: Early Forbid of runtime PM

Kai Vehmanen (1):
  ASoC: hdac_hda: allow runtime pm at end of probe

 sound/pci/hda/hda_codec.c   | 3 +++
 sound/soc/codecs/hdac_hda.c | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.27.0

