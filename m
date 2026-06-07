Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80CECD8C89
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:48:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 246AA6021A;
	Sun,  7 Jun 2026 19:48:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 246AA6021A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780854491;
	bh=9PKZKeFbz0/TTNTIXdi0z88j9mNVL5I4ys97cMPdWDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GemXwJ3ah+bWleZY5M1mJAkKF2lfa34jt5yvqqO4fAKxihlTxIGV7AJdJ9SqAzLq9
	 jAhvyB2IZgG1E87SdfFJF5/w0f9xDJtVsn298pHtmn6sOV6aVBrsEIA/cDTArNwMJ6
	 mbadsFcw96ZnUUoKvH5FMfyHNHpxxJTKlU74AEKo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9BCDDF80684; Sun,  7 Jun 2026 19:46:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2421FF8068F;
	Sun,  7 Jun 2026 19:46:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8DA9BF80589; Sun,  7 Jun 2026 04:56:29 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780800989;
	b=mLa5L7fHySsGRNavRqia5xQUDTGQbZwlK2vZGKGRWmtYenTblHJcxil7TZ6fj80nqcCp
	 xiuxN2dV/wKKbGWJnSoukUjFsaH2nr4Dx5hZSWoVj4v1P5FrnbkFUvSHoLzrvaJkjuf8/
	 rQaEs3wLlU1qFIJU2MaJAYDu337Lk5VaRSdtvQ6b+w+Y/lnEMKuvVM+a1mq8aoziwIQCt
	 FFG/bBFd6qSKrKDPS0+DZyTNl6Bth5UpMW77Lgg6lK277AkKYGTjKXN/2cOXcAlJzEtvp
	 JaklN5Ij3qDB8rxMcxtv4n9i1dNE8fFwjCEO2hUzBXpldSc9cFyCKpiWGnhsiEZngoQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780800989;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9PKZKeFbz0/TTNTIXdi0z88j9mNVL5I4ys97cMPdWDs=;
	b=UepiMYMZ5ymn8222uFWr6GIcrPX8D8MACBdkyk42+DXgn3G6QvMRxLlzSudjHImQbpkH
	 N7UiPgNuTUdEa7SLP+PavNK9Cris6yCdfHjb2trjK1uTod7VNA6XXokQuCspRCtEmUh6i
	 P/AeQXoD9Y1tZGzDk+NnMEsW7eHy5dyZNMQZres2JKSs7iRY9tXMeYMjgvAHRMdlfKTVl
	 UGoRbIaGVQfX6+7/HWDSK1nvrUmb0SdQ1O5ip7j2ljOCQujZnhAt1TT9SKT1Sg2+ErrjU
	 n6KCsh3rYTMuJW2MTr1ff2MXxsH9/nqMrF4pu10jkfm+2OgIAlNHtGSNgvOjGfw6U+w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=EkdKaIUr;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0D64AF80087
	for <alsa-devel@alsa-project.org>; Sun,  7 Jun 2026 04:56:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D64AF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=EkdKaIUr
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-842307473b5so2206284b3a.2
        for <alsa-devel@alsa-project.org>;
 Sat, 06 Jun 2026 19:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780800986; x=1781405786;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhhJTx0YtHowdbDm60LKy/c56f1KmXFLHrUloPR59Vg=;
        b=EkdKaIUrdqhBJLRypsmiVE6kP1a5GdVBdeK8oagzkwY28VEkaFH/2FhoINIG0vxWDz
         TyPhIbHiFzKLFTaGuG4plEAzvUxea0MA6+uWHZ5+cGzFWq0VSJULU4MG8mP9nfNWHNd6
         NNKozUA98IwetgqNDoIZKUsZFqgZdAK2ryyGgtPiw2TMiNcEJTqxJXgbgWlEftsLhzOm
         na4JX+thBg41lcd/ek1yFGpExngo1zNg9a8Eg06UCya6ehUkx6kuxevMz0hYb9dkyBa6
         KyjC0Bju6Ch48cjLHOsLfhrNnV2TS1xIZknurRvDtH8V54iercEL2fcqh1If8v8ENhrh
         qbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780800986; x=1781405786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GhhJTx0YtHowdbDm60LKy/c56f1KmXFLHrUloPR59Vg=;
        b=Ah5cvjBiQgIOL43AngykHr/3X/DHRtXDSokzL3PXSvpmhCkYlmdLTMWheBeYEvN53o
         89aBRschKvcWB9vfDh9tAF/4JtfbFBhFcGBvMy3hskwR/MU0qHN0KrlwUQUvzt+MtH89
         OaTBhpgAFRkhFRr0JxP2wUzxqFkXMrydf1x96BiQesj+xt6HNOzXg53362NjWSfNGKdS
         JQrz42bynxI8CQXXCC/clhUGNTgnS6pt3k3BDg9t5tJjKm5kLgCb9+aX9mJ6kKs9TGnZ
         9zcZ0G3Mf4WzNq6C7y1ttakeZW/5FPNF5gpVwSTS/YBb3VYTb8JLEmcBlaEHIw9vGqop
         jQqg==
