Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91938CD8C89
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:49:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F063960216;
	Sun,  7 Jun 2026 19:49:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F063960216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780854559;
	bh=lZCYhLpjtIv9yFXKAPImch0CcZ3uVGkSOlB5mr3evjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KjGh5bgg0CD79Ku5ZlvY+mRigfZ6/Ivsp39cAy5vQAr8w7pJ5XsaWasDum51Me1Ho
	 99JT6e32CdTbAi0JY4+0lrD5Be+6RsM6ceII3wdIO3tO0/T2I1cFjhF7ndhlbCpHC5
	 R6CYs36lDCBPQ5rG4o9ypUINFoWRL5gsboU4CqcM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9E16BF80709; Sun,  7 Jun 2026 19:46:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CEB3BF80709;
	Sun,  7 Jun 2026 19:46:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D6C72F805EB; Sun,  7 Jun 2026 04:56:37 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780800997;
	b=AT+5Fdj/3cIZ0/9q9DaP+BZeCodNOltPihDMcxsIzxJqEetW5DoO58dL6aXxWwgJVLr4
	 HsB4FaQEm4AbID+h4/8bCZYtxlleciYFdx6AMxY7wRMWqF+3QNcA7wxJzylMz34mnKpsO
	 sLFa2SxcmuvwtGADm/0aN86cwUJk11v693nUA8OicsENo+xCBLZ556pYow8HVi5XOy2kC
	 kq/DaTeDsOeFjNLzyDRfQsP/crpPicjmm8A020yTh9Rm4S5Rbh5hXWRB5KdLRm8U998Qa
	 NyDAe17dZWAjCGOFIj7u1qKTuyWl9F5pzpTjIGZTekLJMLWfo9wdB3riwq0kNoBEytQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780800997;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lZCYhLpjtIv9yFXKAPImch0CcZ3uVGkSOlB5mr3evjA=;
	b=XgKvQ7aMmXZxt5PnE0J5ltpwMhSrA5NWzM3Pw/81O4olmoL6l9osLCwUvXWDEP6oP1sU
	 E7+HzBtiZYjoqfK0/VRJgHGlH+4bv/UMUpJ3MyStsz8+8aO/zvKgzOp70UjqDHr9+7dGU
	 Ov8+/7GhxHaTAvoBICYAcLvne1nt3lzobmz3cY0GvGKu5FvrIx9Sny3PudQeTD/fae71s
	 BF+Z50Yk9tyneTAwJII4HbhEC65IZKxPcUizwvFJ4M7Jh9OCQ5GXAewSigGpLYxcVjk2D
	 iJA2S3PS+hqcZlifeKqkukA/OSBDajQapnflFLIpSwbEWnSKvYGpMvUgSyVuzD9fIpw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=UJenYD2R;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5332AF8055B
	for <alsa-devel@alsa-project.org>; Sun,  7 Jun 2026 04:56:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5332AF8055B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=UJenYD2R
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c8588ec1b44so2270215a12.1
        for <alsa-devel@alsa-project.org>;
 Sat, 06 Jun 2026 19:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780800994; x=1781405794;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IRD15kEjSaFEFvwL8PeAfYR4UwlXFN32tdJ7lhCKUc=;
        b=UJenYD2RBF1WPYFHBn+9ho55ZR3yETytBAjVB+RBCo3Jy6b+qtjxefpK1YxCEOfJSK
         TybzwCtK9i24c/84cXnQigCYR6vzwDEJ01ecqEI/nqtDfonV0C41GzNFDUepIaohnxpS
         b/wf9F7ekcX/VvoGHF+ROvTeSKODfwxyN3jWNYoc2BN7Ju9hO95VOifZjocD6mtpehQQ
         2eisNv1xQVbVbPhxCabtt49/9bA/Uw2o7wwUbIiD9M1F3gc/MbkU3KSWPD2ZCd3CBbR5
         igKefDMYCK2g1m+udEGF+B1KUn+pUayUjdUH1jrAbWAwK1kUhemcSLWNAKDV3b1YkMY+
         nvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780800994; x=1781405794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3IRD15kEjSaFEFvwL8PeAfYR4UwlXFN32tdJ7lhCKUc=;
        b=oIt90HM9wdYF0k4yZWHypqt9GNjDdv6mnZp4Yjbsh119U6HlTDnmZZ2yuipNFzNgq9
         1eLQjYGhaAVu9CxmIQx/Sxt31VdB68ltRzrdwFOcp7iLjOsEU39RVyq5LWTjPxgdW2Mq
         37DgqmTAAE7MbDIeKwodH8q1vUCoSyGcm8WIYB0+w5VOq8RgU6SZhhUaCYDuUmfAqmTL
         fWM8Eiu9+TaYsT+LmoJguNiXglcfSrenBeUbD2auTjDIFr9QGVWnqyYzSXWkQm+keX22
         4YTiSdUKeHezBrQuPfQmIAiSkOoZIXiS8mEUBUrlbutSQ48GzuI6j54nTa9iwwaJsaWq
         EIvw==
