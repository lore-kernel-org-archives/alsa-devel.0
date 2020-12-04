Return-Path: <SRS0=L/cl=FI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1666AC4361A
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Dec 2020 17:07:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8C222B3B
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Dec 2020 17:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8C222B3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 847001887;
	Fri,  4 Dec 2020 18:06:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 847001887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607101617;
	bh=QpTjPt2fqHd096p91E+f2VtY1y3v9XgoJgFE2/ht/g4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=I/njDZ/9q9qfNHpV7WQajiS9kBJqhkCn0nnWMgcjRKRDKh8BX7LswJ4GVZhrz7p/N
	 Zh76aY2q9HQhQc2mSetDqDzauM318RvyDUXFJwFcTOEJ4vSYWCIhVAZiq6wpfkLWyB
	 zSU0rllwMVHlQciLOh09LSmNgzICM3yFLeCJoZ4g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C1B6AF80273;
	Fri,  4 Dec 2020 18:06:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B51D6F80278; Fri,  4 Dec 2020 18:06:05 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88E5AF800E8
 for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2020 18:05:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 88E5AF800E8
IronPort-SDR: qR2AjZoZTujoEqW9woRXhIf3nEH6DyiY/Vj0+aXTqdhBHPxOSY04iDXvUJcaFMO1QNrkX2YlGO
 IFCXQaVKPJ9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="160462396"
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; d="scan'208";a="160462396"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2020 09:05:45 -0800
IronPort-SDR: mFw+Z2+5ItopNQbU2YP0gRxNfAIuTxl+ZJJhWy76dxzI1W1/USOC4t8UqCpLbaXtBddqyYADwv
 d6NgwUCEm6zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; d="scan'208";a="316179268"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga008.fm.intel.com with ESMTP; 04 Dec 2020 09:05:43 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH] ASoC: SOF: control: fix cppcheck warning in
 snd_sof_volume_info()
Date: Fri,  4 Dec 2020 19:03:13 +0200
Message-Id: <20201204170313.2704499-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: lgirdwood@gmail.com, daniel.baluta@nxp.com,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com
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

Fix cppcheck warning:

sound/soc/sof/control.c:117:82: style:inconclusive: Function
'snd_sof_volume_info' argument 2 names different: declaration
'ucontrol' definition 'uinfo'. [funcArgNamesDifferent]

Fixes: fca18e62984a ("ASoC: SOF: control: override volume info callback")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/sof-audio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index d00a918b6f39..dc930fc2f4b5 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -125,7 +125,7 @@ int snd_sof_volume_get(struct snd_kcontrol *kcontrol,
 int snd_sof_volume_put(struct snd_kcontrol *kcontrol,
 		       struct snd_ctl_elem_value *ucontrol);
 int snd_sof_volume_info(struct snd_kcontrol *kcontrol,
-			struct snd_ctl_elem_info *ucontrol);
+			struct snd_ctl_elem_info *uinfo);
 int snd_sof_switch_get(struct snd_kcontrol *kcontrol,
 		       struct snd_ctl_elem_value *ucontrol);
 int snd_sof_switch_put(struct snd_kcontrol *kcontrol,
-- 
2.28.0

