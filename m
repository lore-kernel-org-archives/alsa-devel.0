Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA1ECA9EA0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:36:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B93852086D
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="l1cxaP2o";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faXS+qqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93852086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F2D7A1AEA;
	Mon, 28 Oct 2019 08:35:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F2D7A1AEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572248198;
	bh=iPXiusf6N4CvgBZVlbEcgxX67asE4K5+HrjWpYn0vKg=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=l1cxaP2oueosPwvymR/4Ii6j7+PoGgxX/fKKznE+jYcJbFiIrsDB8Ms8A6knaR+RT
	 l/rNFs0s/ivmpoOgVDVyADV45hYwYSJoNWeE4Rra+4BHELC7myvrvAVVz9c6Yp/7Zj
	 uFFv8JnhgtzqOxeNBECQ1ryCnWSoq7fB9P8cSVXQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 959D1F8060E;
	Mon, 28 Oct 2019 08:33:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A376BF80392; Sun, 27 Oct 2019 20:24:40 +0100 (CET)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EECF7F80228
 for <alsa-devel@alsa-project.org>; Sun, 27 Oct 2019 20:24:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EECF7F80228
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="faXS+qqe"
Received: by mail-io1-xd42.google.com with SMTP id w12so8031295iol.11
 for <alsa-devel@alsa-project.org>; Sun, 27 Oct 2019 12:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=4ofksQ7AcOmTu9H2NgEjkUZ7Z46uH3mw4srj1dXfSSs=;
 b=faXS+qqeDe638CZeqsshIVZhWuSZTrK2yiAsn9fDoQ0Q/sibPkrm78pc6vUC6HQgAU
 LNDbTOCIpw4BdC3vKaP3/3iwt55G0iAge2g2TFSSpPTdZqxe3y4XSPSjcsupx3teh+XV
 Do0nMYDHXPXh2NXH3JMUEatk0KuRo7RHCs7sQZJDBss7aNFDB1FGMbeOP9+TR5GWwOlA
 O4FnvjHrc3mmAkeKVCZWjQ1m0roQQ4kAT4MSSFWGKo6GPKbFVR0szViTvNDzpbBf63ll
 Ey6VYZg8t+/MI7WNUerX2acpc6tx6yI7EFhECU788PS4Ajed+2OIY/TW/8U2jpo8AZmb
 6hJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=4ofksQ7AcOmTu9H2NgEjkUZ7Z46uH3mw4srj1dXfSSs=;
 b=OVAXK2awvHcZzduJG0VHmrkTUifyCl+e6eXfI0EGT18LcqcLY9Ms951nD7ilN+qFr3
 omHwP7rwsWHCNjlkreEXU9mhlN0UY+iUDGTpBwLPb0LR+pLtgkzXjGghayjmFkugnzMm
 o+9vfFMfjrDitzqb5/bQckROdJP8oEIo7sCniaLF+J8N6RBATGfjEFEuwdAeucn+SzTz
 KIeZ3MBc9NFrZsZTf6lZJu6/ArEXhunAtrMCOi7O87j1BscTaOuc8+LkowBxCVnxOsfw
 +SRL6wxuJOyEDEcDPUHNNRudAIk0+a7jUjXdvLM0dAX1V7Ogqutx8/+6OBUedMKt74yl
 KQ+Q==
X-Gm-Message-State: APjAAAXjYg7WBM/A3y5YQH5m/i4TMd4uiSUPyvcsfalQTKatkRTmdyj4
 FkTDqbdlCE1TCgSxDZ0Pxao=
X-Google-Smtp-Source: APXvYqzzOQqltc5n2sD1ambBu/V7rbpCeqXdQqBw8B8OavUNbezXePdT4X4kwQUm7qT5h6NQbGglHw==
X-Received: by 2002:a6b:7942:: with SMTP id j2mr14638510iop.161.1572204271276; 
 Sun, 27 Oct 2019 12:24:31 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
 by smtp.googlemail.com with ESMTPSA id a6sm1212642ill.87.2019.10.27.12.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2019 12:24:30 -0700 (PDT)
From: Navid Emamdoost <navid.emamdoost@gmail.com>
To: 
Date: Sun, 27 Oct 2019 14:24:13 -0500
Message-Id: <20191027192415.32743-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Mon, 28 Oct 2019 08:33:18 +0100
Cc: Hariprasad Kelam <hariprasad.kelam@gmail.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, kjlu@umn.edu, Takashi Iwai <tiwai@suse.com>,
 emamd001@umn.edu, smccaman@umn.edu, Tim Blechmann <tim@klingt.org>,
 Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>,
 Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [alsa-devel] [PATCH] ALSA: lx6464es: Fix memory leaks in
	snd_lx6464es_create
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

In the implementation of snd_lx6464es_create() it there are memory leaks
when error happens. Go to error path if any of these calls fail:
lx_init_dsp(), lx_pcm_create(), lx_proc_create(), snd_ctl_add().

Fixes: 02bec4904508 ("ALSA: lx6464es - driver for the digigram lx6464es interface")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 sound/pci/lx6464es/lx6464es.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index fe10714380f2..7c6e8f4ef826 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -1020,25 +1020,26 @@ static int snd_lx6464es_create(struct snd_card *card,
 	err = lx_init_dsp(chip);
 	if (err < 0) {
 		dev_err(card->dev, "error during DSP initialization\n");
-		return err;
+		goto cleanup;
 	}
 
 	err = lx_pcm_create(chip);
 	if (err < 0)
-		return err;
+		goto cleanup;
 
 	err = lx_proc_create(card, chip);
 	if (err < 0)
-		return err;
+		goto cleanup;
 
 	err = snd_ctl_add(card, snd_ctl_new1(&lx_control_playback_switch,
 					     chip));
 	if (err < 0)
-		return err;
+		goto cleanup;
 
 	*rchip = chip;
 	return 0;
 
+cleanup:
 device_new_failed:
 	free_irq(pci->irq, chip);
 
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
