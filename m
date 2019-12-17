Return-Path: <SRS0=Cvq+=2H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1D4C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:04:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07CD22067C
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CwBcGFsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CD22067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F18911676;
	Tue, 17 Dec 2019 11:03:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F18911676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576577076;
	bh=LDXSHzbdkUNM1BhOf3Znweu8BaqCaBnrT/nNtqByuHQ=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CwBcGFsCpW+0ZNiVFpvXaICvUpBUHC+hIBYC2EP2Q8cENmB4nwrIOnizsPBikW8fM
	 3zqr2PZ+KJiJEHm7FWxK6d1k3s8AlvhaeRsvhVnrYb4MTb9Lr3DGeaSW6FEa4GCZSA
	 IioI5JOFsONaPbIcfrv4BdTyK3U/01JOf0EtiwvQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A148DF8029B;
	Tue, 17 Dec 2019 10:59:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0850BF80276; Tue, 17 Dec 2019 10:59:35 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DCC3AF80218
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2019 10:59:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DCC3AF80218
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2019 01:59:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; d="scan'208";a="221717024"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2019 01:59:26 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 17 Dec 2019 10:58:50 +0100
Message-Id: <20191217095851.19629-7-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217095851.19629-1-cezary.rojewski@intel.com>
References: <20191217095851.19629-1-cezary.rojewski@intel.com>
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>,
 broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
Subject: [alsa-devel] [PATCH 6/7] ASoC: compress: Add pm_runtime support
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

For some devices, components need to be powered-up before stream startup
sequence commences. Update soc_compr_open to provide such functionality.
Based on soc_pcm_open. Adjust soc_compr_free accordingly to power down
components once compress stream is closed.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/soc-compress.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 6615ef64c7f5..b2a5351b1a11 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -19,6 +19,7 @@
 #include <sound/soc.h>
 #include <sound/initval.h>
 #include <sound/soc-dpcm.h>
+#include <linux/pm_runtime.h>
 
 static int soc_compr_components_open(struct snd_compr_stream *cstream,
 				     struct snd_soc_component **last)
@@ -72,10 +73,20 @@ static int soc_compr_components_free(struct snd_compr_stream *cstream,
 static int soc_compr_open(struct snd_compr_stream *cstream)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
-	struct snd_soc_component *component;
+	struct snd_soc_component *component, *save = NULL;
+	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
+	for_each_rtd_components(rtd, rtdcom, component) {
+		ret = pm_runtime_get_sync(component->dev);
+		if (ret < 0 && ret != -EACCES) {
+			pm_runtime_put_noidle(component->dev);
+			save = component;
+			goto pm_err;
+		}
+	}
+
 	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
 
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->startup) {
@@ -115,6 +126,14 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 		cpu_dai->driver->cops->shutdown(cstream, cpu_dai);
 out:
 	mutex_unlock(&rtd->card->pcm_mutex);
+pm_err:
+	for_each_rtd_components(rtd, rtdcom, component) {
+		if (component == save)
+			break;
+		pm_runtime_mark_last_busy(component->dev);
+		pm_runtime_put_autosuspend(component->dev);
+	}
+
 	return ret;
 }
 
@@ -239,6 +258,8 @@ static void close_delayed_work(struct snd_soc_pcm_runtime *rtd)
 static int soc_compr_free(struct snd_compr_stream *cstream)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_component *component;
+	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int stream;
@@ -287,6 +308,12 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 	}
 
 	mutex_unlock(&rtd->card->pcm_mutex);
+
+	for_each_rtd_components(rtd, rtdcom, component) {
+		pm_runtime_mark_last_busy(component->dev);
+		pm_runtime_put_autosuspend(component->dev);
+	}
+
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
