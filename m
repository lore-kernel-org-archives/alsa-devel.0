Return-Path: <SRS0=+ZhY=7J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05632C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 02:17:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F822075F
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 02:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hfTq4U1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F822075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE4AC1770;
	Wed, 27 May 2020 04:16:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE4AC1770
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590545839;
	bh=vh1bJEXe+++yp1ww0NF9A0RU9K+/mnm8FCnkROD+At4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hfTq4U1aQifucmObU6BfYYKzvz6JWdT6ZcqxiVa0zUJkTyt/7KayXOVO0OUzCGfek
	 lrThbqNsAi3WlTN5+xGMKP3a5A2LdE+7F8wDkm4zQ/QSd4aCKMYrIGtrzw3E+RV6p+
	 Sj9uJXjlVvtQbFw9EK2p0t/kJs4PA69OHd38DUXM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D032F80149;
	Wed, 27 May 2020 04:16:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76EE2F8014E; Wed, 27 May 2020 04:16:28 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EFE7CF800CD
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2020 04:16:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFE7CF800CD
IronPort-SDR: 7QvXfQIeBwD/lLITG4Y5fZ7LkGgKijon6bf7MeXL3/TZ4m/pmxJhCnZhbhF6ccufHFKudWQZe7
 VBZ7DCkAV++A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2020 19:16:17 -0700
IronPort-SDR: g3OUjPMr50KHB/nxDxdpre+VKDOFhCLhTnFRJofgfj+ONGpaE8xOnxBkyYJc/nmJzuV8RozF7s
 uE8ZP4b0qg7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,439,1583222400"; d="scan'208";a="468534068"
Received: from keyon-x299.sh.intel.com ([10.239.159.75])
 by fmsmga005.fm.intel.com with ESMTP; 26 May 2020 19:16:15 -0700
From: Keyon Jie <yang.jie@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 0/2] ASoC topology header parsing refinement
Date: Wed, 27 May 2020 10:27:59 +0800
Message-Id: <20200527022801.336264-1-yang.jie@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: cezary.rojewski@intel.com, tiwai@suse.de,
 Keyon Jie <yang.jie@linux.intel.com>, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, broonie@kernel.org,
 sathya.prakash.m.r@intel.com, vamshi.krishna.gopal@intel.com
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

This small series is to optimize the header logging during the topology
parsing. This is verified work fine on both SOF and SST drivers.

Change History:
v3:
- Remove using the separated soc_pass_load() function and merge it to the
  soc_tplg_load_header() body.
- Add more Tested-by tags.

v2:
- Change the internal used array to be 'static' to fix the issue
  reported by: kbuild test robot <lkp@intel.com>
- Add testing coverage including Intel SST driver also.

v1:
- Initial version.

Keyon Jie (2):
  ASoC: topology: refine and log the header in the correct pass
  ASoC: topology: remove the redundant pass checks

 sound/soc/soc-topology.c | 96 ++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 58 deletions(-)

-- 
2.25.1

