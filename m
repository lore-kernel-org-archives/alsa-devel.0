Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12AAC4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 01:28:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD1261029
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 01:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3DD1261029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C269115E5;
	Wed, 18 Aug 2021 03:27:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C269115E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629250097;
	bh=6umufkupZidmynwTF8CLpbrl5W5XUPPk6l7b1ADZ4cc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GqNbWMAeq70hoWof6jG9q+ATQ6L5uvLKnlsyvGJ4Yu23OmwsZpBnpQZDfHWLURJza
	 YEaryOsm/RCJ7o6R5NwAixoOyXe1YSFtIOkB/zrCI63pEfKa0b1j6njRSXKIBJFRWO
	 b/J52ErY2Y3vGwUpsXLbPvBxshzc7fCjYuwrRdjk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 54681F80246;
	Wed, 18 Aug 2021 03:27:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 49438F80246; Wed, 18 Aug 2021 03:27:25 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D1D1F80169
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 03:27:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D1D1F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZAL2F178"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B35460F39;
 Wed, 18 Aug 2021 01:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629250036;
 bh=6umufkupZidmynwTF8CLpbrl5W5XUPPk6l7b1ADZ4cc=;
 h=From:To:Cc:Subject:Date:From;
 b=ZAL2F178ez1XrnzI3G2uBkssO/P4/L4VHm4pBBDUZ8HTktG/s0pR2+NxgmiJeUz50
 5UqP2N2X3XvDwCVrnvbvtQBalSb2iGYm+lPD5z57F3fjL8Em4BxHEwVFpWlUuyzx04
 tWcXvXBycUjFoLx/Air89XbbZ7frg9o0WnbYKhfiYabdxLl5DULBCIfv6oUUm9PhOG
 1QsZJ5rcb/V25ipAMv/00cG+tb2vTkUEP9jbHhhUIQtAGlL4RtWoEpR9np5TyjtLgY
 sbhcENgfQ/zRaoTPydJ1Fw1W8qAGxDqI1QdOhAyVotnBIFhfBKrtau5jAX0wmKPKmq
 ddvGx54QLY22g==
From: Nathan Chancellor <nathan@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 1/2] ALSA: hda/sigmatel - Sink stac_shutup() into
 stac_suspend()
Date: Tue, 17 Aug 2021 18:27:04 -0700
Message-Id: <20210818012705.311963-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Cc: Nathan Chancellor <nathan@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

When CONFIG_PM is not set, there is an unused function warning:

sound/pci/hda/patch_sigmatel.c:4383:13: warning: unused function
'stac_shutup' [-Wunused-function]
static void stac_shutup(struct hda_codec *codec)
            ^
1 warning generated.

Sink the contents of stac_shutup() into stac_suspend() since
stac_shutup() is only called in that one location now.

Fixes: 327b34f2a97d ("ALSA: hda: Nuke unused reboot_notify callback")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 sound/pci/hda/patch_sigmatel.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 3e00116db86e..61df4d33c48f 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4380,18 +4380,6 @@ static int stac_init(struct hda_codec *codec)
 	return 0;
 }
 
-static void stac_shutup(struct hda_codec *codec)
-{
-	struct sigmatel_spec *spec = codec->spec;
-
-	snd_hda_shutup_pins(codec);
-
-	if (spec->eapd_mask)
-		stac_gpio_set(codec, spec->gpio_mask,
-				spec->gpio_dir, spec->gpio_data &
-				~spec->eapd_mask);
-}
-
 #define stac_free	snd_hda_gen_free
 
 #ifdef CONFIG_SND_PROC_FS
@@ -4444,7 +4432,15 @@ static void stac927x_proc_hook(struct snd_info_buffer *buffer,
 #ifdef CONFIG_PM
 static int stac_suspend(struct hda_codec *codec)
 {
-	stac_shutup(codec);
+	struct sigmatel_spec *spec = codec->spec;
+
+	snd_hda_shutup_pins(codec);
+
+	if (spec->eapd_mask)
+		stac_gpio_set(codec, spec->gpio_mask,
+				spec->gpio_dir, spec->gpio_data &
+				~spec->eapd_mask);
+
 	return 0;
 }
 #else

base-commit: 8fc8e903156f42c66245838441d03607e9067381
-- 
2.33.0

