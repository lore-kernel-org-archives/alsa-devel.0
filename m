Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CEECD8C89
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:49:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 946C5601CF;
	Sun,  7 Jun 2026 19:49:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 946C5601CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780854574;
	bh=cETSxH6N8k4VJKEnZYyODhK/zPaA0KGxM0AkYi35j+I=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=rz7/UVaYL+ALSBb/UHRBZGe+i9bQgyFE16kkx4CVnEcEW/lq2HaIqma1Km/HPpdC8
	 Yn2dhlab9Kj1dGdcDAZzGiap+aS+87m7suJ2+gJEzDVjUnfNe2voaLRgZsXCkaPvql
	 /JCBI8/3dSSyKGou+rDVTreHb5EHBNs9RBsMJ1u8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 142AEF807A6; Sun,  7 Jun 2026 19:46:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 77CA4F80798;
	Sun,  7 Jun 2026 19:46:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BB4ECF8055B; Sun,  7 Jun 2026 09:42:28 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780818148;
	b=M8B/QMLnMBQpzfzDyENKIzAYMNVvdwt+8F+9xEckXkkCdjCfCyKsxqKC8jLxjpid1psD
	 CqfnjgLaNjLNVWTNm3nvkuPvfba06knFNiTGc19pEgocvv7cm+H0wgAiR2/On0d7KjWGw
	 SvpDBq+nvsNzcdYfE/kA3SaVzrqwTm5CWASV919PGs/5xh7AaNoU9Qp21hERMGS8dUJ1A
	 9BtHeWgcDL/TAzHruWiSl2Co0iAb7yBbn1CfPxkDtj7FzGNZGXlTOGH+NXNLxs7tnPriz
	 l/U9tZfz0P7lZUEJVJWk+3Cf9A/IFFJb389+HgDVmY5j5+HU1oiY1hs5H3JU+0fuv9g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780818148;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cETSxH6N8k4VJKEnZYyODhK/zPaA0KGxM0AkYi35j+I=;
	b=iJ5QwLYshp//g3jApIWpU1Zh5hJlwd3wcraQVY3+JyTtRMWIlxgTu7QeTlfn4mzH+ZpR
	 1Xs+YpXm76+LPEQIScBPoQDjJGwO4o++0aUDa0lwvqqzRbg97cXn5fRUSFD6ejmsGgEBq
	 KbBsydQlAO9Hs0I/u+zXnu6V+ThwzMJz0PxsLLLPwkDujlCyayxJ4hvnm8anvCS6g1EFI
	 tAZ8KFAEACeXtxGDrkHG2I7YgAOJ/Hjea2nTkD9xSx2IKSdDTep6ZVea5xCn0bNEelnOC
	 h0EUSaHsxKXLmXFBhIgDg7z6Iad3JVu9dxyyp+TvihqcdkKJB1RPcJq95/byhd4fdLw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mvYU8zE0;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2178EF80087
	for <alsa-devel@alsa-project.org>; Sun,  7 Jun 2026 09:42:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2178EF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mvYU8zE0
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-36ba285e98bso3238000a91.2
        for <alsa-devel@alsa-project.org>;
 Sun, 07 Jun 2026 00:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780818145; x=1781422945;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=szQBTLMM+ErJ/0yB+n97U9OvndRfVdMRJeYj292RBIY=;
        b=mvYU8zE0VNBfFydftSZ5DlCokM6iw7Js9OSMgesuXjfeHz3023CPlxYLNjC/l4DE+X
         bxmC3reJ9Rowkan8uJIexDgXGcbe83faY8k7Quuc+FlBYc2hUXAl1MPGWZ375f13CUjC
         0FrNh0KP3FvN0PoZ+LVcCVnEhKSN2i2mJ4HSEBlsMD8qRQttRvfQUK1JdL9+iRdcUqLd
         77vT75g2fA7JH2nWCZtLyUT4jlWWPdbXLtxWgVJ39KdMmsMTrx+VUKnv61Qaqanl6ZoJ
         aLpxRiwjjSymapumMEAsfFk9y2oSDdSAC5Z+iEFRVq4r0LYJUNrHswhMwqMOnmdT9/aR
         6cFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780818145; x=1781422945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szQBTLMM+ErJ/0yB+n97U9OvndRfVdMRJeYj292RBIY=;
        b=lcFFjVezPgqrAu1Wgm4uX6D+8OSjfGPW97uk0cN2HIk9l1/RB38v+cu9kcbnDDaRnh
         w24WgXecQIKfRKah7LxP4MXpWGLVUJss3kt3VBj/Imj/u+MFL0FX5/OwoAE9MCB5kqZA
         ehjwvA818HQc/MwFZfXhrl/+2u7McVEpGQKY1tMIQvH3+LJ1mscjSpoldTH69Uo45zcQ
         gkxATw9GVy389VyKCxh4EPuiUspJcR17KOXnuyO+rf5JTQIaUTPP7lKUpOb6Hi3zMRvl
         z/Zb2jK6TVcsrnbUcXIu6FwxS0JB45kFkvpWt6FmRpH5C2kx2P1YqKi3ETl4PTk7QDKY
         cEVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3mXrClsMTCHAX9LlNtIQKvQAXAVzXTKAKgel6hvMYlLgtxNDg5MvVD7/NwPDQJlVlPbe8dp7ZHKNA@alsa-project.org
