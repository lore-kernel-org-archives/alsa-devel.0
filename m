From: Krzysztof Adamski <k@japko.eu>
Subject: Plug plugin not working on Raspberry Pi.
Date: Fri, 13 Jul 2012 09:38:14 +0200
Message-ID: <4FFFD066.30000@japko.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from box2.japko.eu (box2.japko.eu [91.121.152.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8255B104248
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jul 2012 09:35:49 +0200 (CEST)
Received: from tani.japko.eu (unknown [79.110.194.134])
	by box2.japko.eu (Postfix) with ESMTPSA id 755C860797
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jul 2012 09:32:00 +0200 (CEST)
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

Hi,
for a couple of days I'm trying to figure out problems with ALSA on 
Raspberry Pi. It turned out that for some reason, plug plugin is not 
working as expected. Id does work correctly when I'm using PCM 
configuration that can be handled directly by HW but any other 
configuration (like unsuported format, more channes etc) fails with 
"Invalid argument" on snd_pcm_hw_params.

It's not my code that fails because of this by it's both mplayer and 
VLC. Both snd_pcm_hw_params_set_format and snd_pcm_hw_params_test_format 
(and other similar functions) does not return error. Only when 
snd_pcm_hw_params is run, there is one.

I'm using Debian Wheezy, with ALSA 1.0.25 with all default ALSA 
configuration. ALSA drivers for RPi are not in mainline kernel but they 
can be viewed here:
https://github.com/raspberrypi/linux/tree/rpi-patches/sound/arm (it's 
bcm2835). Card capabilities seems to be described correctly:

static struct snd_pcm_hardware snd_bcm2835_playback_hw = {
.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER),
.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
.rates = SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
.rate_min = 8000,
.rate_max = 48000,
.channels_min = 1,
.channels_max = 2,
.buffer_bytes_max = (4 * 8 - 1) * 1024, /* Needs to be less than 
audioplay buffer size */
.period_bytes_min = 1 * 1024,
.period_bytes_max = (4 * 8 - 1) * 1024,
.periods_min = 1,
.periods_max = 4 * 8 - 1,
};

So, I would like someone to help me investigate if it's a userspace or 
driver BUG and how to fix this. I will be happy to provide any 
information that is needed for debug, test patches, recompile with some 
debugin enabled etc.
