Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB265CD37AC
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2026 14:45:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E22796020D;
	Mon, 11 May 2026 16:44:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E22796020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778510706;
	bh=fAViBQjsAF6s8EqK1QlhWi6JaXkw2k3KM5LgAwBSRVY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=tSsg3xTCYJiCMrN5WPGENRR5ooxeap6cD7oTdRoprjD9RgCne96PNV2GGswsaRnU4
	 o1lO1JcY8sQfmMxEGxhUYtfVas7Y0eoEFJl2Ggg0F55Y8yT8X7ENcA+fbn4vLi9rbc
	 ly0OYCCQDkbX3K6DV93fqGkdBPNtx5Y5d/ZJBIDg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08F1EF805FA; Mon, 11 May 2026 16:44:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AC136F80610;
	Mon, 11 May 2026 16:44:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 344D5F80518; Thu,  7 May 2026 21:01:09 +0200 (CEST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8D9B9F800FE
	for <alsa-devel@alsa-project.org>; Thu,  7 May 2026 21:01:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D9B9F800FE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=IOyIfDWD
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-ba7a1cc0380so209785466b.2
        for <alsa-devel@alsa-project.org>;
 Thu, 07 May 2026 12:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778180466; cv=none;
        d=google.com; s=arc-20240605;
        b=cqA2jRsfRmV9Fl2whjONp1WoGaMCCCwXLTV7yfKDLw4vlnbXPgr6jkB7rWEqg2LCOn
         ZehR7VskOmL/vB3YnKnPHuhxYHljjkRBtkSe6nQnozWiDTHH04H2Z6nWfRFgvGfl5CdQ
         Ji/NEkoDIDMtDPcpV8sc3YLPNOPWzuAvWqeJEZ9cNlHx54NSMLcbLTEON7cTTxbIHcq6
         Wn2ZjqaOTlUnTOQIYCYdn8RjFx3PzAyDTAzdImYkIkicg4Q1CU15Uft46WfUpoHWIprt
         9F8ZKEDzuS0l4LDYCGD2wKkMcEjcVM64h4Kh+K3wRzyFwjA1TufJwpUrdorXpF+sgyU/
         06QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=zBGirz++9FADiX5FR84GXnXFfcpzt2AnUmu/EMIPfZI=;
        fh=Ew/FczzB7o7aRfej3b0OqrTSMw6fQi9VXUH7aRGOf/4=;
        b=CQoz0gzpywR8rUDa0Tl90MJPIU+ARdnEsmvMCdBiURFH503AQpwcz7tGaDdHE84B76
         x6Vkhh9QDEm1C6AEgLMhgRN2UFDXsQ7LLucq+Tze507psbbjysuruUIImISJz75HFvcB
         86oJlabqh2mnXcnYve90zLiE/+a9ZoCKc1TPRImh7TNi1m934lm61gCIObTk6SIjbKdq
         Zw+2+F68KXbuIfx7GE++FBclhSUzP4VJCJ56bIAIzZuGtMdUdasW5ugKpswhtDls1/gZ
         uXtcwKSmJvqoVsujzNAZyk3PjSY9LeOxyZHOuaTZaMl7HaYGE8wn0rXXFbaLI9F/yqsE
         bOJw==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778180466; x=1778785266;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zBGirz++9FADiX5FR84GXnXFfcpzt2AnUmu/EMIPfZI=;
        b=IOyIfDWDds3wMQ8IFNBSBT9PDqFO578WSgA2bNJsxNLIrMyhfCc4YD6ATyGu6I7Xmw
         bj7GvXoA+igHtmOS92Rnkm7I31MuDYamjwHpQp+Gs/M3gana1I/mtvFf7gfXw4s0aMqs
         2H93RN5SNz2ABIgmEBy+kp9i3Q5WoGedzJGvr3wdVo7joRYtPeIgpiUyc8heui/V9Mj7
         9d+yg14VHcH3ubf/8gMFsJLFT9ilYqhWo5RVAOl2dGomOV3Lk/TSNhv7y2EN7TWIw+pd
         7/k0bYnT6LwJJiRGG4pCfzvS8K3kHRLV2K1VzGRQR6EB/PIXGYZmu5zoNhvP+AObLZBt
         h6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778180466; x=1778785266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBGirz++9FADiX5FR84GXnXFfcpzt2AnUmu/EMIPfZI=;
        b=E1+rFkAepO60krFNipRKl664hO/BwReI+Olcy+FjJgX6DW/rPFB0LDmnrFgc1OWn0x
         UEyJ4ufgl6ytcWjSE+E6MOYctmSE4eqpy2tcYx0PtsV07gT8DtWvE4e27/UBZTjLAANs
         3vOwaei8u4D1n7tjg2DJNHa3Df+AdYzb509r9ooVojw6G4PPsJfys8ZgGkkEPQK6A+qC
         2yvO015g7CzcD4yfRYjkrV73y1hCdYhkq9xzSBjlOgqIwwaxokHZLe1hei+FjGfJavBV
         NnuH7W5pXNCyhFwoB6G33IxZLapr4TVzFYRW6o6dTcWqmcLEHiQpPrpY630obBF7lidG
         SKJQ==
X-Gm-Message-State: AOJu0Yy17bXK+YgXaBzzsI3WzY6NKSEdBPhAXUKg5lS/XTPYt9QGmTHo
	SYV/i+ElHPJCqhDyirE+FdsubKO9MIK+KuAPhSPJsnMG3A62Y7aANtOkF50U1NcKcYoAjBAGRRR
	JLwB2VdOvWmHIB4y4YAyhz3o1dXx1WmCc1qvCUiY=
X-Gm-Gg: AeBDiesVarzaxroMazTv3k1g8+1zGpCawYrFfcwnAu33yjOqNnwnlfNemfoPvsJPz6H
	5v8B/OnkJmShJ9fXWDaAdbLz6fkXN0wz+PtE2gd4I69s96fePH1OlBiLDAkeciNzFklrtkdLi6A
	JoGMvRmQ5f7vtiHILROpPUbMGDfHeqCubtCUsTJEwuuuciew+1L0T0jmKaxoEM+0MeSb1vqggQU
	z8JyA7RjMzQlpETYzOJM91Vl1CVPtGrm1F9qbRQLq//NsIZ27KbmsSeTtTX5XeukSteOT/Zy9e0
	Zqq9Hkw=
X-Received: by 2002:a17:906:4fc8:b0:bc6:502e:6d68 with SMTP id
 a640c23a62f3a-bc6502e7514mr379197666b.40.1778180465652; Thu, 07 May 2026
 12:01:05 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Bojan_Janjatovi=C4=87?= <bojan.janjatovic@gmail.com>
Date: Thu, 7 May 2026 21:00:53 +0200
X-Gm-Features: AVHnY4LEUSQJqQKidz6ahMh6fUVQmxRiyZiAsjZIx1wWpuqxSMWxAQFryP2-mEs
Message-ID: 
 <CAA-EO1cvs+qy=k7uEC2DQ+PURK5+9V8fL5jxE8jfEM4ShvXWcQ@mail.gmail.com>
Subject: [PATCH] amixer: handle simple mixer event errors
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, perex@perex.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: bojan.janjatovic@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: KYHFWHVXUQDGJLZ5C5IYSQ6LHW647QGE
X-Message-ID-Hash: KYHFWHVXUQDGJLZ5C5IYSQ6LHW647QGE
X-Mailman-Approved-At: Mon, 11 May 2026 14:44:17 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KYHFWHVXUQDGJLZ5C5IYSQ6LHW647QGE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

nd_mixer_handle_events() can return negative runtime errors while
amixer sevents is monitoring simple mixer events. This was reproduced
during early PipeWire startup, where the handler returned -ENOENT after
snd_mixer_wait() reported a ready event.

The raw control event monitor already reports analogous
snd_hctl_handle_events() errors instead of aborting. Handle simple mixer
event errors the same way so sevents reports the error and keeps
listening instead of hitting an assertion failure.

Fixes: https://github.com/alsa-project/alsa-utils/issues/327

Signed-off-by: Bojan Janjatovi=C4=87 <bojan.janjatovic@gmail.com>
---
 amixer/amixer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/amixer/amixer.c b/amixer/amixer.c
index 07e9819..cf3db8e 100644
--- a/amixer/amixer.c
+++ b/amixer/amixer.c
@@ -27,7 +27,6 @@
 #include <ctype.h>
 #include <math.h>
 #include <errno.h>
-#include <assert.h>
 #include <alsa/asoundlib.h>
 #include <poll.h>
 #include <stdint.h>
@@ -1703,7 +1702,8 @@ static int sevents(int argc ATTRIBUTE_UNUSED,
char *argv[] ATTRIBUTE_UNUSED)
  if (res >=3D 0) {
  printf("Poll ok: %i\n", res);
  res =3D snd_mixer_handle_events(handle);
- assert(res >=3D 0);
+ if (res < 0)
+ printf("ERR: %s (%d)\n", snd_strerror(res), res);
  }
  }
  snd_mixer_close(handle);
--=20
2.54.0
