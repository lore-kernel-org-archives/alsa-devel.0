Return-Path: <SRS0=04K1=DQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342CFC433E7
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:06:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7240C22267
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dJF2k+np"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7240C22267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5696B15E2;
	Fri,  9 Oct 2020 16:05:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5696B15E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602252373;
	bh=FXNDkgY8l5nm7SLb7+3rqRu7+5tSpGLon2iqgnN0FkQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dJF2k+np1dc8SlHsT7OG4ZYkRc6tETDD9HA5/WrhbSyBXnY2QAgpjYRrns85tSAjV
	 bYgajmXNF1YMlMC0Io0Kr1YTRdC4beHunPlbySJzp51HFBGmQ0htJkH86tC3E4qmfi
	 i8lR3F2eZiYNSrRJVrspdyfOdyyvJNNfVbB4dxiA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D572F80148;
	Fri,  9 Oct 2020 16:05:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87BEFF8016B; Fri,  9 Oct 2020 16:05:21 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0E25F80128
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2020 16:05:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0E25F80128
IronPort-SDR: lD4sc2lQftX9VvuvWPRMYDLqbH7lcjlyp99NelCpz/1TdWs1KRkd595KlCFDvfRQ0d1OTFUmxp
 37en3RLnRxcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="152406969"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; d="scan'208";a="152406969"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2020 07:04:13 -0700
IronPort-SDR: 7Al0+E/aw+7QVapNd/yvfh8+lS+sGMPfkLl9Tj6hJy4b3WT4ihKww67U/spiTUcFKXozxFvq3a
 RlUUqRdKFE/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; d="scan'208";a="528942245"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga005.jf.intel.com with ESMTP; 09 Oct 2020 07:04:12 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH 1/1] ALSA: hda: fix jack detection with Realtek codecs when in
 D3
Date: Fri,  9 Oct 2020 17:02:27 +0300
Message-Id: <20201009140227.691140-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Kailang Yang <kailang@realtek.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

In case HDA controller is active, but codec is runtime suspended, jack
detection is not successful and no interrupt is raised. This has been
observed with multiple Realtek codecs and HDA controllers from different
vendors. Bug does not occur if both codec and controller are active,
or both are in suspend. Bug can be easily hit on desktop systems with
no built-in speaker.

The problem can be fixed by powering up the codec once after every
controller runtime resume. Even if codec goes back to suspend, the jack
detection will now work. Add a flag to 'hda_codec' to describe codecs
that require this flow from the controller driver. Mark all Realtek
codecs with this flag.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=209379
Cc: Kailang Yang <kailang@realtek.com>
Co-developed-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 include/sound/hda_codec.h     | 1 +
 sound/pci/hda/hda_intel.c     | 8 ++++++--
 sound/pci/hda/patch_realtek.c | 6 ++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index 0fea49bfc5e8..73827b7d17e0 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -253,6 +253,7 @@ struct hda_codec {
 	unsigned int force_pin_prefix:1; /* Add location prefix */
 	unsigned int link_down_at_suspend:1; /* link down at runtime suspend */
 	unsigned int relaxed_resume:1;	/* don't resume forcibly for jack */
+	unsigned int forced_resume:1; /* forced resume for jack */
 	unsigned int mst_no_extra_pcms:1; /* no backup PCMs for DP-MST */
 
 #ifdef CONFIG_PM
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 61e495187b1a..cfc073c992e7 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1002,12 +1002,16 @@ static void __azx_runtime_resume(struct azx *chip, bool from_rt)
 	azx_init_pci(chip);
 	hda_intel_init_chip(chip, true);
 
-	if (status && from_rt) {
-		list_for_each_codec(codec, &chip->bus)
+	if (from_rt) {
+		list_for_each_codec(codec, &chip->bus) {
+			if (codec->forced_resume && pm_runtime_suspended(hda_codec_dev(codec)))
+				pm_request_resume(hda_codec_dev(codec));
+
 			if (!codec->relaxed_resume &&
 			    (status & (1 << codec->addr)))
 				schedule_delayed_work(&codec->jackpoll_work,
 						      codec->jackpoll_interval);
+		}
 	}
 
 	/* power down again for link-controlled chips */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f89506dffd5b..e4ab483db72f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -849,6 +849,12 @@ static int alc_build_controls(struct hda_codec *codec)
 static void alc_pre_init(struct hda_codec *codec)
 {
 	alc_fill_eapd_coef(codec);
+
+	/*
+	 * if controller is resumed from suspend, while codec remains in D3, codec
+	 * needs to be woken up once or otherwise jack detection does not work
+	 */
+	codec->forced_resume = 1;
 }
 
 #define is_s3_resume(codec) \
-- 
2.28.0

