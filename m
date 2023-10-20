Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70A4C001DF
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Oct 2023 13:13:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3DABF844;
	Fri, 20 Oct 2023 15:12:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3DABF844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697807606;
	bh=yQUsQHobLW1QvEOdwV5mD2y6Vcl/c87cay2o4rZ9rnc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=PX0NJnjYNIzfCw1tDj+hJ/nS5cUtjqBiv6IKVl2vzVQHmx19lJIRBjNi65cv3nI3P
	 g/ZfQ0zYKBKBVTYLZo+jJqdp533LNqMEbaV/DSuHgMOMOim+jOopsUdTF+5F+OCJdN
	 R1WTPHez79cxEJZERxKVD/SnQlTyBCF8M9Y4q+GI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 33088F80552; Fri, 20 Oct 2023 15:12:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7BCE4F800C9;
	Fri, 20 Oct 2023 15:12:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DCD70F8025F; Fri, 20 Oct 2023 11:26:44 +0200 (CEST)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by alsa1.perex.cz (Postfix) with SMTP id CF6EFF8019B
	for <alsa-devel@alsa-project.org>; Fri, 20 Oct 2023 11:26:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF6EFF8019B
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 4237E605164A0;
	Fri, 20 Oct 2023 17:26:29 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: cezary.rojewski@intel.com,
	pierre-louis.bossart@linux.intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: Su Hui <suhui@nfschina.com>,
	zhangyiqun@phytium.com.cn,
	amadeuszx.slawinski@linux.intel.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ASoC: Intel: Skylake: add an error code check in
 skl_pcm_trigger
Date: Fri, 20 Oct 2023 17:26:20 +0800
Message-Id: <20231020092619.210520-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: suhui@nfschina.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: SXIDCZCIYZ7IWMVUFVJYNWBSQXP3U7DA
X-Message-ID-Hash: SXIDCZCIYZ7IWMVUFVJYNWBSQXP3U7DA
X-Mailman-Approved-At: Fri, 20 Oct 2023 13:12:22 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SXIDCZCIYZ7IWMVUFVJYNWBSQXP3U7DA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

skl_decoupled_trigger() can return error code like -EPIPE if failed,
add check for this.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index ac3dc8c63c26..40308501f8bf 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -518,6 +518,9 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 			return ret;
 
 		ret = skl_decoupled_trigger(substream, cmd);
+		if (ret < 0)
+			return ret;
+
 		if ((cmd == SNDRV_PCM_TRIGGER_SUSPEND) && !w->ignore_suspend) {
 			/* save the dpib and lpib positions */
 			hstream->dpib = readl(bus->remap_addr +
-- 
2.30.2

