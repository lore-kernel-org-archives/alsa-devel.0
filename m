Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F34C43463
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:11:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC44720874
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LzhzKGmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC44720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA48116A9;
	Mon, 21 Sep 2020 13:10:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA48116A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600686662;
	bh=yj2te0E3a5OPVVRrcSyjSFgQxEJItGgK5m27TnMFvsM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LzhzKGmo12V3mA6oRU0qAFLeqUvMybu8khwNWsJvSos1nCj2ndMY6FFXHeJAsMByN
	 WNKUsCbzA5G9SEaJNNgyIJX8DCBUuAZfm71czDJQ2ZVMmbT0h9OOVCv7qWW5isQgsm
	 n1exWf+xEJl6GeUB6xfNBW+INZw3Nac3/enM5HWk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57B6FF8021C;
	Mon, 21 Sep 2020 13:10:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08005F8028D; Mon, 21 Sep 2020 13:10:10 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE024F8015F
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 13:10:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE024F8015F
IronPort-SDR: 7BSJkGzFMBALyyVv10MvBOsAwOXN5nOkHAD60zGR0fpdFsHzVlq4Cm3MvX7P+YfpAS8YzS3PtG
 7g0inN5DCb5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="148011228"
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="148011228"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 04:09:58 -0700
IronPort-SDR: sZb3YD/SU92iLH9J5oPbRE4F6JwW6ZAusxo1F+BaBsze0SwZvPoIyFJ0xhbdmTAQEagFtKUsfb
 gkItN/GN9GRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="321730224"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga002.jf.intel.com with ESMTP; 21 Sep 2020 04:09:57 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 2/5] ASoC: SOF: control: fix size checks for volatile
 ext_bytes control .get()
Date: Mon, 21 Sep 2020 14:08:11 +0300
Message-Id: <20200921110814.2910477-3-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200921110814.2910477-1-kai.vehmanen@linux.intel.com>
References: <20200921110814.2910477-1-kai.vehmanen@linux.intel.com>
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

Mirror addition of checks for regular ext_bytes controls.

Fixes: 783560d02dd61 ('ASoC: SOF: Implement snd_sof_bytes_ext_volatile_get kcontrol IO')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/control.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/sof/control.c b/sound/soc/sof/control.c
index 8d499d0e331d..9465611156d5 100644
--- a/sound/soc/sof/control.c
+++ b/sound/soc/sof/control.c
@@ -369,6 +369,14 @@ int snd_sof_bytes_ext_volatile_get(struct snd_kcontrol *kcontrol, unsigned int _
 	int ret;
 	int err;
 
+	/*
+	 * Decrement the limit by ext bytes header size to
+	 * ensure the user space buffer is not exceeded.
+	 */
+	if (size < sizeof(struct snd_ctl_tlv))
+		return -ENOSPC;
+	size -= sizeof(struct snd_ctl_tlv);
+
 	ret = pm_runtime_get_sync(scomp->dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err_ratelimited(scomp->dev, "error: bytes_ext get failed to resume %d\n", ret);
@@ -396,6 +404,12 @@ int snd_sof_bytes_ext_volatile_get(struct snd_kcontrol *kcontrol, unsigned int _
 
 	data_size = cdata->data->size + sizeof(const struct sof_abi_hdr);
 
+	/* make sure we don't exceed size provided by user space for data */
+	if (data_size > size) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
 	header.numid = scontrol->cmd;
 	header.length = data_size;
 	if (copy_to_user(tlvd, &header, sizeof(const struct snd_ctl_tlv))) {
-- 
2.27.0

