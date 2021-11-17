Return-Path: <SRS0=ac5z=QE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E42C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Nov 2021 10:07:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8747261BF4
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Nov 2021 10:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8747261BF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 304CA1778;
	Wed, 17 Nov 2021 11:06:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 304CA1778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637143626;
	bh=Z/3+1BWsl+p3M2N6ukUEdFMi/FQNsD4/tqHuUaA616U=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aoVBst9s6odu2ehjiArTzhXQ16cqXlYjXhs9CEh8K+nubgDX1OAavMijoSrEoig3h
	 T0vcnltUR9QcWPend/oRwLbwET53W6oOYc62V3KMXNelvrCFT/0/HQFn9849UColXv
	 6g5zTWBbahiFX4xCVX2HmeY59lNnFgAr6+OLXpBU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A04F4F80134;
	Wed, 17 Nov 2021 11:06:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C12FF8027D; Wed, 17 Nov 2021 11:06:14 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2363F80134
 for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2021 11:06:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2363F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="QsVzAHjv"
Received: by mail-yb1-xb2b.google.com with SMTP id e71so5801845ybh.10
 for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2021 02:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=Ae53HUdIl8LFz+bBsVHItIqLX490EPHb3zwvtgS/7Bw=;
 b=QsVzAHjv00Jmu6STYR6irh4zaeW8vZFKlBlyKnCGjQpXPHZr59Wvpp3g5LnOIzZDIL
 fT/drg/fbge7K2fK+W9W+0NnKTLIorrlWXn0hH1tgMAIXIEudNMT6jwlMdCm8w4yZ4XT
 cm/cLlPMGzsh+TidWmGT3SK0JFysCzIDlxtP0+QfA5KjKU4hJPsfPm2Gi/nNyyJsN7q/
 GV9ujcFxIpGewMW0eCJusPqBjOICGJ5Y+Pj/6dv/C4D0GlW3VFc79jwHcJTHeiyC+Rw1
 Wuy30Yi33T9XBxEitlsjrS1DYBADbwxxB726C073E1MQmyIEaHbESNS8OqzGcnvjDDut
 D0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=Ae53HUdIl8LFz+bBsVHItIqLX490EPHb3zwvtgS/7Bw=;
 b=CaZXXBvaYwW7Krld/aXA1ySHOxN8v1FSSnlCq/yIbUlbGsOlZek/sCx+3xPO9zE8TO
 yGdFHojEFqPjy0Y54Xk0q16sFd6pEK/DpvvZ5QiKTRDK4Mf/impxOPY1leaXYa3dP003
 aR2hr4hH4IFgcBiQeITsxrJTg3d8Ckrvu3canOQfKV7XTjaUX5VBeUp4yl5xl9M0JkS+
 PQ4Xp+ksZcxWv6e/x1W6Qy5j/1OVkUel+P35gJilRxqmAwixFNnDGjM71/isHAZbKSbT
 ie1i/8+sYijpXVLrPcev0wgZduEhnrjf+IN5whj1qk0vbrEdITSir+CKCoXRpvK1RZD4
 5xbw==
X-Gm-Message-State: AOAM531LbwY8S8CAmSuLIlVjukbzh6BaEmckf3Ft9ukahsDp2RuoVtnq
 4KbJA3ao3FjLOuew+wFxuIUC9Cbx/ZX995Q642Q=
X-Google-Smtp-Source: ABdhPJzU1BgAUSR7puZxQLDS+Mr79o55Z4vi4pUEiUI2aegBc0O9017bjF5iDE9lWxfrX9RSWbDJoldTysHQCHYYZGs=
X-Received: by 2002:a25:e016:: with SMTP id x22mr15764494ybg.534.1637143564337; 
 Wed, 17 Nov 2021 02:06:04 -0800 (PST)
MIME-Version: 1.0
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Wed, 17 Nov 2021 11:05:53 +0100
Message-ID: <CAKXUXMzqgyNGEnxAMQqZiXJYSK-X8uB-nxHWwPg41H6yS0GWNg@mail.gmail.com>
Subject: Reference to the non-existing kconfig symbol SND_SOC_AC97_BUS_NEW
To: Robert Jarzmik <robert.jarzmik@free.fr>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org,
 kernel-janitors <kernel-janitors@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Dear Robert,

In commit 1c8bc7b3de5e ("ASoC: pxa: switch to new ac97 bus support"),
you changed the select in config SND_PXA2XX_SOC_AC97 from
SND_SOC_AC97_BUS to the non-existing symbol SND_SOC_AC97_BUS_NEW.

Hence, since then, ./scripts/checkkconfigsymbols.py is reporting this
invalid reference:

  SND_SOC_AC97_BUS_NEW
  Referencing files: sound/soc/pxa/Kconfig

Robert, it seems that you were already informed in the past and
already acknowledged that some work is required to fix this in this
email response:
https://lore.kernel.org/all/878skf1zmp.fsf@belgarion.home/

As of next-20211117, this issue is still unaddressed, though. Are you
going to address this issue? Is this patch just pending somewhere?

Best regards,

Lukas
