Return-Path: <SRS0=Hs3e=4Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F21C10F25
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Mar 2020 03:15:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD422072C
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Mar 2020 03:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="U2bF/bEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD422072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=manjaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B2DD82A;
	Sun,  8 Mar 2020 04:14:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B2DD82A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583637321;
	bh=/lA45t3HMSrezZJ68hsPlWZYm7O9KJxLKmrYY5YaTF8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U2bF/bEmre470ah/V6jxp1qpXvMh1vd07GpyO6TAM1+LV84aKtK7hyQjAwZJYhvmB
	 TTloKEepQITkgFZkUMWpqjZTYdxZcnLFi+XvHhWyd79VzaoE4HuPwX9yKTqzBtzzGg
	 jZtTUPTSoQW06sKiM7wj1dnavM4Vpe3QOWBBjpzk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97615F80171;
	Sun,  8 Mar 2020 04:14:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6D9DF8020C; Sun,  8 Mar 2020 04:14:26 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [176.9.38.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 821A6F800B5
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2020 04:14:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 821A6F800B5
Received: from localhost (localhost [127.0.0.1])
 by mail.manjaro.org (Postfix) with ESMTP id 8509C3960EFB;
 Sun,  8 Mar 2020 04:14:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
 by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D4ahqBaiLqYL; Sun,  8 Mar 2020 04:14:18 +0100 (CET)
From: Tobias Schramm <t.schramm@manjaro.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [RFC PATCH 0/1] Use native gpiolib inversion for jack gpios
Date: Sun,  8 Mar 2020 04:13:54 +0100
Message-Id: <20200308031355.1149173-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Tobias Schramm <t.schramm@manjaro.org>, linux-kernel@vger.kernel.org
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

This patch changes the logic used for jack gpio state inversion to
utilize gpiolib inversion.

Previously the gpio active state would not correspond to the plugged-in
state of the jack. Since the active state of a gpio is usually defined by
its purpose in a specific application I'd expect the active state to
represent the jacks plug status.

However, judging by the users [1], [2] of snd_soc_jack_add_gpiods the
ACPI tables of some devices seem to indicate the "wrong" polarity for
their jack detect gpios.
I'm not entirely sure how to deal with those devices. At the moment I'd
vote for inverting the gpio active level again
(via gpiod_toggle_active_low) inside snd_soc_jack_add_gpios if
gpio->gpiod_dev != NULL and gpio->invert is set.

I'm not entirely sure about [3] either. In my opinion removing invert = 1
from ams_delta_hook_switch_gpios and adding GPIO_ACTIVE_LOW to the flags
of hook_switch in [4] would be the right move here.

What are your thoughts on this?


Best regards,

Tobias

[1] /sound/soc/intel/boards/byt-max98090.c
[2] /sound/soc/intel/boards/cht_bsw_max98090_ti.c
[3] /sound/soc/ti/ams-delta.c
[4] /arch/arm/mach-omap1/board-ams-delta.c

Tobias Schramm (1):
  ASoC: jack: use gpiolib inversion flag for inverted gpios

 sound/soc/soc-jack.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.24.1

