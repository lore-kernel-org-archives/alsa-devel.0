Return-Path: <SRS0=ctet=F7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D627DC433DB
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Dec 2020 13:12:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D733E2250E
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Dec 2020 13:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D733E2250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 684301770;
	Sun, 27 Dec 2020 14:11:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 684301770
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609074758;
	bh=uzODKI7gePj7DnuH4UcUydf98ASTgCDvz8qRAokUJ8k=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=parbM/y4KWvxLUbHTrmLp+HGl+UrUHbmZyEKrScj/dcABu5GnaeHsNOGzc6+v/tP3
	 hik1F6ik+hVxYdbR5Q49lexCoyyUY1zTfF1AlpXKd3//DHx97xgvXSKVgl0kN+IoBB
	 QOKJfYq2OA6aadgQ5ghhE6DHd3qgv93ZZNd1esJ4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6577F8020C;
	Sun, 27 Dec 2020 14:11:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EDF1F8020C; Sun, 27 Dec 2020 14:11:45 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D2A7F80169
 for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2020 14:11:38 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 94FCBA003F;
 Sun, 27 Dec 2020 14:11:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 94FCBA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1609074697; bh=HIH4ACV2M+E/XJI910cDlKLcXQnH9o7WY5hAuMv60Xo=;
 h=From:To:Cc:Subject:Date:From;
 b=4IzM45z82cILryxBLYRNtQcSIW1Z0BxzhEItcgqks19qSnf1/hPHhjpC6BDPvGKFg
 twfr3XI1KQIt1RAls+LS55IA9YbkH4Vd8j/fLjg+aywlCGlJBF5CalOly2KNgNaL36
 4Jnw/gvKt/47ebhs7dr0zteDfiElfx3KPptOj+cA=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Sun, 27 Dec 2020 14:11:32 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Subject: [PATCH] ASoC: AMD Renoir - add DMI entry for Lenovo ThinkPad X395
Date: Sun, 27 Dec 2020 14:11:24 +0100
Message-Id: <20201227131124.262717-1-perex@perex.cz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
 stable@kernel.org
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

The ThinkPad X395 latop does not have the internal digital
microphone connected to the AMD's ACP bridge, but it's advertised
via BIOS. The internal microphone is connected to the HDA codec.

Use DMI to block the microphone PCM device for this platform.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1892115
Cc: <stable@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/soc/amd/renoir/rn-pci-acp3x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/amd/renoir/rn-pci-acp3x.c b/sound/soc/amd/renoir/rn-pci-acp3x.c
index 749e520eaca9..a2993696e600 100644
--- a/sound/soc/amd/renoir/rn-pci-acp3x.c
+++ b/sound/soc/amd/renoir/rn-pci-acp3x.c
@@ -174,6 +174,11 @@ static const struct dmi_system_id rn_acp_quirk_table[] = {
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "20T6CTO1WW"),
+		},
+		/* Lenovo ThinkPad X395 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "20NLCTO1WW"),
 		}
 	},
 	{}
-- 
2.29.2
