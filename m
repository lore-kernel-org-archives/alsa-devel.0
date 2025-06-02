Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA411C54FB3
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Jun 2025 11:21:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F088360183;
	Mon,  2 Jun 2025 13:21:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F088360183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1748863312;
	bh=C4KOnA8ZItmNmsNmJQrVI0Z4q0NN5OuZ6PQQ2yfsp4Q=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=LVHBHVw24pUYLCNIplubZYdGbnqJ1ncTkXSvB4nNRME408bM1cAtnmOfd6HkvGAhe
	 GSDvrXTJOA38tcPpTI0+pp133eIe5ozssWEYoppJVmuFyiwfgelnwAhE6AWsg4WsW2
	 KFpp2qXB3JM7aGKOq8WEueSrJJiRC3qSfUJ253KA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 52024F805C1; Mon,  2 Jun 2025 13:21:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4577EF805BE;
	Mon,  2 Jun 2025 13:21:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B13ECF80533; Mon,  2 Jun 2025 13:21:13 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B9B3F800F8
	for <alsa-devel@alsa-project.org>; Mon,  2 Jun 2025 13:21:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B9B3F800F8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <184535e12c94bf00-webhooks-bot@alsa-project.org>
In-Reply-To: <184535e12c8de800-webhooks-bot@alsa-project.org>
References: <184535e12c8de800-webhooks-bot@alsa-project.org>
Subject: snd_pcm_drain stucked.
Date: Mon,  2 Jun 2025 13:21:13 +0200 (CEST)
Message-ID-Hash: 3SA3LAU2JVC4ZFJ57Z2CX26PMWSW2WIL
X-Message-ID-Hash: 3SA3LAU2JVC4ZFJ57Z2CX26PMWSW2WIL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3SA3LAU2JVC4ZFJ57Z2CX26PMWSW2WIL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #457 was opened from yangyagami:

When snd_pcm_drain is called, if snd_pcm_drop is called in another thread, snd_pcm_drain will get stuck.
```cpp
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

    std::thread t([handle](){
      std::this_thread::sleep_for(500ms);
      snd_pcm_drop(handle);
    });

    snd_pcm_drain(handle);

    t.join();

    delete[] buffer;
    snd_pcm_close(handle);

    return 0;
}
```

gdb output
```shell
Thread 1 "main" received signal SIGINT, Interrupt.
0x00007ffff71b5e22 in ?? () from /usr/lib/libc.so.6
(gdb) bt
#0  0x00007ffff71b5e22 in ?? () from /usr/lib/libc.so.6
#1  0x00007ffff71a9fda in ?? () from /usr/lib/libc.so.6
#2  0x00007ffff71aa64c in ?? () from /usr/lib/libc.so.6
#3  0x00007ffff71acd1e in pthread_cond_wait () from /usr/lib/libc.so.6
#4  0x00007ffff6b9e2b9 in pw_thread_loop_wait () from /usr/lib/libpipewire-0.3.so.0
#5  0x00007ffff7f2ec8f in ?? () from /usr/lib/alsa-lib/libasound_module_pcm_pipewire.so
#6  0x00007ffff777c2b8 in ?? () from /usr/lib/libasound.so.2
#7  0x0000555555558d6f in main () at main.cc:116
(gdb) 
```

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/457
Repository URL: https://github.com/alsa-project/alsa-lib
