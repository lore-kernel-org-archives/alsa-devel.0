Return-Path: <SRS0=KIty=DT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3A5C43467
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:30:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9AA420790
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WmghcD0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9AA420790
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A2191681;
	Mon, 12 Oct 2020 12:29:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A2191681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602498601;
	bh=5WsrG3gRLC3p8hcwHPp6eeQUsdbg8dno1MjdP7SFvBM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WmghcD0cSuzxApncSqtu+WSIx/arYWMcJcHZR7RaE4UXFJ1uRT9OyTWNiY2/JmYGp
	 PVNWWj8lskCniw+7Yv14B5rFPqtW1VN3nJVpxAxWwQix+VQp3uKvQTtEbljKXVzdJY
	 IFhf6Fpar1If+fVIj/nTSMhN8yUzigagDnSml6fw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A7E5F800D8;
	Mon, 12 Oct 2020 12:29:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A85F9F80217; Mon, 12 Oct 2020 12:29:07 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C33DAF800D8
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2020 12:28:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C33DAF800D8
IronPort-SDR: NeEvra7aUHKjRdQmXFxjH9a7cnJHKGr083NKbsTeKwUkgTNpAaeZMAU8PCyUUrHj6L0Ef6m0MJ
 1rXFkJEuRxtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="162252591"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; d="scan'208";a="162252591"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 03:28:53 -0700
IronPort-SDR: sR/5XCE3qPQq/4BSHJS8xECzj+ZIsqzdLaHRSAHXpcEEWFOGO42khWsDUqeF8zUvEa46518Ujj
 WW+1ggH3p+Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; d="scan'208";a="317878245"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga006.jf.intel.com with ESMTP; 12 Oct 2020 03:28:51 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org, tiwai@suse.de,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH v2] ALSA: hda: fix jack detection with Realtek codecs when in
 D3
Date: Mon, 12 Oct 2020 13:27:04 +0300
Message-Id: <20201012102704.794423-1-kai.vehmanen@linux.intel.com>
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

In case HDA controller becomes active, but codec is runtime suspended,
jack detection is not successful and no interrupt is raised. This has
been observed with multiple Realtek codecs and HDA controllers from
different vendors. Bug does not occur if both codec and controller are
active, or both are in suspend. Bug can be easily hit on desktop systems
with no built-in speaker.

The problem can be fixed by powering up the codec once after every
controller runtime resume. Even if codec goes back to suspend later, the
jack detection will continue to work. Add a flag to 'hda_codec' to
describe codecs that require this flow from the controller driver.
Modify __azx_runtime_resume() to use pm_request_resume() to make the
intent clearer.

Mark all Realtek codecs with the new forced_resume flag.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=209379
Cc: Kailang Yang <kailang@realtek.com>
Co-developed-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 include/sound/hda_codec.h     |  1 +
 sound/pci/hda/hda_intel.c     | 14 ++++++++------
 sound/pci/hda/patch_realtek.c |  1 +
 3 files changed, 10 insertions(+), 6 deletions(-)

v1->v2:
- simplified the for_each_codec block as per feedback from Takashi
- clarified commit message that bug occurs when controller
  is resumed (feedback from Pierre)
- moved forced_resume setting from alc_pre_init to 
  alc_alloc_spec which seems more appropriate and removed 
  the inline comments as those seem out-of-place in patch_realtek (other
  drivers may use the flag as well)

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
index 61e495187b1a..749b88090970 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1002,12 +1002,14 @@ static void __azx_runtime_resume(struct azx *chip, bool from_rt)
 	azx_init_pci(chip);
 	hda_intel_init_chip(chip, true);
 
-	if (status && from_rt) {
-		list_for_each_codec(codec, &chip->bus)
-			if (!codec->relaxed_resume &&
-			    (status & (1 << codec->addr)))
-				schedule_delayed_work(&codec->jackpoll_work,
-						      codec->jackpoll_interval);
+	if (from_rt) {
+		list_for_each_codec(codec, &chip->bus) {
+			if (codec->relaxed_resume)
+				continue;
+
+			if (codec->forced_resume || (status & (1 << codec->addr)))
+				pm_request_resume(hda_codec_dev(codec));
+		}
 	}
 
 	/* power down again for link-controlled chips */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f89506dffd5b..f2398721ac1e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1150,6 +1150,7 @@ static int alc_alloc_spec(struct hda_codec *codec, hda_nid_t mixer_nid)
 	codec->single_adc_amp = 1;
 	/* FIXME: do we need this for all Realtek codec models? */
 	codec->spdif_status_reset = 1;
+	codec->forced_resume = 1;
 	codec->patch_ops = alc_patch_ops;
 
 	err = alc_codec_rename_from_preset(codec);
-- 
2.28.0

