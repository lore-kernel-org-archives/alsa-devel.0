Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3417C5AD5A
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:27:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E427460250;
	Wed, 12 Aug 2026 11:27:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E427460250
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786526831;
	bh=vW0VoaKpYR6UuvZ2TYveGRQwkldVdkjVpuSMwCTKTgs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=pwpJjZqGyKm+ia0icucGWhJyWPE4meAW4MWfjZjZe6diMU9VDbRyFR8uCrBqb9yNi
	 qRR8APsHl7cPrDdt+c+RVqEsbNxpL+BmgrtQk9HvL6OQKUBKtdM+paLRb/ivWbHIzs
	 R+MINMg5gU8XIJdv344qON9hvI0yppT0ueufxkvM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4168BF80634; Wed, 12 Aug 2026 11:26:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D3999F80637;
	Wed, 12 Aug 2026 11:26:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27A7FF804E5; Tue, 11 Aug 2026 16:59:22 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786460361;
	b=bWjPN0K09O+9ind1a8sbSJnhZTGBnDUvgo26Sa6JrOiK7ybtm2t2d1f1H1LGsukjeEMI
	 xcB7x6snZhGpqGvz0+HJE0jzxhLbHyfenZ9fOztp5aJOBVGZOZb80q0atBuDFjYS+hCwd
	 6UtSsf2pXe4/rJwsA64q5RezZloVzyBduKrEUZoLCBlrKt7DX/h4bRYXrCbbELTay9rFA
	 /Izda41jFGrw2L4bSvtsQSPGzVaUi8YDeAzRSKOygIeJRi1O5QSDbz4zLjtd5LOag9evw
	 rHOuKr8O/5f2Rk7FfwJhhnctXDwBJZgqSyV29C8VTPbYFUJMX1tNEkJTbfVJ2W2NMtg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786460361;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vW0VoaKpYR6UuvZ2TYveGRQwkldVdkjVpuSMwCTKTgs=;
	b=IfUm/v8lEXJUZ5w+AHTatgDtSWhgIyXs7mras+WGgbV2iuWqHG8f/mTUUyJb5oFxoufM
	 CTXNgmNb51qAMoknw/Gs8UwkSIRRutJznnONbvjiZMJB3TGzgZLdaNp8RPxbFVwnybKEr
	 CaYG8BlkPWc3SDDZtaNQ/yaH9WmVze7tWsd0E/jnT4XVcDp/N9dZZGOGQPzWSPKsawcLb
	 RyBp0klncALHF8tnff4SUAwP09ZmcQpRY1k15z0p35tl6sV6JMi9WHOJhOZZYyLtKoiLM
	 GpvniGouEVCRnSr1xZeB5ez9Nm37MQqnWlz1g0CXcZ/OktAU6xQ6jPRH2A8GaTZzcew==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mzHC94MQ;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 67D86F80075
	for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2026 16:59:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67D86F80075
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mzHC94MQ
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-84e84a6c4bfso1223145b3a.1
        for <alsa-devel@alsa-project.org>;
 Tue, 11 Aug 2026 07:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786460358; x=1787065158;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFGUKXgNypg9pKlEsqRB8qQHzSOuDwN6U9MUHY9yTYI=;
        b=mzHC94MQnVs/lOty4dQmw2kTQ6J85aTqOxpaGLvG9zy5+D5pZdLSlTEaphrb8U5b5D
         4EQyyg7jInnBw2GXy4htQTMCmUfnwOUf6SaYhtFr20LoBLFaqi/b9T0WEowHSwPbD7f0
         GhH9+RFiSMgfLlPxY6ELRIK9f2oejF+IlnbtqXMN7gdJnGSHvha+rF5l4ysai6pfwNM+
         NJRw/29Bjm1JmTEgl5ffeWYFWtsT1MY/DF90K7bfcOiV3xHsuVF3WL5zk7uaoJENAO9c
         6J2zi1/nzMXbWV27kgkrCwqdVbY4qIV9N+u1cL+xJ3hreEafPZZwge7XCimuTszaTeFR
         94Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786460358; x=1787065158;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XFGUKXgNypg9pKlEsqRB8qQHzSOuDwN6U9MUHY9yTYI=;
        b=lxJ1ePwjQ+pNBuWzTzedTunba7KaxVxsolxQiZvmoZN9hDfbisEc9UA4fD85wX7OqT
         /aAEjHYA8+HqDc4jAm4jtKNDo8SlsF+ZmkfLSvOdFC0SZT820Uvi9gIdIKqot1uS/dxJ
         kect+LGGqSd2ROU99YDEMZW8HGlehcuclevxlhN3kmWAFlzX4WS+ljE0NWRfP6j5ckGI
         qKNjYprze1bxK9GfvNkytACIqdspvyqVwxRXj+k3AUoXFyBn6GRi4i6VAl04s9d5Ef9d
         L8KF6LajjmyTAMnUouldH9S33z7XBFbsFhMDClNYhMpWTnzDJpoFMCTadR8BGSX0b81M
         zbMg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTDO3nXT5wC/wChRZJacu2pzF8lpYhKclEMTp4HV+G9UjIFfL7ls/fhwzVPWSNMon0K9+/HrzVAmAY@alsa-project.org
