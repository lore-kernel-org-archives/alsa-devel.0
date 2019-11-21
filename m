Return-Path: <SRS0=ShlF=ZN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390B3C432C0
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:09:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B732F206CC
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Qshdg2B4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B732F206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D353E179F;
	Thu, 21 Nov 2019 20:08:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D353E179F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574363342;
	bh=+0eofhBU7D38poxvFurQDEieS/8kl4vRmAJDK/5meDU=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qshdg2B4B7GWM1wGDiYYDPIP5ANGNaMLRWpUUkuTZo7UEgEIk8AuTnKX0D7zbz1XD
	 uL/SK6Y3Oy0nH8P7KGXB+qxSYuLsdZdMwNNxhs/VAFV3e50aMPB4rutKfWwZ5DFljX
	 ZiKzZLPccwbOrCPEnPAK0a5qQqH04Wlub2D3Ucls=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 07746F8014E;
	Thu, 21 Nov 2019 20:07:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5333AF800C1; Thu, 21 Nov 2019 20:07:16 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7422F800F0
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2019 20:07:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7422F800F0
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 5850EB004;
 Thu, 21 Nov 2019 19:07:11 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Date: Thu, 21 Nov 2019 20:07:09 +0100
Message-Id: <20191121190709.29121-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191121190709.29121-1-tiwai@suse.de>
References: <20191121190709.29121-1-tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH 2/2] ASoC: component: Add sync_stop PCM ops
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

Add the support of the new PCM sync_stop ops in ASoC component.
It's optional and can be NULL unless you need the sync operation.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/soc-component.h |  3 +++
 sound/soc/soc-component.c     | 19 +++++++++++++++++++
 sound/soc/soc-pcm.c           |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 6aa3ecb7b6d3..d9dc8bcc96d0 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -88,6 +88,8 @@ struct snd_soc_component_driver {
 		       struct snd_pcm_substream *substream);
 	int (*trigger)(struct snd_soc_component *component,
 		       struct snd_pcm_substream *substream, int cmd);
+	int (*sync_stop)(struct snd_soc_component *component,
+			 struct snd_pcm_substream *substream);
 	snd_pcm_uframes_t (*pointer)(struct snd_soc_component *component,
 				     struct snd_pcm_substream *substream);
 	int (*get_time_info)(struct snd_soc_component *component,
@@ -405,6 +407,7 @@ int snd_soc_component_of_xlate_dai_name(struct snd_soc_component *component,
 int snd_soc_pcm_component_pointer(struct snd_pcm_substream *substream);
 int snd_soc_pcm_component_ioctl(struct snd_pcm_substream *substream,
 				unsigned int cmd, void *arg);
+int snd_soc_pcm_component_sync_stop(struct snd_pcm_substream *substream);
 int snd_soc_pcm_component_copy_user(struct snd_pcm_substream *substream,
 				    int channel, unsigned long pos,
 				    void __user *buf, unsigned long bytes);
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index 98ef0666add2..58c1320a3521 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -444,6 +444,25 @@ int snd_soc_pcm_component_ioctl(struct snd_pcm_substream *substream,
 	return snd_pcm_lib_ioctl(substream, cmd, arg);
 }
 
+int snd_soc_pcm_component_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component;
+	struct snd_soc_rtdcom_list *rtdcom;
+	int ret;
+
+	for_each_rtd_components(rtd, rtdcom, component) {
+		if (component->driver->ioctl) {
+			ret = component->driver->sync_stop(component,
+							   substream);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 int snd_soc_pcm_component_copy_user(struct snd_pcm_substream *substream,
 				    int channel, unsigned long pos,
 				    void __user *buf, unsigned long bytes)
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 4dd13c9249ab..4457ac374a0e 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -3020,6 +3020,8 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 
 		if (drv->ioctl)
 			rtd->ops.ioctl		= snd_soc_pcm_component_ioctl;
+		if (drv->sync_stop)
+			rtd->ops.sync_stop	= snd_soc_pcm_component_sync_stop;
 		if (drv->copy_user)
 			rtd->ops.copy_user	= snd_soc_pcm_component_copy_user;
 		if (drv->page)
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
