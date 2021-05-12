Return-Path: <SRS0=rxKz=KH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8DEC43470
	for <alsa-devel@archiver.kernel.org>; Wed, 12 May 2021 18:04:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDEEA61465
	for <alsa-devel@archiver.kernel.org>; Wed, 12 May 2021 18:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEEA61465
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 246FC1831;
	Wed, 12 May 2021 20:03:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 246FC1831
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620842641;
	bh=9Ra2Pkb/2R8SV4fQGjODW9snAVZNS3gJLqWj2jY/YKQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IKKtcAZqE/v/BeUl3/zYLt+uyeFVdegGnBH3rJwXSnQoMbj28LWSPqPnr8PvST6XF
	 gCKfXImju4kAw4NoqnI4QB4CBr4xpjnU6BdZfsxRuEhx4f0XshnbvXyLIN7RNwxj0w
	 L1T3lri8ceOwzgfqor2jbyeDXORDM8283lg9YbmU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA19CF8026B;
	Wed, 12 May 2021 20:03:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99583F800E9; Wed, 12 May 2021 20:03:08 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52381F8013A
 for <alsa-devel@alsa-project.org>; Wed, 12 May 2021 20:03:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52381F8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KmB2FfGe"
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD2906142D;
 Wed, 12 May 2021 18:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620842579;
 bh=9Ra2Pkb/2R8SV4fQGjODW9snAVZNS3gJLqWj2jY/YKQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KmB2FfGeOEEHVC/WZrtcJVi6sCvKvvp5L5lOax8j7SZdTk07FcybnFqCMkhplhXE+
 6Ut1GTHwB1EaHJDsgZDBykRHTkTedU0hOovmiF2EIAfpfaMFjscaTbw0vaGBbLCb01
 kt2Iyn5CKw7iZOsPsm5NbhF6pVrDjWioKTRVFqMt6t3twWgiw7PXjN8W84ngmaE5BT
 Lxwl0DAVicTq/LJ0olZzwbciqMNO3vn+AOvDWT22GxdmtWFh+RHYkj5pKFDpgaQgNo
 KZOqFr6yQQOVpX9WBdEhFQgR0unXnmTjVDsglRSAE9FliM/ui1iuP+Gox6AtVx3z50
 3/7cwmrmSJyaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 32/35] ALSA: hda: generic: change the DAC ctl
 name for LO+SPK or LO+HP
Date: Wed, 12 May 2021 14:02:02 -0400
Message-Id: <20210512180206.664536-32-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512180206.664536-1-sashal@kernel.org>
References: <20210512180206.664536-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Hui Wang <hui.wang@canonical.com>, Takashi Iwai <tiwai@suse.de>,
 alsa-devel@alsa-project.org, Sasha Levin <sashal@kernel.org>
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

From: Hui Wang <hui.wang@canonical.com>

[ Upstream commit f48652bbe3ae62ba2835a396b7e01f063e51c4cd ]

Without this change, the DAC ctl's name could be changed only when
the machine has both Speaker and Headphone, but we met some machines
which only has Lineout and Headhpone, and the Lineout and Headphone
share the Audio Mixer0 and DAC0, the ctl's name is set to "Front".

On most of machines, the "Front" is used for Speaker only or Lineout
only, but on this machine it is shared by Lineout and Headphone,
This introduces an issue in the pipewire and pulseaudio, suppose users
want the Headphone to be on and the Speaker/Lineout to be off, they
could turn off the "Front", this works on most of the machines, but on
this machine, the "Front" couldn't be turned off otherwise the
headphone will be off too. Here we do some change to let the ctl's
name change to "Headphone+LO" on this machine, and pipewire and
pulseaudio already could handle "Headphone+LO" and "Speaker+LO".
(https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/747)

BugLink: http://bugs.launchpad.net/bugs/804178
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Link: https://lore.kernel.org/r/20210504073917.22406-1-hui.wang@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_generic.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 96903295a967..7c49a7e92dd2 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1202,11 +1202,17 @@ static const char *get_line_out_pfx(struct hda_codec *codec, int ch,
 		*index = ch;
 		return "Headphone";
 	case AUTO_PIN_LINE_OUT:
-		/* This deals with the case where we have two DACs and
-		 * one LO, one HP and one Speaker */
-		if (!ch && cfg->speaker_outs && cfg->hp_outs) {
-			bool hp_lo_shared = !path_has_mixer(codec, spec->hp_paths[0], ctl_type);
-			bool spk_lo_shared = !path_has_mixer(codec, spec->speaker_paths[0], ctl_type);
+		/* This deals with the case where one HP or one Speaker or
+		 * one HP + one Speaker need to share the DAC with LO
+		 */
+		if (!ch) {
+			bool hp_lo_shared = false, spk_lo_shared = false;
+
+			if (cfg->speaker_outs)
+				spk_lo_shared = !path_has_mixer(codec,
+								spec->speaker_paths[0],	ctl_type);
+			if (cfg->hp_outs)
+				hp_lo_shared = !path_has_mixer(codec, spec->hp_paths[0], ctl_type);
 			if (hp_lo_shared && spk_lo_shared)
 				return spec->vmaster_mute.hook ? "PCM" : "Master";
 			if (hp_lo_shared)
-- 
2.30.2

