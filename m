Return-Path: <SRS0=Df35=DS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD27C433DF
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Oct 2020 10:07:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2E42083B
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Oct 2020 10:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rpgEuwDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2E42083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1241C1685;
	Sun, 11 Oct 2020 12:06:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1241C1685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602410820;
	bh=HTYSNC1WdGGEeamz/tH+Z/fDVuGzxwe7uPMltgNMnp0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rpgEuwDhF8xqMSWX3i+kHGp0fcICGXr8YGqfi19edkSqNohOUyNPAtHeioDtEa8a/
	 shNVYft5SytZxfo500GKX6KqhefgW0NKqf+8XZGSOBIszveFQU26+yW7XeNDwuqOE3
	 LHQ+YUeFGWgaES3Drh/J8zXsutgBEIMi5lK3d2RM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53E47F80247;
	Sun, 11 Oct 2020 12:03:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A6E4EF80268; Sun, 11 Oct 2020 12:02:59 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04438F80228;
 Sun, 11 Oct 2020 12:02:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04438F80228
X-IronPort-AV: E=Sophos;i="5.77,362,1596492000"; d="scan'208";a="471981622"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256;
 11 Oct 2020 12:02:41 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 5/8] ASoC: SOF: Intel: hda: use semicolons rather than commas
 to separate statements
Date: Sun, 11 Oct 2020 11:19:36 +0200
Message-Id: <1602407979-29038-6-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1602407979-29038-1-git-send-email-Julia.Lawall@inria.fr>
References: <1602407979-29038-1-git-send-email-Julia.Lawall@inria.fr>
Cc: alsa-devel@alsa-project.org,
 =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Joe Perches <joe@perches.com>,
 Thomas Gleixner <tglx@linutronix.de>, Daniel Baluta <daniel.baluta@nxp.com>,
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

Replace commas with semicolons.  What is done is essentially described by
the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):

// <smpl>
@@ expression e1,e2; @@
e1
-,
+;
e2
... when any
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/soc/sof/intel/hda-dsp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 18ff1c2f5376..2b001151fe37 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -44,7 +44,7 @@ int hda_dsp_core_reset_enter(struct snd_sof_dev *sdev, unsigned int core_mask)
 	reset = HDA_DSP_ADSPCS_CRST_MASK(core_mask);
 	snd_sof_dsp_update_bits_unlocked(sdev, HDA_DSP_BAR,
 					 HDA_DSP_REG_ADSPCS,
-					 reset, reset),
+					 reset, reset);
 
 	/* poll with timeout to check if operation successful */
 	ret = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR,

