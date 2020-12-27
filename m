Return-Path: <SRS0=ctet=F7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341A6C433E0
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Dec 2020 12:57:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE391206A5
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Dec 2020 12:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE391206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F239176A;
	Sun, 27 Dec 2020 13:57:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F239176A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609073872;
	bh=zkduSzYejslgu4b6rl96/V2nDrtSjatLpiqsyPQznAo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=B0fvVYfVOHejX03+wbUqpDMv+q/t3ybqA7uAHuCPA1juLOyEU97xQVaXHyL3cIa9w
	 if9PTjsCw/VWfyZpQMpHgV4aoHI6jrXB7pH+U4vHFU3Ef/N8DTdhe/2TdFqBc4qelK
	 Vm8PxBGwy/+pR5p+DwFQNtIgqY+0i91VwKCC2Sc8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19BD7F8020C;
	Sun, 27 Dec 2020 13:57:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EEA00F8022B; Sun, 27 Dec 2020 13:56:59 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 253F7F80169
 for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2020 13:56:53 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id F41A0A0040;
 Sun, 27 Dec 2020 13:56:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz F41A0A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1609073813; bh=9JNc5jwAcBJl3pU/fDyadPXJu5Lgc5rw5IljheiP0As=;
 h=From:To:Cc:Subject:Date:From;
 b=vgMBs3ZG6anVmvrAgmj9J6oczjo6NQjZbbgiLOJV3RPC8vVtlu65E9cUov5pfSdVn
 clc/F+9KMVffVRezRrTHHJRtY4P6twzIkXd4Xes9lcNS39ofdu0OAFpwpIeiqE+kd4
 gwX1K6vZD2Okmd3htOAVIMu/+A3LVwUsjlqH7nks=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Sun, 27 Dec 2020 13:56:46 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Subject: [PATCH] ASoC: AMD Renoir - add DMI entry for Lenovo ThinkPad E14 Gen 2
Date: Sun, 27 Dec 2020 13:56:38 +0100
Message-Id: <20201227125638.260195-1-perex@perex.cz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
 stable@kernel.org, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
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

The ThinkPad E14 Gen 2 latop does not have the internal digital
microphone connected to the AMD's ACP bridge, but it's advertised
via BIOS. The internal microphone is connected to the HDA codec.

Use DMI to block the microphone PCM device for this platform.

Reported-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Cc: <stable@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/soc/amd/renoir/rn-pci-acp3x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/amd/renoir/rn-pci-acp3x.c b/sound/soc/amd/renoir/rn-pci-acp3x.c
index fa169bf09886..749e520eaca9 100644
--- a/sound/soc/amd/renoir/rn-pci-acp3x.c
+++ b/sound/soc/amd/renoir/rn-pci-acp3x.c
@@ -169,6 +169,11 @@ static const struct dmi_system_id rn_acp_quirk_table[] = {
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "LNVNB161216"),
+		},
+		/* Lenovo ThinkPad E14 Gen 2 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "20T6CTO1WW"),
 		}
 	},
 	{}
-- 
2.29.2
