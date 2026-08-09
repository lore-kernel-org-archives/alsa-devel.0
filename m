Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0171C5AD5A
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:26:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 087D260246;
	Wed, 12 Aug 2026 11:26:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 087D260246
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786526802;
	bh=AraZ1rq8LxasfB6TogqLmzZITaAl0hmJqf7mOyPNC50=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=qJe4sCt9bkRNTpOkdhisaEZSfFAZM78VJh3Caa75Ng6yfkkOpEjOUt5s65GSVHwAq
	 y3YfxX5TSI7erVxkhTSi+k4FmSqi4KhxyAB/s6BVboR4veFriFcKP1n+CwqXQrP0ed
	 nAiF0+yBBkxdOeQIVo2vAXwTNENSs8bcXUIEpBJM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 71411F806C1; Wed, 12 Aug 2026 11:24:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2911FF805EB;
	Wed, 12 Aug 2026 11:24:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7808CF8026A; Sun,  9 Aug 2026 09:44:09 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786261445;
	b=OBiwED4+lvf3aW4VLrqwa9E2J59tABpnApfNRZVvj1ge2lDU7HnA7Cupz2ZqWFz1YFH5
	 Ug8JzKcNv//OgtG9BP/lgj+MfVgqWbHDk7p4CprXxov8eCloBxIpmvtKDQqeDvGace+7Y
	 M8y0xXeo3irourW5ZEaMTGf0d+Ds4r3d4dYddvDjKVeZUA7l7ptuiZqTPrzsvrZ+109qA
	 M2zip+N1w6qoieu6a4zMsNi1QWaculcPChJdYIR3T5YVusSO5c9MKPN+84xKQB3AHrU22
	 qLYQO5mVVEN0phaj8MQhiA35fsPThur7zDdY5Oi/nnov6ELttLm5yJXo7HT0CvUOjOg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786261445;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=AraZ1rq8LxasfB6TogqLmzZITaAl0hmJqf7mOyPNC50=;
	b=IuOe8xHtevMofPaTlfg3yO2r1KgiUFvnqRyW+o4s4Yv3bGWQsglyj1a7ck3+LkKn9mF+
	 SIEKvUhDI7KH9aAe4C2fZuGVPM4bH8KLkTLJqlDdBsLXOfW7/kqhHbgBWLQHDSBlyPtf5
	 qQsCR3b7D2dWmKS5uspiJySXS3TFMe25aVleOdXOA3abH5d6nbBYocrwtyiYK6bURtHLt
	 fC6mAak2FY9EtD+5M3H+ehGYHt+JvdYere9ENyDFON0Yyozv8VvHKR5pUPJcW7BY4fKHc
	 siD2LcDuq1dSn3am1tFYz2gQbzOdK7H338FnuMCk1wagRh1D7cXJS5QLZFQuIzp5dfg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eInCuWXk;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 25B69F80240
	for <alsa-devel@alsa-project.org>; Sun,  9 Aug 2026 09:44:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25B69F80240
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eInCuWXk
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-84f3ab8750cso827774b3a.0
        for <alsa-devel@alsa-project.org>;
 Sun, 09 Aug 2026 00:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786261441; x=1786866241;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b9ieAFPZ3KCNYtYRe7iipfxjLEguJtXDiYV3GvLkaig=;
        b=eInCuWXkuLeQRiUg1H0jupQ4piLrpRITDc07j0K5UkvmwjwTcQz+otJUpyjMdZFwk8
         BtsHSFj/ii078WUL1AcEOy5j6o4F+LjNbuDaayZ/0ZNZN9r1M8XJihOg7K5GdpNRi607
         r6kxjEx71YEg0j3vVk8KB+xhxokj5YEZHCbucFEXEwLfzOHBj1Zpbb+AHm1aJZCtMif3
         NhpuYPIVD6/lH5l/gS9+xhVZYTBcmjUHgRBajBqVS7yeqNvYPdjlINHBfc2HLyLv8jf8
         pBAo2uj7OaySLjM30CoMyouQqrwyhOtZrpifgZhsmhiMoioYn92P8+58EjKUNLKDb2OE
         KFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786261441; x=1786866241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b9ieAFPZ3KCNYtYRe7iipfxjLEguJtXDiYV3GvLkaig=;
        b=OlDp09emy2H/ujeT9ayMPoDvtbPyEywFmQlEpwYa1Q4DsvpxqZ6F5QOygWlLOgFEuV
         iTGpxlPxy/kHOSy0AN/CkMfF0MNBje1kcTpcMl4fQBRLWR7ytfYnGxQOb5ummlJCrnL/
         /dP8OKzUIl2TOOeahUEVKC1BW76n87ikx4JuPw914PaZuVBBkNA4qA+QnUoZImouybMI
         EEvvVYUJthHqOVlh8bm3zIdtyZUqpGzJ73Tu0Fc1kXWzdQlpSQhUAa35CCz4GAb2SFbC
         pSZZQ3xjHsKq3Xqi+e9/iRuoGjmQoSYLvfXTks9SfZfXLLHy8B8LjdCK8+3/aUN8nTVr
         DHkw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZX+uWYkBIdCStilPJhuLnqDuFXROp1w2HrPryRngfpPw/F5TcsXkPea4uu7W6p95j0+np1ZgyWCNe@alsa-project.org
