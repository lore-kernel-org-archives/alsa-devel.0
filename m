Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FA5C4332F
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Dec 2022 15:52:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A2B8B1936;
	Thu,  8 Dec 2022 16:51:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A2B8B1936
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670514739;
	bh=EkfbrReB2fmJCccRxQunThOCd7WU7+Pub5ERpxBeRIM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vRnClmCOfVIBJoxbKMvk6K+O+aIElLboXHL/AxttehvR9s2NpB6CVL19gnT7ixjAG
	 zNidyHNIeCouGQ37++ZSFZ/drb/jXcxI+tBs079BR+cXn5ULd4r/21kW5lh35nf0jW
	 7uk3pF/OLyQRCDb8Rn1YXf8zKDg2ku4kFtZHtywg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 41504F80121;
	Thu,  8 Dec 2022 16:51:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EB6FF800F8; Thu,  8 Dec 2022 16:51:20 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 240B7F800F8
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2022 16:51:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 240B7F800F8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="MAgv54Vz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670514675; x=1702050675;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EkfbrReB2fmJCccRxQunThOCd7WU7+Pub5ERpxBeRIM=;
 b=MAgv54VzVHHXwJJoHtBKTkRe4Z2uVjADF5Mb1Ftyxe0JdEdMJ8ajwi2M
 UmU67I6wqtBfm3kTWSMeiU50v1CkjA/XLlM7ScIbhQM0hGy/cslOp/VjQ
 8/r5jutwJS1yb+uVWoRdGbmbzYRGIvC4aD8NhsLmccEzEztcOTQXtgxSo
 sTAh+/wpL9u/ZTIUW8a8U2FJMHayB/F8HgTL/agSgf/AjC6hQS5TQhEv7
 9XBH6FFdYCAPqZXVIuF81WcVFF9vtkSJUTxbw1DE/RYKTZfP0Inh5P2wb
 xL2FPgQXgmp3ui8rLMTpcJIWGf4uiUvi6ac5ojBKk9r6iyCtlLVJUnNBD w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="304856934"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; d="scan'208";a="304856934"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2022 07:44:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="710514692"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; d="scan'208";a="710514692"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga008.fm.intel.com with ESMTP; 08 Dec 2022 07:44:24 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH 1/3] ALSA: hda/hdmi: fix i915 silent stream programming flow
Date: Thu,  8 Dec 2022 17:43:56 +0200
Message-Id: <20221208154358.3848764-2-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208154358.3848764-1-kai.vehmanen@linux.intel.com>
References: <20221208154358.3848764-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: intel-gfx@lists.freedesktop.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 kai.vehmanen@linux.intel.com, Rodrigo Vivi <rodrigo.vivi@intel.com>
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

The i915 display codec may not successfully transition to
normal audio streaming mode, if the stream id is programmed
while codec is actively transmitting data. This can happen
when silent stream is enabled in KAE mode.

Fix the issue by implementing a i915 specific programming
flow, where the silent streaming is temporarily stopped,
a small delay is applied to ensure display codec becomes
idle, and then proceed with reprogramming the stream ID.

Fixes: 15175a4f2bbb ("ALSA: hda/hdmi: add keep-alive support for ADL-P and DG2")
Link: https://gitlab.freedesktop.org/drm/intel/-/issues/7353
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Tested-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 sound/pci/hda/patch_hdmi.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 7a40ddfd695a..a0ba24165ae2 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2879,9 +2879,28 @@ static int i915_hsw_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 				 hda_nid_t pin_nid, int dev_id, u32 stream_tag,
 				 int format)
 {
+	struct hdmi_spec *spec = codec->spec;
+	int pin_idx = pin_id_to_pin_index(codec, pin_nid, dev_id);
+	struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
+	int res;
+
 	haswell_verify_D0(codec, cvt_nid, pin_nid);
-	return hdmi_setup_stream(codec, cvt_nid, pin_nid, dev_id,
-				 stream_tag, format);
+
+	if (spec->silent_stream_type == SILENT_STREAM_KAE && per_pin && per_pin->silent_stream) {
+		silent_stream_set_kae(codec, per_pin, false);
+		/* wait for pending transfers in codec to clear */
+		usleep_range(100, 200);
+	}
+
+	res = hdmi_setup_stream(codec, cvt_nid, pin_nid, dev_id,
+				stream_tag, format);
+
+	if (spec->silent_stream_type == SILENT_STREAM_KAE && per_pin && per_pin->silent_stream) {
+		usleep_range(100, 200);
+		silent_stream_set_kae(codec, per_pin, true);
+	}
+
+	return res;
 }
 
 /* pin_cvt_fixup ops override for HSW+ and VLV+ */
-- 
2.38.1

