Return-Path: <SRS0=qBPI=XB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706BDC43140
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:34:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBFD120693
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RaAN4ynr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFD120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0BC61166B;
	Fri,  6 Sep 2019 16:33:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0BC61166B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567780447;
	bh=mU0j01D5dmQrWDYq99FLn22fnZgEuznksY1GJwUDKVg=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RaAN4ynrMFbVmhUt5/O0/EDS8vaZnbHzbTuZzYMTJ37PqJsihJ4FDdG70G+DbXOy6
	 R3azsipyicKqf+nG+mxofofCo/wmtPXavqzVYeubCrEFOmrjwxLuLdzBhMF8xahUD+
	 X2PmMEIs6wC97IV4Eae/LiG652VnndCtdlimbf6s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC09CF80637;
	Fri,  6 Sep 2019 16:29:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8FE52F80633; Fri,  6 Sep 2019 16:29:44 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11566F805F6
 for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2019 16:29:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11566F805F6
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Sep 2019 07:29:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,473,1559545200"; d="scan'208";a="384228453"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by fmsmga006.fm.intel.com with ESMTP; 06 Sep 2019 07:29:38 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Date: Fri,  6 Sep 2019 17:29:08 +0300
Message-Id: <20190906142909.770-6-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190906142909.770-1-kai.vehmanen@linux.intel.com>
References: <20190906142909.770-1-kai.vehmanen@linux.intel.com>
Cc: libin.yang@intel.com, pierre-louis.bossart@linux.intel.com,
 kai.vehmanen@linux.intel.com
Subject: [alsa-devel] [RFC PATCH v2 5/6] ALSA: hda/hdmi - allow control
	creation without a linked pcm
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

Fix the logic in generic_hdmi_build_controls() to identify
unused hda_pcm entries by searching for SNDRV_PCM_INVALID_DEVICE.
This matches with logic in snd_hda_codec_build_pcms().

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 59aaee4a40fd..c52726e19f44 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2183,11 +2183,13 @@ static int generic_hdmi_build_jack(struct hda_codec *codec, int pcm_idx)
 static int generic_hdmi_build_controls(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec = codec->spec;
+	struct hda_pcm *hda_pcm;
 	int dev, err;
 	int pin_idx, pcm_idx;
 
 	for (pcm_idx = 0; pcm_idx < spec->pcm_used; pcm_idx++) {
-		if (!get_pcm_rec(spec, pcm_idx)->pcm) {
+		hda_pcm = get_pcm_rec(spec, pcm_idx);
+		if (hda_pcm->device == SNDRV_PCM_INVALID_DEVICE) {
 			/* no PCM: mark this for skipping permanently */
 			set_bit(pcm_idx, &spec->pcm_bitmap);
 			continue;
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
