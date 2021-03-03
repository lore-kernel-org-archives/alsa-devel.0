Return-Path: <SRS0=LSvA=IB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D41EC433DB
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 01:26:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C940364FB4
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 01:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C940364FB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3CB7E1AC1;
	Wed,  3 Mar 2021 02:25:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3CB7E1AC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614734758;
	bh=Oa9pA09/NUikjCREU9Ngl5P2WjVM0vi3XZLwQ2gBuLI=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Q2O2mRO8uxUa/lZ9KWO+RQG7yxSOP+SYZ5O7b+5Xg4HPF8ymQm1PnDJBsDwzpy9JM
	 5MzmkR3nkzeHkpuw6I5XIeKPPg9iNlIuLDvZs5ipzPZBn/QlP+7krmQECOJECxBzGJ
	 6dz9p8PRefkf11wTStZozu8tw+17Dt3WlaGddW1w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BF56EF8025B;
	Wed,  3 Mar 2021 02:25:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0AD86F80269; Wed,  3 Mar 2021 02:25:07 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CE115F80088
 for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2021 02:24:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE115F80088
Received: from 61-220-137-34.hinet-ip.hinet.net ([61.220.137.34]
 helo=localhost.localdomain) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1lHGFu-0008KW-BF; Wed, 03 Mar 2021 01:24:51 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH] ALSA: hda - bind headset buttons to the headphone jack
Date: Wed,  3 Mar 2021 09:23:46 +0800
Message-Id: <20210303012346.3290-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

With the HDA driver, if the headset buttons are supported, an audio
Jack will be created for them. This audio Jack is a bit confusing to
users since it can't report headphone/mic insertion events but it
claims to support these events.

And in addition, the driver already builds a headphone Jack and a mic
Jack, and most of those buttons are used for headphone playback, so
do some change to bind those buttons to the headphone Jack. After this
change, the key events are generated from NID 0x55, and are reported
to the input layer via headphone jack (NID 0x21).

If there is no headphone Jack, then build an audio jack to support
those buttons same as previously.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/hda_jack.c      | 43 ++++++++++++++++++++++++++++++++++-
 sound/pci/hda/hda_jack.h      |  5 ++++
 sound/pci/hda/patch_realtek.c | 23 ++++++++++++++++---
 3 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index b8b568046592..640b72b598e8 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -388,6 +388,39 @@ int snd_hda_jack_set_gating_jack(struct hda_codec *codec, hda_nid_t gated_nid,
 }
 EXPORT_SYMBOL_GPL(snd_hda_jack_set_gating_jack);
 
+/**
+ * snd_hda_jack_bind_keymap - bind keys generated from one NID to another jack.
+ * @codec: the HDA codec
+ * @key_nid: key event is generated by this pin NID
+ * @keymap: map of key type and key code
+ * @jack_nid: key reports to the jack of this pin NID
+ *
+ * This function is used in the case of key is generated from one NID while is
+ * reported to the jack of another NID.
+ */
+int snd_hda_jack_bind_keymap(struct hda_codec *codec, hda_nid_t key_nid,
+			     const struct hda_jack_keymap *keymap,
+			     hda_nid_t jack_nid)
+{
+	const struct hda_jack_keymap *map;
+	struct hda_jack_tbl *key_gen = snd_hda_jack_tbl_get(codec, key_nid);
+	struct hda_jack_tbl *report_to = snd_hda_jack_tbl_get(codec, jack_nid);
+
+	WARN_ON(codec->dp_mst);
+
+	if (!key_gen || !report_to || !report_to->jack)
+		return -EINVAL;
+
+	key_gen->key_report_jack = jack_nid;
+
+	if (keymap)
+		for (map = keymap; map->type; map++)
+			snd_jack_set_key(report_to->jack, map->type, map->key);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hda_jack_bind_keymap);
+
 /**
  * snd_hda_jack_report_sync - sync the states of all jacks and report if changed
  * @codec: the HDA codec
@@ -651,7 +684,15 @@ void snd_hda_jack_unsol_event(struct hda_codec *codec, unsigned int res)
 	}
 	if (!event)
 		return;
-	event->jack_dirty = 1;
+
+	if (event->key_report_jack) {
+		struct hda_jack_tbl *report_to =
+			snd_hda_jack_tbl_get_mst(codec, event->key_report_jack,
+						 event->dev_id);
+		if (report_to)
+			report_to->jack_dirty = 1;
+	} else
+		event->jack_dirty = 1;
 
 	call_jack_callback(codec, res, event);
 	snd_hda_jack_report_sync(codec);
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index 8ceaf0ef5df1..339746dd9578 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -40,6 +40,7 @@ struct hda_jack_tbl {
 	unsigned int block_report:1;    /* in a transitional state - do not report to userspace */
 	hda_nid_t gating_jack;		/* valid when gating jack plugged */
 	hda_nid_t gated_jack;		/* gated is dependent on this jack */
+	hda_nid_t key_report_jack;	/* key reports to this jack */
 	int type;
 	int button_state;
 	struct snd_jack *jack;
@@ -99,6 +100,10 @@ snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
 int snd_hda_jack_set_gating_jack(struct hda_codec *codec, hda_nid_t gated_nid,
 				 hda_nid_t gating_nid);
 
+int snd_hda_jack_bind_keymap(struct hda_codec *codec, hda_nid_t key_nid,
+			     const struct hda_jack_keymap *keymap,
+			     hda_nid_t jack_nid);
+
 u32 snd_hda_jack_pin_sense(struct hda_codec *codec, hda_nid_t nid, int dev_id);
 
 /* the jack state returned from snd_hda_jack_detect_state() */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 52907506e16e..f381474f9403 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3102,6 +3102,16 @@ static void alc_headset_btn_callback(struct hda_codec *codec,
 	if (jack->unsol_res & (7 << 10))
 		report |= SND_JACK_BTN_3;
 
+	if (jack->jack->key_report_jack) {
+		struct hda_jack_tbl *report_to =
+			snd_hda_jack_tbl_get(codec, jack->jack->key_report_jack);
+
+		if (report_to) {
+			report_to->button_state = report;
+			return;
+		}
+	}
+
 	jack->jack->button_state = report;
 }
 
@@ -3163,16 +3173,23 @@ static void alc_fixup_headset_jack(struct hda_codec *codec,
 				    const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
+	hda_nid_t hp_pin;
 
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
 		spec->has_hs_key = 1;
 		snd_hda_jack_detect_enable_callback(codec, 0x55,
 						    alc_headset_btn_callback);
-		snd_hda_jack_add_kctl(codec, 0x55, "Headset Jack", false,
-				      SND_JACK_HEADSET, alc_headset_btn_keymap);
 		break;
-	case HDA_FIXUP_ACT_INIT:
+	case HDA_FIXUP_ACT_BUILD:
+		hp_pin = alc_get_hp_pin(spec);
+		if (!hp_pin || snd_hda_jack_bind_keymap(codec, 0x55,
+							alc_headset_btn_keymap,
+							hp_pin))
+			snd_hda_jack_add_kctl(codec, 0x55, "Headset Jack",
+					      false, SND_JACK_HEADSET,
+					      alc_headset_btn_keymap);
+
 		alc_enable_headset_jack_key(codec);
 		break;
 	}
-- 
2.25.1

