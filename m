Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E48C00523
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:41:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B219921D7D
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rogr1OrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B219921D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17A3D1779;
	Fri,  3 Jan 2020 09:40:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17A3D1779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578040863;
	bh=2I42lxjs5llm+MomhDOsGczMpi7m+JULJcNZwc8N/v4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rogr1OrKW3NnY0YJaHz7DAAE7oEAMCj13roiSYuQRawDSmCYCmS+yfnfV939MDKS0
	 ixkVO+7Hqr/RTk4cKFPpYDMecndpV4aWJ0pU4q0qXtog2dzFbidYNRlO1kULrnSTLp
	 ADKFN6al1ochlfEx9hZ7F3c1iLaYQl8Tu79Bu6wQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 339BEF8042A;
	Fri,  3 Jan 2020 09:19:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4DA4F8036D; Fri,  3 Jan 2020 09:18:22 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0BEC1F802A1
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 09:17:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0BEC1F802A1
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4758FB276
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 08:17:21 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri,  3 Jan 2020 09:16:50 +0100
Message-Id: <20200103081714.9560-35-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200103081714.9560-1-tiwai@suse.de>
References: <20200103081714.9560-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 34/58] ALSA: i2c: Constify snd_kcontrol_new
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
 sound/i2c/cs8427.c       | 2 +-
 sound/i2c/other/ak4113.c | 2 +-
 sound/i2c/other/ak4114.c | 2 +-
 sound/i2c/other/ak4117.c | 2 +-
 sound/i2c/tea6330t.c     | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/i2c/cs8427.c b/sound/i2c/cs8427.c
index bac4f0036cd6..8634d4f466b3 100644
--- a/sound/i2c/cs8427.c
+++ b/sound/i2c/cs8427.c
@@ -459,7 +459,7 @@ static int snd_cs8427_spdif_mask_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_cs8427_iec958_controls[] = {
+static const struct snd_kcontrol_new snd_cs8427_iec958_controls[] = {
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.info =		snd_cs8427_in_status_info,
diff --git a/sound/i2c/other/ak4113.c b/sound/i2c/other/ak4113.c
index 2700a8470388..e7213092eb4f 100644
--- a/sound/i2c/other/ak4113.c
+++ b/sound/i2c/other/ak4113.c
@@ -349,7 +349,7 @@ static int snd_ak4113_spdif_qget(struct snd_kcontrol *kcontrol,
 }
 
 /* Don't forget to change AK4113_CONTROLS define!!! */
-static struct snd_kcontrol_new snd_ak4113_iec958_controls[] = {
+static const struct snd_kcontrol_new snd_ak4113_iec958_controls[] = {
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =		"IEC958 Parity Errors",
diff --git a/sound/i2c/other/ak4114.c b/sound/i2c/other/ak4114.c
index e7325af8af5b..2ce0a97957ab 100644
--- a/sound/i2c/other/ak4114.c
+++ b/sound/i2c/other/ak4114.c
@@ -318,7 +318,7 @@ static int snd_ak4114_spdif_qget(struct snd_kcontrol *kcontrol,
 }
 
 /* Don't forget to change AK4114_CONTROLS define!!! */
-static struct snd_kcontrol_new snd_ak4114_iec958_controls[] = {
+static const struct snd_kcontrol_new snd_ak4114_iec958_controls[] = {
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =		"IEC958 Parity Errors",
diff --git a/sound/i2c/other/ak4117.c b/sound/i2c/other/ak4117.c
index 0d9e8252cc27..905be2d0780b 100644
--- a/sound/i2c/other/ak4117.c
+++ b/sound/i2c/other/ak4117.c
@@ -305,7 +305,7 @@ static int snd_ak4117_spdif_qget(struct snd_kcontrol *kcontrol,
 }
 
 /* Don't forget to change AK4117_CONTROLS define!!! */
-static struct snd_kcontrol_new snd_ak4117_iec958_controls[] = {
+static const struct snd_kcontrol_new snd_ak4117_iec958_controls[] = {
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =		"IEC958 Parity Errors",
diff --git a/sound/i2c/tea6330t.c b/sound/i2c/tea6330t.c
index 93ca8bb71f54..08eb6a873768 100644
--- a/sound/i2c/tea6330t.c
+++ b/sound/i2c/tea6330t.c
@@ -260,7 +260,7 @@ static int snd_tea6330t_put_treble(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_tea6330t_controls[] = {
+static const struct snd_kcontrol_new snd_tea6330t_controls[] = {
 TEA6330T_MASTER_SWITCH("Master Playback Switch", 0),
 TEA6330T_MASTER_VOLUME("Master Playback Volume", 0),
 TEA6330T_BASS("Tone Control - Bass", 0),
@@ -278,7 +278,7 @@ int snd_tea6330t_update_mixer(struct snd_card *card,
 {
 	struct snd_i2c_device *device;
 	struct tea6330t *tea;
-	struct snd_kcontrol_new *knew;
+	const struct snd_kcontrol_new *knew;
 	unsigned int idx;
 	int err = -ENOMEM;
 	u8 default_treble, default_bass;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
