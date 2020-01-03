Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22864C3276C
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 01:06:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33FB92085B
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 01:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VTGLloX7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="L8JEUAdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FB92085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26D5716B9;
	Fri,  3 Jan 2020 02:05:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26D5716B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578013599;
	bh=8sk9xnrwbio1Xr1JdqOklb+BUG2HMydDsNEdMgkAv1k=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=VTGLloX7CgQEQ+JsXN9ZIthDWNyo+5HwJ5xQoWfyzbTHL6C3m3k21Bo3JRSiQEZk1
	 qR/gtU0+HjUTaT7Z17c3miMcF+RivQ/djYa/+lbozItytGJcYi6C6Xu+Y/wrdaUHWd
	 qvfTUzHF6MkWPlc3n1W9PYbVGdtcYt4seVQMvszQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A101BF80157;
	Fri,  3 Jan 2020 02:05:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE9F7F8020B; Fri,  3 Jan 2020 02:05:46 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11009F8011F
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 02:05:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11009F8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="L8JEUAdo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=gZEjmaPtmdzkDxQvJj3iL/sednmMjr7nZnC8raFV2J8=; b=L8JEUAdoNfpr
 PrxXtcptNetZirIZTGf12/NEVXaGYK9SEo6FLlldhLhRFHAkCl35Lqhd9C9zgDvnFPCyPN1xj2Ajy
 Z2a+I5i8mCYQZnWGfdtP2u/kVvdORLMLWLCxlpJjQWcTgRwzfqwjqiPEZ1BrZNpVNczQtclHP+Veh
 xaGhE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1inBPJ-0003N4-Rd; Fri, 03 Jan 2020 01:05:41 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 55736D057C6; Fri,  3 Jan 2020 01:05:41 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20200102195952.9465-3-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20200102195952.9465-3-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Date: Fri,  3 Jan 2020 01:05:41 +0000 (GMT)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: soc-topology: fix endianness issues" to
	the asoc tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoC: soc-topology: fix endianness issues

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 72bbeda0222bcd382ee33b3aff71346074410c21 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 2 Jan 2020 13:59:52 -0600
Subject: [PATCH] ASoC: soc-topology: fix endianness issues

