Return-Path: <SRS0=vkql=A4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AD5C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:22:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589D62070E
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gNZgqxLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589D62070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8BF11615;
	Fri, 17 Jul 2020 12:21:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8BF11615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594981356;
	bh=QGe7Ih+xJ/1I7B2d1lTNmISNdLm6P/zm1sPYKZobE70=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gNZgqxLcvYPhCD49+Fm7SgR++1IEwPg717MqR65sPUIP8d9fV3cN+dkZbubyuzgZ9
	 nylpiltrNkSuj6xQefHBulTeY3NlzoE08HmYzWCFMbLDLUtc6Uji3/JuIcOvSxlomX
	 ABrtaZQqU63/Km4qWfm9a5ppFSGECAP2axFZZwZ0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CDAE4F801D8;
	Fri, 17 Jul 2020 12:20:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5DAFCF8014E; Fri, 17 Jul 2020 12:20:56 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60E65F8014E
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2020 12:20:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60E65F8014E
IronPort-SDR: /1Z1sUD2Hbk5MPC14M8BL4tSQcE0BhBwn5EUJMTtwaKlH5zGLAc3Kd3DuGuiwdwnqLY98pCZOO
 tE1hX0r4TpFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="137682722"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; d="scan'208";a="137682722"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2020 03:20:46 -0700
IronPort-SDR: LEH4dqoqO27sOXPghptIz6y0MWhwv3qOCozGKL+a7I9nsCNwH1V1H34++7bR6LPAnM28HWAktZ
 A2R3neRtx/qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; d="scan'208";a="282744417"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga003.jf.intel.com with ESMTP; 17 Jul 2020 03:20:44 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 2/3] ASoC: hdac_hda: fix memleak on module unload
Date: Fri, 17 Jul 2020 13:19:49 +0300
Message-Id: <20200717101950.3885187-2-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717101950.3885187-1-kai.vehmanen@linux.intel.com>
References: <20200717101950.3885187-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com
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

The hdac_hda remove implementation fails to free the hda codec
resources, leading to memleaks at module unload. This gap has been there
from the start, commit 6bae5ea94989 ("ASoC: hdac_hda: add asoc
extension for legacy HDA codec drivers").

Instead of duplicating the cleanup logic, use the common
snd_hda_codec_cleanup_for_unbind() to free the resources. Remove
existing code in hdac_hda to cleanup "codec.jackpoll_work" and call to
snd_hdac_regmap_exit(), as these are already done in
snd_hda_codec_cleanup_for_unbind().

The cleanup is done in ASoC component remove() callback and not in the
HDAC bus hdev_detach(). This is done to ensure the codec specific
cleanup routines are run before the parent card is freed.

Fixes: 6bae5ea94989 ("ASoC: hdac_hda: add asoc extension for legacy HDA codec drivers")
BugLink: https://github.com/thesofproject/linux/issues/2195
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/codecs/hdac_hda.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 72bd779bf942..74574b9180a5 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -513,6 +513,7 @@ static void hdac_hda_codec_remove(struct snd_soc_component *component)
 	struct hdac_hda_priv *hda_pvt =
 		      snd_soc_component_get_drvdata(component);
 	struct hdac_device *hdev = &hda_pvt->codec.core;
+	struct hda_codec *codec = &hda_pvt->codec;
 	struct hdac_ext_link *hlink = NULL;
 
 	hlink = snd_hdac_ext_bus_get_link(hdev->bus, dev_name(&hdev->dev));
@@ -524,7 +525,10 @@ static void hdac_hda_codec_remove(struct snd_soc_component *component)
 	pm_runtime_disable(&hdev->dev);
 	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
 
-	snd_hdac_regmap_exit(hdev);
+	if (codec->patch_ops.free)
+		codec->patch_ops.free(codec);
+
+	snd_hda_codec_cleanup_for_unbind(codec);
 }
 
 static const struct snd_soc_dapm_route hdac_hda_dapm_routes[] = {
@@ -608,12 +612,10 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 
 static int hdac_hda_dev_remove(struct hdac_device *hdev)
 {
-	struct hdac_hda_priv *hda_pvt;
-
-	hda_pvt = dev_get_drvdata(&hdev->dev);
-	if (hda_pvt && hda_pvt->codec.registered)
-		cancel_delayed_work_sync(&hda_pvt->codec.jackpoll_work);
-
+	/*
+	 * Resources are freed in hdac_hda_codec_remove(). This
+	 * function is kept to keep hda_codec_driver_remove() happy.
+	 */
 	return 0;
 }
 
-- 
2.27.0

