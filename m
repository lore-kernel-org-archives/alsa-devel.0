Return-Path: <SRS0=LSvA=IB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72431C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 02:03:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B467D64E6F
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 02:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B467D64E6F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E173C1AD4;
	Wed,  3 Mar 2021 03:02:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E173C1AD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614736977;
	bh=2nd2d5hM2DO3RGuAIIBN9rq8zuIByPs1M+pVJSXnx50=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ekxlwujOjLfMC0a0m5X/W2i/9+GFSa8Ar3OLn4jfcyNWRV9cEGmt9LB8H/IopKmPq
	 ztcSd35T4n68M6W4ZUK+tZr7FPYH0wlfd6h9J9eeY2Er4EJmSkpCDnHF7S5y8klw1m
	 VcSUSAOhyiNkCqvqFjvhmjhRn8hvh7jzOLdFleoM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66176F8025B;
	Wed,  3 Mar 2021 03:02:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4461F80269; Wed,  3 Mar 2021 03:02:06 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1C67DF8012D
 for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2021 03:01:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C67DF8012D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1614736919620125055-webhooks-bot@alsa-project.org>
References: <1614736919620125055-webhooks-bot@alsa-project.org>
Subject: Fiio M3K: Failed to find a working profile
Message-Id: <20210303020206.B4461F80269@alsa1.perex.cz>
Date: Wed,  3 Mar 2021 03:02:06 +0100 (CET)
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

alsa-project/alsa-lib issue #123 was edited from x1unix:

Hello, I have a [Fiio M3K](https://fiio.com/m3k) player which I often use as an external USB DAC.

It worked well with Pipewire, but I had some other issues with Pipewire so I had to rollback to PulseAudio.
Unfortunately, PulseAudio and module-alsa-card cannot setup this device, so it doesn't work.

Here is a small portion of PulseAudio log (full log is available at link below):

```
E: [pulseaudio] module-alsa-card.c: Failed to find a working profile.
E: [pulseaudio] module.c: Failed to load module "module-alsa-card" (argument: "device_id="2" name="usb-GuangZhou_FiiO_Electronics_Technology_Co.__Ltd._FiiO_M3K_FiiO_M3K-00" card_name="alsa_card.usb-GuangZhou_FiiO_Electronics_Technology_Co.__Ltd._FiiO_M3K_FiiO_M3K-00" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes avoid_resampling=no card_properties="module-udev-detect.discovered=1""): initialization failed.
I: [pulseaudio] module-udev-detect.c: Card /devices/pci0000:00/0000:00:08.1/0000:0b:00.3/usb5/5-1/5-1:1.0/sound/card2 (alsa_card.usb-GuangZhou_FiiO_Electronics_Technology_Co.__Ltd._FiiO_M3K_FiiO_M3K-00) failed to load module.
D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC2 is accessible: yes
D: [pulseaudio] module-udev-detect.c: /devices/pci0000:00/0000:00:08.1/0000:0b:00.3/usb5/5-1/5-1:1.0/sound/card2 is busy: no
```

I'm using ArchLinux and Linux 5.11.2 and PulseAudio 14.2.

**Logs and debug info**

aplay, pulseaudio debug log and other info I've posted as gist:
https://gist.github.com/x1unix/dae3fb810ac499cc63362a805220968f

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/123
Repository URL: https://github.com/alsa-project/alsa-lib
