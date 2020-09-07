Return-Path: <SRS0=BS+q=CQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC53EC43461
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:38:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2C421927
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="K5rZHlPn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x53AamPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2C421927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B12DD1702;
	Mon,  7 Sep 2020 18:37:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B12DD1702
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599496720;
	bh=c9OGuA9iQBB1RfYnYn4jTEzeb8UzGNCSGSp+JSD1aWo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K5rZHlPnsPyHUA7IXqwg+mZEfOhPE5oSpuIT+kkXJA0Xf8GgP8DZBu+T1D8jjjbyt
	 iJU75W8mz2IcP/jfn+jC9UUyPeEtTZCZ/m3NuAGNvTy4RJjgVf+KNIXuFmfuxF5Dno
	 0ZXVeV1DouNE5MbVwOtvXtCJWRY8OI9l8FuevpVo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E8EA4F80305;
	Mon,  7 Sep 2020 18:34:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D19DF802FE; Mon,  7 Sep 2020 18:34:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BCFDEF802FE
 for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2020 18:34:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BCFDEF802FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="x53AamPt"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3FFB121D1A;
 Mon,  7 Sep 2020 16:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599496461;
 bh=c9OGuA9iQBB1RfYnYn4jTEzeb8UzGNCSGSp+JSD1aWo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=x53AamPtSZxEMitwJc9P81+tcb9hKZChKud67cO8ntf/PbVkcZTmCH1kGZVqDFim6
 6WZmpJyPo9N5Y80yKnsOu5P7FHD0G7vDLX01BAWdbycQUI423TI/rZP2hTDi4qSuXQ
 T36ZOaUXT7WbQgQVW/gFPM0/dzJ16fJzDDeUvPBs=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 40/43] ALSA: hda: fix a runtime pm issue in SOF
 when integrated GPU is disabled
Date: Mon,  7 Sep 2020 12:33:26 -0400
Message-Id: <20200907163329.1280888-40-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163329.1280888-1-sashal@kernel.org>
References: <20200907163329.1280888-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

From: Rander Wang <rander.wang@intel.com>

[ Upstream commit 13774d81f38538c5fa2924bdcdfa509155480fa6 ]

In snd_hdac_device_init pm_runtime_set_active is called to
increase child_count in parent device. But when it is failed
to build connection with GPU for one case that integrated
graphic gpu is disabled, snd_hdac_ext_bus_device_exit will be
invoked to clean up a HD-audio extended codec base device. At
this time the child_count of parent is not decreased, which
makes parent device can't get suspended.

This patch calls pm_runtime_set_suspended to decrease child_count
in parent device in snd_hdac_device_exit to match with
snd_hdac_device_init. pm_runtime_set_suspended can make sure that
it will not decrease child_count if the device is already suspended.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://lore.kernel.org/r/20200902154218.1440441-1-kai.vehmanen@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/hdac_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index c946fd8beebca..b84e12f4f8046 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -127,6 +127,8 @@ EXPORT_SYMBOL_GPL(snd_hdac_device_init);
 void snd_hdac_device_exit(struct hdac_device *codec)
 {
 	pm_runtime_put_noidle(&codec->dev);
+	/* keep balance of runtime PM child_count in parent device */
+	pm_runtime_set_suspended(&codec->dev);
 	snd_hdac_bus_remove_device(codec->bus, codec);
 	kfree(codec->vendor_name);
 	kfree(codec->chip_name);
-- 
2.25.1

