From: Timur Tabi <timur@freescale.com>
Subject: arecord: main:552: audio open error: Invalid argument
Date: Wed, 4 Aug 2010 14:55:45 -0500
Message-ID: <4C59C5C1.50504@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by alsa0.perex.cz (Postfix) with ESMTP id 52A1B246A5
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Aug 2010 21:56:07 +0200 (CEST)
Received: from mail172-tx2 (localhost.localdomain [127.0.0.1])	by
	mail172-tx2-R.bigfish.com (Postfix) with ESMTP id 90D8D8C8419	for
	<alsa-devel@alsa-project.org>; Wed,  4 Aug 2010 19:56:02 +0000 (UTC)
Received: from TX2EHSMHS001.bigfish.com (unknown [10.9.14.235])	by
	mail172-tx2.bigfish.com (Postfix) with ESMTP id 13D51E90051	for
	<alsa-devel@alsa-project.org>; Wed,  4 Aug 2010 19:56:01 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o74JtlZH016107	for <alsa-devel@alsa-project.org>;
	Wed, 4 Aug 2010 12:55:58 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o74JtqTp028445	for <alsa-devel@alsa-project.org>;
	Wed, 4 Aug 2010 14:55:53 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Liam and Mark,

I created a log with some printks that kinda show what's going on.  In one
process I run speaker-test, and then I start arecord in another process.

fsl_ssi_startup:286 substream=ef3e5000 playback=0 capture=0
fsl_ssi_startup:288 rtd=ef3a2c00 rate=0
fsl_ssi_startup:298
fsl_ssi_startup:373 first=(null) second=(null)
fsl_ssi_startup:427
soc_pcm_open:381
fsl_dma_open:408 rtd=ef3a2c00 rate=0
soc_pcm_open:391
soc_pcm_open:402
soc_pcm_open:412
soc_pcm_open:463
soc_pcm_open:471
soc_pcm_open:477
soc_pcm_open:484
asoc: cs4270-hifi <-> e0016000.ssi info:
asoc: rate mask 0x40001fff
asoc: min ch 2 max ch 2
asoc: min rate 5512 max rate 192000
fsl_ssi_hw_params:450
Rate set to 48000Hz (requested 48000Hz)
fsl_dma_hw_params:579
soc_pcm_hw_params:748 rtd=ef3a2c00 rate=48000

...
fsl_ssi_startup:286 substream=ef3e5300 playback=1 capture=0
fsl_ssi_startup:288 rtd=ef3a2d10 rate=0
fsl_ssi_startup:373 first=ef3e5000 second=(null)
fsl_ssi_startup:411 runtime=ef4ba800 sample_bits=16
fsl_ssi_startup:427
soc_pcm_open:381
fsl_dma_open:408 rtd=ef3a2d10 rate=0  <<------
soc_pcm_open:391
soc_pcm_open:402
soc_pcm_open:412
soc_pcm_open:463
soc_pcm_open:471
soc_pcm_open:477
soc_pcm_open:484
soc_pcm_apply_symmetry:335 rtd=ef3a2d10 rate=0
 capture: Symmetry forces 0Hz rate

In summary, the problem appears to be that asoc calls
soc_pcm_apply_symmetry() in soc_pcm_open(), but this occurs before
soc_pcm_hw_params() can set rtd->rate.  So rtd->rate is always zero when
soc_pcm_apply_symmetry() is called.

For some reason, this isn't a problem when arecord is started before
speaker-test.  In that case, rtd->rate is 48000 when speaker-test is started:

fsl_ssi_startup:286 substream=ef3e5300 playback=0 capture=0
fsl_ssi_startup:288 rtd=ef3e6d10 rate=0
fsl_ssi_startup:298
fsl_ssi_startup:373 first=(null) second=(null)
fsl_ssi_startup:427
soc_pcm_open:382
fsl_dma_open:408 rtd=ef3e6d10 rate=0
soc_pcm_open:392
soc_pcm_open:403
soc_pcm_open:413
soc_pcm_open:464
soc_pcm_open:472
soc_pcm_open:478
soc_pcm_open:485
asoc: cs4270-hifi <-> e0016000.ssi info:
asoc: rate mask 0x40001fff
asoc: min ch 2 max ch 2
asoc: min rate 5512 max rate 192000
fsl_ssi_hw_params:450
fsl_dma_hw_params:579
soc_pcm_hw_params:749 rtd=ef3e6d10 rate=48000
pop wq checking: Playback status: inactive waiting: yes
...
fsl_ssi_startup:286 substream=ef3e5000 playback=0 capture=1
fsl_ssi_startup:288 rtd=ef3e6c00 rate=48000
fsl_ssi_startup:373 first=ef3e5300 second=(null)
fsl_ssi_startup:411 runtime=ef4c6c00 sample_bits=16
fsl_ssi_startup:427
soc_pcm_open:382
fsl_dma_open:408 rtd=ef3e6c00 rate=48000   <<------
soc_pcm_open:392
soc_pcm_open:403
soc_pcm_open:413
soc_pcm_open:464
soc_pcm_open:472
soc_pcm_open:478
soc_pcm_open:485
soc_pcm_apply_symmetry:333 rtd=ef3e6c00 rate=48000
 playback: Symmetry forces 48000Hz rate
asoc: cs4270-hifi <-> e0016000.ssi info:
asoc: rate mask 0x40001fff
asoc: min ch 2 max ch 2
asoc: min rate 5512 max rate 192000
fsl_ssi_hw_params:450
Rate set to 48000Hz (requested 48000Hz)
fsl_dma_hw_params:579
Buffer soc_pcm_hw_params:749 rtd=ef3e6c00 rate=48000
