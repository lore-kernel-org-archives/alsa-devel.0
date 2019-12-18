Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6322C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 00:07:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F48C21582
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 00:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OXDosP9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F48C21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B4FE1658;
	Wed, 18 Dec 2019 01:06:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B4FE1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576627645;
	bh=/ejLfEG2rf5y65NtLex7iFFJp24qHOZCr3Bn6DmXndE=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OXDosP9o0hr5AYEkDE8Gq2pn2MXtEL2CkDf3hKEztebYVQxIzXx6K0GHPXsdHWLWu
	 UnXWOWwf35EE13XkdkVR/3lSdDqfw/6jEvvYakZq0v8id3ouB3gYTYc/IHNZThgevQ
	 djlo3DFJ5HJuSUt0K42iSYa7Bt+zEaL7JK9okQss=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47F0FF8023F;
	Wed, 18 Dec 2019 01:05:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6323BF80256; Wed, 18 Dec 2019 01:05:39 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 263E6F80100
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 01:05:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 263E6F80100
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2019 16:05:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,327,1571727600"; d="scan'208";a="266723542"
Received: from dshoemak-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.3.243])
 by FMSMGA003.fm.intel.com with ESMTP; 17 Dec 2019 16:05:29 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 17 Dec 2019 18:05:16 -0600
Message-Id: <20191218000518.5830-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218000518.5830-1-pierre-louis.bossart@linux.intel.com>
References: <20191218000518.5830-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH v2 1/3] ASoC: SOF: fix fault at driver unload
	after failed probe
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

If sof_machine_check() fails during driver probe, the IPC
state is not initialized and this will lead to a NULL
dereference at driver unload. Example log is as follows:

[ 1535.980630] sof-audio-pci 0000:00:1f.3: error: no matching ASoC machine driver found - aborting probe
[ 1535.980631] sof-audio-pci 0000:00:1f.3: error: failed to get machine info -19
[ 1535.980632] sof-audio-pci 0000:00:1f.3: error: sof_probe_work failed err: -19
[ 1550.798373] BUG: kernel NULL pointer dereference, address: 0000000000000008
...
[ 1550.798393] Call Trace:
[ 1550.798397]  snd_sof_ipc_free+0x15/0x30 [snd_sof]
[ 1550.798399]  snd_sof_device_remove+0x29/0xa0 [snd_sof]
[ 1550.798400]  sof_pci_remove+0x10/0x30 [snd_sof_pci]

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ipc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
index 293c5ae8e882..1cede16aa7d8 100644
--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -830,6 +830,9 @@ void snd_sof_ipc_free(struct snd_sof_dev *sdev)
 {
 	struct snd_sof_ipc *ipc = sdev->ipc;
 
+	if (!ipc)
+		return;
+
 	/* disable sending of ipc's */
 	mutex_lock(&ipc->tx_mutex);
 	ipc->disable_ipc_tx = true;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
