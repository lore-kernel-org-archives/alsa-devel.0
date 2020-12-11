Return-Path: <SRS0=kZkJ=FP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB98C4167B
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 12:49:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74BCC23EF2
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 12:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BCC23EF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 128391746;
	Fri, 11 Dec 2020 13:48:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 128391746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607690972;
	bh=Z8FnnzK/sz/y+E1g0ZrYWqP7oRVj4oPWrkPok695s80=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=p6MdnGnB3sQ/iAnjTepeW5EpaNBw5jb1SkqT2mJ/6taYs9ItPqzHwc3o0yZUWX2t7
	 DLQVop6biSCLxMtbMua9yDtu/y1Xju7t4RCZjgU/IREStN7sliN+jYzgZ9gk/snYro
	 JomIh2QFRb8Dv2dpYOJrs9j7DmXBq3t8/diKdnEA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A07D2F801D8;
	Fri, 11 Dec 2020 13:48:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 863F9F8020D; Fri, 11 Dec 2020 13:48:39 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF1D3F8014E
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 13:48:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF1D3F8014E
IronPort-SDR: m6+pPOxAkp/B+iDVTyBHJEfsLnTqv6vcWgGz/IxGd/4Owq2hPtEyi/mtkQ4gTZx+4tzyAOhCMc
 EtQct7pvBVXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="238528537"
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; d="scan'208";a="238528537"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2020 04:48:28 -0800
IronPort-SDR: tJnt3+QXZCy8EEwXJ87999x5H07dP0gEk+bXuxc75tHlaN4Nuw2yqEcuV09mT/HpKFyqReCBfI
 QKaqjzMHVISA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; d="scan'208";a="322056078"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga008.fm.intel.com with ESMTP; 11 Dec 2020 04:48:26 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH] ALSA: hda/hdmi: always print pin NIDs as hexadecimal
Date: Fri, 11 Dec 2020 14:45:47 +0200
Message-Id: <20201211124547.3243871-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: kai.vehmanen@linux.intel.com
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

The debug prints from patch_hdmi.c are not aligned with HDA common code
in hda_codec.c nor with other HDA codec drivers.

To align with rest of the codebase, use hexadecimal formatting whenever
printing value of a HDA NID. Also refer to NIDs with capital letters in
traces as is done other modules. This presentation is also aligned with
the formatting used in HDA codec procfs entry.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 2ddc27db8c01..22f5a29d25f6 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -253,7 +253,7 @@ static int pin_id_to_pin_index(struct hda_codec *codec,
 			return pin_idx;
 	}
 
-	codec_warn(codec, "HDMI: pin nid %d not registered\n", pin_nid);
+	codec_warn(codec, "HDMI: pin NID 0x%x not registered\n", pin_nid);
 	return -EINVAL;
 }
 
@@ -313,7 +313,7 @@ static int cvt_nid_to_cvt_index(struct hda_codec *codec, hda_nid_t cvt_nid)
 		if (get_cvt(spec, cvt_idx)->cvt_nid == cvt_nid)
 			return cvt_idx;
 
-	codec_warn(codec, "HDMI: cvt nid %d not registered\n", cvt_nid);
+	codec_warn(codec, "HDMI: cvt NID 0x%x not registered\n", cvt_nid);
 	return -EINVAL;
 }
 
@@ -687,8 +687,7 @@ static void hdmi_pin_setup_infoframe(struct hda_codec *codec,
 		dp_ai->CC02_CT47	= active_channels - 1;
 		dp_ai->CA		= ca;
 	} else {
-		codec_dbg(codec, "HDMI: unknown connection type at pin %d\n",
-			    pin_nid);
+		codec_dbg(codec, "HDMI: unknown connection type at pin NID 0x%x\n", pin_nid);
 		return;
 	}
 
