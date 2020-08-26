Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B52C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:49:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B6F208E4
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cpEpmEvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B6F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE97017A1;
	Wed, 26 Aug 2020 20:48:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE97017A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598467755;
	bh=TPjiDn4i0mDOOnkJZST0V3v2MI3I2Qq0ydYRKg6ae60=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cpEpmEvmOPqHI+n0n/dcN95kAGld7ZUHczP18V0Q4l0MUfc2xkqKKD9sTiAOOj1qP
	 kM31qw52t0wqObgdXbKa31PJ7Iz1t8y71AOgCk6SIi7DYRKRpOETYSvI35qqYTDx5c
	 AcrFNGgZFLJnMkthX5Ze7H/iAE5xbgYH26r0Bd8o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C735F802DC;
	Wed, 26 Aug 2020 20:46:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0CF90F802D2; Wed, 26 Aug 2020 20:45:59 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6907FF80105
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 20:45:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6907FF80105
IronPort-SDR: V3ijsy07p1guvlabU47aNdpMY3wwX47n4lxI8we8UXo0VkXcOLGxyWSQnwTtD3YzXAJt933gJ0
 wlhduTv6n7rw==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="174418616"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; d="scan'208";a="174418616"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2020 11:45:45 -0700
IronPort-SDR: TxmSM1WAazPxnhhX9uXbe++7ddMN/xlibjeMiEkmrqNaLW4VEI8QvWyX7VYKREmviRPNN7cn+h
 lwoe2ZzMMXVw==
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; d="scan'208";a="500347334"
Received: from sghoshal-mobl.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.209.145.101])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2020 11:45:45 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/8] ASoC: SOF: Intel: hda: modify the signature of
 get_stream_with_tag()
Date: Wed, 26 Aug 2020 11:45:28 -0700
Message-Id: <20200826184532.1612070-5-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826184532.1612070-1-ranjani.sridharan@linux.intel.com>
References: <20200826184532.1612070-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 broonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
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

Modify the signature of get_stream_with_tag() to add the direction
as an argument to extend it for using with capture streams.

Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda-loader.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/intel/hda-loader.c b/sound/soc/sof/intel/hda-loader.c
index 914699f550b1..804f5f64aa33 100644
--- a/sound/soc/sof/intel/hda-loader.c
+++ b/sound/soc/sof/intel/hda-loader.c
@@ -205,18 +205,15 @@ static int cl_trigger(struct snd_sof_dev *sdev,
 }
 
 static struct hdac_ext_stream *get_stream_with_tag(struct snd_sof_dev *sdev,
-						   int tag)
+						   int tag, int direction)
 {
 	struct hdac_bus *bus = sof_to_bus(sdev);
 	struct hdac_stream *s;
 
 	/* get stream with tag */
-	list_for_each_entry(s, &bus->stream_list, list) {
-		if (s->direction == SNDRV_PCM_STREAM_PLAYBACK &&
-		    s->stream_tag == tag) {
+	list_for_each_entry(s, &bus->stream_list, list)
+		if (s->direction == direction && s->stream_tag == tag)
 			return stream_to_hdac_ext_stream(s);
-		}
-	}
 
 	return NULL;
 }
@@ -322,7 +319,7 @@ int hda_dsp_cl_boot_firmware(struct snd_sof_dev *sdev)
 	}
 
 	/* get stream with tag */
-	stream = get_stream_with_tag(sdev, tag);
+	stream = get_stream_with_tag(sdev, tag, SNDRV_PCM_STREAM_PLAYBACK);
 	if (!stream) {
 		dev_err(sdev->dev,
 			"error: could not get stream with stream tag %d\n",
-- 
2.25.1

