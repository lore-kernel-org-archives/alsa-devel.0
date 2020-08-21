Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F269C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:00:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F039020738
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FvfZlOzk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHMz4Ht5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F039020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8973F1689;
	Fri, 21 Aug 2020 20:59:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8973F1689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598036423;
	bh=qSZrZMiL1PsWz7U7aueP2YDXSbUzrztuxJmd4ZcOXHc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FvfZlOzk0a7agwr2/NcVP2iuPYXHJonB0vqOTor0kFGdRFRQjzb+oDVe3JV7+7FqP
	 gNtcpGjWS9DDMlY+2O1j0QqGB3KNqtIS7ObCb3dPAWddl0s3dLC3kIT5jkWvEta4d0
	 tEG5wwkYGdqw5cZRCuvuYxHZNFjuy7isZ6BmIzOk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24C25F802FD;
	Fri, 21 Aug 2020 20:54:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 090EBF802F7; Fri, 21 Aug 2020 20:54:06 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 742C5F802DF
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 20:53:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 742C5F802DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="bHMz4Ht5"
Received: by mail-qk1-x743.google.com with SMTP id u3so2260579qkd.9
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 11:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dRoRCggi8EdohCRwOMamTs7F9Ex68uNFaZTz9zGb0Zk=;
 b=bHMz4Ht5vwX+q8ADoAC35a2xJJdiDVCnVPj/wyg2XKkhfeQcjZjCesbaCZr7UJRizQ
 V/y7W7d7lssHUAcpf3GpeVnAftjyH2Cwmy3WUd/lfBz6GTUX3U6Uv+AUfcLsCdlsYW6x
 kLhzg1wDyNWEEkwf/L6OBzxM7zrNQbWEvGROZQo0VltKceupu478Qixm5qOZsWJDC2LI
 QJpDbGSfWTMO55Xtp1TuUJ/VlNC2taw5uqP7O20c0bYy18x4bH733NoJ7rYB0uPfauHF
 OTk1OBiJEsjabiJn5vjMmzWkuIHb88155pW+xp+M+DA6eYdX8iTXGeye5SEV+TlD9MQp
 1ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dRoRCggi8EdohCRwOMamTs7F9Ex68uNFaZTz9zGb0Zk=;
 b=tOqNrGmf/6/OuJpX4/KC6NpVeuGtaeYJoeUHW4IbqnAL4wr/0GlP1omnqB6V1mTd3O
 +CVgZKEuNTilORR1o3jfOFhmB0+J6LjJr+MQhYtHjSDQI9EpBy3t2pk7YL0KQtAQhsBB
 KIxQDYxiJ29Oml+gZTL5TKY2nNFcdVq5JzSrDvunbAm3zxdoHXKDaz9P5lSuVoDkLYUS
 rEx5lfA1NLeYOMjr6ntBDX1jNk02sso9dwWh6/zCd4qx2CUtoxwrbc8x9Do/B4XI37YG
 ExZTolj94gfiGkfi6FuIt87y0EqPkb86CxIlFaQxyRaCDy+SyPXeMvOVb2udxM6vd7aZ
 FSsQ==
X-Gm-Message-State: AOAM532qf2gKOa780j/yeBgSsGMRqJ5yTWLHr/g4ekQzUr3N5B+MvyGV
 R1jDpz5Bic64U0FcEFQpbTHiUO9R6Hk=
X-Google-Smtp-Source: ABdhPJyy1Yysmy6zE+dyTA641LNOUFu78UKKJ8Evz1PzwzSm4I5hRZxkO4dY76b1gWaI5Mv2d/nMWQ==
X-Received: by 2002:a37:a4ce:: with SMTP id n197mr4011097qke.77.1598036037979; 
 Fri, 21 Aug 2020 11:53:57 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com.
 [71.65.111.223])
 by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 11:53:57 -0700 (PDT)
From: Connor McAdams <conmanx360@gmail.com>
To: 
Subject: [PATCH 09/20] ALSA: hda/ca0132 - Fix Recon3D Center/LFE output.
Date: Fri, 21 Aug 2020 14:52:26 -0400
Message-Id: <20200821185239.26133-10-conmanx360@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200821185239.26133-1-conmanx360@gmail.com>
References: <20200821185239.26133-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, conmanx360@gmail.com,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
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

Properly set the GPIO pin to un-mute the Center/LFE channel on the
Recon3D.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index ac9dcaf69a2e..9c61a10114aa 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7819,6 +7819,12 @@ static void r3d_setup_defaults(struct hda_codec *codec)
 	if (ca0132_quirk(spec) == QUIRK_R3DI)
 		r3di_gpio_dsp_status_set(codec, R3DI_DSP_DOWNLOADED);
 
+	/* Disable mute on Center/LFE. */
+	if (ca0132_quirk(spec) == QUIRK_R3D) {
+		ca0113_mmio_gpio_set(codec, 2, false);
+		ca0113_mmio_gpio_set(codec, 4, true);
+	}
+
 	/* Setup effect defaults */
 	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT + 1;
 	for (idx = 0; idx < num_fx; idx++) {
-- 
2.20.1

