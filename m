Return-Path: <SRS0=YoTX=4X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AED6C10DCE
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:32:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B452073B
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S+tAhj/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B452073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD8491660;
	Fri,  6 Mar 2020 12:31:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD8491660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583494330;
	bh=8RDdvfnpwQdS9lqYHcXrY0dqIX5r44fRYdCVS86YJKg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=S+tAhj/uEddab9J+M1PkhB/JptVj7F+QO6H59mXshbAPCF71UqXGC3o6R4JGpb7IL
	 SrZyHPkhJ5zSNVycJDoIOBGv4UvQr0ARSwMjmKiu66A95yTvMuPZa7u+aKFjhtj9mG
	 8QfNL2/5BGisV60i4NYbgRIiisM+EV7XHS3rQKBI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59D42F8028B;
	Fri,  6 Mar 2020 12:30:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80CBBF8028D; Fri,  6 Mar 2020 12:30:49 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F1EAF8028B
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2020 12:30:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F1EAF8028B
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Mar 2020 03:30:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,521,1574150400"; d="scan'208";a="287948936"
Received: from mgorski-all-series.igk.intel.com ([10.237.149.201])
 by FMSMGA003.fm.intel.com with ESMTP; 06 Mar 2020 03:30:38 -0800
From: Mateusz Gorski <mateusz.gorski@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ucm2: hdadsp: add basic ucm config
Date: Fri,  6 Mar 2020 12:30:31 +0100
Message-Id: <20200306113031.713-1-mateusz.gorski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: cezary.rojewski@intel.com, Mateusz Gorski <mateusz.gorski@linux.intel.com>,
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

Basic UCM configuration for HDA DSP generic enabling codec playback and
capture on both HDA codec and DMIC ports.

Signed-off-by: Mateusz Gorski <mateusz.gorski@linux.intel.com>
---
 ucm2/hdadsp/hdadsp.conf | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 ucm2/hdadsp/hdadsp.conf

diff --git a/ucm2/hdadsp/hdadsp.conf b/ucm2/hdadsp/hdadsp.conf
new file mode 100644
index 0000000..4e98545
--- /dev/null
+++ b/ucm2/hdadsp/hdadsp.conf
@@ -0,0 +1,16 @@
+# UCM for Intel CAVS platforms
+# For Audio in HDA and DMIC mode
+
+ValueDefaults {
+	PlaybackChannels "2"
+	PlaybackPriority "1"
+	CaptureChannels "2"
+	CapturePriority "2"
+}
+
+SectionDefaults [
+	cdev "hw:hdadsp"
+	cset "name='codec0_out mo media0_in mi Switch' 1"
+	cset "name='media0_out mo codec0_in mi Switch' 1"
+	cset "name='mch_cap_out mo mch_cap_in mi Switch' 1"
+]
-- 
2.17.1

