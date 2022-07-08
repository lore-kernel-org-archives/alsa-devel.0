Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0843CC43334
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jul 2022 20:07:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10D9682E;
	Fri,  8 Jul 2022 22:06:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10D9682E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657310828;
	bh=A3TwDo1AaYeN1ryje0/OiP89brBIAd85gVoZmFDGFNk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZfzVfowJrTA8pVvVyRcmCBizPlq+xaifPkosphUhVEL49IbJ8oebN55VFFDPbBIxz
	 GbZLNsqc4pW7QLf8/MAHxpRi9o2MjPAcYvw/aBH7NoLebCr65RenoYsSHrKq0hWpkm
	 VX51qcpJikTXI6HfAOZq5R2YXzDuJnpyESbEmZfs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1353F8053A;
	Fri,  8 Jul 2022 22:05:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9A0C6F80538; Fri,  8 Jul 2022 22:05:47 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3DE8F80166
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2022 22:05:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3DE8F80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="ZeGmcjEe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657310741; x=1688846741;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A3TwDo1AaYeN1ryje0/OiP89brBIAd85gVoZmFDGFNk=;
 b=ZeGmcjEeL2DnciWKXyaye7wR5JCwwKW4KBYDHjHDdoMD0AJ2l3vCmOgI
 sCtynMQg5FaQefNG6tHWK+r/phHPEsMRiOHL1kmel9j545BWn38Xm+1FK
 FfD1FflSbB9L3fucGSSZOgxaFdsGMRuJzJNf7p5Ml+leRe8w7OgY2d37K
 NyDF6t8BaalaKzMdmCykU2gJbwUQtM8xzAtwUw7zZtdDz9pFHHedv1GnH
 CzwfxYbVEUTrW3XAOqRzfeITcKVQ608WCKKZnsPkh7KpyT+QiLFfy1i+b
 KAqBIPIZqDtjdf4XiTE9L2Mp+L7PQKaY6ait3KHbZs3f2xeuizqE5RMtP A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="284378843"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; d="scan'208";a="284378843"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2022 13:05:32 -0700
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; d="scan'208";a="651691924"
Received: from gcisnero-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.87.49])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2022 13:05:31 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ASoC: SOF: ipc4-topology: check dai->private in ipc_free()
Date: Fri,  8 Jul 2022 15:05:15 -0500
Message-Id: <20220708200516.26853-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220708200516.26853-1-pierre-louis.bossart@linux.intel.com>
References: <20220708200516.26853-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Libin Yang <libin.yang@intel.com>, broonie@kernel.org,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

From: Libin Yang <libin.yang@intel.com>

Set the swidget->private or dai->private to NULL after kfree in the error
handling in ipc_setup(). The private needs to be set NULL because if
ipc_setup() returns error, ipc_free() will be called later. ipc_free()
will judge the private is NULL or not to do the clearing.

For dai widget, dai->private is allocated and set in dai widget
ipc_setup(). So we need to check dai->private is NULL or not
in the ipc_free().

Fixes: 2cabd02b6090 ("ASoC: SOF: ipc4-topology: Add support for parsing AIF_IN/AIF_OUT widgets")
Fixes: abfb536bd116 ("ASoC: SOF: ipc4-topology: Add support for parsing DAI_IN/DAI_OUT widgets")
Fixes: 4f838ab20812 ("ASoC: SOF: ipc4-topology: Add support for parsing and preparing pga widgets")
Fixes: 4d4ba014ac4b ("ASoC: SOF: ipc4-topology: Add support for parsing mixer widgets")
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Libin Yang <libin.yang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 34f805431f2e..2d157ea79db5 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -394,6 +394,7 @@ static int sof_ipc4_widget_setup_pcm(struct snd_sof_widget *swidget)
 	kfree(available_fmt->dma_buffer_size);
 free_copier:
 	kfree(ipc4_copier);
+	swidget->private = NULL;
 	return ret;
 }
 
@@ -541,6 +542,8 @@ static int sof_ipc4_widget_setup_comp_dai(struct snd_sof_widget *swidget)
 	kfree(available_fmt->dma_buffer_size);
 free_copier:
 	kfree(ipc4_copier);
+	dai->private = NULL;
+	dai->scomp = NULL;
 	return ret;
 }
 
@@ -553,6 +556,12 @@ static void sof_ipc4_widget_free_comp_dai(struct snd_sof_widget *swidget)
 	if (!dai)
 		return;
 
+	if (!dai->private) {
+		kfree(dai);
+		swidget->private = NULL;
+		return;
+	}
+
 	ipc4_copier = dai->private;
 	available_fmt = &ipc4_copier->available_fmt;
 
@@ -669,6 +678,7 @@ static int sof_ipc4_widget_setup_comp_pga(struct snd_sof_widget *swidget)
 	return 0;
 err:
 	kfree(gain);
+	swidget->private = NULL;
 	return ret;
 }
 
@@ -698,6 +708,7 @@ static int sof_ipc4_widget_setup_comp_mixer(struct snd_sof_widget *swidget)
 	return 0;
 err:
 	kfree(mixer);
+	swidget->private = NULL;
 	return ret;
 }
 
-- 
2.34.1

