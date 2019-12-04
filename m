Return-Path: <SRS0=elh7=Z2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3962AC43603
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 21:19:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B40522073C
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 21:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Zq3tKLMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40522073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EEBD61673;
	Wed,  4 Dec 2019 22:18:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EEBD61673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575494382;
	bh=8b3nq1pyOUnxjY9SyDGXunXF2uLlu43v6FmQRa2okjw=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zq3tKLMy6/M9/Xs6NMkzH+AS3spVU0QHMNquU0eqQkQPxP9NQlAnNISl+ygcVXVq6
	 7O7/1bN6iV2nZ2sljLf2DJzPW3TWXGMxVhyOnZGHDWcgIiSLE1kt2W7UQzDwYuaeFM
	 iJ7MClfV27jQJz2X7laMl0Bcp9benFy9zI38Fa0Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 38C67F80252;
	Wed,  4 Dec 2019 22:16:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0AD3DF80218; Wed,  4 Dec 2019 22:16:22 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD0D2F800B4
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2019 22:16:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD0D2F800B4
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Dec 2019 13:16:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,278,1571727600"; d="scan'208";a="223378561"
Received: from rgolani-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.153.236])
 by orsmga002.jf.intel.com with ESMTP; 04 Dec 2019 13:16:13 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Wed,  4 Dec 2019 15:15:47 -0600
Message-Id: <20191204211556.12671-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191204211556.12671-1-pierre-louis.bossart@linux.intel.com>
References: <20191204211556.12671-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH v2 04/13] ASoC: SOF: topology: remove
	snd_sof_init_topology()
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

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Remove snd_sof_init_topology() as it is never used.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/sof-priv.h | 2 --
 sound/soc/sof/topology.c | 9 ---------
 2 files changed, 11 deletions(-)

diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index c7c2c70ee4d0..31f0eb31598a 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -585,8 +585,6 @@ int snd_sof_ipc_set_get_comp_data(struct snd_sof_ipc *ipc,
  * There is no snd_sof_free_topology since topology components will
  * be freed by snd_soc_unregister_component,
  */
-int snd_sof_init_topology(struct snd_sof_dev *sdev,
-			  struct snd_soc_tplg_ops *ops);
 int snd_sof_load_topology(struct snd_sof_dev *sdev, const char *file);
 int snd_sof_complete_pipeline(struct snd_sof_dev *sdev,
 			      struct snd_sof_widget *swidget);
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index e20b806ec80f..f31791ce9958 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -3465,15 +3465,6 @@ static struct snd_soc_tplg_ops sof_tplg_ops = {
 	.bytes_ext_ops_count	= ARRAY_SIZE(sof_bytes_ext_ops),
 };
 
-int snd_sof_init_topology(struct snd_sof_dev *sdev,
-			  struct snd_soc_tplg_ops *ops)
-{
-	/* TODO: support linked list of topologies */
-	sdev->tplg_ops = ops;
-	return 0;
-}
-EXPORT_SYMBOL(snd_sof_init_topology);
-
 int snd_sof_load_topology(struct snd_sof_dev *sdev, const char *file)
 {
 	const struct firmware *fw;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
