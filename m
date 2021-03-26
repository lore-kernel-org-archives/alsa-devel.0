Return-Path: <SRS0=Z4e1=IY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10B9C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 22:05:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B16861953
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 22:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B16861953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFED5168F;
	Fri, 26 Mar 2021 23:04:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFED5168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616796339;
	bh=rC8yy1OycOYnLgPsPaYTUuQZu4KUwYzh4AOX2YF1LU0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A7kposRX/Ri3nMMtvl1HjLrypNGeAN1ydSKcDVEQdW54H+LcC3jjMR3hb2o90SsD4
	 sdmb3H7RUWMUSQJWXU+WGuvsPDwaMQU0hGVcGGdqSLaNUCwuaCoFnjbpY/XZ2LktTG
	 R24XxMDXW20IqgdadghPtTpYFkXT7Qo97nwNBB8Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8374DF804F3;
	Fri, 26 Mar 2021 23:00:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD23AF80156; Fri, 26 Mar 2021 23:00:20 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A179DF80156
 for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2021 23:00:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A179DF80156
IronPort-SDR: UXQBMB27qC+VQXxTCiM1Jk3FwlERPIegUTR2JkbX/aXsIWtovoPcL1LIvc8vxzmHuwawQFVEU7
 Q0dFouH2oeEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="211396753"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="211396753"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 15:00:16 -0700
IronPort-SDR: 15zBF2Zfwe4jsAAkx5TiwFWzQ65OMD/8NbSxh7zKIyLnQR5RUNkA3CZWPBgdgymVZC+MVu8ZfI
 xc3/H++oqpng==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="416706901"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.255.231.203])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 15:00:14 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 13/17] ASoC: tegra: tegra20_das: align function prototypes
Date: Fri, 26 Mar 2021 16:59:23 -0500
Message-Id: <20210326215927.936377-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>, tiwai@suse.de,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, broonie@kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>
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

cppcheck warnings:

sound/soc/tegra/tegra20_das.c:35:40: style:inconclusive: Function
'tegra20_das_connect_dap_to_dac' argument 1 names different:
declaration 'dap_id' definition 'dap'. [funcArgNamesDifferent]

int tegra20_das_connect_dap_to_dac(int dap, int dac)
                                       ^
sound/soc/tegra/tegra20_das.h:98:47: note: Function
'tegra20_das_connect_dap_to_dac' argument 1 names different:
declaration 'dap_id' definition 'dap'.
extern int tegra20_das_connect_dap_to_dac(int dap_id, int dac_sel);
                                              ^
sound/soc/tegra/tegra20_das.c:35:40: note: Function
'tegra20_das_connect_dap_to_dac' argument 1 names different:
declaration 'dap_id' definition 'dap'.
int tegra20_das_connect_dap_to_dac(int dap, int dac)
                                       ^
sound/soc/tegra/tegra20_das.c:35:49: style:inconclusive: Function
'tegra20_das_connect_dap_to_dac' argument 2 names different:
declaration 'dac_sel' definition 'dac'. [funcArgNamesDifferent]
int tegra20_das_connect_dap_to_dac(int dap, int dac)
                                                ^
sound/soc/tegra/tegra20_das.h:98:59: note: Function
'tegra20_das_connect_dap_to_dac' argument 2 names different:
declaration 'dac_sel' definition 'dac'.
extern int tegra20_das_connect_dap_to_dac(int dap_id, int dac_sel);
                                                          ^
sound/soc/tegra/tegra20_das.c:35:49: note: Function 'tegra20_das_connect_dap_to_dac' argument 2 names different: declaration 'dac_sel' definition 'dac'.
int tegra20_das_connect_dap_to_dac(int dap, int dac)
                                                ^
