Return-Path: <SRS0=iTaG=EB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF96AC4363A
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:52:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4502224A
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="d8LAPSlc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2AdJ1WT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4502224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FEF816CD;
	Tue, 27 Oct 2020 00:51:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FEF816CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603756348;
	bh=9C528tZoQ9h5NstXknIAS/BD9iT7n94wKg9f1AkabPU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d8LAPSlc4f7+mv1a9xEokxFvLrq5PU3qlaCmG3JMumw/McRgN7poOKMO0erB8Evxk
	 PVhMmsSbZGgXQ8KBxjpgXdDIym/NW3sZSgnkuWdi2MPHsiHBhOF5PNiR0vLUN85DUU
	 LAgcvybUDsr0kdUW7cUbx+ALqsLAfLlMgpXLT6dM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B132F80276;
	Tue, 27 Oct 2020 00:50:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 256A5F80276; Tue, 27 Oct 2020 00:50:04 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22373F801D5;
 Tue, 27 Oct 2020 00:49:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22373F801D5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Y2AdJ1WT"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7F5AC20882;
 Mon, 26 Oct 2020 23:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603756195;
 bh=9C528tZoQ9h5NstXknIAS/BD9iT7n94wKg9f1AkabPU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y2AdJ1WTaaip6fR5ChBlE+H6jSCUy0L2SX00hAFxr079ipJ8MrnRDuaLpTyRjJzz3
 4KHikIW42xMXS+142YFm1nBribQwYeeV6CX+nCWkSVtM8h2y4QsI5lHh+L3VQEqxFg
 FMKWpWML4TcbNmxO9bzXoKMoKdES5J1PqRjI3m0A=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.9 039/147] ASoC: SOF: fix a runtime pm issue in SOF
 when HDMI codec doesn't work
Date: Mon, 26 Oct 2020 19:47:17 -0400
Message-Id: <20201026234905.1022767-39-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026234905.1022767-1-sashal@kernel.org>
References: <20201026234905.1022767-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Rander Wang <rander.wang@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 sound-open-firmware@alsa-project.org
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

[ Upstream commit 6c63c954e1c52f1262f986f36d95f557c6f8fa94 ]

When hda_codec_probe() doesn't initialize audio component, we disable
the codec and keep going. However,the resources are not released. The
child_count of SOF device is increased in snd_hdac_ext_bus_device_init
but is not decrease in error case, so SOF can't get suspended.

snd_hdac_ext_bus_device_exit will be invoked in HDA framework if it
gets a error. Now copy this behavior to release resources and decrease
SOF device child_count to release SOF device.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20200825235040.1586478-3-ranjani.sridharan@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 2c5c451fa19d7..c475955c6eeba 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -151,7 +151,7 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address,
 		if (!hdev->bus->audio_component) {
 			dev_dbg(sdev->dev,
 				"iDisp hw present but no driver\n");
-			return -ENOENT;
+			goto error;
 		}
 		hda_priv->need_display_power = true;
 	}
@@ -174,7 +174,7 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address,
 		 * other return codes without modification
 		 */
 		if (ret == 0)
-			ret = -ENOENT;
+			goto error;
 	}
 
 	return ret;
-- 
2.25.1

