Return-Path: <SRS0=UTIM=IR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA0FC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 08:01:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC3964F6C
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 08:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC3964F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8E2E1696;
	Fri, 19 Mar 2021 09:00:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8E2E1696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616140869;
	bh=RDU6iZT4R+yUdiiznRUm9McVWYMmNorHrsHg6jroT3s=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RR6AnECsqI/uGHIYkExX4JOHPt+zBBWQFBu7a9QiNUkUXLYvQ8p/K2F1EICoNNKYQ
	 XrxJJaIw56AqYagHVgMquZ7yymA9X5e7e6BGuLrJfygua1Hcu/afsekXYKIHfS8z/q
	 hahVz0527xQVswwYKMVgtp5M5GAEMvE6qRisTrk0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D1AAF8023E;
	Fri, 19 Mar 2021 08:59:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D5F2F800BB; Fri, 19 Mar 2021 08:59:28 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2F8EF800BB
 for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2021 08:59:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2F8EF800BB
Received: from [103.229.218.199] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1lNA2I-0005XM-NP; Fri, 19 Mar 2021 07:59:11 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	kailang@realtek.com
Subject: [PATCH v2 2/2] ALSA: hda/realtek: call alc_update_headset_mode() in
 hp_automute_hook
Date: Fri, 19 Mar 2021 15:59:03 +0800
Message-Id: <20210319075903.6480-2-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210319075903.6480-1-hui.wang@canonical.com>
References: <20210319075903.6480-1-hui.wang@canonical.com>
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

We found the alc_update_headset_mode() is not called on some machines
when unplugging the headset, as a result, the mode of the
ALC_HEADSET_MODE_UNPLUGGED can't be set, then the current_headset_type
is not cleared, if users plug a differnt type of headset next time,
the determine_headset_type() will not be called and the audio jack is
set to the headset type of previous time.

On the Dell machines which connect the dmic to the PCH, if we open
the gnome-sound-setting and unplug the headset, this issue will
happen. Those machines disable the auto-mute by ucm and has no
internal mic in the input source, so the update_headset_mode() will
not be called by cap_sync_hook or automute_hook when unplugging, and
because the gnome-sound-setting is opened, the codec will not enter
the runtime_suspend state, so the update_headset_mode() will not be
called by alc_resume when unplugging. In this case the
hp_automute_hook is called when unplugging, so add
update_headset_mode() calling to this function.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 442e555de44c..c928704da20b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5447,6 +5447,7 @@ static void alc_update_headset_jack_cb(struct hda_codec *codec,
 				       struct hda_jack_callback *jack)
 {
 	snd_hda_gen_hp_automute(codec, jack);
+	alc_update_headset_mode(codec);
 }
 
 static void alc_probe_headset_mode(struct hda_codec *codec)
@@ -5559,7 +5560,7 @@ static void alc288_update_headset_jack_cb(struct hda_codec *codec,
 {
 	struct alc_spec *spec = codec->spec;
 
-	alc_update_headset_jack_cb(codec, jack);
+	snd_hda_gen_hp_automute(codec, jack);
 	/* Headset Mic enable or disable, only for Dell Dino */
 	alc_update_gpio_data(codec, 0x40, spec->gen.hp_jack_present);
 }
-- 
2.25.1

