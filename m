From: Jon Flatley <jflat@chromium.org>
Subject: [BUG] bdw-rt5650 DSP boot timeout
Date: Mon, 29 Jul 2019 14:53:16 -0700
Message-ID: <CACJJ=pxPm7dRUE534hDWy2tN3dGYDyrgU8JKqett=wOQx+nWCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5B45F800E4
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2019 23:53:30 +0200 (CEST)
Received: by mail-lf1-x131.google.com with SMTP id b17so43160635lff.7
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2019 14:53:30 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id m10sm10768428lfd.32.2019.07.29.14.53.28
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 14:53:28 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id v85so43109282lfa.6
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2019 14:53:28 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: benzh@chromium.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

I've been working on upstreaming the bdw-rt5650 machine driver for the
Acer Chromebase 24 (buddy). There seems to be an issue when first
setting the hardware controls that appears to be crashing the DSP:

[   51.424554] haswell-pcm-audio haswell-pcm-audio: FW loaded, mailbox
readback FW info: type 01, - version: 00.00, build 77, source commit
id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
...
[   84.924666] haswell-pcm-audio haswell-pcm-audio: error: audio DSP
boot timeout IPCD 0x0 IPCX 0x0
[   85.260655] haswell-pcm-audio haswell-pcm-audio: ipc: --message
timeout-- ipcx 0x83000000 isr 0x00000000 ipcd 0x00000000 imrx
0x7fff0000
[   85.273609] haswell-pcm-audio haswell-pcm-audio: error: stream commit failed
[   85.279746]  System PCM: error: failed to commit stream -110
[   85.285388] haswell-pcm-audio haswell-pcm-audio: ASoC:
haswell-pcm-audio hw params failed: -110
[   85.293963]  System PCM: ASoC: hw_params FE failed -110

This happens roughly 50% of the time when first setting hardware
controls after a reboot. The other 50% of the time the DSP comes up
just fine and audio works fine thereafter. Adding "#define DEBUG 1" to
sound/soc/intel/haswell/sst-haswell-ipc.c makes the issue occur much
less frequently in my testing. Seems like a subtle timing issue.

There were timing issues encountered during the bringup of the 2015
chromebook pixel (samus) which uses the bdw-rt5677 machine driver.
Those were slightly different, and manifested during repeated
arecords. Both devices use the same revision of the sst2 firmware.

Any ideas for how to debug this?

Thanks,
Jon
