Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568C2C982DA
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2026 00:16:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D08A660208;
	Mon, 21 Sep 2026 02:16:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D08A660208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789949783;
	bh=xVTV/LN2pyrizshMmEuoS5KWaVeZob69tdyq5x7RVEg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=VgAh9lVI1iAyIJSKUF/i8ssAC1TKJYTRCyr96XON2TUckTuD8wHeLJWE1SxkmVtil
	 DVbALhg++ikPZOGZpa+NbqR3rjHrH07kTGN0CIa3fJcRfDQj3IYzU5i8ireuxMVb3W
	 o11JysdVXTlD+HU07e8nDHZb/BOPDeS1/uYnhDXA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0A253F80602; Mon, 21 Sep 2026 02:15:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BE42F80603;
	Mon, 21 Sep 2026 02:15:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9FD6CF804F3; Mon, 21 Sep 2026 02:15:42 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789949741;
	b=d03Kp/7i00S9HuRMF6WZfza63HR5n6twANPlKhI0tTwFblDbm4c0hg+vrp0XqPhofdyY
	 PGOCko57Kj4vZ6Xt2TcpsVQF+8FF/s2Y7Y5SCccWgJDoXeBLEmKPppX7xs4R2WvhpRZqp
	 6fBbGegyT2AYFwTu42naExas+rb2xXWTG0sKcl77O8doxjpStNpnMg3mPCkOFz43C/edk
	 41Ie43VrehtlRjHrInVaUvC8O8bKLmVls09KUcxXjgkchz2kkcBKCGyayb77T7p1sTleZ
	 cFPcyKuX3NMAhIarWGx3rIb/RgE0IateULX8dTB6P74ehkr8mC5sY1uk7fdGID0lMZA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789949741;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=xVTV/LN2pyrizshMmEuoS5KWaVeZob69tdyq5x7RVEg=;
	b=gvK0ot9SmLBcwTGbWpoUwj2Lnu3xxYBC5yxAyRJ8qs169bz7zkVhkc1IFkC3pJGOf9pM
	 xyyzqpWzvyd2yPO0YzowBcCFBWZ9gQM4HkTdDgdfXQfzQm3ouSA0u05ksYwULqEDtZa1d
	 BTPsTBXhXP25+6JENL+uVNKc+JN0h8wSA8gE6f93xu2sGYccV9raUZMw9cVG926wwaALV
	 YAin4MjQ4kIwNYaA2UXyYgta6Im+4isXjyZWB68pTS/aZ8EKrN7ZASKD8vjXlSxovGXxx
	 6vWalMbCPiJFgnKpVC8CI3DkmYG9nAIP3k/hxbZwbzZ5h+DGzWQ36Ge8MtB+KZoHHhA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 91A6EF800B0
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 02:15:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91A6EF800B0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d72dce2a50b600-webhooks-bot@alsa-project.org>
In-Reply-To: <18d72dce2a4a3b00-webhooks-bot@alsa-project.org>
References: <18d72dce2a4a3b00-webhooks-bot@alsa-project.org>
Subject: ALSA Pulse plugin returns -EIO from snd_pcm_avail_delay() in case of
 -PA_ERR_NODATA
Date: Mon, 21 Sep 2026 02:15:42 +0200 (CEST)
Message-ID-Hash: 75XBZT3MMNHF3NW6BWV72RC2LJFU7ZTT
X-Message-ID-Hash: 75XBZT3MMNHF3NW6BWV72RC2LJFU7ZTT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/75XBZT3MMNHF3NW6BWV72RC2LJFU7ZTT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-plugins issue #65 was edited from argothiel:

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

`snd_pcm_avail_delay()` should wait until PulseAudio timing information is available, then return the available-frame and delay values.

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/65
Repository URL: https://github.com/alsa-project/alsa-plugins
