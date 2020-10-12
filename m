Return-Path: <SRS0=KIty=DT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E030C433E7
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:34:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155DA20790
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vWoUXyXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155DA20790
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 258A71697;
	Mon, 12 Oct 2020 12:33:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 258A71697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602498888;
	bh=HuqQ47FgePPX44Hln2mHJVA7ukQsYafgiZf1KWCrG7Y=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vWoUXyXMbFHZJeEjk+G0aeZNbTMeh1kBgscsCtTnbjz1NyRKKcLJGt9zu1MIaUGfA
	 xeVjXW0Qhbmrre1YjKCx60SS6NcyZtDwAC1dnK8APlAEdOrx7anzumaCqtxvynGI6V
	 E3GPaFY5goKBvpP6ALK2nxEm7YYOOf3tAgcWdJVU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8773EF80225;
	Mon, 12 Oct 2020 12:33:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F074FF800F6; Mon, 12 Oct 2020 12:33:04 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C691F800D8
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2020 12:32:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C691F800D8
IronPort-SDR: WpmHG1rk4ARJzNM3Eyb/OEZzKbfbZKPmZA4z4x0bgvJ4TekuDFB9udIUTNBy7ToxOxbYfgCim4
 HmJ4iIQuiB5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="164933659"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; d="scan'208";a="164933659"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 03:32:54 -0700
IronPort-SDR: yAjzgTyq9wj7MCj7tHcV0sGTUusrvAiiAhbyQZ/RZrp99M75O2MmonhLigH0k72eINEzFouzmM
 wWwFtC2QmrZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; d="scan'208";a="519574021"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga006.fm.intel.com with ESMTP; 12 Oct 2020 03:32:52 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ASoC: Intel: catpt: Wake up device before configuring SSP
 port
Date: Mon, 12 Oct 2020 12:32:20 +0200
Message-Id: <20201012103221.30759-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, andriy.shevchenko@linux.intel.com,
 lgirdwood@gmail.com, tiwai@suse.com, hdegoede@redhat.com, vkoul@kernel.org,
 broonie@kernel.org
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

catpt_dai_pcm_new() invoked during new PCM runtime creation configures
SSP by sending IPC to DSP firmware. For that to succeed device needs to
be up and running. While components default probing behavior -
snd_soc_catpt causing machine board module to load just after it - needs
no changes, machine board's module may be unloaded and re-loaded at a
different time e.g.: when catpt is already asleep.

Wake device explicitly in catpt_dai_pcm_new() to ensure communication is
established before sending any IPCs, enabling those advanced scenarios
in the process.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---

In short, this allows for following scenario (which user usually do not
touch):

1. modprobe snd_soc_catpt // core driver
2. modprobe snd_soc_sst_broadwell // machine board driver
3. wait for snd_soc_catpt to suspend (~2s)
4. rmmod snd_soc_sst_broadwell
5. modprobe snd_soc_sst_broadwell

Without the 3. everything works just fine but let's be more flexible
here.
Right now, -110 (timeout) will occur as device will simply be asleep. To
allow for this advanced scenario, pm_runtime manipulation is required.
memcmp check is to prevent unnecessary operations from occurring.

 sound/soc/intel/catpt/pcm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/catpt/pcm.c b/sound/soc/intel/catpt/pcm.c
index f78018c857b8..ba653ebea7d1 100644
--- a/sound/soc/intel/catpt/pcm.c
+++ b/sound/soc/intel/catpt/pcm.c
@@ -667,7 +667,17 @@ static int catpt_dai_pcm_new(struct snd_soc_pcm_runtime *rtm,
 		break;
 	}
 
+	/* see if this is a new configuration */
+	if (!memcmp(&cdev->devfmt[devfmt.iface], &devfmt, sizeof(devfmt)))
+		return 0;
+
+	pm_runtime_get_sync(cdev->dev);
+
 	ret = catpt_ipc_set_device_format(cdev, &devfmt);
+
+	pm_runtime_mark_last_busy(cdev->dev);
+	pm_runtime_put_autosuspend(cdev->dev);
+
 	if (ret)
 		return CATPT_IPC_ERROR(ret);
 
-- 
2.17.1

