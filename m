Return-Path: <SRS0=uPGH=3Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDFDC3524A
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Feb 2020 07:23:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C88A20730
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Feb 2020 07:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AvDTQEaL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iUoKeC72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C88A20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01C3016A1;
	Tue,  4 Feb 2020 08:22:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01C3016A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580801003;
	bh=HQKHiMZsxL5tRBeZ2ahbxeolqVNrjb9cMwt7GRMQ0lY=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AvDTQEaLZNeyR/WkADfbG9JouFysMxTTS5Hv/Q8LNbh81ePTxjo1bZs003dzlV//R
	 VnU9dlygPxPEf1zU28u6b4raiBSJ92afukwEhZKoBKzyLLwER/GG6SobiV3Yaepa2V
	 UfXiKDWakD1aVsblAw6gpkmsWAsOT/Liz0wTZwy0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BE257F8027B;
	Tue,  4 Feb 2020 08:20:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E83DDF8025A; Tue,  4 Feb 2020 08:20:52 +0100 (CET)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A420F80162
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2020 08:20:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A420F80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="iUoKeC72"
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e391b3d0000>; Mon, 03 Feb 2020 23:20:29 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 03 Feb 2020 23:20:44 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 03 Feb 2020 23:20:44 -0800
Received: from nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com (172.20.187.13)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Tue, 4 Feb 2020 07:20:41 +0000
From: Nikhil Mahale <nmahale@nvidia.com>
To: <tiwai@suse.com>, <kai.vehmanen@linux.intel.com>
Date: Tue, 4 Feb 2020 12:50:16 +0530
Message-ID: <20200204072017.9554-3-nmahale@nvidia.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204072017.9554-1-nmahale@nvidia.com>
References: <20200204072017.9554-1-nmahale@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1580800830; bh=PcvC1pN9+jSxqS3ZOq1pKrYISTG7O0QzDS/7ADpNxSY=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 X-Originating-IP:X-ClientProxiedBy:Content-Type;
 b=iUoKeC72t6AoUK88jUbwoYbZE+P5H3H0sk+chkz1fHC5bYVvxcSUwZcLEulYTNptW
 UEj6LQS7cT7OEKiLHJXOxwZC+IGP2GvlaKB5RbDdsEfdajvOEoSvLR644WS4X1Qn8H
 9i0SNTDgzqNZSlt0uQMWwyhWMEyP3HNSZ11MMYpMbXxXs1hoA9sgPFa+IXoCwkPbJ2
 r+w5ST8wUFKyZqbY6BKnFOzUdKJHsr9DQjWWCCfraqgXAfohmLP4lIhp4UNzuiTmG+
 l5bZHoT6HiXUwzkr8dbQDBsjkd0VdCEn5c+oWkyMqvjbCAAUlrs6BoAMqSjtBkZkLT
 PteDqQDpcDBYA==
Cc: alsa-devel@alsa-project.org, martin@larkos.de,
 Nikhil Mahale <nmahale@nvidia.com>, aplattner@nvidia.com
Subject: [alsa-devel] [PATCH v1 3/4] ALSA: hda - Change return type of
	update_eld() to void
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

snd_jack_report() does nothing is old and new status are same.

Signed-off-by: Nikhil Mahale <nmahale@nvidia.com>
---
 sound/pci/hda/patch_hdmi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index de45f5e5c724..1cf0604020bc 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1485,7 +1485,7 @@ static void hdmi_pcm_reset_pin(struct hdmi_spec *spec,
 /* update per_pin ELD from the given new ELD;
  * setup info frame and notification accordingly
  */
-static bool update_eld(struct hda_codec *codec,
+static void update_eld(struct hda_codec *codec,
 		       struct hdmi_spec_per_pin *per_pin,
 		       struct hdmi_eld *eld)
 {
@@ -1549,7 +1549,6 @@ static bool update_eld(struct hda_codec *codec,
 			       SNDRV_CTL_EVENT_MASK_VALUE |
 			       SNDRV_CTL_EVENT_MASK_INFO,
 			       &get_hdmi_pcm(spec, pcm_idx)->eld_ctl->id);
-	return eld_changed;
 }
 
 /* update ELD and jack state via HD-audio verbs */
@@ -1654,7 +1653,6 @@ static void sync_eld_via_acomp(struct hda_codec *codec,
 	struct hdmi_spec *spec = codec->spec;
 	struct hdmi_eld *eld = &spec->temp_eld;
 	struct snd_jack *jack = NULL;
-	bool changed;
 	int size;
 
 	mutex_lock(&per_pin->lock);
@@ -1681,10 +1679,10 @@ static void sync_eld_via_acomp(struct hda_codec *codec,
 	 * disconnected event. Jack must be fetched before update_eld()
 	 */
 	jack = pin_idx_to_jack(codec, per_pin);
-	changed = update_eld(codec, per_pin, eld);
+	update_eld(codec, per_pin, eld);
 	if (jack == NULL)
 		jack = pin_idx_to_jack(codec, per_pin);
-	if (changed && jack)
+	if (jack)
 		snd_jack_report(jack,
 				(eld->monitor_present && eld->eld_valid) ?
 				SND_JACK_AVOUT : 0);
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
