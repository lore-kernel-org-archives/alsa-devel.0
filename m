Return-Path: <SRS0=Fseo=P4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C54CC433FE
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:20:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F2D61A51
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F2F2D61A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3AC031664;
	Tue,  9 Nov 2021 23:19:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3AC031664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636496401;
	bh=rZ9QWQfRU/US9o4SdMAl+V6Df536/kZ9QhPCdC8ndLk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X66B+OFyhvwZhaET/d0+mAfee4Rt//vubj04BLEK3iR88cRTvoMJNRjM8XeUpDQSB
	 VkrQlvlUM1mSUfaPshKOg13JGIqnDtY7PzCDjmPgF1pHn/4WfT9NcPr3kbwxe7DuUX
	 ZhmyqFewy+4EHG4FRvC9G9FlluyUQguj6+5EikjQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2FCA4F80506;
	Tue,  9 Nov 2021 23:18:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D235FF804ED; Tue,  9 Nov 2021 23:18:06 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 203E2F802E3
 for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2021 23:17:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 203E2F802E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="U7p8y3gz"
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC7E761361;
 Tue,  9 Nov 2021 22:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636496275;
 bh=rZ9QWQfRU/US9o4SdMAl+V6Df536/kZ9QhPCdC8ndLk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=U7p8y3gz8noLjjJbwDmrm/Jb/C42UFPQT4V0oHJPP+wfymq+hkwQ/30EjPSh0OqVE
 XWnoMvc26tN2J8Kk+llgaq2dRWGGcrIPtr2OGJ2iVU2NRwuENlzi1aAqVgm+HpIwif
 SXNt9zqDefaDd/ZNI0C+MR1pMxrbLRe6D5S0UQI8OhXH70LofkNOFXE1Vhd2LQDAxP
 Er03p2R6cnfuPaoTDmYJ4pEUvZB0zJpq+vKME97HJM3eyX+eOhTecjl22vg3ecXukZ
 1aUDHPzz9xbxZFviGlIKNk37IBWyhlSQOXRtT07x0pr4Tc71esTFAj2gE6UUyo0z2Q
 YJ1IQopQIqHgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 38/82] ALSA: usb-audio: disable implicit feedback
 sync for Behringer UFX1204 and UFX1604
Date: Tue,  9 Nov 2021 17:15:56 -0500
Message-Id: <20211109221641.1233217-38-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109221641.1233217-1-sashal@kernel.org>
References: <20211109221641.1233217-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.de>, tiwai@suse.com,
 Geraldo Nascimento <geraldogabriel@gmail.com>
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

From: Geraldo Nascimento <geraldogabriel@gmail.com>

[ Upstream commit 28c369e60827f706cef4604a3e2848198f25bd26 ]

Behringer UFX1204 and UFX1604 have Synchronous endpoints to which
current ALSA code applies implicit feedback sync as if they were
Asynchronous endpoints. This breaks UAC compliance and is unneeded.

The commit 5e35dc0338d85ccebacf3f77eca1e5dea73155e8 and subsequent
1a15718b41df026cffd0e42cfdc38a1384ce19f9 were meant to clear up noise.

Unfortunately, noise persisted for those using higher sample rates and
this was only solved by commit d2e8f641257d0d3af6e45d6ac2d6f9d56b8ea964

Since there are no more reports of noise, let's get rid of the
implicit-fb quirks breaking UAC compliance.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
Link: https://lore.kernel.org/r/YVYSnoQ7nxLXT0Dq@geday
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/implicit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/usb/implicit.c b/sound/usb/implicit.c
index 23767a14d1266..70319c822c10b 100644
--- a/sound/usb/implicit.c
+++ b/sound/usb/implicit.c
@@ -54,8 +54,6 @@ static const struct snd_usb_implicit_fb_match playback_implicit_fb_quirks[] = {
 
 	/* Fixed EP */
 	/* FIXME: check the availability of generic matching */
-	IMPLICIT_FB_FIXED_DEV(0x1397, 0x0001, 0x81, 1), /* Behringer UFX1604 */
-	IMPLICIT_FB_FIXED_DEV(0x1397, 0x0002, 0x81, 1), /* Behringer UFX1204 */
 	IMPLICIT_FB_FIXED_DEV(0x2466, 0x8010, 0x81, 2), /* Fractal Audio Axe-Fx III */
 	IMPLICIT_FB_FIXED_DEV(0x31e9, 0x0001, 0x81, 2), /* Solid State Logic SSL2 */
 	IMPLICIT_FB_FIXED_DEV(0x31e9, 0x0002, 0x81, 2), /* Solid State Logic SSL2+ */
-- 
2.33.0