X-Gm-Message-State: AOJu0Yw9AQKcDUIGfyHRmrNe8bUdAMicJxE06bDX3izV0ijezsnX7ZGm
	E2wEXOknyw4POhiRuq/IfEmuopoYd9nHl9mVvkyeOXpOHXM6QGPo1zZU
X-Gm-Gg: AR+sD11xpmGFDWfzxTC+3n/A1Q/kzXZqQILXejpxfLhhLdZT5zlmL8HUnOi2e+/tX4H
	iNhxvZR6YNReJgZ5jO7fMOZFa/DmzJFbZ5J5G29tm69zs6plxoLeK0r8gjY8sxufHMW79PMcvhQ
	6y0V+KkHbtzSisXOhFIntkoRKbgPQ73qWJ6xg5bFtcHbn5GrF9KW0RIxrUY/WL4EMppFV0iEU72
	ZnYS3pbeVxiSRNt9ixqWa9hl7aL4YHNh5UEwtDZgp/0R7/E20aCROzX9PANaXaCXkftE3H90iDk
	GNdr7KA2H44K9m2MTAXwAEA0vqNbBE9tBZRee6SH7KPNzTW2cOqkGlvN58U0TgcBQ+CbZZCJS0Z
	czbhRFZn9YjiBsPPOCMvoQQU08jv03OpLR8wgSG4wlsRIg7+yHoiC3LwbM910PjnmvXZhnpadoL
	Ul40dvjkXvcWeqqmaGXRiNbGx8h4oQvcpD4Lbg6+fP6RS6cRj7r/AD32K7PjXCfV4D8rOxtIYU1
	QXXFMqzcA==
X-Received: by 2002:a05:6a00:4218:b0:845:ce5f:c926 with SMTP id
 d2e1a72fcca58-84f2e210308mr40466210b3a.1.1786261441265;
        Sun, 09 Aug 2026 00:44:01 -0700 (PDT)
Received: from LAPTOP-7K7V6NC8.localdomain ([120.212.170.8])
        by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f371f4fsm2443827a12.24.2026.08.09.00.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 00:44:00 -0700 (PDT)
From: pzqqt88198@gmail.com
To: stable@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	pzqqt88198@gmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10.y v1] ALSA: usb-audio: Evaluate packsize caps at the
 right place
Date: Sun,  9 Aug 2026 15:43:20 +0800
Message-ID: <20260809074320.1407-1-pzqqt88198@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: pzqqt88198@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 6TUPWTSSKKESWMNE5RQKX27OHNAAPWVI
X-Message-ID-Hash: 6TUPWTSSKKESWMNE5RQKX27OHNAAPWVI
X-Mailman-Approved-At: Wed, 12 Aug 2026 09:24:52 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6TUPWTSSKKESWMNE5RQKX27OHNAAPWVI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 52521e8398839105ef8eb22b3f0993f9b0d11a57 ]

We introduced the upper bound checks of the packet sizes by the
ep->maxframesize for avoiding the URB submission errors.  However, the
check was applied at an incorrect place in the function
snd_usb_endpoint_set_params() where ep->maxframesize isn't defined
yet; the value is defined at a bit later position.  So this ended up
with a failure at the first run while the second run works.

For fixing it, move the check at the correct place, right after the
calculation of ep->maxframesize in the same function.

Fixes: 7fe8dec3f628 ("ALSA: usb-audio: Cap the packet size pre-calculations")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221292
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260410143220.1676344-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[Pzqqt: Backport to 5.10]
Signed-off-by: Pzqqt <pzqqt88198@gmail.com>
---
 sound/usb/endpoint.c | 3 ---
 sound/usb/pcm.c      | 7 +++++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 8e2b90cb5b95..21bcdc811a81 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1099,9 +1099,6 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 		return -EINVAL;
 	}
 
-	ep->packsize[0] = min(ep->packsize[0], ep->maxframesize);
-	ep->packsize[1] = min(ep->packsize[1], ep->maxframesize);
-
 	/* calculate the frequency in 16.16 format */
 	ep->freqm = ep->freqn;
 	ep->freqshift = INT_MIN;
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index f4494d054917..802ed1dbd23b 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -953,6 +953,13 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	subs->data_endpoint->curframesize =
 		bytes_to_frames(runtime, subs->data_endpoint->curpacksize);
 
+	subs->data_endpoint->packsize[0] = min(
+		subs->data_endpoint->packsize[0],
+		subs->data_endpoint->maxframesize);
+	subs->data_endpoint->packsize[1] = min(
+		subs->data_endpoint->packsize[1],
+		subs->data_endpoint->maxframesize);
+
 	/* reset the pointer */
 	subs->hwptr_done = 0;
 	subs->transfer_done = 0;
-- 
2.43.0