X-Gm-Message-State: AOJu0YysLaueUvKiJ7jAxh/aHJ5mfCmULRdUFq9ijRCMAaQ8RIlWOE2F
	jQwKutFflRHZhIoIZxZSCOhMKcPcyjelkeruA2Bbjd4ARdHYkKJw73Zx
X-Gm-Gg: Acq92OH1EVKumKoBDaVkyXPgDste6dQxbzMEHp3KdW3dsB8qOZ8y4Rqn0I+uDVR3dgh
	NwQdFGVcBdM0ZtH6jAbH700VfrSCDYIQAoVgPob0TM3ygWBC6tosFSfbXfOtl0n8vgTTIsiCvpQ
	JtAPocaBRd7mkD6xyAjgEt2tbgNs5ClP3fJhnACRCYmnwhzT2oeLaMVunKlu5ZOQuXoeTl1xX4m
	3e4sPGVoCJZwQtgckqDMr0CmLyya9HB8C4kfscqUNswKZROieVnONDIRc0vpSGkyaCQhiePftsE
	FLDH9LxtC7Dc4CaZnXaYm7HJYfhMfXUPaD38a4FU9+g7o70Axr2uTSJXZ/Bbti9iRJFWhuaYoer
	CJ4K+QLWO9P4sZDhkrm5NRyPMZgNWBZio9eoKCUXkx83JNaz3BwbwaZmamYyOyMe3w8p8dKUOOe
	B+GKB8uPTnic6IAbk0SjV6gFJDIov95rJcE7cv5GStriICWMYB341w0Q==
X-Received: by 2002:a05:6a00:3498:b0:842:2ddb:e303 with SMTP id
 d2e1a72fcca58-842b0d5736amr11055732b3a.12.1780800986372;
        Sat, 06 Jun 2026 19:56:26 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:967f:7ce4:ec98:f08b])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282918b8csm13034210b3a.57.2026.06.06.19.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 19:56:26 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] ALSA: es1938: check control allocation before private data
 setup
Date: Sun,  7 Jun 2026 10:56:09 +0800
Message-ID: <20260607025613.3604194-5-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260607025613.3604194-1-ruoyuw560@gmail.com>
References: <20260607025613.3604194-1-ruoyuw560@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: ruoyuw560@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: YN6QODMLBQKWE75LF4ZNFB2RQUEST6PK
X-Message-ID-Hash: YN6QODMLBQKWE75LF4ZNFB2RQUEST6PK
X-Mailman-Approved-At: Sun, 07 Jun 2026 17:46:23 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YN6QODMLBQKWE75LF4ZNFB2RQUEST6PK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

snd_es1938_mixer() creates mixer controls with snd_ctl_new1() and then
stores hardware-volume pointers and private_free hooks in the returned
controls before calling snd_ctl_add(). snd_ctl_new1() can return NULL on
allocation failure, so these setup writes can dereference NULL.

Check the allocation result before using the control pointer.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 sound/pci/es1938.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index 280125eff3624..b6dcb721fffce 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -1655,6 +1655,8 @@ static int snd_es1938_mixer(struct es1938 *chip)
 	for (idx = 0; idx < ARRAY_SIZE(snd_es1938_controls); idx++) {
 		struct snd_kcontrol *kctl;
 		kctl = snd_ctl_new1(&snd_es1938_controls[idx], chip);
+		if (!kctl)
+			return -ENOMEM;
 		switch (idx) {
 			case 0:
 				chip->master_volume = kctl;
-- 
2.34.1

