Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3177C5AD49
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Jun 2025 09:59:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2862C601E8;
	Tue,  3 Jun 2025 11:59:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2862C601E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1748944754;
	bh=SbBPd3Zp0xHdxcz5k84/xEX8B9ybcIJNAfbwizULgyY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=j8zncmsKNqrPTDR20aeSaM/8XALvkgB1PDeYP0uwqChuFWixEn6/GkuwVyUKrEfzZ
	 diAtVQDMqgFrhH3c4la8mwqo2Cebhx3eVOAlcenpPwmX/EB+wciQPIaIBs8RyGfSkY
	 SPnRIFtnX8g0V+Y2RGyr4bTgKTs8xNRUGupq3TnY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2AE4EF805C3; Tue,  3 Jun 2025 11:58:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EFCF8F805BD;
	Tue,  3 Jun 2025 11:58:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1266CF80424; Tue,  3 Jun 2025 11:58:37 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 555E1F8026D
	for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2025 11:58:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 555E1F8026D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18457ff3ab2fc100-webhooks-bot@alsa-project.org>
In-Reply-To: <18457ff3ab28c900-webhooks-bot@alsa-project.org>
References: <18457ff3ab28c900-webhooks-bot@alsa-project.org>
Subject: How to know how much audio has been played?
Date: Tue,  3 Jun 2025 11:58:37 +0200 (CEST)
Message-ID-Hash: Q3TH7ZA3ELIAC3AF4YDKFBSIZSGHE3ME
X-Message-ID-Hash: Q3TH7ZA3ELIAC3AF4YDKFBSIZSGHE3ME
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q3TH7ZA3ELIAC3AF4YDKFBSIZSGHE3ME/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #458 was opened from yangyagami:

I tried to get an answer from AI, but the result has discrepancies.
```cpp
#include <stdio.h>

#include <iostream>
#include <cmath>
#include <thread>

#include <alsa/asoundlib.h>

#define SAMPLE_RATE 44100
#define FREQUENCY 440.0 // A4 note
#define DURATION 5.0    // seconds

using namespace std::chrono_literals;

int main() {
    snd_pcm_t *handle;
    snd_pcm_hw_params_t *params;
    unsigned int rate = SAMPLE_RATE;
    int dir;
    int pcm;

    pcm = snd_pcm_open(&handle, "default", SND_PCM_STREAM_PLAYBACK, 0);
    if (pcm < 0) {
        std::cerr << "Unable to open PCM device: " << snd_strerror(pcm) << std::endl;
        return 1;
    }

    snd_pcm_hw_params_alloca(&params);
    snd_pcm_hw_params_any(handle, params);

    snd_pcm_hw_params_set_access(handle, params, SND_PCM_ACCESS_RW_INTERLEAVED);
    snd_pcm_hw_params_set_format(handle, params, SND_PCM_FORMAT_S16_LE);
    snd_pcm_hw_params_set_rate_near(handle, params, &rate, &dir);
    snd_pcm_hw_params_set_channels(handle, params, 1);

    pcm = snd_pcm_hw_params(handle, params);
    if (pcm < 0) {
        std::cerr << "Unable to set HW parameters: " << snd_strerror(pcm) << std::endl;
        return 1;
    }

    int samples = static_cast<int>(DURATION * SAMPLE_RATE);
    int16_t *buffer = new int16_t[samples];

    for (int i = 0; i < samples; ++i) {
        buffer[i] = static_cast<int16_t>(32767 * sin(2 * M_PI * FREQUENCY * i / SAMPLE_RATE));
    }

    pcm = snd_pcm_writei(handle, buffer, samples);
    if (pcm < 0) {
        std::cerr << "Playback error: " << snd_strerror(pcm) << std::endl;
    }

    while (true) {
      snd_pcm_sframes_t delay;
      int rc = snd_pcm_delay(handle, &delay);
      if (rc == 0) {
        double played_sec = (samples - delay) / 44100.0f;
        printf("Played: %.2f sec\n", played_sec);
      } else {
        std::cerr << snd_strerror(rc) << std::endl;
        break;
      }
    }

    snd_pcm_drain(handle);

    delete[] buffer;
    snd_pcm_close(handle);

    return 0;
}

```

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/458
Repository URL: https://github.com/alsa-project/alsa-lib
