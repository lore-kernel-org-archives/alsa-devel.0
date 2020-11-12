Return-Path: <SRS0=f4/q=ES=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2ABC56202
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 16:32:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC14C20B80
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 16:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jdTFvtB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC14C20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D306B1816;
	Thu, 12 Nov 2020 17:31:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D306B1816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605198718;
	bh=1PG/WpIggRVr4vN8KWaI8pgYooHNQsrRlk7bFccbzeY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jdTFvtB+G4lEq/Wuh6cmHSl6XlNx6FTXwlknVFHvLmaN8Hayrs/ekhnb4/1L7qGIp
	 afaz0mm3gEd6wLPeeIVdb2zPuxO5RN09meIlV7G1ak9/36DEqO6TcZeFHjjMTIKLxj
	 3A/lFJO8k6eMMT/WrMZP4jQzIB+gV5+/CDJb1vUE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E37ABF8007E;
	Thu, 12 Nov 2020 17:30:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 587FAF804B1; Thu, 12 Nov 2020 17:30:17 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 045F4F800D1
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2020 17:30:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 045F4F800D1
IronPort-SDR: 6pXbbkx483EApIm4jDyfTDHDWFnfaE74Gy2qdSxjcYf7I9QEVQgGCD4JUHAIi9UvJkAYR4YdCN
 KAlVcHvj44EQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="157355229"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; d="scan'208";a="157355229"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2020 08:30:05 -0800
IronPort-SDR: QCKGs5igTVf56T+PITM4cV0307387jFOQ23YDP2FOONWVFzziVko9YTYoDk12KNA1ugqBVkaRr
 fsKzF+5Dl4/A==
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; d="scan'208";a="357147686"
Received: from nsalmulx-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.36.117])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2020 08:30:04 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH RESEND 3/3] topology: use inclusive language in documentation
Date: Thu, 12 Nov 2020 10:29:40 -0600
Message-Id: <20201112162940.4970-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112162940.4970-1-pierre-louis.bossart@linux.intel.com>
References: <20201112162940.4970-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, broonie@kernel.org,
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

Use codec_provider and codec_consumer for bclk and fsync

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/topology.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/topology.h b/include/topology.h
index 4ade20df..d1feee4d 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -658,8 +658,8 @@ extern "C" {
  *
  *	id "1"				# used for binding to the config
  *	format "I2S"			# physical audio format.
- *	bclk   "master"			# Platform is master of bit clock
- *	fsync  "slave"			# Platform is slave of fsync
+ *	bclk   "codec_provider"		# Codec provides the bit clock
+ *	fsync  "codec_consumer"		# Codec follows the fsync
  * }
  * </pre>
  *
-- 
2.25.1

