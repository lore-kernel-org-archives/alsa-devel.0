From: John Faith <jfaith@freescale.com>
Subject: Re: pcm test app failure on PowerPC
Date: Thu, 29 Nov 2007 10:48:13 -0800
Message-ID: <474F096D.70007@freescale.com>
References: <474B1A24.1060601@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id C95C4244C4
	for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2007 19:49:22 +0100 (CET)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	lATIn6cx011968
	for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2007 11:49:17 -0700 (MST)
Received: from [127.0.0.1] (mvp-10-214-72-67.am.freescale.net [10.214.72.67])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	lATIn5k8019040
	for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2007 12:49:05 -0600 (CST)
In-Reply-To: <474B1A24.1060601@freescale.com>
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

Hello,
I had a look at the driver for my platform and in its snd_pcm_hardware 
struct, it sets ".formats = SNDRV_PCM_FMTBIT_S16_LE" (no big endian 
format).  Does the S16_BE format being used by alsalib/test/pcm get set 
  in alsalib or elsewhere in the kernel?

Thanks,
John


John Faith wrote:
> Hello,
> I am using alsa-lib 1.0.15 on an embedded PowerPC board.  I can play 
> audio with aplay, but gstreamer fails, so I built and ran the 'pcm' app 
> in alsa-lib-1.0.15/test/.  pcm gives:
> 
> # export LIBASOUND_DEBUG=1
> # ./pcm
> Playback device is plughw:0,0
> Stream parameters are 44100Hz, S16_BE, 1 channels
> Sine wave rate is 440.0000Hz
> Using transfer method: write
> ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to find 
> an usable access for 'plughw:0,0'
> ALSA ERROR hw_params: set (FORMAT)
>             value = S16_BE : Invalid argument
> ACCESS:  RW_INTERLEAVED
> FORMAT:  S8 U8 S16_LE S16_BE U16_LE U16_BE S24_LE S24_BE U24_LE U24_BE 
> S32_LE S32_BE U32_LE U32_BE FLOAT_LE FLOAT_BE
> SUBFORMAT:  STD
> SAMPLE_BITS: [4 64]
> FRAME_BITS: [4 640000]
> CHANNELS: [1 10000]
> RATE: [4000 4294967295)
> PERIOD_TIME: [25000 300000]
> PERIOD_SIZE: [100 1288490189)
> PERIOD_BYTES: [50 4294967295)
> PERIODS: (0 12884902)
> BUFFER_TIME: [1 4294967295]
> BUFFER_SIZE: [100 1288490188]
> BUFFER_BYTES: [50 4294967295]
> TICK_TIME: 4000
> Sample format not available for playback: Invalid argument
> Setting of hwparams failed: Invalid argument
> 
> 
> Is the driver saying it can do format S16_BE somewhere, but fails when 
> the format is actually set?  How can I dig deeper on this?
> 
> 
> Thanks in advance for any ideas!
> ,
> John
