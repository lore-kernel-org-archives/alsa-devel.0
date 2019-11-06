Return-Path: <SRS0=zQEr=Y6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB99C5DF63
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:00:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956B4217F4
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rpFXhPES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956B4217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F80216A1;
	Wed,  6 Nov 2019 15:59:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F80216A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573052397;
	bh=uzfRNL6eDkdXZcktmO9nPMxXAbkoKxiInAQ65iYUSCk=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rpFXhPESLEwZKTcVuFs5u+C4VKHsAK/CdyjR0KHH/rjY+KJxMYNhK5UieBWB6Tz4o
	 7lZfc1lc15PHliTzQ1tYG9BRGTa0hW/foLt561f74S001anW2g+qiPHSNmeeGQ1Dwi
	 zqMltpKkWk3T/0dTnFht9xxwUZE/jruhIUR7D/iM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D807F8045F;
	Wed,  6 Nov 2019 15:58:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E3EDF804CF; Wed,  6 Nov 2019 15:58:29 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1FAA5F8045F
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2019 15:58:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1FAA5F8045F
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 06:58:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; d="scan'208";a="227506676"
Received: from pdblomfi-mobl.gar.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.107.145])
 by fmsmga004.fm.intel.com with ESMTP; 06 Nov 2019 06:58:21 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Wed,  6 Nov 2019 08:58:16 -0600
Message-Id: <20191106145816.9367-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>,
 Jaska Uimonen <jaska.uimonen@intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org
Subject: [alsa-devel] [PATCH] ASoC: SOF: topology: Fix bytes control size
	checks
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

From: Dragos Tarcatu <dragos_tarcatu@mentor.com>

When using the example SOF amp widget topology, KASAN dumps this
when the AMP bytes kcontrol gets loaded:

[ 9.579548] BUG: KASAN: slab-out-of-bounds in
sof_control_load+0x8cc/0xac0 [snd_sof]
[ 9.588194] Write of size 40 at addr ffff8882314559dc by task
systemd-udevd/2411

Fix that by rejecting the topology if the bytes data size > max_size

Fixes: 311ce4fe7637d ("ASoC: SOF: Add support for loading topologies")
Reviewed-by: Jaska Uimonen <jaska.uimonen@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/topology.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 17fe6a1d5f3e..6096731e89ce 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1048,15 +1048,16 @@ static int sof_control_load_bytes(struct snd_soc_component *scomp,
 	struct soc_bytes_ext *sbe = (struct soc_bytes_ext *)kc->private_value;
 	int max_size = sbe->max;
 
-	if (le32_to_cpu(control->priv.size) > max_size) {
+	/* init the get/put bytes data */
+	scontrol->size = sizeof(struct sof_ipc_ctrl_data) +
+		le32_to_cpu(control->priv.size);
+
+	if (scontrol->size > max_size) {
 		dev_err(sdev->dev, "err: bytes data size %d exceeds max %d.\n",
-			control->priv.size, max_size);
+			scontrol->size, max_size);
 		return -EINVAL;
 	}
 
-	/* init the get/put bytes data */
-	scontrol->size = sizeof(struct sof_ipc_ctrl_data) +
-		le32_to_cpu(control->priv.size);
 	scontrol->control_data = kzalloc(max_size, GFP_KERNEL);
 	cdata = scontrol->control_data;
 	if (!scontrol->control_data)
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