Sparse complains about a series of easy warnings, fix.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200102195952.9465-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 42 +++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 69d6a52d0066..107ba3ed5440 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -605,9 +605,11 @@ static int soc_tplg_kcontrol_bind_io(struct snd_soc_tplg_ctl_hdr *hdr,
 		ext_ops = tplg->bytes_ext_ops;
 		num_ops = tplg->bytes_ext_ops_count;
 		for (i = 0; i < num_ops; i++) {
-			if (!sbe->put && ext_ops[i].id == be->ext_ops.put)
+			if (!sbe->put &&
+			    ext_ops[i].id == le32_to_cpu(be->ext_ops.put))
 				sbe->put = ext_ops[i].put;
-			if (!sbe->get && ext_ops[i].id == be->ext_ops.get)
+			if (!sbe->get &&
+			    ext_ops[i].id == le32_to_cpu(be->ext_ops.get))
 				sbe->get = ext_ops[i].get;
 		}
 
@@ -622,11 +624,11 @@ static int soc_tplg_kcontrol_bind_io(struct snd_soc_tplg_ctl_hdr *hdr,
 	num_ops = tplg->io_ops_count;
 	for (i = 0; i < num_ops; i++) {
 
-		if (k->put == NULL && ops[i].id == hdr->ops.put)
+		if (k->put == NULL && ops[i].id == le32_to_cpu(hdr->ops.put))
 			k->put = ops[i].put;
-		if (k->get == NULL && ops[i].id == hdr->ops.get)
+		if (k->get == NULL && ops[i].id == le32_to_cpu(hdr->ops.get))
 			k->get = ops[i].get;
-		if (k->info == NULL && ops[i].id == hdr->ops.info)
+		if (k->info == NULL && ops[i].id == le32_to_cpu(hdr->ops.info))
 			k->info = ops[i].info;
 	}
 
@@ -639,11 +641,11 @@ static int soc_tplg_kcontrol_bind_io(struct snd_soc_tplg_ctl_hdr *hdr,
 	num_ops = ARRAY_SIZE(io_ops);
 	for (i = 0; i < num_ops; i++) {
 
-		if (k->put == NULL && ops[i].id == hdr->ops.put)
+		if (k->put == NULL && ops[i].id == le32_to_cpu(hdr->ops.put))
 			k->put = ops[i].put;
-		if (k->get == NULL && ops[i].id == hdr->ops.get)
+		if (k->get == NULL && ops[i].id == le32_to_cpu(hdr->ops.get))
 			k->get = ops[i].get;
-		if (k->info == NULL && ops[i].id == hdr->ops.info)
+		if (k->info == NULL && ops[i].id == le32_to_cpu(hdr->ops.info))
 			k->info = ops[i].info;
 	}
 
@@ -932,7 +934,7 @@ static int soc_tplg_denum_create_texts(struct soc_enum *se,
 	if (se->dobj.control.dtexts == NULL)
 		return -ENOMEM;
 
-	for (i = 0; i < ec->items; i++) {
+	for (i = 0; i < le32_to_cpu(ec->items); i++) {
 
 		if (strnlen(ec->texts[i], SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
 			SNDRV_CTL_ELEM_ID_NAME_MAXLEN) {
@@ -1326,7 +1328,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 		if (kc[i].name == NULL)
 			goto err_sm;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-		kc[i].access = mc->hdr.access;
+		kc[i].access = le32_to_cpu(mc->hdr.access);
 
 		/* we only support FL/FR channel mapping atm */
 		sm->reg = tplc_chan_get_reg(tplg, mc->channel,
@@ -1338,10 +1340,10 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 		sm->rshift = tplc_chan_get_shift(tplg, mc->channel,
 			SNDRV_CHMAP_FR);
 
-		sm->max = mc->max;
-		sm->min = mc->min;
-		sm->invert = mc->invert;
-		sm->platform_max = mc->platform_max;
+		sm->max = le32_to_cpu(mc->max);
+		sm->min = le32_to_cpu(mc->min);
+		sm->invert = le32_to_cpu(mc->invert);
+		sm->platform_max = le32_to_cpu(mc->platform_max);
 		sm->dobj.index = tplg->index;
 		INIT_LIST_HEAD(&sm->dobj.list);
 
@@ -1402,7 +1404,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 			goto err_se;
 
 		tplg->pos += (sizeof(struct snd_soc_tplg_enum_control) +
-				ec->priv.size);
+			      le32_to_cpu(ec->priv.size));
 
 		dev_dbg(tplg->dev, " adding DAPM widget enum control %s\n",
 			ec->hdr.name);
@@ -1412,7 +1414,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 		if (kc[i].name == NULL)
 			goto err_se;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-		kc[i].access = ec->hdr.access;
+		kc[i].access = le32_to_cpu(ec->hdr.access);
 
 		/* we only support FL/FR channel mapping atm */
 		se->reg = tplc_chan_get_reg(tplg, ec->channel, SNDRV_CHMAP_FL);
@@ -1421,8 +1423,8 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 		se->shift_r = tplc_chan_get_shift(tplg, ec->channel,
 						  SNDRV_CHMAP_FR);
 
-		se->items = ec->items;
-		se->mask = ec->mask;
+		se->items = le32_to_cpu(ec->items);
+		se->mask = le32_to_cpu(ec->mask);
 		se->dobj.index = tplg->index;
 
 		switch (le32_to_cpu(ec->hdr.ops.info)) {
@@ -1524,9 +1526,9 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dbytes_create(
 		if (kc[i].name == NULL)
 			goto err_sbe;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-		kc[i].access = be->hdr.access;
+		kc[i].access = le32_to_cpu(be->hdr.access);
 
-		sbe->max = be->max;
+		sbe->max = le32_to_cpu(be->max);
 		INIT_LIST_HEAD(&sbe->dobj.list);
 
 		/* map standard io handlers and check for external handlers */
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
