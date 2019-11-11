Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9F2C17445
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 19:10:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE87520659
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 19:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rjnXfpQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE87520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87B86820;
	Mon, 11 Nov 2019 20:09:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87B86820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573499436;
	bh=js5MJZF4Rj0n5uzc+uJKqxEgTvJYNE+OQe59izawePU=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rjnXfpQIlpGjL24UCnWc1UyXrYBVdgQPvl9Dic6EKb5P2vICttifptBUpn+g5hUsZ
	 zXOvdRSiFNr4/K5op0HqYjj+pI1GsPzhj8QRqpC2sZTofuHlFnMwmbpbPiXKl3sTje
	 +PAAvlcnpAcwZcK3wH5E9ykxS+aCY0ys+regv2AE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F17A1F8045D;
	Mon, 11 Nov 2019 20:09:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6DF78F804FF; Mon, 11 Nov 2019 20:09:43 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E32B4F8015C
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 20:09:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E32B4F8015C
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B84ACB22E;
 Mon, 11 Nov 2019 19:09:39 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon, 11 Nov 2019 20:09:37 +0100
Message-Id: <20191111190937.19186-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [alsa-devel] [PATCH] ALSA: hda/hdmi - Clean up Intel
	platform-specific fixup checks
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Introduce a new flag in hdmi_spec to indicate the Intel platform-
specific fixups so that we can get rid of the lengthy codec ID
checks.  The flag is set in intel_hsw_common_init() commonly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 78bd2e3722c7..d05529a429a5 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -37,25 +37,6 @@ static bool static_hdmi_pcm;
 module_param(static_hdmi_pcm, bool, 0644);
 MODULE_PARM_DESC(static_hdmi_pcm, "Don't restrict PCM parameters per ELD info");
 
-#define is_haswell(codec)  ((codec)->core.vendor_id == 0x80862807)
-#define is_broadwell(codec)    ((codec)->core.vendor_id == 0x80862808)
-#define is_skylake(codec) ((codec)->core.vendor_id == 0x80862809)
-#define is_broxton(codec) ((codec)->core.vendor_id == 0x8086280a)
-#define is_kabylake(codec) ((codec)->core.vendor_id == 0x8086280b)
-#define is_geminilake(codec) (((codec)->core.vendor_id == 0x8086280d) || \
-				((codec)->core.vendor_id == 0x80862800))
-#define is_cannonlake(codec) ((codec)->core.vendor_id == 0x8086280c)
-#define is_icelake(codec) ((codec)->core.vendor_id == 0x8086280f)
-#define is_tigerlake(codec) ((codec)->core.vendor_id == 0x80862812)
-#define is_haswell_plus(codec) (is_haswell(codec) || is_broadwell(codec) \
-				|| is_skylake(codec) || is_broxton(codec) \
-				|| is_kabylake(codec) || is_geminilake(codec) \
-				|| is_cannonlake(codec) || is_icelake(codec) \
-				|| is_tigerlake(codec))
-#define is_valleyview(codec) ((codec)->core.vendor_id == 0x80862882)
-#define is_cherryview(codec) ((codec)->core.vendor_id == 0x80862883)
-#define is_valleyview_plus(codec) (is_valleyview(codec) || is_cherryview(codec))
-
 struct hdmi_spec_per_cvt {
 	hda_nid_t cvt_nid;
 	int assigned;
@@ -162,6 +143,7 @@ struct hdmi_spec {
 
 	bool dyn_pin_out;
 	bool dyn_pcm_assign;
+	bool intel_hsw_fixup;	/* apply Intel platform-specific fixups */
 	/*
 	 * Non-generic VIA/NVIDIA specific
 	 */
@@ -925,7 +907,7 @@ static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 		return err;
 	}
 
-	if (is_haswell_plus(codec)) {
+	if (spec->intel_hsw_fixup) {
 
 		/*
 		 * on recent platforms IEC Coding Type is required for HBR
@@ -1709,7 +1691,7 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 	 * To simplify the implementation, malloc all
 	 * the virtual pins in the initialization statically
 	 */
-	if (is_haswell_plus(codec)) {
+	if (spec->intel_hsw_fixup) {
 		/*
 		 * On Intel platforms, device entries number is
 		 * changed dynamically. If there is a DP MST
@@ -1758,7 +1740,7 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 		per_pin->dev_id = i;
 		per_pin->non_pcm = false;
 		snd_hda_set_dev_select(codec, pin_nid, i);
-		if (is_haswell_plus(codec))
+		if (spec->intel_hsw_fixup)
 			intel_haswell_fixup_connect_list(codec, pin_nid);
 		err = hdmi_read_pin_conn(codec, pin_idx);
 		if (err < 0)
@@ -2816,6 +2798,7 @@ static int intel_hsw_common_init(struct hda_codec *codec, hda_nid_t vendor_nid,
 	spec->vendor_nid = vendor_nid;
 	spec->port_map = port_map;
 	spec->port_num = port_num;
+	spec->intel_hsw_fixup = true;
 
 	intel_haswell_enable_all_pins(codec, true);
 	intel_haswell_fixup_enable_dp12(codec);
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
