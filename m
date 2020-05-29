Return-Path: <SRS0=qQ1O=7L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B623C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 12:29:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB522075A
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 12:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Wi0RQdWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB522075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B4721786;
	Fri, 29 May 2020 14:28:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B4721786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590755367;
	bh=XxxzWtndB6f9doMsnPm5RcgLAvAG2lTTIsCQGdRsMe8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Wi0RQdWXUdvUk8H1viA6WOszpp2BZu2YSDTSiwL9rb5UIhaRpDXESLc3ZFmZwt3Qz
	 MKKRZiJCbvArQg9spLwp4kevye9DHHqB7ES/UUa7VBBkEXS8sgiB7JvxN54NSfCpjL
	 aN14tVKDnfN8VzHpEIYerV7cJ6qfyaYpbaNcPago=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C998EF8014E;
	Fri, 29 May 2020 14:28:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB514F8021E; Fri, 29 May 2020 14:28:32 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C334EF800FF
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2020 14:28:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C334EF800FF
IronPort-SDR: 2cfDf4pFcxeg0Uwosju3T6ItTD2Wthslxj2PwMArZaiWCGUeccLZrPMO1zYa6C5ZajgFLtk7ix
 i50OZnGvyzIg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2020 05:28:20 -0700
IronPort-SDR: um5js2YQ+zUWt7gjiCaqFtkMTIlW+yL2woRSZi+0zIjWKkkCgwZARzuZqeYXWyRqHJGZHqurm7
 JNQXedQw27Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,448,1583222400"; d="scan'208";a="469491461"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga006.fm.intel.com with ESMTP; 29 May 2020 05:28:20 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	perex@perex.cz
Subject: [PATCH 0/2] alsa-lib: -ENODATA documentation
Date: Fri, 29 May 2020 15:28:15 +0300
Message-Id: <20200529122817.1198-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: kai.vehmanen@linux.intel.com
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

Hello all,

here's patch to document -ENODATA error as a PCM error code.
We have recently merged patches to SOF firmware to use
this error code:
  https://github.com/thesofproject/sof/pull/2918

Some additional background on the use-case:
  https://github.com/thesofproject/sof/issues/2564

In thread "Functionality of pcm_notify in snd-aloop?"
https://mailman.alsa-project.org/pipermail/alsa-devel/2020-April/166974.html

.. we discussed the possibility for ALSA to provide a mechanism
for application to wait for the condition to change, but at least
for the currently known usages, the synchronization responsibility
will be in user-space (UCM file will describe the PCM dependencies).
Anyways, this is orthogonal to documenting -ENODATA, so sending
this now.

Kai Vehmanen (2):
  pcm: add documentation for -ENODATA error code
  pcm: fix spelling in documentation for -EBADFD

 src/pcm/pcm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.26.2

