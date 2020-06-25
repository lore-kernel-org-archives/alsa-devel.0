Return-Path: <SRS0=XzTt=AG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1682AC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:59:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944F120781
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RL40QPTp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="kiS4bNg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944F120781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21E5285D;
	Thu, 25 Jun 2020 13:58:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21E5285D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593086380;
	bh=mqSK+Nk/lpG1HDQvrdVnROhVSFO5g7eKbhytbx0wI7A=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RL40QPTpv+H+YJinDVBS8T+CHDzyR88JxegF6uPqFwXHZGFR6Or7+svgLcEYHxaTO
	 uzKnmpOpCCuwGOYF5fDkRyz48av6CEQo3/JAQIcDsUHY1uuVLswYxIWLX3pPGxW9Pq
	 4/OTI8PPdAaRZHwRLSsG2wAJO8PiVoaCZ76BkVEg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E7B1F80158;
	Thu, 25 Jun 2020 13:58:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 75C6EF80234; Thu, 25 Jun 2020 13:58:47 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2649FF80158
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 13:58:40 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 13DF0A003F;
 Thu, 25 Jun 2020 13:58:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 13DF0A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1593086319; bh=1p+fiRQhOEUiwl+CUXZO320U1CUa5ubHCZI3JICVqSE=;
 h=From:To:Cc:Subject:Date:From;
 b=kiS4bNg5LhAU9t6MjlJtZIkSWjved04+GPaeiuc8QdgVB5lZNETu+vif+Dkw5ffLI
 OpCb0L5bgf0pxhyiI9v/uXL0XzSsHr+TZLsP2og8kw74Z/gPxJf1eUNBoH1VHCCr2D
 0iFn9yBh72N3wjTTI0KnuiU6+LKWTv80+77v+ggk=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Thu, 25 Jun 2020 13:58:32 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Subject: [PATCH] AsoC: amd: add missing snd- module prefix to the acp3x-rn
 driver kernel module
Date: Thu, 25 Jun 2020 13:58:29 +0200
Message-Id: <20200625115829.791750-1-perex@perex.cz>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Alexander.Deucher@amd.com,
 Mark Brown <broonie@kernel.org>, vijendar.mukunda@amd.com
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

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Cc: Mark Brown <broonie@kernel.org>
Cc: vijendar.mukunda@amd.com
Cc: Alexander.Deucher@amd.com
---
 sound/soc/amd/renoir/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/renoir/Makefile b/sound/soc/amd/renoir/Makefile
index e4371932a55a..4a82690aec16 100644
--- a/sound/soc/amd/renoir/Makefile
+++ b/sound/soc/amd/renoir/Makefile
@@ -2,6 +2,7 @@
 # Renoir platform Support
 snd-rn-pci-acp3x-objs	:= rn-pci-acp3x.o
 snd-acp3x-pdm-dma-objs	:= acp3x-pdm-dma.o
-obj-$(CONFIG_SND_SOC_AMD_RENOIR)	 += snd-rn-pci-acp3x.o
-obj-$(CONFIG_SND_SOC_AMD_RENOIR)	 += snd-acp3x-pdm-dma.o
-obj-$(CONFIG_SND_SOC_AMD_RENOIR_MACH)	+= acp3x-rn.o
+snd-acp3x-rn-objs	:= acp3x-rn.o
+obj-$(CONFIG_SND_SOC_AMD_RENOIR)	+= snd-rn-pci-acp3x.o
+obj-$(CONFIG_SND_SOC_AMD_RENOIR)	+= snd-acp3x-pdm-dma.o
+obj-$(CONFIG_SND_SOC_AMD_RENOIR_MACH)	+= snd-acp3x-rn.o
-- 
2.25.4
