Return-Path: <SRS0=8+EQ=IJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67965C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 00:47:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F65964FCA
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 00:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F65964FCA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB3AC1704;
	Thu, 11 Mar 2021 01:46:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB3AC1704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615423623;
	bh=nYYFRdIHuxuDZBF1koBOFdsCvQTOrlGfJt4bk8tyshg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SMVZe/V7qIdRZZKmBO1dx371UCyMKJvOyOxfvxzW0VKU4CialSfYK7lZlr6s1zYNw
	 oDi2E4MlMdxoBi3IkXf8AxKIptfakGfIT568TCRkS4bq1rcZJq9ulihSACqJRt9WSi
	 KXbsrcDiPdM1J6ro5CNmmSR8OQoYezvFPCEilNvw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E520DF8049C;
	Thu, 11 Mar 2021 01:44:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2911BF8042F; Thu, 11 Mar 2021 01:44:03 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10018F8020D
 for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2021 01:43:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10018F8020D
IronPort-SDR: xw72kbTDCr1rLsuYFr+I5yDjQUX2aK7uRq5FXbUyKWgBhCZQobtBGiJBQPC0VV3D1x5DRaL0+P
 PIlvusEIqYaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="176185742"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; d="scan'208";a="176185742"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 16:43:45 -0800
IronPort-SDR: aEXDNJkYzhFMyN+5p5gvqV28CggUGgnkgunf7M2hMO++gVbiojLJpT0ArmU8WKisnQBKOKGbpg
 zPQPR6c8Kupw==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; d="scan'208";a="370385621"
Received: from theer-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.212.101.109])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 16:43:44 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 05/10] ASoC: wm8958-dsp2: rename local 'control' arrays
Date: Wed, 10 Mar 2021 18:43:27 -0600
Message-Id: <20210311004332.120901-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311004332.120901-1-pierre-louis.bossart@linux.intel.com>
References: <20210311004332.120901-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, patches@opensource.cirrus.com, broonie@kernel.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
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

cppcheck complains about shadowed variables:

