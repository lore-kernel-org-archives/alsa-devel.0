Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6606EC433E6
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:28:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6361464F2E
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6361464F2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7055F192B;
	Tue,  2 Mar 2021 22:27:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7055F192B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614720493;
	bh=NAbrfsFSDKir8Bbe+Pqo/qNfH5NyoDeP3pjVvF2ibaA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PlG/6frdqI5/JIujefTY1LLFX9UblCihQVimx2MLz/W1ljMlJ6YCGkA8+1SDWJaHh
	 BicYIMwtHHPMwJtVOtTlDWL1wfAqKJr5l5QEsFhyqYArMB2v/xzPCqaD3mfYwH0t2f
	 wNe3G9y1TAVrbIlk+QrcskUSCXSegYiW+uPkQncQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C6751F804AF;
	Tue,  2 Mar 2021 22:26:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B6ABF804AD; Tue,  2 Mar 2021 22:26:15 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB4D1F80277
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 22:26:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB4D1F80277
IronPort-SDR: yInG/Issn1rZCKmit+V2hGbyFGTkbKUXrbtKIjkQ9UMto3s+kb2qRYlt2mvC02knf7EEzAv3mU
 CK0mcK8QoXjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174631369"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="174631369"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:26:04 -0800
IronPort-SDR: GCJi5vO4QAnACGQx2O1rzRKEFIpf159mL5AmKLspNlCBLIEmkPcSPjasLtULQk4n5Bsnn4UUIg
 Yb9cMnAg6KWQ==
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="399223436"
Received: from btucker-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.60.230])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:26:01 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 12/24] ASoC: rt5651: remove useless assignment
Date: Tue,  2 Mar 2021 15:25:15 -0600
Message-Id: <20210302212527.55158-13-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210302212527.55158-1-pierre-louis.bossart@linux.intel.com>
References: <20210302212527.55158-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Shuming Fan <shumingf@realtek.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>
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

cppcheck warning:

sound/soc/codecs/rt5651.c:1786:13: style: Variable 'report' is
assigned a value that is never used. [unreadVariable]
 int report = 0;
            ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5651.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 49fab9db5917..fc0c83b73f09 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1783,7 +1783,7 @@ static void rt5651_jack_detect_work(struct work_struct *work)
 	struct rt5651_priv *rt5651 =
 		container_of(work, struct rt5651_priv, jack_detect_work);
 	struct snd_soc_component *component = rt5651->component;
-	int report = 0;
+	int report;
 
 	if (!rt5651_jack_inserted(component)) {
 		/* Jack removed, or spurious IRQ? */
-- 
2.25.1

