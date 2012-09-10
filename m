From: Timur Tabi <timur@freescale.com>
Subject: Need help with failed driver initialization
Date: Mon, 10 Sep 2012 11:04:33 -0500
Message-ID: <504E0F91.4040907@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 054662650D5
 for <Alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 18:04:41 +0200 (CEST)
Received: from mail145-co1 (localhost [127.0.0.1])	by
 mail145-co1-R.bigfish.com (Postfix) with ESMTP id 90ED4C0014B	for
 <Alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 16:04:40 +0000 (UTC)
Received: from CO1EHSMHS019.bigfish.com (unknown [10.243.78.249])	by
 mail145-co1.bigfish.com (Postfix) with ESMTP id 6AAD9120068	for
 <Alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 16:04:38 +0000 (UTC)
Received: from [10.82.123.3] (efes.am.freescale.net [10.82.123.3])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q8AG4Xbi016139	for
 <Alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 09:04:34 -0700
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Every 6-12 months it seems, my audio drivers break because of some update to the ASoC.  It's that time again.

It appears that support for deferred probing isn't working for me.  I turned on debug printks (and added a few of my own to my drivers), and here's the log:

It looks like everything is registering, but the audio device still doesn't exist.  Can anyone give me a clue what's wrong?

bus: 'i2c': driver_probe_device: matched device 0-004f with driver cs4270
bus: 'i2c': really_probe: probing driver cs4270 with device 0-004f
cs4270 0-004f: found device at i2c address 4F
cs4270 0-004f: hardware revision 3
cs4270 0-004f: codec register 0-004f
cs4270 0-004f: dai register 0-004f #1
cs4270 0-004f: Mapped DAI cs4270-hifi to CODEC cs4270.0-004f
Registered DAI 'cs4270-hifi'
Registered codec 'cs4270.0-004f'
driver: '0-004f': driver_bound: bound to device 'cs4270'
bus: 'i2c': really_probe: bound device 0-004f to driver cs4270
Freescale MPC8610 HPCD ALSA SoC machine driver
bus: 'platform': driver_probe_device: matched device e0016000.ssi with driver fsl-ssi-dai
bus: 'platform': really_probe: probing driver fsl-ssi-dai with device e0016000.ssi
fsl-ssi-dai e0016000.ssi: probing
fsl-ssi-dai e0016000.ssi: registering with ASoC
fsl-ssi-dai e0016000.ssi: dai register e0016000.ssi
Registered DAI 'e0016000.ssi'
fsl-ssi-dai e0016000.ssi: AsoC registration complete
fsl-ssi-dai e0016000.ssi: platform registration 'snd-soc-mpc8610hpcd'
bus: 'platform': driver_probe_device: matched device snd-soc-mpc8610hpcd.0 with driver snd-soc-mpc8610hpcd
bus: 'platform': really_probe: probing driver snd-soc-mpc8610hpcd with device snd-soc-mpc8610hpcd.0
bus: 'platform': driver_probe_device: matched device soc-audio with driver soc-audio
bus: 'platform': really_probe: probing driver soc-audio with device soc-audio
soc-audio soc-audio: ASoC machine snd-soc-mpc8610hpcd should use snd_soc_register_card()
soc-audio soc-audio: binding playback at idx 0
soc-audio soc-audio: platform e0021100.dma-channel not registered
platform soc-audio: Driver soc-audio requests probe deferral
platform soc-audio: Added to deferred list
driver: 'snd-soc-mpc8610hpcd.0': driver_bound: bound to device 'snd-soc-mpc8610hpcd'
bus: 'platform': really_probe: bound device snd-soc-mpc8610hpcd.0 to driver snd-soc-mpc8610hpcd
fsl-ssi-dai e0016000.ssi: probe successful
driver: 'e0016000.ssi': driver_bound: bound to device 'fsl-ssi-dai'
bus: 'platform': really_probe: bound device e0016000.ssi to driver fsl-ssi-dai
bus: 'platform': driver_probe_device: matched device e0021100.dma-channel with driver fsl-pcm-audio
bus: 'platform': really_probe: probing driver fsl-pcm-audio with device e0021100.dma-channel
fsl-pcm-audio e0021100.dma-channel: probing
fsl-pcm-audio e0021100.dma-channel: platform register e0021100.dma-channel
Registered platform 'e0021100.dma-channel'
fsl-pcm-audio e0021100.dma-channel: probe successful
driver: 'e0021100.dma-channel': driver_bound: bound to device 'fsl-pcm-audio'
bus: 'platform': really_probe: bound device e0021100.dma-channel to driver fsl-pcm-audio
bus: 'platform': driver_probe_device: matched device e0021180.dma-channel with driver fsl-pcm-audio
bus: 'platform': really_probe: probing driver fsl-pcm-audio with device e0021180.dma-channel
fsl-pcm-audio e0021180.dma-channel: probing
fsl-pcm-audio e0021180.dma-channel: platform register e0021180.dma-channel
Registered platform 'e0021180.dma-channel'
fsl-pcm-audio e0021180.dma-channel: probe successful
driver: 'e0021180.dma-channel': driver_bound: bound to device 'fsl-pcm-audio'
bus: 'platform': really_probe: bound device e0021180.dma-channel to driver fsl-pcm-audio
...
ALSA device list:
  No soundcards found.
platform soc-audio: Retrying from deferred list
bus: 'platform': driver_probe_device: matched device soc-audio with driver soc-audio
bus: 'platform': really_probe: probing driver soc-audio with device soc-audio
soc-audio: probe of soc-audio failed with error -22

When I use speaker-test, I get this:

# speaker-test -t sine -c 2 -r 48000

speaker-test 1.0.11rc2

Playback device is default
Stream parameters are 48000Hz, S16_BE, 2 channels
Sine wave rate is 440.0000Hz
ALSA lib confmisc.c:768:(parse_card) cannot find card '0'
ALSA lib conf.c:3513:(_snd_config_evaluate) function snd_func_card_driver returned error: No such file or directory
ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
ALSA lib conf.c:3513:(_snd_config_evaluate) function snd_func_concat returned error: No such file or directory
ALSA lib confmisc.c:1251:(snd_func_refer) error evaluating name
ALSA lib conf.c:3513:(_snd_config_evaluate) function snd_func_refer returned error: No such file or directory
ALSA lib conf.c:3985:(snd_config_expand) Evaluate error: No such file or directory
ALSA lib pcm.c:2202:(snd_pcm_open_noupdate) Unknown PCM default
Playback open error: -2,No such file or directory


-- 
Timur Tabi
Linux kernel developer at Freescale
