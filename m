Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA78C982D8
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2026 00:21:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09EB260211;
	Mon, 21 Sep 2026 02:21:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09EB260211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789950097;
	bh=v9o3fTt3s/VvDJDW7EHWa0T63zRbH0AWRtVaxdiwYlM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=d/eBvGNUD5Ogv5ZdVAqHttrj+fhJWk5yh/tk5G28nF1IQ5IunFWsf/dCHZ81pugiW
	 UJdFu+o077IeoKJs/ciqwmUkbADBuSlmFLo8vbxT5lmfscL18MGSU+daHjL83hxnZu
	 XpHZN3Fr/XO3Tot0fgHtHHZeVy0DlSI/rPrUxA48=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12518F805FE; Mon, 21 Sep 2026 02:21:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B201EF805F7;
	Mon, 21 Sep 2026 02:21:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D3CBF804F3; Mon, 21 Sep 2026 02:20:55 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789950054;
	b=A7fw0A3tQLj5+zcG3cwaR9QX7wBWRbExE7F6A9Jl+PQrpHfcx9Yat2u2HjTLh+T1vn7V
	 igg1s30SAaCR/JJ0BJzwPb7zvbkrUc+dPxVQ+nZwRMQCZojIhL21ffbE8rcHN/c5nHzIM
	 UDlxhutIu1EyQyN1hrz6YEILQ9dDfeOlB06Qgy26dbkl8gqfzImHgg1ErIdJo6fPOBq1d
	 LPSyOditslNq0mem+vPpfuT7+UIQ3KaySCkPig80oNDYi0MYCDdBZbM0jCU0Y8zquoY5H
	 AgYjgkXkzWIW7UUEmw4ZKXnfMuclIH9Hm9NTHlCrjgEQcYh93DK5l+5ri6kxVYMby/A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789950054;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=v9o3fTt3s/VvDJDW7EHWa0T63zRbH0AWRtVaxdiwYlM=;
	b=TuODqO6hZ/qUK72f3bbYz4tuIfn2DHCpfWMa2SDFeKvD/lMTHTUAGQ2tZjWCwsOGS4lk
	 rJ/qVIfUELeqPjDcI1tL6d4X5vF2oTwMpOCQM1b7ptMgfEOndunCoZVRGyX+gZxPWkyw9
	 Tl31ghbQGeXuGMh4787Tg8HIwuf7jhMnPhAZSBrDRjA6cTyWh68mEKiFOOZLwR3wtc/jy
	 h/z5lSNqLWEj95+WxtodV2Z87dsDdR4jkea0oYPN5/DAE8Mu3vqajo5qkNl3ZNe+T3Zud
	 2lVbJ/361weQL0eDfiB/a90YzHTbm0KnXNXgBgGSgk4a1168q5A1431gh5DCg/lEyoQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EBECF800B0
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 02:20:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0EBECF800B0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d72e16c75cd900-webhooks-bot@alsa-project.org>
In-Reply-To: <18d72e16c7535000-webhooks-bot@alsa-project.org>
References: <18d72e16c7535000-webhooks-bot@alsa-project.org>
Subject: ALSA Pulse plugin returns -EIO from snd_pcm_avail_delay() in case of
 -PA_ERR_NODATA
Date: Mon, 21 Sep 2026 02:20:55 +0200 (CEST)
Message-ID-Hash: V56FEJLTQ7MIS7U7A77TUL32YUDOH5WS
X-Message-ID-Hash: V56FEJLTQ7MIS7U7A77TUL32YUDOH5WS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V56FEJLTQ7MIS7U7A77TUL32YUDOH5WS/>
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
  https://github.com/pulseaudio/pulseaudio/blob/77d25a1e613095bdf87a1d13b65e7c330565077a/src/pulse/stream.h#L725-L726
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
