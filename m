Return-Path: <SRS0=Zr1M=45=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AD2C1975A
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 10:13:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91195206FA
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 10:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jmvspIBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91195206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F47016C9;
	Thu, 12 Mar 2020 11:12:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F47016C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584008012;
	bh=nEG1oQS3Ls9cVrcqMPNlRKv+dSW5pdUVaAcIb/MA66k=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jmvspIBVSIvyQTYKSCW/oV8v+Eo7njqHNAQML/3vUpSfVmYdzcOIlDtkrSRRRJEpo
	 6wZq78Ndnat66/mc3LC/2PGV+sNctgzXAbXlqtcp8rpePIUgwUK3mk638cWJP5LInx
	 UHwoKePiVjMF8RipzUiVHkh3Lk9A4b06YdifSgnw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B1F4F801D9;
	Thu, 12 Mar 2020 11:12:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7D31F8020C; Thu, 12 Mar 2020 11:12:39 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 030FAF800BE
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2020 11:12:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 030FAF800BE
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 03:12:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; d="scan'208";a="246321887"
Received: from pi-desktop.igk.intel.com ([10.237.148.102])
 by orsmga006.jf.intel.com with ESMTP; 12 Mar 2020 03:12:31 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: topology: Perform component check upfront
Date: Thu, 12 Mar 2020 08:22:39 -0400
Message-Id: <20200312122239.14489-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
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

Function soc_tplg_dbytes_create(), calls soc_tplg_init_kcontrol() to
perform additional driver specific initialization. While
soc_tplg_init_kcontrol() ensures that component is valid before invoking
ops->control_load, there is no such check at the end of
soc_tplg_dbytes_create() where list_add() is used.

Also in quite a few places, there is reference of tplg->comp->dapm or
tplg->comp->card, without any checks for tplg->comp.

In consequence of the above this may lead to referencing NULL pointer.

This allows for removal of now unnecessary checks.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/soc-topology.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 575da6aba807..66958c57d884 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -251,7 +251,7 @@ static int soc_tplg_vendor_load_(struct soc_tplg *tplg,
 {
 	int ret = 0;
 
-	if (tplg->comp && tplg->ops && tplg->ops->vendor_load)
+	if (tplg->ops && tplg->ops->vendor_load)
 		ret = tplg->ops->vendor_load(tplg->comp, tplg->index, hdr);
 	else {
 		dev_err(tplg->dev, "ASoC: no vendor load callback for ID %d\n",
@@ -283,7 +283,7 @@ static int soc_tplg_vendor_load(struct soc_tplg *tplg,
 static int soc_tplg_widget_load(struct soc_tplg *tplg,
 	struct snd_soc_dapm_widget *w, struct snd_soc_tplg_dapm_widget *tplg_w)
 {
-	if (tplg->comp && tplg->ops && tplg->ops->widget_load)
+	if (tplg->ops && tplg->ops->widget_load)
 		return tplg->ops->widget_load(tplg->comp, tplg->index, w,
 			tplg_w);
 
@@ -295,7 +295,7 @@ static int soc_tplg_widget_load(struct soc_tplg *tplg,
 static int soc_tplg_widget_ready(struct soc_tplg *tplg,
 	struct snd_soc_dapm_widget *w, struct snd_soc_tplg_dapm_widget *tplg_w)
 {
-	if (tplg->comp && tplg->ops && tplg->ops->widget_ready)
+	if (tplg->ops && tplg->ops->widget_ready)
 		return tplg->ops->widget_ready(tplg->comp, tplg->index, w,
 			tplg_w);
 
@@ -307,7 +307,7 @@ static int soc_tplg_dai_load(struct soc_tplg *tplg,
 	struct snd_soc_dai_driver *dai_drv,
 	struct snd_soc_tplg_pcm *pcm, struct snd_soc_dai *dai)
 {
-	if (tplg->comp && tplg->ops && tplg->ops->dai_load)
+	if (tplg->ops && tplg->ops->dai_load)
 		return tplg->ops->dai_load(tplg->comp, tplg->index, dai_drv,
 			pcm, dai);
 
@@ -318,7 +318,7 @@ static int soc_tplg_dai_load(struct soc_tplg *tplg,
 static int soc_tplg_dai_link_load(struct soc_tplg *tplg,
 	struct snd_soc_dai_link *link, struct snd_soc_tplg_link_config *cfg)
 {
-	if (tplg->comp && tplg->ops && tplg->ops->link_load)
+	if (tplg->ops && tplg->ops->link_load)
 		return tplg->ops->link_load(tplg->comp, tplg->index, link, cfg);
 
 	return 0;
@@ -327,7 +327,7 @@ static int soc_tplg_dai_link_load(struct soc_tplg *tplg,
 /* tell the component driver that all firmware has been loaded in this request */
 static void soc_tplg_complete(struct soc_tplg *tplg)
 {
-	if (tplg->comp && tplg->ops && tplg->ops->complete)
+	if (tplg->ops && tplg->ops->complete)
 		tplg->ops->complete(tplg->comp);
 }
 
@@ -684,7 +684,7 @@ EXPORT_SYMBOL_GPL(snd_soc_tplg_widget_bind_event);
 static int soc_tplg_init_kcontrol(struct soc_tplg *tplg,
 	struct snd_kcontrol_new *k, struct snd_soc_tplg_ctl_hdr *hdr)
 {
-	if (tplg->comp && tplg->ops && tplg->ops->control_load)
+	if (tplg->ops && tplg->ops->control_load)
 		return tplg->ops->control_load(tplg->comp, tplg->index, k,
 			hdr);
 
@@ -1174,7 +1174,7 @@ static int soc_tplg_kcontrol_elems_load(struct soc_tplg *tplg,
 static int soc_tplg_add_route(struct soc_tplg *tplg,
 	struct snd_soc_dapm_route *route)
 {
-	if (tplg->comp && tplg->ops && tplg->ops->dapm_route_load)
+	if (tplg->ops && tplg->ops->dapm_route_load)
 		return tplg->ops->dapm_route_load(tplg->comp, tplg->index,
 			route);
 
@@ -2564,7 +2564,7 @@ static int soc_tplg_manifest_load(struct soc_tplg *tplg,
 	}
 
 	/* pass control to component driver for optional further init */
-	if (tplg->comp && tplg->ops && tplg->ops->manifest)
+	if (tplg->ops && tplg->ops->manifest)
 		ret = tplg->ops->manifest(tplg->comp, tplg->index, _manifest);
 
 	if (!abi_match)	/* free the duplicated one */
@@ -2736,6 +2736,10 @@ int snd_soc_tplg_component_load(struct snd_soc_component *comp,
 	struct soc_tplg tplg;
 	int ret;
 
+	/* component needs to exist to keep and reference data while parsing */
+	if (!comp)
+		return -EINVAL;
+
 	/* setup parsing context */
 	memset(&tplg, 0, sizeof(tplg));
 	tplg.fw = fw;
-- 
2.17.1

