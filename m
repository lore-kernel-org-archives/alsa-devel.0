Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CB9C00144
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Aug 2022 17:02:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 834CC161F;
	Mon,  1 Aug 2022 19:01:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 834CC161F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1659373358;
	bh=55V1BvmMetu/7vDDZXOuK1uxhRk4c6TcJvPK9doQihI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T3Wi+aFZS3J3LXg4ZyBlgMEwoZuEijQ3ekBG+zsp97K/t/M6Wc4ASq0s1gwCYKncc
	 4C75VEnNbcaHNmu/TnFRRfTRF5+Ao6dmObaOvWYwgfsu6d1mAq3RNQvYe7QQOSMjvh
	 L/A/98WVV5Ce/odMc+27JbQX/1WZ86k41hGdoJiU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DD10F80548;
	Mon,  1 Aug 2022 19:01:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F2BFF80152; Mon,  1 Aug 2022 19:01:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36198F8013D
 for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2022 19:01:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36198F8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="gDKc14HS"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="81XI/GS4"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E5282067B;
 Mon,  1 Aug 2022 17:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1659373272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=536i7ilnn05TJs+Ne4ryRe3yjGFHU0oVRyL0R3gDG00=;
 b=gDKc14HSOU67YzHjOjFM5SVwEshLzhWK8iM/fUB2waUzv0WX+HR+ssfh4CEvdcp19aAnxZ
 CDloJicyGzebWoFP8Krqa9Pi551EKy+95AziSmFVoBLyH2yAMwcSI7WaqW4WMTSBexJCjz
 g6EY4PobktdmGj4HJ1f3YLOcN50ia2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1659373272;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=536i7ilnn05TJs+Ne4ryRe3yjGFHU0oVRyL0R3gDG00=;
 b=81XI/GS4HLuhdJf2Hqc/SIHeAUTf9Er6cWrLkn7ib0Ja0s1qf4G2SFQL7a1Hto3SpMdk30
 yma6MbC68IWNNFAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3F6B13AAE;
 Mon,  1 Aug 2022 17:01:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uHONMtcG6GKJHAAAMHmgww
 (envelope-from <tiwai@suse.de>); Mon, 01 Aug 2022 17:01:11 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/8] ASoC: Intel: sst: Replace sprintf() with sysfs_emit()
Date: Mon,  1 Aug 2022 19:01:03 +0200
Message-Id: <20220801170108.26340-4-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220801170108.26340-1-tiwai@suse.de>
References: <20220801170108.26340-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Lucas Tanure <tanureal@opensource.cirrus.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
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

For sysfs outputs, it's safer to use a new helper, sysfs_emit(),
instead of the raw sprintf() & co.  This patch replaces those usages
straightforwardly with a new helper, sysfs_emit().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/intel/atom/sst/sst.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index 160b50f479fb..a0d29510d2bc 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -242,11 +242,11 @@ static ssize_t firmware_version_show(struct device *dev,
 
 	if (ctx->fw_version.type == 0 && ctx->fw_version.major == 0 &&
 	    ctx->fw_version.minor == 0 && ctx->fw_version.build == 0)
-		return sprintf(buf, "FW not yet loaded\n");
+		return sysfs_emit(buf, "FW not yet loaded\n");
 	else
-		return sprintf(buf, "v%02x.%02x.%02x.%02x\n",
-			       ctx->fw_version.type, ctx->fw_version.major,
-			       ctx->fw_version.minor, ctx->fw_version.build);
+		return sysfs_emit(buf, "v%02x.%02x.%02x.%02x\n",
+				  ctx->fw_version.type, ctx->fw_version.major,
+				  ctx->fw_version.minor, ctx->fw_version.build);
 
 }
 
-- 
2.35.3

