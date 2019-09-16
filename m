Return-Path: <SRS0=lXbg=XL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03258C49ED7
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Sep 2019 19:29:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8238C20665
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Sep 2019 19:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="noeOdnjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8238C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D484F1676;
	Mon, 16 Sep 2019 21:28:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D484F1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568662155;
	bh=XJi2oTovmshLXswcByd+C+yeQWT0q0G91tt13eBWUao=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=noeOdnjGkzBizf/zsoZht6qtt56jO3sx6qMvPfVDp+oxF6cG5nQ4UiWbv32KOHyuW
	 Dc+zXFA9XrAChRQZB/jC2n6Mk2m6f7JHrvSiA+USMKXLfrEQfYw/u69e6TI8wZGhVZ
	 PF4AHD1PwJT4qQQCojAbNOTZTvOwx7ucDrvA+/MM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F256F8063E;
	Mon, 16 Sep 2019 21:24:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 31161F8060E; Mon, 16 Sep 2019 21:24:06 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 307F0F80535
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2019 21:24:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 307F0F80535
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Sep 2019 12:24:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,513,1559545200"; d="scan'208";a="270291205"
Received: from jvhicko1-mobl2.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.254.104.227])
 by orsmga001.jf.intel.com with ESMTP; 16 Sep 2019 12:23:59 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Mon, 16 Sep 2019 14:23:48 -0500
Message-Id: <20190916192348.467-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916192348.467-1-pierre-louis.bossart@linux.intel.com>
References: <20190916192348.467-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH 6/6] soundwire: cadence_master: improve PDI
	allocation
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

PDI number should match dai->id, there is no need to track if a PDI is
allocated or not.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 27 ++++++++++++++-------------
 drivers/soundwire/cadence_master.h |  4 +---
 drivers/soundwire/intel.c          |  5 ++---
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index dfce2b8c5ad2..29391bad88a1 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -871,7 +871,6 @@ static int cdns_allocate_pdi(struct sdw_cdns *cdns,
 
 	for (i = 0; i < num; i++) {
 		pdi[i].num = i + pdi_offset;
-		pdi[i].assigned = false;
 	}
 
 	*stream = pdi;
@@ -1225,21 +1224,20 @@ EXPORT_SYMBOL(cdns_set_sdw_stream);
  * @num: Number of PDIs
  * @pdi: PDI instances
  *
- * Find and return a free PDI for a given PDI array
+ * Find a PDI for a given PDI array. The PDI num and dai_id are
+ * expected to match, return NULL otherwise.
  */
 static struct sdw_cdns_pdi *cdns_find_pdi(struct sdw_cdns *cdns,
 					  unsigned int offset,
 					  unsigned int num,
-					  struct sdw_cdns_pdi *pdi)
+					  struct sdw_cdns_pdi *pdi,
+					  int dai_id)
 {
 	int i;
 
-	for (i = offset; i < num; i++) {
-		if (pdi[i].assigned)
-			continue;
-		pdi[i].assigned = true;
-		return &pdi[i];
-	}
+	for (i = offset; i < offset + num; i++)
+		if (pdi[i].num == dai_id)
+			return &pdi[i];
 
 	return NULL;
 }
@@ -1279,18 +1277,21 @@ EXPORT_SYMBOL(sdw_cdns_config_stream);
  */
 struct sdw_cdns_pdi *sdw_cdns_alloc_pdi(struct sdw_cdns *cdns,
 					struct sdw_cdns_streams *stream,
-					u32 ch, u32 dir)
+					u32 ch, u32 dir, int dai_id)
 {
 	struct sdw_cdns_pdi *pdi = NULL;
 
 	if (dir == SDW_DATA_DIR_RX)
-		pdi = cdns_find_pdi(cdns, 0, stream->num_in, stream->in);
+		pdi = cdns_find_pdi(cdns, 0, stream->num_in, stream->in,
+				    dai_id);
 	else
-		pdi = cdns_find_pdi(cdns, 0, stream->num_out, stream->out);
+		pdi = cdns_find_pdi(cdns, 0, stream->num_out, stream->out,
+				    dai_id);
 
 	/* check if we found a PDI, else find in bi-directional */
 	if (!pdi)
-		pdi = cdns_find_pdi(cdns, 2, stream->num_bd, stream->bd);
+		pdi = cdns_find_pdi(cdns, 2, stream->num_bd, stream->bd,
+				    dai_id);
 
 	if (pdi) {
 		pdi->l_ch_num = 0;
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 43493fc3d2ee..001457cbe5ad 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -8,7 +8,6 @@
 /**
  * struct sdw_cdns_pdi: PDI (Physical Data Interface) instance
  *
- * @assigned: pdi assigned
  * @num: pdi number
  * @intel_alh_id: link identifier
  * @l_ch_num: low channel for PDI
@@ -18,7 +17,6 @@
  * @type: stream type, PDM or PCM
  */
 struct sdw_cdns_pdi {
-	bool assigned;
 	int num;
 	int intel_alh_id;
 	int l_ch_num;
@@ -155,7 +153,7 @@ int sdw_cdns_get_stream(struct sdw_cdns *cdns,
 			u32 ch, u32 dir);
 struct sdw_cdns_pdi *sdw_cdns_alloc_pdi(struct sdw_cdns *cdns,
 					struct sdw_cdns_streams *stream,
-					u32 ch, u32 dir);
+					u32 ch, u32 dir, int dai_id);
 void sdw_cdns_config_stream(struct sdw_cdns *cdns,
 			    u32 ch, u32 dir, struct sdw_cdns_pdi *pdi);
 
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 8a4b690948c1..44e7afee83b5 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -631,11 +631,10 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	if (dma->stream_type == SDW_STREAM_PDM)
 		pcm = false;
 
-	/* FIXME: We would need to get PDI info from topology */
 	if (pcm)
-		pdi = sdw_cdns_alloc_pdi(cdns, &cdns->pcm, ch, dir);
+		pdi = sdw_cdns_alloc_pdi(cdns, &cdns->pcm, ch, dir, dai->id);
 	else
-		pdi = sdw_cdns_alloc_pdi(cdns, &cdns->pdm, ch, dir);
+		pdi = sdw_cdns_alloc_pdi(cdns, &cdns->pdm, ch, dir, dai->id);
 
 	if (!pdi) {
 		ret = -EINVAL;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
