Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57E2C982D8
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2026 00:09:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 032A160206;
	Mon, 21 Sep 2026 02:09:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 032A160206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789949359;
	bh=3p56J5X83Xotbr3WbbYwWTA1zMrGH20fGRTcvQzf7fo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=b5KE3tT5emw7ID0qzOzhLkjPc97Dio6MNHBoFJaXNpTWnGPHC2zrSxOX7m8sVDPdc
	 Tt7NTDGTZSNFdPkJ1N0l28005CxE3wFH8MJUoVQ6Wa6Hf5V3rJFKHyCdTXTiockjBC
	 niDOTPrdXqUUaJJLSAmPVwKbMScK0s3rJhzO8MYk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8FDCDF80600; Mon, 21 Sep 2026 02:08:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E918F80602;
	Mon, 21 Sep 2026 02:08:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7627BF804F3; Mon, 21 Sep 2026 02:08:36 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789949315;
	b=XSv9oMwrna5GSugbbr6r63L78kA0R4L+2dV644BlvMHi9PuZ3LZnOYFV5WHsRyttVQJH
	 L/6uwnwb7fG+RAiknfUpBammK0YRZTesYp+AAGuN2y9E60nUGIxrYTT5bFa1PO9JaUR6n
	 YB+GVe6S2rTeunIeOw3OpqHGOOV3iqINYiQhtFNa45HwfZf/z/SkIlJ4PgbCJgs8g9T6A
	 bNIeGUfBPV5rwtVvwmIyy64xbu4ZrBKs9t9JitfkOz82WiTIcDOd2x2JQmvjA5xyPFrsN
	 2S3fcUzU0GrA8OdTe9r6WlhlRmyGbQ92HY1LJw6RGRy615OwGXbJGK3Ijbdr7CMcaOQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789949315;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=3p56J5X83Xotbr3WbbYwWTA1zMrGH20fGRTcvQzf7fo=;
	b=sRX/WeKCRS0M7C/oZwFUn7b07GLZpLVhrwbS19D2fjP7rzVycAhKbtr9DtocUEHklZOH
	 HzKSl3MRLyj6IpuU1gYgQtSzVKhiel95a0BF35B+3w2XW2YdEwOGKYVLFA7W5l8kCQmiM
	 RPGaIGmZUXEtTROEk5u5WZfiR7hgf+tic93OQ0z5KKQVmg5hsu13GvjlQHDn6IB6SivmR
	 SUSSwJ0355FhF3mjZe29bZ4LKgGltYGAusCBnGoiObfwWYGS1VP8fCY41WJgIjjtK9VX+
	 ToMc7iP15ZGFwoGJtC6ZneUzl516BNLcrB9k3h41u6piXRGagV+obVtEeMtXu5fhjDQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 58DF8F800FA
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 02:08:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58DF8F800FA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d72d6ada29e700-webhooks-bot@alsa-project.org>
In-Reply-To: <18d72d6ada085a00-webhooks-bot@alsa-project.org>
References: <18d72d6ada085a00-webhooks-bot@alsa-project.org>
Subject: ALSA Pulse plugin returns -EIO from snd_pcm_avail_delay() in case of
 -PA_ERR_NODATA
Date: Mon, 21 Sep 2026 02:08:36 +0200 (CEST)
Message-ID-Hash: VXBPXDSRHBNCW3O2JPFTHJZBGFBXKT7K
X-Message-ID-Hash: VXBPXDSRHBNCW3O2JPFTHJZBGFBXKT7K
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VXBPXDSRHBNCW3O2JPFTHJZBGFBXKT7K/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-plugins issue #65 was opened from argothiel:

### Environment

- Ubuntu 26.04 under WSL2 / WSLg
- `libasound2-plugins` 1.2.12-2build1
- PulseAudio server available through WSLg

### Problem

Immediately after configuring a playback PCM opened through the ALSA `pulse` plugin, `snd_pcm_avail_delay()` returns `-EIO`. This seems to be an issue with `pulse_delay()` which calls `pa_stream_get_latency()`. PulseAudio documents that this function returns `-PA_ERR_NODATA` when timing information is not available yet. The ALSA Pulse plugin compares the result against positive `PA_ERR_NODATA`; it therefore treats that temporary condition as an unrelated failure and returns `-EIO`:
- ALSA Pulse plugin comparison:
  https://github.com/alsa-project/alsa-plugins/blob/ffc8b900792b77764213bac6816ba60f2c8d8025/pulse/pcm_pulse.c#L397-L404
- PulseAudio `pa_stream_get_latency()` documentation:
  https://github.com/pulseaudio/pulseaudio/blob/77d25a1e613095bdf87a1d13b65e7c330565077a/src/pulse/stream.h#L721-L726
- The same issue has been fixed in the `shairport-sync` version:
  https://github.com/mikebrady/shairport-sync/pull/2119

### Reproducer

```c
#include <alsa/asoundlib.h>
#include <assert.h>
#include <stdio.h>

int main(void)
{
    snd_pcm_t *pcm;
    snd_pcm_sframes_t avail, delay;
    int err;

    err = snd_pcm_open(&pcm, "pulse", SND_PCM_STREAM_PLAYBACK, 0);
    assert(err == 0);

    err = snd_pcm_set_params(
        pcm,
        SND_PCM_FORMAT_FLOAT_LE,
        SND_PCM_ACCESS_RW_INTERLEAVED,
        2,
        48000,
        1,
        20000);
    assert(err == 0);

    err = snd_pcm_avail_delay(pcm, &avail, &delay);
    printf("snd_pcm_avail_delay: %s (%d)\n", snd_strerror(err), err);

    snd_pcm_close(pcm);
    return err < 0;
}
```

Build and run:
```sh
cc main.c -lasound && ./a.out
```

### Actual result

```sh
snd_pcm_avail_delay: Input/output error (-5)
```

### Expected result

`snd_pcm_avail_delay()` should return the available-frame and delay values, or a more specific recoverable error if latency information is temporarily unavailable.

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/65
Repository URL: https://github.com/alsa-project/alsa-plugins
