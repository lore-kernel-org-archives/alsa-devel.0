Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAC5E7D24B
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Sep 2023 08:09:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1954E84B;
	Tue, 26 Sep 2023 10:08:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1954E84B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695715775;
	bh=CulHCpIqq+8SqFZI6n0jd1wWfF3PVrQrXjcgxK1RioY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KtaUJMCAYKkyN5+IYXleVbNBOg+Z8+Zxg7UDz9QZT8VhNkY/VGi22MDuC7BbC+G0K
	 bCqQFI1hTzROHHURAU+Zuld3zIcX26iXm7rtq/abU7CCjJ4uC8TGRGoJ74O8yYbxHw
	 j7u6NlW9ftsPY1wKWZLc8P7Cr4QUidwCAQwVoIis=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 941ACF805B3; Tue, 26 Sep 2023 10:07:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 20F4FF805AE;
	Tue, 26 Sep 2023 10:07:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E924CF80568; Tue, 26 Sep 2023 10:07:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 685F6F8016A
	for <alsa-devel@alsa-project.org>; Tue, 26 Sep 2023 10:06:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 685F6F8016A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=a1R+/hVC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695715618; x=1727251618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CulHCpIqq+8SqFZI6n0jd1wWfF3PVrQrXjcgxK1RioY=;
  b=a1R+/hVCKuNeHJBunDGvAIviROiduVhFfPDL8qtiuJhVUPok39Jhkf/R
   GWL2YJfGJPUbmYKMRWFQa0+OLLTA4haIa23Ug1rGq0CjFADs3CLCKjLSI
   e2L39U9aIJidi64Nx0jpDKBdx6asaWuptcEJq6FdsK984NhbEBl7LRtsB
   lr/JeWwlC64meBFAgUwGHSXDuvCLzRGk6g3X2D1T8aHA9H0fYogH/yvIr
   VXVRu4kXgrWCPOQQtluiX39tRo0MdRFSqSGIsx/my1DFA1V/kD+j+CLlo
   ogfk68KvvA6xusZ+GiQPP+fLaEB+DYVCxtSLtnRSo4g7L+5apkxqNCl0l
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360891443"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200";
   d="scan'208";a="360891443"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 01:06:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="725358003"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200";
   d="scan'208";a="725358003"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by orsmga006.jf.intel.com with ESMTP; 26 Sep 2023 01:06:54 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: broonie@kernel.org,
	tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	perex@perex.cz,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	hdegoede@redhat.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v3 4/4] ASoC: Intel: Skylake: Use helper to setup HOST stream
Date: Tue, 26 Sep 2023 10:06:23 +0200
Message-Id: <20230926080623.43927-5-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926080623.43927-1-cezary.rojewski@intel.com>
References: <20230926080623.43927-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: V6VLGAHG4MU24YMRPE7YLSS77PG3G2OL
X-Message-ID-Hash: V6VLGAHG4MU24YMRPE7YLSS77PG3G2OL
X-MailFrom: cezary.rojewski@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V6VLGAHG4MU24YMRPE7YLSS77PG3G2OL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

snd_hdac_ext_host_stream_setup() abstracts the procedure details away.
Simplify the code by using it.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index ac3dc8c63c26..7502b2e70e46 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -124,7 +124,6 @@ static void skl_set_suspend_active(struct snd_pcm_substream *substream,
 int skl_pcm_host_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 {
 	struct hdac_bus *bus = dev_get_drvdata(dev);
-	struct skl_dev *skl = bus_to_skl(bus);
 	unsigned int format_val;
 	struct hdac_stream *hstream;
 	struct hdac_ext_stream *stream;
@@ -149,18 +148,7 @@ int skl_pcm_host_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 	if (err < 0)
 		return err;
 
-	/*
-	 * The recommended SDxFMT programming sequence for BXT
-	 * platforms is to couple the stream before writing the format
-	 */
-	if (HDA_CONTROLLER_IS_APL(skl->pci)) {
-		snd_hdac_ext_stream_decouple(bus, stream, false);
-		err = snd_hdac_stream_setup(hdac_stream(stream));
-		snd_hdac_ext_stream_decouple(bus, stream, true);
-	} else {
-		err = snd_hdac_stream_setup(hdac_stream(stream));
-	}
-
+	err = snd_hdac_ext_host_stream_setup(stream);
 	if (err < 0)
 		return err;
 
-- 
2.25.1

