From: Timur Tabi <timur@freescale.com>
Subject: SNDRV_PCM_INFO_MMAP - what do I need for it?
Date: Wed, 16 Jan 2008 09:17:57 -0600
Message-ID: <478E2025.8010509@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id CD8D4244CA
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 16:20:55 +0100 (CET)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m0GFHwLF027623
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 08:20:53 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m0GFHvXA002237
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 09:17:57 -0600 (CST)
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

My 8610 ASoC driver has this:

static const struct snd_pcm_hardware fsl_dma_hardware = {

	.info   		= SNDRV_PCM_INFO_INTERLEAVED,

This means that MMAP is not enabled.

I understand what MMAP is, but not from an ALSA driver perspective.  If I change 
the above line to this:

	.info   		= SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_MMAP | 
SNDRV_PCM_INFO_MMAP_VALID,

what does ALSA do differently?  Do I need to define any new functions?  From an 
application perspective, what is different?

Also, does DMIX need MMAP support?

-- 
Timur Tabi
Linux kernel developer at Freescale
