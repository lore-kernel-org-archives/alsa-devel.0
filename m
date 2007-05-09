From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: ALSA problems with simultaneous Capture and playback
Date: Wed, 9 May 2007 23:36:00 +0530
Message-ID: <8d6898730705091106l5ad0acl772b3dc4fd0d5fbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.235])
	by alsa0.perex.cz (Postfix) with ESMTP id A452424398
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2007 20:06:01 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so278392nzf
	for <alsa-devel@alsa-project.org>; Wed, 09 May 2007 11:06:00 -0700 (PDT)
Content-Disposition: inline
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

I am facing a problem with simultaneous playback and Capture.

I am doing Mic Capture and Playing it back.

this is format i am using SND_PCM_FORMAT_S16_LE.
I am recording only one channel "Mono".

this is my driver pcm_hardware configuration

static struct snd_pcm_hardware pcm_hw_info = {
	.info			= SNDRV_PCM_INFO_MMAP |
				  SNDRV_PCM_INFO_MMAP_VALID |
				  SNDRV_PCM_INFO_INTERLEAVED |
				  SNDRV_PCM_INFO_BLOCK_TRANSFER |
				  SNDRV_PCM_INFO_RESUME,

	/*
	 * ALSA doesn't support 18-bit or 20-bit packed into 32-bit
	 * words.  It also doesn't support 12-bit at all.
	 */
	.formats		= SNDRV_PCM_FMTBIT_S16_LE,

	/* should this be continuous or knot? */
	.buffer_bytes_max	= 64 * 1024,
	.period_bytes_min	= 1024,
	.period_bytes_max	= 1024,
	.periods_min		= 4,
	.periods_max		= 64,
};



I am getting following errors when i do simultaneous capture and playback.
Start the while looop

 MY ReadFromAlsa        512     256

 MY WriteToAlsa 512     256

 MY ReadFromAlsa        512     256

 MY WriteToAlsa 512     256

 MY ReadFromAlsa        512     256

 MY WriteToAlsa 512     256

 MY ReadFromAlsa        512     256

 MY WriteToAlsa 512     256

 MY ReadFromAlsa        512     256

 MY WriteToAlsa 512     256

 MY ReadFromAlsa        512     256

 MY WriteToAlsa 512     256

 MY ReadFromAlsa        512     256

 MY WriteToAlsa 512     256

 MY ReadFromAlsa        512     256

 MY WriteToAlsa 512     256

 MY ReadFromAlsaTrying to free free IRQ27
        512     256
ReadFromAlsa():State:4, iiLen=2048
ReadFromAlsa():State:2
Overflow state

 MY ReadFromAlsa        512     256

 MY WriteToAlsa 512     256

 MY ReadFromAlsa        512     256

 MY WriteToAlsa 512     256

 MY ReadFromAlsa        512     256

 MY WriteToAlsa 512     256

 MY ReadFromAlsa        512     256

 MY WriteToAlsa 512     256

 MY ReadFromAlsa        512     256

 MY WriteToAlsa 512     256

 MY ReadFromAlsaTrying to free free IRQ27
        512     256
ReadFromAlsa():State:4, iiLen=1280
ReadFromAlsa():State:2
Overflow state

 MY ReadFromAlsa        512     256

 MY WriteToAlsa 512     256

 MY ReadFromAlsa        512     256

 MY WriteToAlsa 512     256

 MY ReadFromAlsa        512     256

 MY WriteToAlsa 512     256

 MY ReadFromAlsa        512     256

 MY WriteToAlsa 512     256

 MY ReadFromAlsa        512     256

 MY WriteToAlsa 512     256

 MY ReadFromAlsaTrying to free free IRQ27
        512     256
ReadFromAlsa():State:4, iiLen=1280
ReadFromAlsa():State:2
Overflow state

One read and write handle 256 frames.

Write seems to be OK, but read fails

State 4 is SND_PCM_STATE_XRUN

why this XRUN is happening?


any idea why this is coming?

where i am going wrong?

Thanks
