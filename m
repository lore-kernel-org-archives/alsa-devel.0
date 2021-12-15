Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022DDC433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Dec 2021 18:09:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 36EF71ABA;
	Wed, 15 Dec 2021 19:08:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 36EF71ABA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639591786;
	bh=DSxUJaKFIQu9VTD8xohDlGg+ZmuhLjoYunjkDOxj4uo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JE3TLJ5haco7UoeeiupTa3vZtXgH414LwxDnO45gKOQ0kwjart1ZipfjwOsF5smLV
	 GTmN+E33HZDGBLdrAOMa83zbmVs8WL/l+pISSUoJfuUjJhs4Ifz9RiJaL6qIyLW49F
	 QZqgquR+Uq4xFPPaRh5meTVZL9/0Tk2Z12zPmq/0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 407FBF80311;
	Wed, 15 Dec 2021 19:07:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74235F8051D; Wed, 15 Dec 2021 19:07:08 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F5AAF8032D
 for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2021 19:06:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F5AAF8032D
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="302671000"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; d="scan'208";a="302671000"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2021 10:04:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; d="scan'208";a="662015049"
Received: from manamie-mobl.amr.corp.intel.com (HELO
 rsridh2-mobl1.localdomain) ([10.254.37.3])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2021 10:04:13 -0800
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/8] ASoC: SOF: topology: Set control_data->cmd alongside
 scontrol->cmd
Date: Wed, 15 Dec 2021 10:03:59 -0800
Message-Id: <20211215180404.53254-4-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215180404.53254-1-ranjani.sridharan@linux.intel.com>
References: <20211215180404.53254-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

Set the scontrol->control_data->cmd early to the same as scontrol->cmd.

This is a preparatory patch to remove the ctrl_cmd parameter for the
snd_sof_ipc_set_get_comp_data() function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/topology.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index b3ad3a604918..c440e1c53ca5 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1091,10 +1091,12 @@ static int sof_control_load_volume(struct snd_soc_component *scomp,
 	/* set cmd for mixer control */
 	if (le32_to_cpu(mc->max) == 1) {
 		scontrol->cmd = SOF_CTRL_CMD_SWITCH;
+		scontrol->control_data->cmd = scontrol->cmd;
 		goto skip;
 	}
 
 	scontrol->cmd = SOF_CTRL_CMD_VOLUME;
+	scontrol->control_data->cmd = scontrol->cmd;
 
 	/* extract tlv data */
 	if (!kc->tlv.p || get_tlv_data(kc->tlv.p, tlv) < 0) {
@@ -1166,6 +1168,7 @@ static int sof_control_load_enum(struct snd_soc_component *scomp,
 	scontrol->num_channels = le32_to_cpu(ec->num_channels);
 	scontrol->control_data->index = kc->index;
 	scontrol->cmd = SOF_CTRL_CMD_ENUM;
+	scontrol->control_data->cmd = scontrol->cmd;
 
 	dev_dbg(scomp->dev, "tplg: load kcontrol index %d chans %d comp_id %d\n",
 		scontrol->comp_id, scontrol->num_channels, scontrol->comp_id);
@@ -1212,6 +1215,7 @@ static int sof_control_load_bytes(struct snd_soc_component *scomp,
 
 	scontrol->comp_id = sdev->next_comp_id;
 	scontrol->cmd = SOF_CTRL_CMD_BINARY;
+	scontrol->control_data->cmd = scontrol->cmd;
 	scontrol->control_data->index = kc->index;
 
 	dev_dbg(scomp->dev, "tplg: load kcontrol index %d chans %d\n",
-- 
2.25.1

