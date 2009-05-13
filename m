From: Jon Smirl <jonsmirl@gmail.com>
Subject: WM9712 - Big and little endian format conversion.
Date: Wed, 13 May 2009 13:55:43 -0400
Message-ID: <9e4733910905131055v4eb487dhf5d410ae5d6b1a52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DF201038D7
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 19:55:45 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so554794qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 10:55:44 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

I have three areas specifying audio formats. The WM9712 AC97 codec is
S16_LE. My DMA hardware is S32_BE. All samples need to be in 32b words
even if they are 8,16,24b.  The cpu's AC97 system sends the first 20
big endian bits down the AC97 link in the proper order.

How can I force the DMA engine setting to override what the codec is
saying? Or should the codec be changed to specify all bit lengths and
both endians?

My DMA platform:

static const struct snd_pcm_hardware psc_dma_hardware = {
	.info = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
		SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
		SNDRV_PCM_INFO_BATCH,
	.formats = SNDRV_PCM_FMTBIT_S32_BE,
	.rate_min = 8000,
	.rate_max = 48000,
	.channels_min = 1,
	.channels_max = 2,
	.period_bytes_max	= 1024 * 1024,
	.period_bytes_min	= 32,
	.periods_min		= 2,
	.periods_max		= 256,
	.buffer_bytes_max	= 2 * 1024 * 1024,
	.fifo_size		= 512,
};


CPU DAI:
static struct snd_soc_dai psc_ac97_dai_template[] = {
{
	.name   = "%s analog",
	.suspend = psc_ac97_suspend,
	.resume = psc_ac97_resume,
	.playback = {
		.channels_min   = 1,
		.channels_max   = 6,
		.rates          = SNDRV_PCM_RATE_8000_48000,
		.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE |
			   SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S32_BE,
	},
	.capture = {
		.channels_min   = 1,
		.channels_max   = 2,
		.rates          = SNDRV_PCM_RATE_8000_48000,
		.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE |
			   SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S32_BE,
	},
	.ops = &psc_ac97_analog_ops,
},

Codec:

struct snd_soc_dai wm9712_dai[] = {
{
	.name = "AC97 HiFi",
	.ac97_control = 1,
	.playback = {
		.stream_name = "HiFi Playback",
		.channels_min = 1,
		.channels_max = 2,
		.rates = WM9712_AC97_RATES,
		.formats = SNDRV_PCM_FMTBIT_S16_LE,
	},
	.capture = {
		.stream_name = "HiFi Capture",
		.channels_min = 1,
		.channels_max = 2,
		.rates = WM9712_AC97_RATES,
		.formats = SNDRV_PCM_FMTBIT_S16_LE,
	},
	.ops = &wm9712_dai_ops_hifi,
},
{



-- 
Jon Smirl
jonsmirl@gmail.com
