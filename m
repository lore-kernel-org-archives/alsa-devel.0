Return-Path: <SRS0=Z4e1=IY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0899AC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 22:04:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1FF361953
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 22:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FF361953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C267168C;
	Fri, 26 Mar 2021 23:03:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C267168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616796279;
	bh=f9qmsNUc0jj83jPt03XRRrAKuS+hKxvppDPmVhyl8sM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bOx4D0xi8NOwrXEbIrgw4FPbGvdvFziLdKuDQ3mAKeFAXnG+Eg6kTFMcuKU7Yy32G
	 jLGL/wcsZ1G/o2irFH7SF2aW6LjZf7kF/wu22QM5Sv11VbH5OOesEEijeoYEcYWDbv
	 puW9KhZjAftNLUESo33m/fTHzn6zTB/GZUeW1N+0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9ED31F804E1;
	Fri, 26 Mar 2021 23:00:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50725F80156; Fri, 26 Mar 2021 23:00:15 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1364BF8032C
 for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2021 23:00:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1364BF8032C
IronPort-SDR: 4xL/P/XbPeYvUQLzLuSSHW4s0uQl0rXBrTMPakovk0kIUKq1RkekrQRgIoYN7PRYgLc1aDTw/a
 2sB+efStrVcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="211396722"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="211396722"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 15:00:07 -0700
IronPort-SDR: pN/1xZugGRK4FmXCaX5DbIjro6qYN2CO3AN2B868fvbV9d9cuop8ag3Jy2dcFwhpH6hDq9Qnzv
 Ftj5AihvMCDQ==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="416706816"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.255.231.203])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 15:00:06 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 09/17] ASoC: sti: uniperif: align function prototypes
Date: Fri, 26 Mar 2021 16:59:19 -0500
Message-Id: <20210326215927.936377-10-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 Takashi Iwai <tiwai@suse.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 broonie@kernel.org
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

cppcheck warning:

sound/soc/sti/uniperif_player.c:1049:24: style:inconclusive: Function
'uni_player_init' argument 2 names different: declaration 'uni_player'
definition 'player'. [funcArgNamesDifferent]
      struct uniperif *player)
                       ^
sound/soc/sti/uniperif.h:1375:24: note: Function 'uni_player_init'
argument 2 names different: declaration 'uni_player' definition
'player'.
      struct uniperif *uni_player);
                       ^
sound/soc/sti/uniperif_player.c:1049:24: note: Function
'uni_player_init' argument 2 names different: declaration 'uni_player'
definition 'player'.
      struct uniperif *player)
                       ^
sound/soc/sti/uniperif_reader.c:411:24: style:inconclusive: Function
'uni_reader_init' argument 2 names different: declaration 'uni_reader'
definition 'reader'. [funcArgNamesDifferent]
      struct uniperif *reader)
                       ^
sound/soc/sti/uniperif.h:1380:24: note: Function 'uni_reader_init'
argument 2 names different: declaration 'uni_reader' definition
'reader'.
      struct uniperif *uni_reader);
                       ^
sound/soc/sti/uniperif_reader.c:411:24: note: Function
'uni_reader_init' argument 2 names different: declaration 'uni_reader'
definition 'reader'.
      struct uniperif *reader)
                       ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sti/uniperif.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index a16adeb7c1e9..2a5de328501c 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1372,12 +1372,12 @@ static __maybe_unused const struct snd_pcm_hardware uni_tdm_hw = {
 
 /* uniperiph player*/
 int uni_player_init(struct platform_device *pdev,
-		    struct uniperif *uni_player);
+		    struct uniperif *player);
 int uni_player_resume(struct uniperif *player);
 
 /* uniperiph reader */
 int uni_reader_init(struct platform_device *pdev,
-		    struct uniperif *uni_reader);
+		    struct uniperif *reader);
 
 /* common */
 int sti_uniperiph_dai_set_fmt(struct snd_soc_dai *dai,
-- 
2.25.1

