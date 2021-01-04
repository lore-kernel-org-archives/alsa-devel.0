Return-Path: <SRS0=I7Cd=GH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA64C4332B
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Jan 2021 14:10:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A74820770
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Jan 2021 14:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A74820770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7090F166D;
	Mon,  4 Jan 2021 15:09:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7090F166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609769419;
	bh=b5EKFhpDVr2mrxl/wh/3v3YHOQ4NpSIms2jcPfA9bfI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZiOftnxSPHrx9pCsHj4PLc+13oL3GMlNHExB0OpdW8eVg88/1CqrnNRqal0FixFsR
	 Ca5afPDQm5/nkoCVAGwKxHKps5fgHdSkE/N07joB3bdphrB/Xdc9d+FyjyQ1dRBlYv
	 JhznTOeNivvBrENsDTn+TBBCNZM4UF98l3HZmup4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED6B1F80167;
	Mon,  4 Jan 2021 15:09:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21E84F80167; Mon,  4 Jan 2021 15:09:25 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7676CF8012C;
 Mon,  4 Jan 2021 15:09:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7676CF8012C
Received: from 36-229-96-78.dynamic-ip.hinet.net ([36.229.96.78]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1kwQXd-0006oi-46; Mon, 04 Jan 2021 14:09:02 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 daniel.baluta@nxp.com
Subject: [PATCH v2 1/3] ASoC: SOF: Intel: hda: Resume codec to do jack
 detection
Date: Mon,  4 Jan 2021 22:08:50 +0800
Message-Id: <20210104140853.228448-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Rander Wang <rander.wang@intel.com>,
 Mark Brown <broonie@kernel.org>,
 Payal Kshirsagar <payalskshirsagar1234@gmail.com>,
 "moderated list:SOUND - SOUND OPEN FIRMWARE SOF DRIVERS"
 <sound-open-firmware@alsa-project.org>
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

Instead of queueing jackpoll_work, runtime resume the codec to let it
use different jack detection methods based on jackpoll_interval.

This matches SOF driver's behavior with commit a6e7d0a4bdb0 ("ALSA: hda:
fix jack detection with Realtek codecs when in D3"). Since SOF only uses
Realtek codec, we don't need any additional check for the resume.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 No change.

 sound/soc/sof/intel/hda-codec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 6875fa570c2c..df59c79cfdfc 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -93,8 +93,7 @@ void hda_codec_jack_check(struct snd_sof_dev *sdev)
 		 * has been recorded in STATESTS
 		 */
 		if (codec->jacktbl.used)
-			schedule_delayed_work(&codec->jackpoll_work,
-					      codec->jackpoll_interval);
+			pm_request_resume(&codec->core.dev);
 }
 #else
 void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev) {}
-- 
2.29.2

