Return-Path: <SRS0=iLk1=HA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E51C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 15:40:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5056564DE9
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 15:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5056564DE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF25816C0;
	Fri, 29 Jan 2021 16:39:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF25816C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611934812;
	bh=NXNouyx6VKhBlXzANDlHY8thWjXibcwa2KqZUbE4TQg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aL546YYpMIB03ZUwz6wmsJ1jnw/Lo68LpZYfvWP3DVV1a5UjDKz9QiziL1uCGEWCO
	 LIGBoy5t01VMBMEHWhNn9vdown4FCizQ2RA/mZpkE1cvrDCICFDyiOcXIXzIVlHzQm
	 OO9LfSPKRIGB8SMRFAX/FoV5Dp/XZ49El7+6TL5w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 073D6F804E6;
	Fri, 29 Jan 2021 16:38:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81041F804E4; Fri, 29 Jan 2021 16:38:26 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2C2EF804DF;
 Fri, 29 Jan 2021 16:38:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2C2EF804DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="BIHxfZ6E"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33F3064E24;
 Fri, 29 Jan 2021 15:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611934697;
 bh=NXNouyx6VKhBlXzANDlHY8thWjXibcwa2KqZUbE4TQg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BIHxfZ6En29pIzy1xOdI3jZWeHAqYWN8ChssmBKn0K5+U4XZc2OSgWFp+PWVZPeDQ
 Ky2jIYoR3GzfR2mBj3qhxNAXXh6AJkz14R6a/go8HyUa8W73+O8X735L9bc89SjSpU
 sCbamve87yUmPGigXQRH2idVvizsjzDc1dRwHLiotwNGi4PR13M7W1SOglNvxXW88i
 5PsLFDkqNL9xxYG03FKc9fXxHvViZHg5aLoBfbDVXVj3Gk9AEqCdy4WY9idZLjUros
 Rfyehcs21rcBsiWrb7ubShTfRbUwpts8ZjXUMXV09wqdOy4eYeQv1tTdYAuLCxs1Q0
 6xsiQ/X6OcdOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 08/19] ASoC: SOF: Intel: hda: Resume codec to do
 jack detection
Date: Fri, 29 Jan 2021 10:37:55 -0500
Message-Id: <20210129153806.1592565-8-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210129153806.1592565-1-sashal@kernel.org>
References: <20210129153806.1592565-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, Mark Brown <broonie@kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, alsa-devel@alsa-project.org,
 sound-open-firmware@alsa-project.org
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

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit bcd7059abc19e6ec5b2260dff6a008fb99c4eef9 ]

Instead of queueing jackpoll_work, runtime resume the codec to let it
use different jack detection methods based on jackpoll_interval.

This partially matches SOF driver's behavior with commit a6e7d0a4bdb0
("ALSA: hda: fix jack detection with Realtek codecs when in D3"), the
difference is SOF unconditionally resumes the codec.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Link: https://lore.kernel.org/r/20210112181128.1229827-1-kai.heng.feng@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-codec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 9e8233c10d860..df38616c431a6 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -68,8 +68,7 @@ void hda_codec_jack_check(struct snd_sof_dev *sdev)
 		 * has been recorded in STATESTS
 		 */
 		if (codec->jacktbl.used)
-			schedule_delayed_work(&codec->jackpoll_work,
-					      codec->jackpoll_interval);
+			pm_request_resume(&codec->core.dev);
 }
 #else
 void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev) {}
-- 
2.27.0

