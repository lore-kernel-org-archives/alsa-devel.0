Return-Path: <SRS0=NYZN=LL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBD9C49EA2
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 13:18:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A5E613BA
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 13:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A5E613BA
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EAF316FB;
	Thu, 17 Jun 2021 15:17:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EAF316FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623935893;
	bh=uO6FUItMW4c/U160iSRinJdYu9tYiRZiA0cpF8BL3eY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=peNDCbjNy321yV33MQHCUPgvChOBn2scstieLdZ5jLjButvpWqwJabAk+L7lJCeZz
	 ZoUOdMgH5pSpVfR1yOEG7kG4rzfI3L6evlMs8JJwfldh5C848f9O8Wq5C3ZAn10s/h
	 wTJzPvjah3tcRlkYoeIJvYpzDfRGEJw9zZ6T/VEs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E7285F8028B;
	Thu, 17 Jun 2021 15:17:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CFD3BF802A9; Thu, 17 Jun 2021 15:17:14 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 0C98FF8025E
 for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2021 15:17:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C98FF8025E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623935824550184011-webhooks-bot@alsa-project.org>
References: <1623935824550184011-webhooks-bot@alsa-project.org>
Subject: a52 plugin crashing pulseaudio
Message-Id: <20210617131714.CFD3BF802A9@alsa1.perex.cz>
Date: Thu, 17 Jun 2021 15:17:14 +0200 (CEST)
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

alsa-project/alsa-plugins issue #28 was edited from quequotion:

Ever since f11e7a8994111f971bc881d4069f768472452f4f, the recent commit that brings the a52 plugin up to speed with ffmpeg's requirement for s32le format sampling, sending any audio to plug:a52 from any pulseaudio client crashes pulseaudio.

I [posted this log](https://gist.github.com/quequotion/78972bac339f5249cf6b383519cdcedf) earlier in #23, in which audio from mpv crashes pulseaudio.

I have tried other clients since and they all crash the same way.

This is with a default pulseaudio configuration, as shipped in Archlinux, and the following `/etc/asound.conf`:

```
# Alsa Resampler
 defaults.pcm.rate_converter "speexrate_best"

# Use PulseAudio by default
pcm.!default {
  type pulse
  fallback "sysdefault"
  hint {
    show on
    description "Default ALSA Output (currently PulseAudio Sound Server)"
  }
}

ctl.!default {
  type pulse
  fallback "sysdefault"
}

defaults.namehint.showall on
defaults.namehint.extended on
```

To enable the use of plug:a52 in pulseaudio without configuring it manually, I select the "Digital Surround 5.1 (IEC958/AC3) Output" profile in `pavucontrol`.

Pulseaudio, as far as I know, is agnostic of how ALSA plugins work internally. This leads me to think there is something not getting done right in the new patchset, even if it is tolerable in an ALSA-only setup.

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/28
Repository URL: https://github.com/alsa-project/alsa-plugins
