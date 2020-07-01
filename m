Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3DAC433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 05:23:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0228A2073E
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 05:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PPunBb/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0228A2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 643441670;
	Wed,  1 Jul 2020 07:22:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 643441670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593581005;
	bh=wMErSbnRpPq91v5Bz7dDCvRdt5lpVBEav6NqCopw1TA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PPunBb/POFWGoglTAxiBIzPDNSSpTQFOIkrRhCR2cr3CR4sac/GsbTRKHzi1Etqd8
	 ks862sr3yZhdenHHxkl3m3VczT75Th2ZEjoM7LJM8wPOJdHjYJqytZ/SFdfg+s3b7X
	 BtrlxpFt3o0K28Ps3YxEiTBTtU67i/7p8Mtiqc7g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BAED0F8020C;
	Wed,  1 Jul 2020 07:22:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 334A8F800EA; Wed,  1 Jul 2020 07:22:33 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63EE1F800EA
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 07:22:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63EE1F800EA
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1jqVBw-0001yp-1w; Wed, 01 Jul 2020 05:21:52 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tiwai@suse.com
Subject: [PATCH] ALSA: hda/realtek: Serialize setting GPIO LED
Date: Wed,  1 Jul 2020 13:21:35 +0800
Message-Id: <20200701052138.6378-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Cc: Libin Yang <libin.yang@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Kailang Yang <kailang@realtek.com>, Tomas Espeleta <tomas.espeleta@gmail.com>,
 Thomas Hebb <tommyhebb@gmail.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 open list <linux-kernel@vger.kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 anthony.won@canonical.com, Hui Wang <hui.wang@canonical.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Jian-Hong Pan <jian-hong@endlessm.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
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

If a system has two GPIO controlled LED, one for mute and another one
for micmute, and both of them are on before system suspend, sometimes
one of them won't be turned off by system suspend.

The codec doesn't seem to be able to control multiple GPIO LEDs at the
same time, so introduce a new mutex to serialize setting the LED, to
prevent the issue from happening.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 include/sound/hda_codec.h     | 1 +
 sound/pci/hda/hda_codec.c     | 1 +
 sound/pci/hda/patch_realtek.c | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index d16a4229209b..3a1792bbb7ac 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -206,6 +206,7 @@ struct hda_codec {
 
 	struct mutex spdif_mutex;
 	struct mutex control_mutex;
+	struct mutex led_mutex;
 	struct snd_array spdif_out;
 	unsigned int spdif_in_enable;	/* SPDIF input enable? */
 	const hda_nid_t *slave_dig_outs; /* optional digital out slave widgets */
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 7e3ae4534df9..ec477cd8afed 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -946,6 +946,7 @@ int snd_hda_codec_device_new(struct hda_bus *bus, struct snd_card *card,
 	codec->addr = codec_addr;
 	mutex_init(&codec->spdif_mutex);
 	mutex_init(&codec->control_mutex);
+	mutex_init(&codec->led_mutex);
 	snd_array_init(&codec->mixers, sizeof(struct hda_nid_item), 32);
 	snd_array_init(&codec->nids, sizeof(struct hda_nid_item), 32);
 	snd_array_init(&codec->init_pins, sizeof(struct hda_pincfg), 16);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 53e0eef8b042..96dac365fbb8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4101,7 +4101,10 @@ static void alc_update_gpio_led(struct hda_codec *codec, unsigned int mask,
 {
 	if (polarity)
 		enabled = !enabled;
+
+	mutex_lock(&codec->led_mutex);
 	alc_update_gpio_data(codec, mask, !enabled); /* muted -> LED on */
+	mutex_unlock(&codec->led_mutex);
 }
 
 /* turn on/off mute LED via GPIO per vmaster hook */
-- 
2.17.1

