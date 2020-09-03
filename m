Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DFEC433E2
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:13:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4FEA2071B
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qI/syCdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FEA2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 749831943;
	Thu,  3 Sep 2020 22:12:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 749831943
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599164014;
	bh=drRL8/ck8AitVxFqAly+f6FazZSeN3y75m1kGXBVFL4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qI/syCdKjmOGgkkNp0ZtTaSBOpzIhRj18MpXSd3P+5+OD5cHDwKcBpxjs4+q2rlAN
	 qJVAFFpQanU247HheWEjDXDLrjRqud2u3L3FhLcQjVVHE61AVgIHOG8clr0w2mVIBs
	 xshkECFUlWHA6NCPpSi1RD1FkQqAx/iy4inzaDIM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D32BFF802BC;
	Thu,  3 Sep 2020 22:11:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4455DF80278; Thu,  3 Sep 2020 22:11:07 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 322CAF80217
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 22:10:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 322CAF80217
IronPort-SDR: JbPkAmyLD2wnzoqogM2bffJ0h/IZGZ0MY41JH4EQmCUAfafRaBRyG+EBtD92VH9ZzzBX/gO07P
 cBR2Chr5kcBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="242471259"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; d="scan'208";a="242471259"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 13:10:48 -0700
IronPort-SDR: AB6qyFq4t8thP8TS+3Dbxba/zc7I3cA1uUEkWRGrbcQt8VRn6YmkveewrhON2ibhQqqEd6K2kz
 UHVaTvKLLXbw==
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; d="scan'208";a="447033089"
Received: from mrcordie-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.195.28])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 13:10:49 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 3/3] topology: use inclusive language in documentation
Date: Thu,  3 Sep 2020 15:10:24 -0500
Message-Id: <20200903201024.1109914-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903201024.1109914-1-pierre-louis.bossart@linux.intel.com>
References: <20200903201024.1109914-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Use codec_provider and codec_follower for bclk and fsync

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/topology.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/topology.h b/include/topology.h
index 4ade20df..fcf9361d 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -658,8 +658,8 @@ extern "C" {
  *
  *	id "1"				# used for binding to the config
  *	format "I2S"			# physical audio format.
- *	bclk   "master"			# Platform is master of bit clock
- *	fsync  "slave"			# Platform is slave of fsync
+ *	bclk   "codec_provider"		# Codec provides the bit clock
+ *	fsync  "codec_follower"		# Codec follows the fsync
  * }
  * </pre>
  *
-- 
2.25.1