X-Gm-Message-State: AOJu0YzacD1lXUBwgsUJw6UuUJL1OT4+D8rjY/vVuzm5K6fjj8sEzMqZ
	7FIFEZlXWc+DYrCf4w4JjQlV/JAogZjo8JTDQgou6L21RGo6YiUqWE+8rq1SnxIC9SA=
X-Gm-Gg: Acq92OHU25LKVNqJzZHlFdZYOAB/pjH7ehcs0/dUWiEFNQ8ysbsWQWT17ARRTICbONd
	Zu7kOY5vbcxIQ30TMBVVHIMNN68prwLli/7ekk3DsZvCsuFnUo04FO15YO20m7hWUyqkP/1Yu4+
	vZKSu9NKjcaSc4M/beX6Bcil7EdJ9xaceTeFNbg9Qv5g+smflRuHSQjqXgSm3B1ZARSXk3Nj1Uc
	ZQcEL7thCwNIFMxUmpcSggWrkouDm7grIuDU0y2CwgWMb7xyzI11mpjib2bfUn8PF1Z1ZLN1IU6
	57Pj+0m+BckoK7fNJs7rnHNkhJKfzOa8lpR5kKRQXY9Ga/ceT8CbdEEEbq4mm0pM621Sm4D4pgw
	nKStB9C44Sklah4tmn+jZNEwtzE1YQBHnZPBKG7Up0aHNMoGxTcbWs8m15T+jpJ2ocaLztkSH1L
	zkAHvwRI2Xw8w/E+1Y7HJmuPub9zUQ5CbBzI0YaO98cGViJYqxcnn4
X-Received: by 2002:a17:90b:390b:b0:36b:3ecd:88d2 with SMTP id
 98e67ed59e1d1-370eeb1bebamr11537085a91.3.1780818144906;
        Sun, 07 Jun 2026 00:42:24 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:5d57:2cec:64ac:50a])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6ea172b8sm11903157a91.17.2026.06.07.00.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 00:42:24 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH v2] ALSA: es18xx: check control allocation before private data
 setup
Date: Sun,  7 Jun 2026 15:42:19 +0800
Message-ID: <20260607074219.3-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: ruoyuw560@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: CHJDR6NDMD3QPS6GVN7VV45BVDCLYWG2
X-Message-ID-Hash: CHJDR6NDMD3QPS6GVN7VV45BVDCLYWG2
X-Mailman-Approved-At: Sun, 07 Jun 2026 17:46:24 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CHJDR6NDMD3QPS6GVN7VV45BVDCLYWG2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

snd_es18xx_mixer() creates controls with snd_ctl_new1() and then stores
bookkeeping pointers or sets private_free before calling snd_ctl_add().
snd_ctl_new1() can return NULL on allocation failure, so those writes
can dereference a NULL control pointer.

Check the returned control pointers before using them and return -ENOMEM
on allocation failure.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
v2:
- Rebase on sound.git for-next.
- Resend only es18xx; the other v1 patches are already in for-next.

 sound/isa/es18xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index df88d91e0fb..1a02da1679d 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -1762,6 +1762,8 @@ static int snd_es18xx_mixer(struct snd_card *card)
 	for (idx = 0; idx < ARRAY_SIZE(snd_es18xx_base_controls); idx++) {
 		struct snd_kcontrol *kctl;
 		kctl = snd_ctl_new1(&snd_es18xx_base_controls[idx], chip);
+		if (!kctl)
+			return -ENOMEM;
 		if (chip->caps & ES18XX_HWV) {
 			switch (idx) {
 			case 0:
@@ -1823,6 +1825,8 @@ static int snd_es18xx_mixer(struct snd_card *card)
 		for (idx = 0; idx < ARRAY_SIZE(snd_es18xx_hw_volume_controls); idx++) {
 			struct snd_kcontrol *kctl;
 			kctl = snd_ctl_new1(&snd_es18xx_hw_volume_controls[idx], chip);
+			if (!kctl)
+				return -ENOMEM;
 			if (idx == 0)
 				chip->hw_volume = kctl;
 			else
-- 
2.51.0

