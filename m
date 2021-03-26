Return-Path: <SRS0=Z4e1=IY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF146C433C1
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 22:02:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD6E61A38
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 22:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD6E61A38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 173B4168E;
	Fri, 26 Mar 2021 23:01:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 173B4168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616796147;
	bh=O9oqgqlwb0i/FBI2TwMHdIfgHUwFWIST8NoQZshjG2s=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gGBHEVEH2YKHbFhv7/mw5K9NCOdwZpH5nLYKvWjX43kgCepj2Aqg4Wei2NWDDRYzR
	 3yFTCzjciJkB8PAcv9RjdMiEPuXc2ARHZ3UbEgHZJYZ/NF2XDsthJzxZ3jkElAGDt7
	 gAFfovXP9gXxOewrAjaw/dUjFAZtGrVcx8CRMiA0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 228F1F80475;
	Fri, 26 Mar 2021 23:00:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C2E7CF80425; Fri, 26 Mar 2021 23:00:10 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65433F801D5
 for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2021 23:00:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65433F801D5
IronPort-SDR: 9by4PUFhrPloP5GfEHVs7I1uVUPyYtLI6BJCChhIewRC3S7lPisyHJj5d80kzGcbyr03e0NG9s
 c6bzX/SoF5dQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="211396704"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="211396704"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 15:00:01 -0700
IronPort-SDR: dJ+318LZoLkx+tEgRq6r4XoeOcWNyo7aGBSaCulwoJHxbRfbxYzt2w+vpi/aQPWgdOt6t2L2Mb
 85pAMZ15mLOw==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="416706701"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.255.231.203])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 15:00:00 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 05/17] ASoC: meson: axg-tdmin: remove useless assignment
Date: Fri, 26 Mar 2021 16:59:15 -0500
Message-Id: <20210326215927.936377-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Neil Armstrong <narmstrong@baylibre.com>, tiwai@suse.de,
 Kevin Hilman <khilman@baylibre.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, broonie@kernel.org,
 "open list:ARM/Amlogic Meson SoC support" <linux-amlogic@lists.infradead.org>,
 "moderated list:ARM/Amlogic Meson SoC support"
 <linux-arm-kernel@lists.infradead.org>, Jerome Brunet <jbrunet@baylibre.com>
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

cppcheck complains about potential null pointer dereference but it's
rather an unnecessary assignment to NULL before walking through a
list.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/meson/axg-tdmin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/axg-tdmin.c b/sound/soc/meson/axg-tdmin.c
index b4faf9d5c1aa..49b613a1faf2 100644
--- a/sound/soc/meson/axg-tdmin.c
+++ b/sound/soc/meson/axg-tdmin.c
@@ -57,7 +57,7 @@ static const struct snd_kcontrol_new axg_tdmin_in_mux =
 static struct snd_soc_dai *
 axg_tdmin_get_be(struct snd_soc_dapm_widget *w)
 {
-	struct snd_soc_dapm_path *p = NULL;
+	struct snd_soc_dapm_path *p;
 	struct snd_soc_dai *be;
 
 	snd_soc_dapm_widget_for_each_source_path(w, p) {
-- 
2.25.1

