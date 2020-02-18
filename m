Return-Path: <SRS0=1Vby=4G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93993C34026
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:15:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD1D20659
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VJ3XEPlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD1D20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 670011607;
	Tue, 18 Feb 2020 10:14:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 670011607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582017305;
	bh=JJc08Bty/Ef1BFAPVDEtVCocfuDQQxKemXNtoUbSvVo=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VJ3XEPlxm2VScoQiyEkEa8Bzd6VKIeDCbtAGc8NpizwvjZXbqbhMNuQUg7VLY0dSX
	 O1xkYJxkW2ALpHFVUJ8431eDVpOFiyZJxkLvSD3iZlKiCC6hOpugyScVluWR469LvZ
	 qmVKqnAmPn4qeSgx40Wtr9hLD6r/HmVHXMgfoElc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA24BF800C4;
	Tue, 18 Feb 2020 10:14:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D08B1F80148; Tue, 18 Feb 2020 10:14:13 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2FB01F800C4
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2020 10:14:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FB01F800C4
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3F0EDB031
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2020 09:14:10 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda: Use scnprintf() for printing texts for sysfs/procfs
Date: Tue, 18 Feb 2020 10:14:09 +0100
Message-Id: <20200218091409.27162-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
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

Some code in HD-audio driver calls snprintf() in a loop and still
expects that the return value were actually written size, while
snprintf() returns the expected would-be length instead.  When the
given buffer limit were small, this leads to a buffer overflow.

Use scnprintf() for addressing those issues.  It returns the actually
written size unlike snprintf().

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdmi_chmap.c    | 2 +-
 sound/pci/hda/hda_codec.c | 2 +-
 sound/pci/hda/hda_eld.c   | 2 +-
 sound/pci/hda/hda_sysfs.c | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/hda/hdmi_chmap.c b/sound/hda/hdmi_chmap.c
index 5fd6d575e123..aad5c4bf4d34 100644
--- a/sound/hda/hdmi_chmap.c
+++ b/sound/hda/hdmi_chmap.c
@@ -250,7 +250,7 @@ void snd_hdac_print_channel_allocation(int spk_alloc, char *buf, int buflen)
 
 	for (i = 0, j = 0; i < ARRAY_SIZE(cea_speaker_allocation_names); i++) {
 		if (spk_alloc & (1 << i))
-			j += snprintf(buf + j, buflen - j,  " %s",
+			j += scnprintf(buf + j, buflen - j,  " %s",
 					cea_speaker_allocation_names[i]);
 	}
 	buf[j] = '\0';	/* necessary when j == 0 */
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 5dc42f932739..53e7732ef752 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -4022,7 +4022,7 @@ void snd_print_pcm_bits(int pcm, char *buf, int buflen)
 
 	for (i = 0, j = 0; i < ARRAY_SIZE(bits); i++)
 		if (pcm & (AC_SUPPCM_BITS_8 << i))
-			j += snprintf(buf + j, buflen - j,  " %d", bits[i]);
+			j += scnprintf(buf + j, buflen - j,  " %d", bits[i]);
 
 	buf[j] = '\0'; /* necessary when j == 0 */
 }
diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index bb46c89b7f63..136477ed46ae 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -360,7 +360,7 @@ static void hdmi_print_pcm_rates(int pcm, char *buf, int buflen)
 
 	for (i = 0, j = 0; i < ARRAY_SIZE(alsa_rates); i++)
 		if (pcm & (1 << i))
-			j += snprintf(buf + j, buflen - j,  " %d",
+			j += scnprintf(buf + j, buflen - j,  " %d",
 				alsa_rates[i]);
 
 	buf[j] = '\0'; /* necessary when j == 0 */
diff --git a/sound/pci/hda/hda_sysfs.c b/sound/pci/hda/hda_sysfs.c
index 0607ed5d1959..eb8ec109d7ad 100644
--- a/sound/pci/hda/hda_sysfs.c
+++ b/sound/pci/hda/hda_sysfs.c
@@ -222,7 +222,7 @@ static ssize_t init_verbs_show(struct device *dev,
 	int i, len = 0;
 	mutex_lock(&codec->user_mutex);
 	snd_array_for_each(&codec->init_verbs, i, v) {
-		len += snprintf(buf + len, PAGE_SIZE - len,
+		len += scnprintf(buf + len, PAGE_SIZE - len,
 				"0x%02x 0x%03x 0x%04x\n",
 				v->nid, v->verb, v->param);
 	}
@@ -272,7 +272,7 @@ static ssize_t hints_show(struct device *dev,
 	int i, len = 0;
 	mutex_lock(&codec->user_mutex);
 	snd_array_for_each(&codec->hints, i, hint) {
-		len += snprintf(buf + len, PAGE_SIZE - len,
+		len += scnprintf(buf + len, PAGE_SIZE - len,
 				"%s = %s\n", hint->key, hint->val);
 	}
 	mutex_unlock(&codec->user_mutex);
-- 
2.16.4

