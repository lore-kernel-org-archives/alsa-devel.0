Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721C4C4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Dec 2022 09:48:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7EA54172F;
	Fri, 16 Dec 2022 10:47:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7EA54172F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671184082;
	bh=Rk+XUbebVXCh694DgtWDhN5UyiMI1s8gQshk6aScB+0=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=f2F5cLxQbk1A8FLqsLkBzHfei7yDwL2IjynPUnHFBvWgTIX+z7CnnbPGv41RL7pWm
	 /zaYLtlPz+Uwd8aI6BLdzQzUXf7lWHeGshx5rzT+REA3IvUPCZmA+RQFc5WipB0jZM
	 7Vs55xa273ISerbX4dWNSOvOmlA6x6Wt9VKEnFu4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C60AF804F1;
	Fri, 16 Dec 2022 10:47:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B7B1F804E7; Fri, 16 Dec 2022 10:47:10 +0100 (CET)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1B9A7F804E7
 for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2022 10:47:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B9A7F804E7
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=denx.de header.i=@denx.de header.a=rsa-sha256
 header.s=phobos-20191101 header.b=rNGlylIt
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4A937851FC;
 Fri, 16 Dec 2022 10:46:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1671183998;
 bh=WOaRp1o2Jv3EJCkvPGwU9coZufEjr6sI22bltN9JL4k=;
 h=From:To:Cc:Subject:Date:From;
 b=rNGlylItoItOvElXqnnbH37EsM6DM9gINpC6+fj4W3IUHrZyi/8IUhN5tGxSlYzp7
 pNxdX1830iKdCZjGrk4HoC0NZfJtgSMGUzA032x4ZUdIo8QBqKUZQDtAiZdxj1X3wm
 +LJZy1+UFlaOvYqKSWqf1sdF5GGdje0ynQcrJwilfiSqRhAoh8eEVIHmpGC04YW6G6
 rOacsev2iK9KSz7zF7mzMFpVKJPzyE4xsackHi5YaJWdWahwa8bydVlP447moPwNSW
 Np2/Z3zulHY/Q9CTVYLEnY0Ar/V64JbJyvyTgQh+h1nthmPL3RUA7Z88HzVLazgSEq
 RrlVv7Oe5PKeg==
From: Lukasz Majewski <lukma@denx.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v3 1/3] ASoC: wm8940: Remove warning when no plat data present
Date: Fri, 16 Dec 2022 10:46:22 +0100
Message-Id: <20221216094624.3849278-1-lukma@denx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, Stephen Kitt <steve@sk2.org>,
 patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The lack of platform data in the contemporary Linux
shall not be the reason to display warnings to the
kernel logs.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

---
Changes for v2:
- None
Changes for v3:
- None
---
 sound/soc/codecs/wm8940.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 8dac9fd88547..0b59020d747f 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -709,9 +709,7 @@ static int wm8940_probe(struct snd_soc_component *component)
 	if (ret < 0)
 		return ret;
 
-	if (!pdata)
-		dev_warn(component->dev, "No platform data supplied\n");
-	else {
+	if (pdata) {
 		reg = snd_soc_component_read(component, WM8940_OUTPUTCTL);
 		ret = snd_soc_component_write(component, WM8940_OUTPUTCTL, reg | pdata->vroi);
 		if (ret < 0)
-- 
2.20.1

