Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C41CC3F68F
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 21:12:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2F7246C3
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 21:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Hc/5X6qq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wwYUKEwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2F7246C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF86C1672;
	Tue, 10 Dec 2019 22:11:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF86C1672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576012321;
	bh=q7bc7zKg4ewxmcsAabfP8VkHT08GfYfRsJMyokh/2WU=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hc/5X6qqKShpEniPiOrXMbOuL1R5gDo98ivOuDDWT0c52JWc/Gaa2qmKpgQom0AFN
	 R7pk0xBs7B3HWXYDSk51jEQnkZrmvNsvx9PqwS4v5m70rtxtDokG1Eau7kQllJAw5O
	 LJ9qA/tKaXfAZSwpTJzznHRr8k0ptG2j+E+zqapk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 83324F80248;
	Tue, 10 Dec 2019 22:10:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69F81F80254; Tue, 10 Dec 2019 22:10:34 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53E99F801D8
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 22:10:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53E99F801D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="wwYUKEwK"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DBFF02077B;
 Tue, 10 Dec 2019 21:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576012229;
 bh=cXHoFaCPOcdNxCGH5Nh0rBLLYZyaMEeDTY7yKhcYT/8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wwYUKEwKYIk8arMW1TyelSgMlRX8JeLwMhD6cUFnkNRb7w9Fpv6BVxhw5Xe47Bcnw
 amkAETaNDxE52qqDJ3tN66UNaXDjLA4VH0MjnL445ChlRBPzq9gbi77Hjr/QdnOHPa
 JwdimdJx9G2VQgbWHJcRPfyTnNaKWfM3fPBmxp6E=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Tue, 10 Dec 2019 16:04:44 -0500
Message-Id: <20191210210735.9077-140-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] [PATCH AUTOSEL 5.4 179/350] ALSA: hda/hdmi - implement
	mst_no_extra_pcms flag
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit 2a2edfbbfee47947dd05f5860c66c0e80ee5e09d ]

To support the DP-MST multiple streams via single connector feature,
the HDMI driver was extended with the concept of backup PCMs. See
commit 9152085defb6 ("ALSA: hda - add DP MST audio support").

This implementation works fine with snd_hda_intel.c as PCM topology
is fully managed within the single driver.

When the HDA codec driver is used from ASoC components, the concept
of backup PCMs no longer fits. For ASoC topologies, the physical
HDMI converters are presented as backend DAIs and these should match
with hardware capabilities. The ASoC topology may define arbitrary
PCMs (i.e. frontend DAIs) and have processing elements before eventual
routing to the HDMI BE DAIs. With backup PCMs, the link between
FE and BE DAIs would become dynamic and change when monitors are
(un)plugged. This would lead to modifying the topology every time
hotplug events happen, which is not currently possible in ASoC and
there does not seem to be any obvious benefits from this design.

To overcome above problems and enable the HDMI driver to be used
from ASoC, this patch adds a new mode (mst_no_extra_pcms flags) to
patch_hdmi.c. In this mode, the codec driver does not assume
the backup PCMs to be created.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191029134017.18901-2-kai.vehmanen@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/hda_codec.h  |  1 +
 sound/pci/hda/patch_hdmi.c | 19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index 9a0393cf024c2..ac18f428eda6c 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -254,6 +254,7 @@ struct hda_codec {
 	unsigned int force_pin_prefix:1; /* Add location prefix */
 	unsigned int link_down_at_suspend:1; /* link down at runtime suspend */
 	unsigned int relaxed_resume:1;	/* don't resume forcibly for jack */
+	unsigned int mst_no_extra_pcms:1; /* no backup PCMs for DP-MST */
 
 #ifdef CONFIG_PM
 	unsigned long power_on_acct;
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index d14f6684737d0..b8579cd218098 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2075,15 +2075,24 @@ static bool is_hdmi_pcm_attached(struct hdac_device *hdac, int pcm_idx)
 static int generic_hdmi_build_pcms(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec = codec->spec;
-	int idx;
+	int idx, pcm_num;
 
 	/*
 	 * for non-mst mode, pcm number is the same as before
-	 * for DP MST mode, pcm number is (nid number + dev_num - 1)
-	 *  dev_num is the device entry number in a pin
-	 *
+	 * for DP MST mode without extra PCM, pcm number is same
+	 * for DP MST mode with extra PCMs, pcm number is
+	 *  (nid number + dev_num - 1)
+	 * dev_num is the device entry number in a pin
 	 */
-	for (idx = 0; idx < spec->num_nids + spec->dev_num - 1; idx++) {
+
+	if (codec->mst_no_extra_pcms)
+		pcm_num = spec->num_nids;
+	else
+		pcm_num = spec->num_nids + spec->dev_num - 1;
+
+	codec_dbg(codec, "hdmi: pcm_num set to %d\n", pcm_num);
+
+	for (idx = 0; idx < pcm_num; idx++) {
 		struct hda_pcm *info;
 		struct hda_pcm_stream *pstr;
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