sound/soc/tegra/tegra20_das.c:53:40: style:inconclusive: Function
'tegra20_das_connect_dap_to_dap' argument 1 names different:
declaration 'dap_id' definition 'dap'. [funcArgNamesDifferent]
int tegra20_das_connect_dap_to_dap(int dap, int otherdap, int master,
                                       ^
sound/soc/tegra/tegra20_das.h:108:47: note: Function
'tegra20_das_connect_dap_to_dap' argument 1 names different:
declaration 'dap_id' definition 'dap'.
extern int tegra20_das_connect_dap_to_dap(int dap_id, int other_dap_sel,
                                              ^
sound/soc/tegra/tegra20_das.c:53:40: note: Function
'tegra20_das_connect_dap_to_dap' argument 1 names different:
declaration 'dap_id' definition 'dap'.
int tegra20_das_connect_dap_to_dap(int dap, int otherdap, int master,
                                       ^
sound/soc/tegra/tegra20_das.c:53:49: style:inconclusive: Function
'tegra20_das_connect_dap_to_dap' argument 2 names different:
declaration 'other_dap_sel' definition
'otherdap'. [funcArgNamesDifferent]
int tegra20_das_connect_dap_to_dap(int dap, int otherdap, int master,
                                                ^
sound/soc/tegra/tegra20_das.h:108:59: note: Function
'tegra20_das_connect_dap_to_dap' argument 2 names different:
declaration 'other_dap_sel' definition 'otherdap'.
extern int tegra20_das_connect_dap_to_dap(int dap_id, int other_dap_sel,
                                                          ^
sound/soc/tegra/tegra20_das.c:53:49: note: Function
'tegra20_das_connect_dap_to_dap' argument 2 names different:
declaration 'other_dap_sel' definition 'otherdap'.
int tegra20_das_connect_dap_to_dap(int dap, int otherdap, int master,
                                                ^
sound/soc/tegra/tegra20_das.c:75:40: style:inconclusive: Function
'tegra20_das_connect_dac_to_dap' argument 1 names different:
declaration 'dac_id' definition 'dac'. [funcArgNamesDifferent]
int tegra20_das_connect_dac_to_dap(int dac, int dap)
                                       ^
sound/soc/tegra/tegra20_das.h:118:47: note: Function
'tegra20_das_connect_dac_to_dap' argument 1 names different:
declaration 'dac_id' definition 'dac'.
extern int tegra20_das_connect_dac_to_dap(int dac_id, int dap_sel);
                                              ^
sound/soc/tegra/tegra20_das.c:75:40: note: Function
'tegra20_das_connect_dac_to_dap' argument 1 names different:
declaration 'dac_id' definition 'dac'.
int tegra20_das_connect_dac_to_dap(int dac, int dap)
                                       ^
sound/soc/tegra/tegra20_das.c:75:49: style:inconclusive: Function
'tegra20_das_connect_dac_to_dap' argument 2 names different:
declaration 'dap_sel' definition 'dap'. [funcArgNamesDifferent]
int tegra20_das_connect_dac_to_dap(int dac, int dap)
                                                ^
sound/soc/tegra/tegra20_das.h:118:59: note: Function
'tegra20_das_connect_dac_to_dap' argument 2 names different:
declaration 'dap_sel' definition 'dap'.
extern int tegra20_das_connect_dac_to_dap(int dac_id, int dap_sel);
                                                          ^
sound/soc/tegra/tegra20_das.c:75:49: note: Function
'tegra20_das_connect_dac_to_dap' argument 2 names different:
declaration 'dap_sel' definition 'dap'.
int tegra20_das_connect_dac_to_dap(int dac, int dap)
                                                ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/tegra/tegra20_das.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/tegra/tegra20_das.h b/sound/soc/tegra/tegra20_das.h
index d22abc4d08e6..18e832ded73a 100644
--- a/sound/soc/tegra/tegra20_das.h
+++ b/sound/soc/tegra/tegra20_das.h
@@ -95,7 +95,7 @@ struct tegra20_das {
  * dap_id: DAP to connect: TEGRA20_DAS_DAP_ID_*
  * dac_sel: DAC to connect to: TEGRA20_DAS_DAP_SEL_DAC*
  */
-extern int tegra20_das_connect_dap_to_dac(int dap_id, int dac_sel);
+extern int tegra20_das_connect_dap_to_dac(int dap, int dac);
 
 /*
  * Connect a DAP to another DAP
@@ -105,7 +105,7 @@ extern int tegra20_das_connect_dap_to_dac(int dap_id, int dac_sel);
  * sdata1rx: Is this DAP's SDATA1 pin RX (1) or TX (0)
  * sdata2rx: Is this DAP's SDATA2 pin RX (1) or TX (0)
  */
-extern int tegra20_das_connect_dap_to_dap(int dap_id, int other_dap_sel,
+extern int tegra20_das_connect_dap_to_dap(int dap, int otherdap,
 					  int master, int sdata1rx,
 					  int sdata2rx);
 
@@ -115,6 +115,6 @@ extern int tegra20_das_connect_dap_to_dap(int dap_id, int other_dap_sel,
  * dac_id: DAC ID to connect: TEGRA20_DAS_DAC_ID_*
  * dap_sel: DAP to receive input from: TEGRA20_DAS_DAC_SEL_DAP*
  */
-extern int tegra20_das_connect_dac_to_dap(int dac_id, int dap_sel);
+extern int tegra20_das_connect_dac_to_dap(int dac, int dap);
 
 #endif
-- 
2.25.1

