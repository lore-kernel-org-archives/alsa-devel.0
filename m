Return-Path: <SRS0=mf2d=HH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323C6C433DB
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 17:15:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0ABD64E41
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 17:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0ABD64E41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B7391607;
	Fri,  5 Feb 2021 18:14:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B7391607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612545343;
	bh=8+gSkmF4rwA4azISb+SFNCLHF+xfOhOkPDe7iVT+LE0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oc3y8XSW9CNUYMjbm7UgHgOcoDmg9yMNPU1lJOgWIrL+e1rtQxxsOl0o595pWExuG
	 iNOmBiKHFKBN7z2eUzFzNoIuIVtaixfLCMiE6yxgZkygp19/7MZj6NUk2sOCzDSLkp
	 ddSMip6ToCwZIrRBEo/4l0dU+D8qEuk8ucdQbWWA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9964F80156;
	Fri,  5 Feb 2021 18:14:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6167F8015A; Fri,  5 Feb 2021 18:14:51 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10BC2F80152
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2021 18:14:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10BC2F80152
IronPort-SDR: 0qwP2JBV29gUsk2DAAQBRBnmO6M4Hq/KN73i197ekfjDCnhpPwGBb6Ik1pDq5t9EqwSVR03J0A
 jUjyuImklJLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="266290127"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; d="scan'208";a="266290127"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2021 09:14:35 -0800
IronPort-SDR: GhXHo6rQp3+lTr4OIpJfkWoNos3Yj+ABMpCj5iFGFfiCGDsdROqWB0GVikNUUmUQ796ZB9A8gi
 X0HJzsyu3OJQ==
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; d="scan'208";a="373471831"
Received: from aadetola-mobl.amr.corp.intel.com (HELO
 rsridh-mobl1.localdomain) ([10.255.230.203])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2021 09:14:34 -0800
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2] ASoC: rt5682: Fix panic in rt5682_jack_detect_handler
 happening during system shutdown
Date: Fri,  5 Feb 2021 09:14:28 -0800
Message-Id: <20210205171428.2344210-1-ranjani.sridharan@linux.intel.com>
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
Fix this panic by cancelling all jack detection delayed work.

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
 sound/soc/codecs/rt5682-i2c.c | 3 +++
 1 file changed, 3 insertions(+)

Changelog
=========
v1 -> v2: cancel both jack detection work

diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index 37d13120f5ba..93c1603b42f1 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -273,6 +273,9 @@ static void rt5682_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt5682_priv *rt5682 = i2c_get_clientdata(client);
 
+	cancel_delayed_work_sync(&rt5682->jack_detect_work);
+	cancel_delayed_work_sync(&rt5682->jd_check_work);
+
 	rt5682_reset(rt5682);
 }
 
-- 
2.25.1

