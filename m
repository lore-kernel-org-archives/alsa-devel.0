Return-Path: <SRS0=jKKe=K3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D30C4708F
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 16:30:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4477E613BD
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 16:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4477E613BD
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B671816CE;
	Tue,  1 Jun 2021 18:29:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B671816CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622565012;
	bh=rWpSO39kyqGkFf1xSyKf7Jf/LI+4GqQBI7c46VHu/ME=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MDFHQC8TPEZ7byNT+8n1+ZrKqWS0GK0jWe7q/k+ZqjHbDSVv2mABxG5iryLaoTMEh
	 gdIRvwSMyzC22SxFutBLc/4LxvvCwyzeqivGQzMdYKHlmu+UaavxRSjJvBNV/JuR6a
	 Z6/MNMM7yk4PZXrz+QSY0OdK2jUTHiWEGa3FKcP4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 606B1F80141;
	Tue,  1 Jun 2021 18:29:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ABBF6F800B2; Tue,  1 Jun 2021 18:29:15 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 4EA2EF800B2
 for <alsa-devel@alsa-project.org>; Tue,  1 Jun 2021 18:29:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4EA2EF800B2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1622564952660048008-webhooks-bot@alsa-project.org>
References: <1622564952660048008-webhooks-bot@alsa-project.org>
Subject: Incomplete sound device detection in PulseAudio with alsa-lib 1.2.5
Message-Id: <20210601162916.ABBF6F800B2@alsa1.perex.cz>
Date: Tue,  1 Jun 2021 18:29:15 +0200 (CEST)
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

alsa-project/alsa-lib issue #143 was opened from foutrelis:

(Copying my comments over from #142 since it appears to be a different issue to that one. Sorry for the noise there!)

After upgrading to alsa-lib 1.2.5 Chromium stopped playing audio until pulseaudio was restarted. Upon closer inspection, `pactl list cards` is now missing the `HDA Intel HDMI` card and only shows the `HDA Intel PCH` one.

Some error messages I've gathered:

- After upgrading to alsa-lib and before restarting pulseaudio, attempting to play a video in Chromium would result in:
  `pulseaudio[625]: Error opening PCM device front:0: Invalid argument`

- Restarting pulseaudio with alsa-lib 1.2.5 installed logs the following to the journal:
  ```
  pulseaudio[66345]: Failed to find a working profile.
  pulseaudio[66345]: Failed to load module "module-alsa-card" (argument: "device_id="1" name="pci-0000_00_03.0"
  card_name="alsa_card.pci-0000_00_03.0" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no
  deferred_volume=yes use_ucm=yes avoid_resampling=no card_properties="module-udev-detect.discovered=1""):
  initialization failed.
  ```

Git bisect points to commit 63f7745be504e447923f2cde421177a2fca99340 as the first commit that results in the `Failed to find a working profile` error.

After restarting pulseaudio with alsa-lib 1.2.5 installed, it appears that `pactl list cards` shows one fewer cards on my laptop which has this audio hardware:

```
$ lspci | grep Audio
00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio Controller (rev 0b)
00:1b.0 Audio device: Intel Corporation 8 Series HD Audio Controller (rev 04)
```

[alsa-lib-1.2.4-pactl-list-cards.txt](https://github.com/alsa-project/alsa-lib/files/6575475/alsa-lib-1.2.4-pactl-list-cards.txt)
[alsa-lib-1.2.5-pactl-list-cards.txt](https://github.com/alsa-project/alsa-lib/files/6575476/alsa-lib-1.2.5-pactl-list-cards.txt)

`pulseaudio -v` output:

[pulseaudio-verbose.txt](https://github.com/alsa-project/alsa-lib/files/6577650/pulseaudio-verbose.txt)

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/143
Repository URL: https://github.com/alsa-project/alsa-lib