X-Gm-Message-State: AOJu0Yy1qY79iDGhDvl0gTVnHEm323XJN42dO2/BMWNEwk5y8HELyEK2
	/PNs6BSjk6wDeywq8tQt+GtgXLGFFNQI6GwwGrFvoVi4u+ngER0LRuYM
X-Gm-Gg: AR+sD13VtPGQnTHLsb7UQK5nx6ccWy6y1VfYxkdmraCRyKM/K/VwYhuAJQ9ScpR06Q5
	w6KdZi7xqf1nfGc1jMCxKvnDTNSS2AnU4Gxf3lCYbNalrgN/5vjaAHG9llG8BUHvSvNlh4Zby2+
	FSB5DYHKRqgroMrjGjPuwf7emmullgeS94gwqkCzkKbcKLhYddVoYeQ6R82/I29EilLwXa3jXvC
	hVVhwvI1R+zySu43STayI+HKHmztS2qDr9G/RJH7BVv8Z9pG14eCfKdLWe9hcloWNQZh3Ydyod1
	J7S1PU8fSpYtGNmoqCXhaIQtzB+BzTdjPV3W6lGIZfoK3w201GYDaVIk1KuIAJ1UiJ1udAV83+k
	EjQLiGBXzZC5BJmrbn89wi5xYl+uT85uqrEIm0ZQN8PcKRwafFMMYEXRFQMoUBA27EBqL1KvvOC
	7Bm6VoH2qjZtDmBpBjVoUPygoI8ecC+ht8ty0d5pxb8yW+aiydNWhANPXGxANRTUx0hMK6dEgGc
	vFVMsvJMg==
X-Received: by 2002:a05:6a00:4095:b0:84e:46d:23a6 with SMTP id
 d2e1a72fcca58-84faff3da20mr616615b3a.18.1786460357810;
        Tue, 11 Aug 2026 07:59:17 -0700 (PDT)
Received: from LAPTOP-7K7V6NC8.localdomain ([120.212.170.8])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fa91b63b7sm947484b3a.22.2026.08.11.07.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:59:17 -0700 (PDT)
From: pzqqt88198@gmail.com
To: stable@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	pzqqt88198@gmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10.y v2] ALSA: usb-audio: Evaluate packsize caps at the
 right place
Date: Tue, 11 Aug 2026 22:57:40 +0800
Message-ID: <20260811145740.306-1-pzqqt88198@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: pzqqt88198@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: HUHDUJD73EEHYOY4YVKVNYZZXSUBH7M6
X-Message-ID-Hash: HUHDUJD73EEHYOY4YVKVNYZZXSUBH7M6
X-Mailman-Approved-At: Wed, 12 Aug 2026 09:26:01 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HUHDUJD73EEHYOY4YVKVNYZZXSUBH7M6/>
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
[王YP: Move the check to `snd_usb_pcm_prepare()`. For linux-5.10.y,
       ep->maxframesize is calculated in `snd_usb_pcm_prepare()`.]
Signed-off-by: 王YP <pzqqt88198@gmail.com>
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

