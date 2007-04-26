From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [ASoC] Sample format non available
Date: Thu, 26 Apr 2007 14:46:03 +0100
Message-ID: <1177595163.32188.465.camel@a10072.wolfsonmicro.main>
References: <6zwszzjn7u.fsf@odpc25.int.ondemand.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id F02A224A6C
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2007 15:46:05 +0200 (CEST)
In-Reply-To: <6zwszzjn7u.fsf@odpc25.int.ondemand.co.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Markus Korber <korbse@gmx.at>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-04-26 at 15:10 +0200, Markus Korber wrote:
> Dear list,
> 
> I'm currently implementing a ASoC solution for a custom chip and I've
> written a codec, I2S, PCM, and machine driver.  However, when using
> aplay I get the following error (requested format was: 2):
> 
> root:~# aplay -M -D hw:0,0 test.wav 
> Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> aplay: set_params:906: Sample format non available
> 
> However, I've told each piece involved, that it is capable of playing
> S16_LE.  So I don't know what I am missing here?
> 

Is your target CPU ARM based ?

If so, there is a gcc optimisation bug that causes a refinement error
(like above).  

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=27363

Fwiw, Openembedded builds a working toolchain for ARM and ALSA.

> Should I provide more debugging output like RULES_DEBUG output from
> sound/core/pcm_native.c?
> 

Yes please. Can you also set SOC_DEBUG to 1 in soc-core.c

> ,----[ CODEC DAI ]
> | #define CS4265_RATES (SNDRV_PCM_RATE_8000_192000)
> | #define CS4265_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
> | 
> | struct snd_soc_codec_dai cs4265_dai = {
> |       .name = "CS4265",
> |       .playback = {
> |               .stream_name = "Playback",
> |               .channels_min = 1,
> |               .channels_max = 2,
> |               .rates = CS4265_RATES,
> |               .formats = CS4265_FORMATS,},
> |       .capture = {
> |               .stream_name = "Capture",
> |               .channels_min = 1,
> |               .channels_max = 2,
> |               .rates = CS4265_RATES,
> |               .formats = CS4265_FORMATS,},
> |         [...]
> | };
> `----
> 
> ,----[ CPU DAI ]
> | #define CHIP_I2S_RATES (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
> |                         SNDRV_PCM_RATE_48000)
> | #define CHIP_I2S_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE)
> | 
> | struct snd_soc_cpu_dai chip_i2s_dai = {
> |       /* DAI description */
> |         [...]
> |       /* DAI callbacks */
> |         [...]
> |       /* DAI capabilities */
> |       .playback = {
> |               .channels_min   = 2,
> |               .channels_max   = 2,
> |               .rates          = CHIP_I2S_RATES,
> |               .formats        = CHIP_I2S_FORMATS,},
> |       .capture  = {
> |               .channels_min   = 2,
> |               .channels_max   = 2,
> |               .rates          = CHIP_I2S_RATES,
> |               .formats        = CHIP_I2S_FORMATS,},
> |       /* ops */
> |         [...]
> `----
> 
> ,----[ HW DAI ]
> | static const struct snd_pcm_hardware chip_pcm_hardware = {
> |       .info                   = SNDRV_PCM_INFO_MMAP |
> |                                 SNDRV_PCM_INFO_MMAP_VALID | /* For OSS emulation */
> |                                 SNDRV_PCM_INFO_BLOCK_TRANSFER | /* For OSS emulation */
> |                                 SNDRV_PCM_INFO_NONINTERLEAVED,
> |       .formats                = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
> |                                 SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_S16_LE |
> |       .channels_min           = 2, /* Stereo */
> |       .channels_max           = 2,
> |       .period_bytes_min       = 32,
> |       .period_bytes_max       = 8192,
> |       .periods_min            = 2,
> |       .periods_max            = 1024, /* PAGE_SIZE/sizeof(chip_dma_desc), */
> |       .buffer_bytes_max       = 32 * 1024,
> |       .fifo_size              = 0, /* Still unused in ALSA? */
> | };
> `----
> 

This looks fine. All show S16_LE and 44100 rate stereo.

> root:~# uname -a
> Linux 2.6.21
> root:~# cat /proc/asound/version 
> Advanced Linux Sound Architecture Driver Version 1.0.14rc3 (Wed Mar 14 07:25:50 2007 UTC).
> root:~# aplay --version
> aplay: version 1.0.14rc2 by Jaroslav Kysela <perex@suse.cz>
> 
> root:~# aplay -M test.wav 
> chip-pcm: Entered chip_pcm_open
> board_cs4265: Entered board_cs4265_startup
> Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> ALSA lib pcm_plug.c:840:(snd_pcm_plug_hw_refine_cchange) Unable to find an usable client format

Can you send the debug output with the debug turned on (as above) and
with aplay writing directly to the hardware  i.e.

aplay -Dhw:0,0 test.wav

Thanks

Liam