@@ -701,10 +700,8 @@ static void hdmi_pin_setup_infoframe(struct hda_codec *codec,
 	 */
 	if (!hdmi_infoframe_uptodate(codec, pin_nid, ai.bytes,
 					sizeof(ai))) {
-		codec_dbg(codec,
-			  "hdmi_pin_setup_infoframe: pin=%d channels=%d ca=0x%02x\n",
-			    pin_nid,
-			    active_channels, ca);
+		codec_dbg(codec, "%s: pin NID=0x%x channels=%d ca=0x%02x\n",
+			  __func__, pin_nid, active_channels, ca);
 		hdmi_stop_infoframe_trans(codec, pin_nid);
 		hdmi_fill_audio_infoframe(codec, pin_nid,
 					    ai.bytes, sizeof(ai));
@@ -796,7 +793,7 @@ static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res,
 	jack->jack_dirty = 1;
 
 	codec_dbg(codec,
-		"HDMI hot plug event: Codec=%d Pin=%d Device=%d Inactive=%d Presence_Detect=%d ELD_Valid=%d\n",
+		"HDMI hot plug event: Codec=%d NID=0x%x Device=%d Inactive=%d Presence_Detect=%d ELD_Valid=%d\n",
 		codec->addr, jack->nid, jack->dev_id, !!(res & AC_UNSOL_RES_IA),
 		!!(res & AC_UNSOL_RES_PD), !!(res & AC_UNSOL_RES_ELDV));
 
@@ -874,7 +871,7 @@ static void haswell_verify_D0(struct hda_codec *codec,
 		msleep(40);
 		pwr = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_POWER_STATE, 0);
 		pwr = (pwr & AC_PWRST_ACTUAL) >> AC_PWRST_ACTUAL_SHIFT;
-		codec_dbg(codec, "Haswell HDMI audio: Power for pin 0x%x is now D%d\n", nid, pwr);
+		codec_dbg(codec, "Haswell HDMI audio: Power for NID 0x%x is now D%d\n", nid, pwr);
 	}
 }
 
@@ -1121,8 +1118,8 @@ static void intel_not_share_assigned_cvt(struct hda_codec *codec,
 			per_cvt = get_cvt(spec, cvt_idx);
 			if (!per_cvt->assigned) {
 				codec_dbg(codec,
-					  "choose cvt %d for pin nid %d\n",
-					cvt_idx, nid);
+					  "choose cvt %d for pin NID 0x%x\n",
+					  cvt_idx, nid);
 				snd_hda_codec_write_cache(codec, nid, 0,
 					    AC_VERB_SET_CONNECT_SEL,
 					    cvt_idx);
@@ -1320,7 +1317,7 @@ static int hdmi_read_pin_conn(struct hda_codec *codec, int pin_idx)
 
 	if (!(get_wcaps(codec, pin_nid) & AC_WCAP_CONN_LIST)) {
 		codec_warn(codec,
-			   "HDMI: pin %d wcaps %#x does not support connection list\n",
+			   "HDMI: pin NID 0x%x wcaps %#x does not support connection list\n",
 			   pin_nid, get_wcaps(codec, pin_nid));
 		return -EINVAL;
 	}
@@ -1635,7 +1632,7 @@ static void hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 		eld->eld_valid = false;
 
 	codec_dbg(codec,
-		"HDMI status: Codec=%d Pin=%d Presence_Detect=%d ELD_Valid=%d\n",
+		"HDMI status: Codec=%d NID=0x%x Presence_Detect=%d ELD_Valid=%d\n",
 		codec->addr, pin_nid, eld->monitor_present, eld->eld_valid);
 
 	if (eld->eld_valid) {
@@ -2795,7 +2792,7 @@ static int intel_pin2port(void *audio_ptr, int pin_nid)
 			return i;
 	}
 
-	codec_info(codec, "Can't find the HDMI/DP port for pin %d\n", pin_nid);
+	codec_info(codec, "Can't find the HDMI/DP port for pin NID 0x%x\n", pin_nid);
 	return -1;
 }
 
-- 
2.29.2

