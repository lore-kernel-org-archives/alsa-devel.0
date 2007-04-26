From: Markus Korber <korbse@gmx.at>
Subject: [ASoC] Sample format non available
Date: Thu, 26 Apr 2007 15:10:13 +0200
Message-ID: <6zwszzjn7u.fsf@odpc25.int.ondemand.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 01770246EA
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2007 15:10:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dear list,

I'm currently implementing a ASoC solution for a custom chip and I've
written a codec, I2S, PCM, and machine driver.  However, when using
aplay I get the following error (requested format was: 2):

root:~# aplay -M -D hw:0,0 test.wav 
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
aplay: set_params:906: Sample format non available

However, I've told each piece involved, that it is capable of playing
S16_LE.  So I don't know what I am missing here?

Should I provide more debugging output like RULES_DEBUG output from
sound/core/pcm_native.c?

,----[ CODEC DAI ]
| #define CS4265_RATES (SNDRV_PCM_RATE_8000_192000)
| #define CS4265_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
| 
| struct snd_soc_codec_dai cs4265_dai = {
|       .name = "CS4265",
|       .playback = {
|               .stream_name = "Playback",
|               .channels_min = 1,
|               .channels_max = 2,
|               .rates = CS4265_RATES,
|               .formats = CS4265_FORMATS,},
|       .capture = {
|               .stream_name = "Capture",
|               .channels_min = 1,
|               .channels_max = 2,
|               .rates = CS4265_RATES,
|               .formats = CS4265_FORMATS,},
|         [...]
| };
`----

,----[ CPU DAI ]
| #define CHIP_I2S_RATES (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
|                         SNDRV_PCM_RATE_48000)
| #define CHIP_I2S_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE)
| 
| struct snd_soc_cpu_dai chip_i2s_dai = {
|       /* DAI description */
|         [...]
|       /* DAI callbacks */
|         [...]
|       /* DAI capabilities */
|       .playback = {
|               .channels_min   = 2,
|               .channels_max   = 2,
|               .rates          = CHIP_I2S_RATES,
|               .formats        = CHIP_I2S_FORMATS,},
|       .capture  = {
|               .channels_min   = 2,
|               .channels_max   = 2,
|               .rates          = CHIP_I2S_RATES,
|               .formats        = CHIP_I2S_FORMATS,},
|       /* ops */
|         [...]
`----

,----[ HW DAI ]
| static const struct snd_pcm_hardware chip_pcm_hardware = {
|       .info                   = SNDRV_PCM_INFO_MMAP |
|                                 SNDRV_PCM_INFO_MMAP_VALID | /* For OSS emulation */
|                                 SNDRV_PCM_INFO_BLOCK_TRANSFER | /* For OSS emulation */
|                                 SNDRV_PCM_INFO_NONINTERLEAVED,
|       .formats                = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
|                                 SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_S16_LE |
|       .channels_min           = 2, /* Stereo */
|       .channels_max           = 2,
|       .period_bytes_min       = 32,
|       .period_bytes_max       = 8192,
|       .periods_min            = 2,
|       .periods_max            = 1024, /* PAGE_SIZE/sizeof(chip_dma_desc), */
|       .buffer_bytes_max       = 32 * 1024,
|       .fifo_size              = 0, /* Still unused in ALSA? */
| };
`----

root:~# uname -a
Linux 2.6.21
root:~# cat /proc/asound/version 
Advanced Linux Sound Architecture Driver Version 1.0.14rc3 (Wed Mar 14 07:25:50 2007 UTC).
root:~# aplay --version
aplay: version 1.0.14rc2 by Jaroslav Kysela <perex@suse.cz>

root:~# aplay -M test.wav 
chip-pcm: Entered chip_pcm_open
board_cs4265: Entered board_cs4265_startup
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
ALSA lib pcm_plug.c:840:(snd_pcm_plug_hw_refine_cchange) Unable to find an usable client format
chip-pcm: Entered chip_pcm_hw_free
chip-cs4265: Entered cs4265_shutdown
chip-cs4265: Entered cs4265_write
board_cs4265: Entered board_cs4265_shutdown
chip-pcm: Entered chip_pcm_close
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: S8
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: U8
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: S16_LE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: S16_BE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: U16_LE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: U16_BE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: S24_LE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: S24_BE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: U24_LE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: U24_BE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: S32_LE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: S32_BE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: U32_LE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: U32_BE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: FLOAT_LE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: FLOAT_BE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: FLOAT64_LE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: FLOAT64_BE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: IEC958_SUBFRAME_LE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: MU_LAW
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: A_LAW
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: IMA_ADPCM
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: GSM
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: SPECIAL
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: S24_3LE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: S24_3BE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: U24_3LE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: U24_3BE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: S20_3LE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: S20_3BE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: U20_3LE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: U20_3BE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: S18_3LE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: S18_3BE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: U18_3LE
ALSA lib pcm_plug.c:844:(snd_pcm_plug_hw_refine_cchange) Format: U18_3BE
aplay: set_params:878: Broken configuration for this PCM: no configurations available

Regards,
Markus Korber
