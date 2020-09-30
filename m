Return-Path: <SRS0=iKRb=DH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D449BC4727C
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:27:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B9B620759
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MI3UvyjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9B620759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E1B21716;
	Wed, 30 Sep 2020 17:26:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E1B21716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601479634;
	bh=7rXaJlVwY5vJSmn4SfWcxfIw88e1CI6TqG11yynaAYs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MI3UvyjAn0eTl1U7o4VlyKeZGaJrcBSrGkqXdOJATa68V0ED10uI4JdgOm/fpplhK
	 o7DbbYK3NVSMsFwAeA1tVAl3AHAxMDJGZYXETYXaQP3Mqf10sPEH17L21TwrVN0u4S
	 AEE49MNsuhRkMZ4HuQuxwgubZ9AjBOken1N14/R4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DB33F800AB;
	Wed, 30 Sep 2020 17:24:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E81EBF802D2; Wed, 30 Sep 2020 17:24:48 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07585F801F9
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2020 17:24:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07585F801F9
IronPort-SDR: BbdEUyyyPf7GcumZ1xa3fsH/CPhEuPq/B3qY3hOZ+QBlYsetfK+K//pSR8vCSqgeoRIQ7OybIF
 l5QH1m93obIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="150130912"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="150130912"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 08:22:09 -0700
IronPort-SDR: WnAb0mYUrDuqhN/ZPWacfF4xfyZoHfP9zno6p9Vkw4HRc/rchvDQFiPsa/+3Z6JRuD6kbHjW1D
 PSRxkH497sPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="515114062"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga005.fm.intel.com with ESMTP; 30 Sep 2020 08:22:07 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 1/4] ASoC: SOF: control: remove const in sizeof()
Date: Wed, 30 Sep 2020 18:20:23 +0300
Message-Id: <20200930152026.3902186-2-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200930152026.3902186-1-kai.vehmanen@linux.intel.com>
References: <20200930152026.3902186-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
 daniel.baluta@nxp.com
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We should only use the type, the const attribute makes no sense in
sizeof().

Reported-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/control.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sof/control.c b/sound/soc/sof/control.c
index 0352d2b61358..056c86ad5a47 100644
--- a/sound/soc/sof/control.c
+++ b/sound/soc/sof/control.c
@@ -309,7 +309,7 @@ int snd_sof_bytes_ext_put(struct snd_kcontrol *kcontrol,
 	 * the length (as bytes) is needed to know the correct copy
 	 * length of data from tlvd->tlv.
 	 */
-	if (copy_from_user(&header, tlvd, sizeof(const struct snd_ctl_tlv)))
+	if (copy_from_user(&header, tlvd, sizeof(struct snd_ctl_tlv)))
 		return -EFAULT;
 
 	/* make sure TLV info is consistent */
@@ -351,7 +351,7 @@ int snd_sof_bytes_ext_put(struct snd_kcontrol *kcontrol,
 	}
 
 	/* be->max has been verified to be >= sizeof(struct sof_abi_hdr) */
-	if (cdata->data->size > be->max - sizeof(const struct sof_abi_hdr)) {
+	if (cdata->data->size > be->max - sizeof(struct sof_abi_hdr)) {
 		dev_err_ratelimited(scomp->dev, "error: Mismatch in ABI data size (truncated?).\n");
 		return -EINVAL;
 	}
@@ -405,15 +405,15 @@ int snd_sof_bytes_ext_volatile_get(struct snd_kcontrol *kcontrol, unsigned int _
 		goto out;
 
 	/* check data size doesn't exceed max coming from topology */
-	if (cdata->data->size > be->max - sizeof(const struct sof_abi_hdr)) {
+	if (cdata->data->size > be->max - sizeof(struct sof_abi_hdr)) {
 		dev_err_ratelimited(scomp->dev, "error: user data size %d exceeds max size %zu.\n",
 				    cdata->data->size,
-				    be->max - sizeof(const struct sof_abi_hdr));
+				    be->max - sizeof(struct sof_abi_hdr));
 		ret = -EINVAL;
 		goto out;
 	}
 
-	data_size = cdata->data->size + sizeof(const struct sof_abi_hdr);
+	data_size = cdata->data->size + sizeof(struct sof_abi_hdr);
 
 	/* make sure we don't exceed size provided by user space for data */
 	if (data_size > size) {
@@ -423,7 +423,7 @@ int snd_sof_bytes_ext_volatile_get(struct snd_kcontrol *kcontrol, unsigned int _
 
 	header.numid = scontrol->cmd;
 	header.length = data_size;
-	if (copy_to_user(tlvd, &header, sizeof(const struct snd_ctl_tlv))) {
+	if (copy_to_user(tlvd, &header, sizeof(struct snd_ctl_tlv))) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -466,14 +466,14 @@ int snd_sof_bytes_ext_get(struct snd_kcontrol *kcontrol,
 	cdata->data->abi = SOF_ABI_VERSION;
 
 	/* check data size doesn't exceed max coming from topology */
-	if (cdata->data->size > be->max - sizeof(const struct sof_abi_hdr)) {
+	if (cdata->data->size > be->max - sizeof(struct sof_abi_hdr)) {
 		dev_err_ratelimited(scomp->dev, "error: user data size %d exceeds max size %zu.\n",
 				    cdata->data->size,
-				    be->max - sizeof(const struct sof_abi_hdr));
+				    be->max - sizeof(struct sof_abi_hdr));
 		return -EINVAL;
 	}
 
-	data_size = cdata->data->size + sizeof(const struct sof_abi_hdr);
+	data_size = cdata->data->size + sizeof(struct sof_abi_hdr);
 
 	/* make sure we don't exceed size provided by user space for data */
 	if (data_size > size)
@@ -481,7 +481,7 @@ int snd_sof_bytes_ext_get(struct snd_kcontrol *kcontrol,
 
 	header.numid = scontrol->cmd;
 	header.length = data_size;
-	if (copy_to_user(tlvd, &header, sizeof(const struct snd_ctl_tlv)))
+	if (copy_to_user(tlvd, &header, sizeof(struct snd_ctl_tlv)))
 		return -EFAULT;
 
 	if (copy_to_user(tlvd->tlv, cdata->data, data_size))
-- 
2.27.0

