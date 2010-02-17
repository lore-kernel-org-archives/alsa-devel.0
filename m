From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Understanding SND_PCM_INFO_ [BATCH, BLOCK_TRANSFER,
	DOUBLE]
Date: Wed, 17 Feb 2010 20:35:36 +1300
Message-ID: <4B7B9C48.5070608@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 924DC103847
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 08:36:29 +0100 (CET)
Received: from [192.168.1.6]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0KXZ0028U6GPWN20@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Wed, 17 Feb 2010 20:36:26 +1300 (NZDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I've been looking at these info flags, and whether they cause the driver
to be accessed any differently by the upper layers.
So far I can find hardly any examples where they are used in any
significant way - what am I missing if anything?

SND_/SNDRV_
_PCM_INFO_BATCH
double buffering
skips the check enabled by XRUN_DEBUG_JIFFIESCHECK
alsa-lib returns it in snd_pcm_hw_params_is_batch()

_PCM_INFO_BLOCK_TRANSFER
/* hardware transfer block of samples */
translated by pcm_oss.c into ~DSP_CAP_REALTIME
lib: snd_pcm_hw_params_is_block_transfer()

_PCM_INFO_DOUBLE
/* double buffering needed for PCM start/stop */
snd_pcm_hw_params_is_double()

I don't see any of these functions called by aplay...


--
Eliot
