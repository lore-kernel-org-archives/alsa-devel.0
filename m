Return-Path: <SRS0=eswj=3E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D00C33CB1
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jan 2020 10:01:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9617222C3
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jan 2020 10:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="su9Fww8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9617222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB3C617A6;
	Wed, 15 Jan 2020 11:00:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB3C617A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579082494;
	bh=CCYco8ocLnpOSI2oA3JgAsh+po0H3bxsZAmxTozitbI=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=su9Fww8UDReo/CKpbtaTbLer/dZI53yt3m7d3ZScmBf7ybUJ7g/DfPC17oXYDP5Oz
	 ECI9xvPAhBmrPUXeM7qvbJlVPFW8EO+hhZ45pgC5ltU6nmzsEomZUJO1tleeG9sU9o
	 W+GzufbKveWeywu+t0xEpOVlNNbgIbvfeWa85utk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70F4CF800B9;
	Wed, 15 Jan 2020 11:00:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6E152F801EB; Wed, 15 Jan 2020 11:00:41 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59E7BF800E9
 for <alsa-devel@alsa-project.org>; Wed, 15 Jan 2020 11:00:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59E7BF800E9
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C0FBDACCA;
 Wed, 15 Jan 2020 10:00:36 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Wed, 15 Jan 2020 11:00:35 +0100
Message-Id: <20200115100035.22511-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Colin Ian King <colin.king@canonical.com>
Subject: [alsa-devel] [PATCH] ALSA: hda/analog - Minor optimization for
	SPDIF mux connections
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

AD HD-audio codec driver has a few code lines invoking
snd_get_num_conns() and using its return value as the array index
without checking.  This is basically safe in all those places; at the
second and later calls snd_get_num_conns() returns the value cached
from the first invocation, hence the value is always consistent.

However, it looks a bit confusing as if a lack of the proper check.
This patch introduces a new field num_smux_conns in ad198x_spec for
simplifying the code.  Now we store and refer to the value more
locally without invoking the extra function at each time.

Reported-by: Colin King <colin.king@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 88c46b051d14..2132b2acec4d 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -28,6 +28,7 @@ struct ad198x_spec {
 	hda_nid_t eapd_nid;
 
 	unsigned int beep_amp;	/* beep amp value, set via set_beep_amp() */
+	int num_smux_conns;
 };
 
 
@@ -453,8 +454,7 @@ static int ad1983_auto_smux_enum_info(struct snd_kcontrol *kcontrol,
 	struct ad198x_spec *spec = codec->spec;
 	static const char * const texts2[] = { "PCM", "ADC" };
 	static const char * const texts3[] = { "PCM", "ADC1", "ADC2" };
-	hda_nid_t dig_out = spec->gen.multiout.dig_out_nid;
-	int num_conns = snd_hda_get_num_conns(codec, dig_out);
+	int num_conns = spec->num_smux_conns;
 
 	if (num_conns == 2)
 		return snd_hda_enum_helper_info(kcontrol, uinfo, 2, texts2);
@@ -481,7 +481,7 @@ static int ad1983_auto_smux_enum_put(struct snd_kcontrol *kcontrol,
 	struct ad198x_spec *spec = codec->spec;
 	unsigned int val = ucontrol->value.enumerated.item[0];
 	hda_nid_t dig_out = spec->gen.multiout.dig_out_nid;
-	int num_conns = snd_hda_get_num_conns(codec, dig_out);
+	int num_conns = spec->num_smux_conns;
 
 	if (val >= num_conns)
 		return -EINVAL;
@@ -512,6 +512,7 @@ static int ad1983_add_spdif_mux_ctl(struct hda_codec *codec)
 	num_conns = snd_hda_get_num_conns(codec, dig_out);
 	if (num_conns != 2 && num_conns != 3)
 		return 0;
+	spec->num_smux_conns = num_conns;
 	if (!snd_hda_gen_add_kctl(&spec->gen, NULL, &ad1983_auto_smux_mixer))
 		return -ENOMEM;
 	return 0;
@@ -730,10 +731,12 @@ static int ad1988_auto_smux_enum_info(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_info *uinfo)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ad198x_spec *spec = codec->spec;
 	static const char * const texts[] = {
 		"PCM", "ADC1", "ADC2", "ADC3",
 	};
-	int num_conns = snd_hda_get_num_conns(codec, 0x0b) + 1;
+	int num_conns = spec->num_smux_conns;
+
 	if (num_conns > 4)
 		num_conns = 4;
 	return snd_hda_enum_helper_info(kcontrol, uinfo, num_conns, texts);
@@ -756,7 +759,7 @@ static int ad1988_auto_smux_enum_put(struct snd_kcontrol *kcontrol,
 	struct ad198x_spec *spec = codec->spec;
 	unsigned int val = ucontrol->value.enumerated.item[0];
 	struct nid_path *path;
-	int num_conns = snd_hda_get_num_conns(codec, 0x0b) + 1;
+	int num_conns = spec->num_smux_conns;
 
 	if (val >= num_conns)
 		return -EINVAL;
@@ -847,6 +850,7 @@ static int ad1988_add_spdif_mux_ctl(struct hda_codec *codec)
 	num_conns = snd_hda_get_num_conns(codec, 0x0b) + 1;
 	if (num_conns != 3 && num_conns != 4)
 		return 0;
+	spec->num_smux_conns = num_conns;
 
 	for (i = 0; i < num_conns; i++) {
 		struct nid_path *path = snd_array_new(&spec->gen.paths);
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
