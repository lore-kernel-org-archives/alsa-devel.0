Return-Path: <SRS0=kM0A=OA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7A2C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Sep 2021 09:49:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A394061186
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Sep 2021 09:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A394061186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C341F1687;
	Fri, 10 Sep 2021 11:49:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C341F1687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631267392;
	bh=H7ci8eJbQzLGB1SHk3Ya/0ChyWTkyhne4JqjzBoP0kI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GNsNkx7eT5B9abRBmzF4H0ir4WEIqPbWWPMKhdrJKi7shROnV76vMJ3kRHV9/zE+x
	 +mbQq68jKKIhB1/VsqZZyeSgPDSMAJlellv/0hTZgzecW7x5BptTxjyL2BL1atn9kq
	 qAgizy29xaZPcE/QJD0MYxDTJGXo4kPby9O8D+S4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48EAFF80143;
	Fri, 10 Sep 2021 11:49:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 756DCF802E7; Fri, 10 Sep 2021 11:49:01 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97ACEF80143
 for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2021 11:48:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97ACEF80143
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.b="IWXUQcgg"; 
 dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.b="7V3YOok7"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1631267333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Rz3tGDgPBAXnGujrHD1zuoc/hzbCNasdjn/vbgjqVZc=;
 b=IWXUQcggOUvVlNYQ0ipUwpR1IMWcLIw4NGD7l4EaZ0tn81gv+bURr4N24isCgrmgb9esQu
 I5NgeP7u3R1Ds9R5XEjF0c0jA9IYATnKHVOBNsvsqHopgiDXNmPlB91p8Fp70VDRLKm339
 r8RK0SkrFUO5pTRrTC3WPAMyqAoPdOKpUiVrFhXXz5K4pzpJIFIPPqx5qWC/A3UO5EuMjD
 m0mfgqv5g+MtonTiWI8GoIXHQZ2DSKTlOqRXTcvaGTaNuJRwIvwpeCO2oAe13/ycF2IfW/
 vpKApnmcNtTGdqoH8D6RiaIRnw5RGNfG4tyEVnz+e0WXS4zenc/0BBslRSabCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1631267333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Rz3tGDgPBAXnGujrHD1zuoc/hzbCNasdjn/vbgjqVZc=;
 b=7V3YOok7yjsuyehPZ0LQi0YSZQnk8m5JfR/bGiu7fRG7aaCgmLkjnV+AQABPdnQCm3O7by
 asB7vC1BL143otBw==
To: alsa-devel@alsa-project.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoC: mediatek: mt8195: Remove unsued irqs_lock.
Date: Fri, 10 Sep 2021 11:48:47 +0200
Message-Id: <20210910094847.3430413-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

irqs_lock is not used, never was.

Remove irqs_lock.

Fixes: 283b612429a27 ("ASoC: mediatek: implement mediatek common structure")
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 sound/soc/mediatek/common/mtk-afe-fe-dai.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.c b/sound/soc/mediate=
k/common/mtk-afe-fe-dai.c
index baaa5881b1d48..0c2482b7ce584 100644
--- a/sound/soc/mediatek/common/mtk-afe-fe-dai.c
+++ b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
@@ -288,7 +288,6 @@ const struct snd_soc_dai_ops mtk_afe_fe_ops =3D {
 };
 EXPORT_SYMBOL_GPL(mtk_afe_fe_ops);
=20
-static DEFINE_MUTEX(irqs_lock);
 int mtk_dynamic_irq_acquire(struct mtk_base_afe *afe)
 {
 	int i;
--=20
2.33.0

