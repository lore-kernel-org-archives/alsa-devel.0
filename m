Return-Path: <SRS0=grW5=HG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B53C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 17:28:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B8064DD6
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 17:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B8064DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1632165E;
	Thu,  4 Feb 2021 18:27:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1632165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612459718;
	bh=1SyXeD1nBqFT7P9snhns4XllZ6eIMMYB24UIRy2Wrzk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MoDRc78T26frWQX7c4PZQaMGg2gMMyHa633+GjF0gjwcmapPdZGaYb6ef9NIb9L3Q
	 QCImXillfaXuo8J0G9jvp/PoHcSVsPZrKm4uwCiOiN4tM3w/IaQho2j1BlfJGTxX+6
	 m/JB61/YD8W8iLWyhXnwnPRhcAhnM9uPqO58ZtR0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69C25F80155;
	Thu,  4 Feb 2021 18:27:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 36A7BF80171; Thu,  4 Feb 2021 18:27:45 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A4164F80152
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2021 18:27:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4164F80152
IronPort-SDR: S0RugXQWm4cczGOP8z42PYmXilPzXtATZ0VbwsQOpPpTB9zhDyZrt+xxmALkZX5WG1K1EVTZJE
 KLS3XNyPXUDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="168967866"
X-IronPort-AV: E=Sophos;i="5.81,401,1610438400"; d="scan'208";a="168967866"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 09:27:32 -0800
IronPort-SDR: 9r22ITF+iZBGpZbpH18ggHoVkItqeOZVUHCcnBvXP+shLnd2ObZx82ymsE2xYc3NFMf0uP/AMs
 iVpWs5je4KXQ==
X-IronPort-AV: E=Sophos;i="5.81,401,1610438400"; d="scan'208";a="372890399"
Received: from samgoodw-mobl1.amr.corp.intel.com (HELO
 rsridh-mobl1.localdomain) ([10.209.119.164])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 09:27:31 -0800
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: rt5682: Fix panic in rt5682_jack_detect_handler
 happening during system shutdown
Date: Thu,  4 Feb 2021 09:27:24 -0800
Message-Id: <20210204172724.2299583-1-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jairaj Arava <jairaj.arava@intel.com>, tiwai@suse.de,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
 Shuming Fan <shumingf@realtek.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
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

From: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>

During Coldboot stress tests, system encountered the following panic.
Panic logs depicts rt5682_i2c_shutdown() happened first and then later
jack detect handler workqueue function triggered.
This situation causes panic as rt5682_i2c_shutdown() resets codec.
Fix this panic by cancelling properly delayed work.

Panic log:
[   20.936124] sof_pci_shutdown
[   20.940248] snd_sof_device_shutdown
[   20.945023] snd_sof_shutdown
[   21.126849] rt5682_i2c_shutdown
[   21.286053] rt5682_jack_detect_handler
[   21.291235] BUG: kernel NULL pointer dereference, address: 000000000000037c
[   21.299302] #PF: supervisor read access in kernel mode
[   21.305254] #PF: error_code(0x0000) - not-present page
[   21.311218] PGD 0 P4D 0
[   21.314155] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   21.319206] CPU: 2 PID: 123 Comm: kworker/2:3 Tainted: G     U            5.4.68 #10
[   21.333687] ACPI: Preparing to enter system sleep state S5
[   21.337669] Workqueue: events_power_efficient rt5682_jack_detect_handler [snd_soc_rt5682]
[   21.337671] RIP: 0010:rt5682_jack_detect_handler+0x6c/0x279 [snd_soc_rt5682]

Fixes: a50067d4f3c1d ('ASoC: rt5682: split i2c driver into separate module')
Signed-off-by: Jairaj Arava <jairaj.arava@intel.com>
Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
Reviewed-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/codecs/rt5682-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index 37d13120f5ba..6effd2611e3c 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -273,6 +273,8 @@ static void rt5682_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt5682_priv *rt5682 = i2c_get_clientdata(client);
 
+	cancel_delayed_work_sync(&rt5682->jack_detect_work);
+
 	rt5682_reset(rt5682);
 }
 
-- 
2.25.1