X-Gm-Message-State: AOJu0YzRSL0pQnXqMzAFR4bKCLgV7+KAlrP+2zYnigCsBfxa5nWy3Cu5
	JMdMVoYg7dWP6hNWjeqdr32H4XltHsbKnjWcr9sxm1TKmt1w2kct0Xew1VVMW3MJFAA=
X-Gm-Gg: Acq92OF3CdoT5835yO21e+BsrJk91kEF7cL47kRuzf90MttL0Wht9zVz6yD2S8z8KCu
	MvsvB+DbC6k/PM27RwzGFqQDSVj5Q+G1Tizh5KhABXHkeTh5rqIOqRIO5fHo3tiWI79Jaq1+hN6
	QtsEH9kl32MJRLmHgCpFYj6gMBn10qngI5/5ro01k+Vdpw8MygeRNoMBY3Zp+74TBruE9izTobe
	C7vLNjwFGLA+zYrsmU87V3IPY1YaKVw7rbCHU+JDgQRNIjnJGHUuKAaFCWkxhFrkz+rvS/QQLNb
	+e/Xcrxo6u3I6rCkgwDuG1B0kEF9wrRcvHfnbLnB5H3PwwRJjZgCNpBNyj8xcjO3J0jpxHVbRec
	YIT55htUTymAFpt+HiFs9Nge2FQX0VHNZT3xYTQnJ+q4sHwXLps+EuC1QTfygBVuZZ01M0r5SAN
	5cotKhBspcFGnQFPTU5vVy3fQdCEGH71s97Txwj5/6xdtYUWDYBaLxtg==
X-Received: by 2002:a05:6a00:2449:b0:842:38d2:a358 with SMTP id
 d2e1a72fcca58-842b0e3c6c8mr10985327b3a.26.1780800994554;
        Sat, 06 Jun 2026 19:56:34 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:967f:7ce4:ec98:f08b])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282918b8csm13034210b3a.57.2026.06.06.19.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 19:56:34 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] ALSA: ymfpci: check S/PDIF control allocations
Date: Sun,  7 Jun 2026 10:56:13 +0800
Message-ID: <20260607025613.3604194-9-ruoyuw560@gmail.com>
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
Message-ID-Hash: 2L3XN22LHLGZDFAE7M6XREIT666BHYZQ
X-Message-ID-Hash: 2L3XN22LHLGZDFAE7M6XREIT666BHYZQ
X-Mailman-Approved-At: Sun, 07 Jun 2026 17:46:24 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2L3XN22LHLGZDFAE7M6XREIT666BHYZQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

snd_ymfpci_mixer() creates S/PDIF controls and then sets kctl->id.device
before adding each control. snd_ctl_new1() can return NULL on allocation
failure, and snd_ctl_add() cannot protect these earlier id writes.

Check the control allocation results before using them.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 sound/pci/ymfpci/ymfpci_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index b9a09568afc9e..2ccb976e68e0b 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -1781,16 +1781,22 @@ int snd_ymfpci_mixer(struct snd_ymfpci *chip, int rear_switch)
 	if (snd_BUG_ON(!chip->pcm_spdif))
 		return -ENXIO;
 	kctl = snd_ctl_new1(&snd_ymfpci_spdif_default, chip);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = chip->pcm_spdif->device;
 	err = snd_ctl_add(chip->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_ymfpci_spdif_mask, chip);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = chip->pcm_spdif->device;
 	err = snd_ctl_add(chip->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_ymfpci_spdif_stream, chip);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = chip->pcm_spdif->device;
 	err = snd_ctl_add(chip->card, kctl);
 	if (err < 0)
-- 
2.34.1

