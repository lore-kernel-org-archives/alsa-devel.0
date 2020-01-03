Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A04C00523
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:36:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72E02253D
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="abOu6PPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72E02253D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E728D1762;
	Fri,  3 Jan 2020 09:35:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E728D1762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578040558;
	bh=muqudHSv8MBs4fiqG8H5FWwdJRhgpG1V5/yNsZ1SVVw=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=abOu6PPFv+WGeADnhDghXgy/Pxd4aQSLF2WDUjMdkBRddo12f73dxEJtWnM1lTnAy
	 16Lz5S/A/h/SrpT2qpbQbvYRmWlsi3QT8Y1vblfNLCyQiSaL1c3KDV32z2Ba7841hs
	 03gofTVTOhsUVyYjlml0qTosOBqaQw+PDt+T0Kho=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DED7F803CE;
	Fri,  3 Jan 2020 09:18:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF1E3F8034E; Fri,  3 Jan 2020 09:18:11 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F31BF80299
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 09:17:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F31BF80299
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2CB39B274
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 08:17:21 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri,  3 Jan 2020 09:16:48 +0100
Message-Id: <20200103081714.9560-33-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200103081714.9560-1-tiwai@suse.de>
References: <20200103081714.9560-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 32/58] ALSA: aoa: Constify snd_kcontrol_new
	items
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

Most of snd_kcontrol_new definitions are read-only and passed as-is.
Let's declare them as const for further optimization.

There should be no functional changes by this patch.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/aoa/codecs/onyx.c    | 2 +-
 sound/aoa/codecs/tas.c     | 2 +-
 sound/aoa/fabrics/layout.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index 83ab3e58a0d3..f85bc8a1e2a6 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -413,7 +413,7 @@ static int onyx_snd_single_bit_put(struct snd_kcontrol *kcontrol,
 }
 
 #define SINGLE_BIT(n, type, description, address, mask, flags)	 	\
-static struct snd_kcontrol_new n##_control = {				\
+static const struct snd_kcontrol_new n##_control = {			\
 	.iface = SNDRV_CTL_ELEM_IFACE_##type,				\
 	.name = description,						\
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,			\
diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
index c60b78367fc9..d3e37577b529 100644
--- a/sound/aoa/codecs/tas.c
+++ b/sound/aoa/codecs/tas.c
@@ -369,7 +369,7 @@ static int tas_snd_mixer_put(struct snd_kcontrol *kcontrol,
 }
 
 #define MIXER_CONTROL(n,descr,idx)			\
-static struct snd_kcontrol_new n##_control = {		\
+static const struct snd_kcontrol_new n##_control = {	\
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,		\
 	.name = descr " Playback Volume",		\
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,	\
diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index 801b2f7699c2..d2e85b83f7ed 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -655,7 +655,7 @@ static int n##_control_put(struct snd_kcontrol *kcontrol,		\
 			!!ucontrol->value.integer.value[0]);		\
 	return 1;							\
 }									\
-static struct snd_kcontrol_new n##_ctl = {				\
+static const struct snd_kcontrol_new n##_ctl = {			\
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,				\
 	.name = description,						\
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,                      \
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
