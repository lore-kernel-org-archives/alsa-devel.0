Return-Path: <SRS0=Z19R=PP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B64EC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 02:19:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032D2610A5
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 02:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 032D2610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D73E16C1;
	Wed, 27 Oct 2021 04:18:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D73E16C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635301184;
	bh=/csl+dGX+BaU8goQFBljMLQTm8tdq91B4gdyIuAsGhE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eEedmNAhvVQJ0MblO+zRQn9t3PuBJMVr7ByEDY462q75EbVTFh/jhiRZRxNoKzfsg
	 FHrCDEiB+TKqKqKcmTxSirESLwuU0c2DlGFVWGmKPdn3F3V0WEtmvjGykaGsvyACvM
	 rbM46XVmayjTIr/9MnyWpD8f/TTnDuxIh+3veY3k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E19F1F8027B;
	Wed, 27 Oct 2021 04:18:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7D529F804D0; Wed, 27 Oct 2021 04:18:51 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4EE40F8025A
 for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2021 04:18:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4EE40F8025A
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="217229390"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; d="scan'208";a="217229390"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2021 19:18:41 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; d="scan'208";a="486446269"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2021 19:18:39 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Subject: [PATCH 02/10] ASoC: Intel: sof_sdw: fix jack detection on HP Spectre
 x360 convertible
Date: Wed, 27 Oct 2021 10:18:16 +0800
Message-Id: <20211027021824.24776-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211027021824.24776-1-yung-chuan.liao@linux.intel.com>
References: <20211027021824.24776-1-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 bard.liao@intel.com
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

Tests on device show the JD2 mode does not work at all, the 'Headphone
Jack' and 'Headset Mic Jack' are shown as 'on' always.

JD1 seems to be the better option, with at least a change between the
two cases.

Jack not plugged-in:
[root@fedora ~]# amixer -Dhw:0 cget numid=12
numid=12,iface=CARD,name='Headphone Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=off
[root@fedora ~]# amixer -Dhw:0 cget numid=13
numid=13,iface=CARD,name='Headset Mic Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=off

Jack plugged-in:
[root@fedora ~]# amixer -Dhw:0 cget numid=13
numid=13,iface=CARD,name='Headset Mic Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=on
[root@fedora ~]# amixer -Dhw:0 cget numid=13
numid=13,iface=CARD,name='Headset Mic Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=on

The 'Headset Mic Jack' is updated with a delay which seems normal with
additional calibration needed.

Fixes: d92e279dee56 ('ASoC: Intel: sof_sdw: add quirk for HP Spectre x360 convertible')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index a1fb41136cf0..523de5bfef60 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -188,7 +188,7 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
 					SOF_SDW_PCH_DMIC |
-					RT711_JD2),
+					RT711_JD1),
 	},
 	{
 		/* NUC15 'Bishop County' LAPBC510 and LAPBC710 skews */
-- 
2.17.1