sound/soc/codecs/wm8958-dsp2.c:926:27: style: Local variable 'control'
shadows outer variable [shadowVariable]

  struct snd_kcontrol_new control[] = {
                          ^
sound/soc/codecs/wm8958-dsp2.c:900:17: note: Shadowed declaration
 struct wm8994 *control = wm8994->wm8994;
                ^
sound/soc/codecs/wm8958-dsp2.c:926:27: note: Shadow variable
  struct snd_kcontrol_new control[] = {
                          ^
sound/soc/codecs/wm8958-dsp2.c:952:27: style: Local variable 'control'
shadows outer variable [shadowVariable]
  struct snd_kcontrol_new control[] = {
                          ^
sound/soc/codecs/wm8958-dsp2.c:900:17: note: Shadowed declaration
 struct wm8994 *control = wm8994->wm8994;
                ^
sound/soc/codecs/wm8958-dsp2.c:952:27: note: Shadow variable
  struct snd_kcontrol_new control[] = {
                          ^
sound/soc/codecs/wm8958-dsp2.c:978:27: style: Local variable 'control'
shadows outer variable [shadowVariable]
  struct snd_kcontrol_new control[] = {
                          ^
sound/soc/codecs/wm8958-dsp2.c:900:17: note: Shadowed declaration
 struct wm8994 *control = wm8994->wm8994;
                ^
sound/soc/codecs/wm8958-dsp2.c:978:27: note: Shadow variable
  struct snd_kcontrol_new control[] = {
                          ^
sound/soc/codecs/wm8958-dsp2.c:1006:27: style: Local variable
'control' shadows outer variable [shadowVariable]
  struct snd_kcontrol_new control[] = {
                          ^
sound/soc/codecs/wm8958-dsp2.c:900:17: note: Shadowed declaration
 struct wm8994 *control = wm8994->wm8994;
                ^
sound/soc/codecs/wm8958-dsp2.c:1006:27: note: Shadow variable
  struct snd_kcontrol_new control[] = {
                          ^

fix by adding a prefix related to each control.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/wm8958-dsp2.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index 3bce9a14f0f3..536339e43dc7 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -923,7 +923,7 @@ void wm8958_dsp2_init(struct snd_soc_component *component)
 				component, wm8958_enh_eq_loaded);
 
 	if (pdata->num_mbc_cfgs) {
-		struct snd_kcontrol_new control[] = {
+		struct snd_kcontrol_new mbc_control[] = {
 			SOC_ENUM_EXT("MBC Mode", wm8994->mbc_enum,
 				     wm8958_get_mbc_enum, wm8958_put_mbc_enum),
 		};
@@ -942,14 +942,14 @@ void wm8958_dsp2_init(struct snd_soc_component *component)
 		wm8994->mbc_enum.texts = wm8994->mbc_texts;
 
 		ret = snd_soc_add_component_controls(wm8994->hubs.component,
-						 control, 1);
+						 mbc_control, 1);
 		if (ret != 0)
 			dev_err(wm8994->hubs.component->dev,
 				"Failed to add MBC mode controls: %d\n", ret);
 	}
 
 	if (pdata->num_vss_cfgs) {
-		struct snd_kcontrol_new control[] = {
+		struct snd_kcontrol_new vss_control[] = {
 			SOC_ENUM_EXT("VSS Mode", wm8994->vss_enum,
 				     wm8958_get_vss_enum, wm8958_put_vss_enum),
 		};
@@ -968,14 +968,14 @@ void wm8958_dsp2_init(struct snd_soc_component *component)
 		wm8994->vss_enum.texts = wm8994->vss_texts;
 
 		ret = snd_soc_add_component_controls(wm8994->hubs.component,
-						 control, 1);
+						 vss_control, 1);
 		if (ret != 0)
 			dev_err(wm8994->hubs.component->dev,
 				"Failed to add VSS mode controls: %d\n", ret);
 	}
 
 	if (pdata->num_vss_hpf_cfgs) {
-		struct snd_kcontrol_new control[] = {
+		struct snd_kcontrol_new hpf_control[] = {
 			SOC_ENUM_EXT("VSS HPF Mode", wm8994->vss_hpf_enum,
 				     wm8958_get_vss_hpf_enum,
 				     wm8958_put_vss_hpf_enum),
@@ -995,7 +995,7 @@ void wm8958_dsp2_init(struct snd_soc_component *component)
 		wm8994->vss_hpf_enum.texts = wm8994->vss_hpf_texts;
 
 		ret = snd_soc_add_component_controls(wm8994->hubs.component,
-						 control, 1);
+						 hpf_control, 1);
 		if (ret != 0)
 			dev_err(wm8994->hubs.component->dev,
 				"Failed to add VSS HPFmode controls: %d\n",
@@ -1003,7 +1003,7 @@ void wm8958_dsp2_init(struct snd_soc_component *component)
 	}
 
 	if (pdata->num_enh_eq_cfgs) {
-		struct snd_kcontrol_new control[] = {
+		struct snd_kcontrol_new eq_control[] = {
 			SOC_ENUM_EXT("Enhanced EQ Mode", wm8994->enh_eq_enum,
 				     wm8958_get_enh_eq_enum,
 				     wm8958_put_enh_eq_enum),
@@ -1023,7 +1023,7 @@ void wm8958_dsp2_init(struct snd_soc_component *component)
 		wm8994->enh_eq_enum.texts = wm8994->enh_eq_texts;
 
 		ret = snd_soc_add_component_controls(wm8994->hubs.component,
-						 control, 1);
+						 eq_control, 1);
 		if (ret != 0)
 			dev_err(wm8994->hubs.component->dev,
 				"Failed to add enhanced EQ controls: %d\n",
-- 
2.25.1

