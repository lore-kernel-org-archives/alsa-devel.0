Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E196C61DA4
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Mar 2023 01:17:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E0151203;
	Thu, 16 Mar 2023 02:16:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E0151203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678929465;
	bh=mruBbeYEYvS76q1If3LbzUoj9KfnmiBSODHrmLNTmvM=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=tCByjWUm8xu4z6PMK6cm0imK9E+ZYGoGjGDYCJMlO1eQstQ7vmY/Y2VhGsavmUrfN
	 pR8YKaFpcXIBqoJ8kWEPpUTwUFOWCEVb7Je2NJqp+Xi71xT3NZuTXizqMYJM9Jfqee
	 JrDbQY1d+rWYRPvn1se13Sqrdj6h/6QVu70ZyvtM=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5EF9EF80423;
	Thu, 16 Mar 2023 02:16:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ABF4DF80423; Thu, 16 Mar 2023 02:16:30 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 616A6F8016C
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2023 02:16:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 616A6F8016C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SAc8zfgY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678929384; x=1710465384;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mruBbeYEYvS76q1If3LbzUoj9KfnmiBSODHrmLNTmvM=;
  b=SAc8zfgYkVdXKxzQW1Vs/K+7zii4xFFbDHhts6VtC0FX7wmRgclCTXZj
   XOoeUL1ET2Oytb9DCAua9wnUWXueReZOabVb3ZtT+Z2xQmatm1C2Zn7QO
   Ofu2O2Cpo2DDQtyUmhkhYPyouyNZdO7sPybvzigyW9Tfq1btyc7ibuAyN
   FYEpcrvWk1biDxu9yvunMgGoPcs2fy19kfKA7co40LdjeVLhdtUZFJ7ZK
   Pc3K/oVnreHPishZ4yjevE4bFVa94cmUbIiZ489TBmd/EJ7u538xNWvJs
   j396dJ1lQFf4kXFp9j9+mwKQxD7Jy2ZQacDFMHj11K+wdl7wYjow+vMGX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340224482"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400";
   d="scan'208";a="340224482"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2023 18:16:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="925547207"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400";
   d="scan'208";a="925547207"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2023 18:16:14 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH] soundwire: stream: restore cumulative bus bandwidth when
 compute_params callback failed
Date: Thu, 16 Mar 2023 09:30:41 +0800
Message-Id: <20230316013041.1008003-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ML5SHF4SLZU2FCD52G6YLYBTTPK5673W
X-Message-ID-Hash: ML5SHF4SLZU2FCD52G6YLYBTTPK5673W
X-MailFrom: yung-chuan.liao@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ML5SHF4SLZU2FCD52G6YLYBTTPK5673W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Shuming Fan <shumingf@realtek.com>

The _sdw_prepare_stream function just returns the error code when
compute_params callback failed.
The cumulative bus bandwidth will keep the value and won't be decreased
by sdw_deprepare_stream function.
We should restore the value of cumulative bus bandwidth when
compute_params callback failed.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Reviewed-by: Paul Olaru <paul.olaru@oss.nxp.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 8c6da1739e3d..136b6850a3f0 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1369,7 +1369,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
 			if (ret < 0) {
 				dev_err(bus->dev, "Compute params failed: %d\n",
 					ret);
-				return ret;
+				goto restore_params;
 			}
 		}
 
-- 
2.25.1

