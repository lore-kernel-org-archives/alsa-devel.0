From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001766]: jackd : ALSA: cannot set period size to 1024 frames for capture
Date: Sat, 28 Jan 2006 02:23:50 +0100
Message-ID: <58926eda576de67febd8bf2356dc6654@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 701091B1
	for <alsa-devel@alsa-project.org>; Sat, 28 Jan 2006 02:23:50 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1766> 
======================================================================
Reported By:                Raymond
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1766
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-21-2006 05:02 CET
Last Modified:              01-28-2006 02:23 CET
======================================================================
Summary:                    jackd : ALSA: cannot set period size to 1024 frames
for capture
Description: 
snd_pcm_hw_params_get_channels_max() return 4 for capture stream

static struct snd_pcm_hardware snd_vortex_playback_hw_adb = {
	.info =
	    (SNDRV_PCM_INFO_MMAP | /* SNDRV_PCM_INFO_RESUME | */
	     SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_INTERLEAVED |
	     SNDRV_PCM_INFO_MMAP_VALID),
	.formats =
	    SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_U8 |
	    SNDRV_PCM_FMTBIT_MU_LAW | SNDRV_PCM_FMTBIT_A_LAW,
	.rates = SNDRV_PCM_RATE_CONTINUOUS,
	.rate_min = 5000,
	.rate_max = 48000,
	.channels_min = 1,
#ifdef CHIP_AU8830
	.channels_max = 4,
#else
	.channels_max = 2,
#endif
	.buffer_bytes_max = 0x10000,
	.period_bytes_min = 0x1,
	.period_bytes_max = 0x1000,
	.periods_min = 2,
	.periods_max = 32,
};

static int
vortex_adb_allocroute(vortex_t * vortex, int dma, int nr_ch, int dir, int
type)
{
	stream_t *stream;
	int i, en;
	
	if ((nr_ch == 3)
	    || ((dir == SNDRV_PCM_STREAM_CAPTURE) && (nr_ch > 2)))
		return -EBUSY;

therefore jackd fail with "ALSA: cannot set period size to 1024 frames for
capture"

jackd -d alsa hw:0 -S
jackd 0.100.9

...
 
JACK compiled with System V SHM support.
loading driver ..
creating alsa driver ... hw:0|hw:0|1024|2|48000|0|0|nomon|swmeter|-|16bit
control device hw:0
configuring for 48000Hz, period = 1024 frames, buffer = 2 periods
ALSA: cannot set period size to 1024 frames for capture
ALSA: cannot configure capture channel
cannot load driver module alsa
no message buffer overruns

======================================================================

----------------------------------------------------------------------
 Raymond - 01-24-06 11:25 
----------------------------------------------------------------------
au88x0 driver only require period size to be power of two.

au88x0 have to use "export PA_ALSA_PERIODSIZE=1024" in order to use
capture function in audacity ( portaudio=v19 )

The new pcm help function will not work with au88x0 driver

int snd_pcm_set_params(snd_pcm_t *pcm,
                       snd_pcm_format_t format,
                       snd_pcm_access_t access,
                       unsigned int channels,
                       unsigned int rate,
                       int soft_resample,
                       unsigned int latency);

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1724

----------------------------------------------------------------------
 Raymond - 01-28-06 02:23 
----------------------------------------------------------------------
define RULES_DEBUG In core/pcm_native.c 

jackd -d alsa hw:0 -S -i 2 

vortex_pcm_open substream->stream=0
vortex_pcm_open substream->stream=1
ACCESS = 00000000ffffffffffffffff -> 0000000000000009
FORMAT = 00000000ffffffffffffffff -> 000000000000300006
SUBFORMAT = 00000000ffffffffffffffff -> 0000000000000001
SAMPLE_BITS = [0 4294967295] -> [0 4294967295]
FRAME_BITS = [0 4294967295] -> [0 4294967295]
CHANNELS = [0 4294967295] -> [1 2]
RATE = [0 4294967295] -> [5000 48000]
PERIOD_TIME = [0 4294967295] -> [0 4294967295]
PERIOD_SIZE = [0 4294967295] -> [0 4294967295]
PERIOD_BYTES = [0 4294967295] -> [1 4096]
PERIODS = [0 4294967295] -> [2 32]
BUFFER_TIME = [0 4294967295] -> [0 4294967295]
BUFFER_SIZE = [0 4294967295] -> [0 4294967295]
BUFFER_BYTES = [0 4294967295] -> [1 65536]
TICK_TIME = [0 4294967295] -> [10000 10000]
Rule 0 [e1cff010]: FORMAT = 300006 -> 300006
Rule 1 [e1cff140]: SAMPLE_BITS = [0 4294967295] -> [8 16]
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 16] -> [8 16]
Rule 3 [e1cfee30]: FRAME_BITS = [0 4294967295] -> [8 32]
Rule 4 [e1cfef90]: FRAME_BITS = [8 32] -> [8 32]
Rule 5 [e1cfef90]: FRAME_BITS = [8 32] -> [8 32]
Rule 6 [e1cfeea0]: CHANNELS = [1 2] -> [1 2]
Rule 7 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 8 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 32] -> [2 32]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [0 4294967295] -> [0 2147483647]
Rule 11 [e1cfef90]: PERIOD_SIZE = [0 2147483647] -> [1 4096]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 13 [e1cfee30]: BUFFER_SIZE = [0 4294967295] -> [2 131072]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 131072] -> [2 65536]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 16 [e1cfef10]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [1 65536] -> [2 65536]
Rule 18 [e1cfef90]: PERIOD_TIME = [0 4294967295] -> (20 819200]
Rule 19 [e1cfef90]: BUFFER_TIME = [0 4294967295] -> (41 13107200]
Rule 20 [e1d047f0]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 21 [e1cff230]: BUFFER_BYTES = [2 65536] -> [2 65536]
Rule 0 [e1cff010]: FORMAT = 300006 -> 300006
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 16] -> [8 16]
Rule 4 [e1cfef90]: FRAME_BITS = [8 32] -> [8 32]
Rule 5 [e1cfef90]: FRAME_BITS = [8 32] -> [8 32]
Rule 7 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 8 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 32] -> [2 32]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 65536] -> [2 65536]
ACCESS = 0000000000000001 -> 0000000000000001
FORMAT = 0000000000000004 -> 0000000000000004
Rule 1 [e1cff140]: SAMPLE_BITS = [8 16] -> [16 16]
Rule 3 [e1cfee30]: FRAME_BITS = [8 32] -> [16 32]
Rule 6 [e1cfeea0]: CHANNELS = [1 2] -> [1 2]
Rule 11 [e1cfef90]: PERIOD_SIZE = [1 4096] -> [1 2048]
Rule 13 [e1cfee30]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 65536] -> [2 32768]
Rule 16 [e1cfef10]: PERIOD_BYTES = [1 4096] -> [2 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [2 65536] -> [4 65536]
Rule 18 [e1cfef90]: PERIOD_TIME = (20 819200] -> (20 409600]
Rule 19 [e1cfef90]: BUFFER_TIME = (41 13107200] -> (41 6553600]
Rule 20 [e1d047f0]: PERIOD_BYTES = [2 4096] -> [2 4096]
Rule 21 [e1cff230]: BUFFER_BYTES = [4 65536] -> [4 65536]
Rule 0 [e1cff010]: FORMAT = 4 -> 4
Rule 2 [e1cfeea0]: SAMPLE_BITS = [16 16] -> [16 16]
Rule 4 [e1cfef90]: FRAME_BITS = [16 32] -> [16 32]
Rule 5 [e1cfef90]: FRAME_BITS = [16 32] -> [16 32]
Rule 7 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 8 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 32] -> [2 32]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [1 2048] -> [1 2048]
Rule 11 [e1cfef90]: PERIOD_SIZE = [1 2048] -> [1 2048]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 2048] -> [1 2048]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 32768] -> [2 32768]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 32768] -> [2 32768]
RATE = [48000 48000] -> [48000 48000]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 2048] -> [1 2048]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 32768] -> [2 32768]
Rule 18 [e1cfef90]: PERIOD_TIME = (20 409600] -> (20 42667)
Rule 19 [e1cfef90]: BUFFER_TIME = (41 6553600] -> (41 682667)
Rule 7 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 8 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 2048] -> [1 2048]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 32768] -> [2 32768]
CHANNELS = [2 2] -> [2 2]
Rule 2 [e1cfeea0]: SAMPLE_BITS = [16 16] -> [16 16]
Rule 3 [e1cfee30]: FRAME_BITS = [16 32] -> [32 32]
Rule 6 [e1cfeea0]: CHANNELS = [2 2] -> [2 2]
Rule 11 [e1cfef90]: PERIOD_SIZE = [1 2048] -> [1 1024]
Rule 13 [e1cfee30]: BUFFER_SIZE = [2 32768] -> [2 32768]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 32768] -> [2 16384]
Rule 16 [e1cfef10]: PERIOD_BYTES = [2 4096] -> [4 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [4 65536] -> [8 65536]
Rule 18 [e1cfef90]: PERIOD_TIME = (20 42667) -> (20 21334)
Rule 19 [e1cfef90]: BUFFER_TIME = (41 682667) -> (41 341334)
Rule 20 [e1d047f0]: PERIOD_BYTES = [4 4096] -> [4 4096]
Rule 21 [e1cff230]: BUFFER_BYTES = [8 65536] -> [8 65536]
Rule 2 [e1cfeea0]: SAMPLE_BITS = [16 16] -> [16 16]
Rule 4 [e1cfef90]: FRAME_BITS = [32 32] -> [32 32]
Rule 5 [e1cfef90]: FRAME_BITS = [32 32] -> [32 32]
Rule 7 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 8 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 32] -> [2 32]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [1 1024] -> [1 1024]
Rule 11 [e1cfef90]: PERIOD_SIZE = [1 1024] -> [1 1024]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 1024] -> [1 1024]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 16384] -> [2 16384]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 16384] -> [2 16384]
PERIOD_SIZE = [1024 1024] -> [1024 1024]
Rule 4 [e1cfef90]: FRAME_BITS = [32 32] -> [32 32]
Rule 7 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 32] -> [2 16]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [1024 1024] -> [1024 1024]
Rule 13 [e1cfee30]: BUFFER_SIZE = [2 16384] -> [2048 16384]
Rule 16 [e1cfef10]: PERIOD_BYTES = [4 4096] -> [4096 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [8 65536] -> [8192 65536]
Rule 18 [e1cfef90]: PERIOD_TIME = (20 21334) -> (21333 21334)
Rule 19 [e1cfef90]: BUFFER_TIME = (41 341334) -> (42666 341334)
Rule 20 [e1d047f0]: PERIOD_BYTES = [4096 4096] -> [4096 4096]
Rule 21 [e1cff230]: BUFFER_BYTES = [8192 65536] -> [8192 65536]
Rule 4 [e1cfef90]: FRAME_BITS = [32 32] -> [32 32]
Rule 5 [e1cfef90]: FRAME_BITS = [32 32] -> [32 32]
Rule 7 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 8 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 16] -> [2 16]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [1024 1024] -> [1024 1024]
Rule 11 [e1cfef90]: PERIOD_SIZE = [1024 1024] -> [1024 1024]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1024 1024] -> [1024 1024]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2048 16384] -> [2048 16384]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2048 16384] -> [2048 16384]
PERIODS = [2 2] -> [2 2]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [1024 1024] -> [1024 1024]
Rule 13 [e1cfee30]: BUFFER_SIZE = [2048 16384] -> [2048 2048]
Rule 17 [e1cfef10]: BUFFER_BYTES = [8192 65536] -> [8192 8192]
Rule 19 [e1cfef90]: BUFFER_TIME = (42666 341334) -> (42666 42667)
Rule 21 [e1cff230]: BUFFER_BYTES = [8192 8192] -> [8192 8192]
Rule 5 [e1cfef90]: FRAME_BITS = [32 32] -> [32 32]
Rule 8 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 2] -> [2 2]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [1024 1024] -> [1024 1024]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2048 2048] -> [2048 2048]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2048 2048] -> [2048 2048]
ACCESS = 0000000000000001 -> 0000000000000001
FORMAT = 0000000000000004 -> 0000000000000004
SUBFORMAT = 0000000000000001 -> 0000000000000001
SAMPLE_BITS = [16 16] -> [16 16]
FRAME_BITS = [32 32] -> [32 32]
CHANNELS = [2 2] -> [2 2]
RATE = [48000 48000] -> [48000 48000]
PERIOD_TIME = (21333 21334) -> (21333 21334)
PERIOD_SIZE = [1024 1024] -> [1024 1024]
PERIOD_BYTES = [4096 4096] -> [4096 4096]
PERIODS = [2 2] -> [2 2]
BUFFER_TIME = (42666 42667) -> (42666 42667)
BUFFER_SIZE = [2048 2048] -> [2048 2048]
BUFFER_BYTES = [8192 8192] -> [8192 8192]
TICK_TIME = [10000 10000] -> [10000 10000]
Rule 0 [e1cff010]: FORMAT = 4 -> 4
Rule 1 [e1cff140]: SAMPLE_BITS = [16 16] -> [16 16]
Rule 2 [e1cfeea0]: SAMPLE_BITS = [16 16] -> [16 16]
Rule 3 [e1cfee30]: FRAME_BITS = [32 32] -> [32 32]
Rule 4 [e1cfef90]: FRAME_BITS = [32 32] -> [32 32]
Rule 5 [e1cfef90]: FRAME_BITS = [32 32] -> [32 32]
Rule 6 [e1cfeea0]: CHANNELS = [2 2] -> [2 2]
Rule 7 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 8 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 2] -> [2 2]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [1024 1024] -> [1024 1024]
Rule 11 [e1cfef90]: PERIOD_SIZE = [1024 1024] -> [1024 1024]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1024 1024] -> [1024 1024]
Rule 13 [e1cfee30]: BUFFER_SIZE = [2048 2048] -> [2048 2048]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2048 2048] -> [2048 2048]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2048 2048] -> [2048 2048]
Rule 16 [e1cfef10]: PERIOD_BYTES = [4096 4096] -> [4096 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [8192 8192] -> [8192 8192]
Rule 18 [e1cfef90]: PERIOD_TIME = (21333 21334) -> (21333 21334)
Rule 19 [e1cfef90]: BUFFER_TIME = (42666 42667) -> (42666 42667)
Rule 20 [e1d047f0]: PERIOD_BYTES = [4096 4096] -> [4096 4096]
Rule 21 [e1cff230]: BUFFER_BYTES = [8192 8192] -> [8192 8192]
vortex_pcm_hw_params substream->stream=1
vortex_pcm_prepare substream->stream=1
ACCESS = 00000000ffffffffffffffff -> 0000000000000009
FORMAT = 00000000ffffffffffffffff -> 000000000000300006
SUBFORMAT = 00000000ffffffffffffffff -> 0000000000000001
SAMPLE_BITS = [0 4294967295] -> [0 4294967295]
FRAME_BITS = [0 4294967295] -> [0 4294967295]
CHANNELS = [0 4294967295] -> [1 4]
RATE = [0 4294967295] -> [5000 48000]
PERIOD_TIME = [0 4294967295] -> [0 4294967295]
PERIOD_SIZE = [0 4294967295] -> [0 4294967295]
PERIOD_BYTES = [0 4294967295] -> [1 4096]
PERIODS = [0 4294967295] -> [2 32]
BUFFER_TIME = [0 4294967295] -> [0 4294967295]
BUFFER_SIZE = [0 4294967295] -> [0 4294967295]
BUFFER_BYTES = [0 4294967295] -> [1 65536]
TICK_TIME = [0 4294967295] -> [10000 10000]
Rule 0 [e1cff010]: FORMAT = 300006 -> 300006
Rule 1 [e1cff140]: SAMPLE_BITS = [0 4294967295] -> [8 16]
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 16] -> [8 16]
Rule 3 [e1cfee30]: FRAME_BITS = [0 4294967295] -> [8 64]
Rule 4 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 5 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 6 [e1cfeea0]: CHANNELS = [1 4] -> [1 4]
Rule 7 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 8 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 32] -> [2 32]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [0 4294967295] -> [0 2147483647]
Rule 11 [e1cfef90]: PERIOD_SIZE = [0 2147483647] -> [1 4096]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 13 [e1cfee30]: BUFFER_SIZE = [0 4294967295] -> [2 131072]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 131072] -> [2 65536]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 16 [e1cfef10]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [1 65536] -> [2 65536]
Rule 18 [e1cfef90]: PERIOD_TIME = [0 4294967295] -> (20 819200]
Rule 19 [e1cfef90]: BUFFER_TIME = [0 4294967295] -> (41 13107200]
Rule 20 [e1d047f0]: PERIOD_BYTES = [1 4096] -> [1 4096]
Rule 21 [e1cff230]: BUFFER_BYTES = [2 65536] -> [2 65536]
Rule 0 [e1cff010]: FORMAT = 300006 -> 300006
Rule 2 [e1cfeea0]: SAMPLE_BITS = [8 16] -> [8 16]
Rule 4 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 5 [e1cfef90]: FRAME_BITS = [8 64] -> [8 64]
Rule 7 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 8 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 32] -> [2 32]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 4096] -> [1 4096]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 65536] -> [2 65536]
ACCESS = 0000000000000001 -> 0000000000000001
FORMAT = 0000000000000004 -> 0000000000000004
Rule 1 [e1cff140]: SAMPLE_BITS = [8 16] -> [16 16]
Rule 3 [e1cfee30]: FRAME_BITS = [8 64] -> [16 64]
Rule 6 [e1cfeea0]: CHANNELS = [1 4] -> [1 4]
Rule 11 [e1cfef90]: PERIOD_SIZE = [1 4096] -> [1 2048]
Rule 13 [e1cfee30]: BUFFER_SIZE = [2 65536] -> [2 65536]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 65536] -> [2 32768]
Rule 16 [e1cfef10]: PERIOD_BYTES = [1 4096] -> [2 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [2 65536] -> [4 65536]
Rule 18 [e1cfef90]: PERIOD_TIME = (20 819200] -> (20 409600]
Rule 19 [e1cfef90]: BUFFER_TIME = (41 13107200] -> (41 6553600]
Rule 20 [e1d047f0]: PERIOD_BYTES = [2 4096] -> [2 4096]
Rule 21 [e1cff230]: BUFFER_BYTES = [4 65536] -> [4 65536]
Rule 0 [e1cff010]: FORMAT = 4 -> 4
Rule 2 [e1cfeea0]: SAMPLE_BITS = [16 16] -> [16 16]
Rule 4 [e1cfef90]: FRAME_BITS = [16 64] -> [16 64]
Rule 5 [e1cfef90]: FRAME_BITS = [16 64] -> [16 64]
Rule 7 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 8 [e1cfef90]: RATE = [5000 48000] -> [5000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 32] -> [2 32]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [1 2048] -> [1 2048]
Rule 11 [e1cfef90]: PERIOD_SIZE = [1 2048] -> [1 2048]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 2048] -> [1 2048]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 32768] -> [2 32768]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 32768] -> [2 32768]
RATE = [48000 48000] -> [48000 48000]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 2048] -> [1 2048]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 32768] -> [2 32768]
Rule 18 [e1cfef90]: PERIOD_TIME = (20 409600] -> (20 42667)
Rule 19 [e1cfef90]: BUFFER_TIME = (41 6553600] -> (41 682667)
Rule 7 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 8 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 2048] -> [1 2048]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 32768] -> [2 32768]
CHANNELS = [4 4] -> [4 4]
Rule 2 [e1cfeea0]: SAMPLE_BITS = [16 16] -> [16 16]
Rule 3 [e1cfee30]: FRAME_BITS = [16 64] -> [64 64]
Rule 6 [e1cfeea0]: CHANNELS = [4 4] -> [4 4]
Rule 11 [e1cfef90]: PERIOD_SIZE = [1 2048] -> [1 512]
Rule 13 [e1cfee30]: BUFFER_SIZE = [2 32768] -> [2 16384]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 16384] -> [2 8192]
Rule 16 [e1cfef10]: PERIOD_BYTES = [2 4096] -> [8 4096]
Rule 17 [e1cfef10]: BUFFER_BYTES = [4 65536] -> [16 65536]
Rule 18 [e1cfef90]: PERIOD_TIME = (20 42667) -> (20 10667)
Rule 19 [e1cfef90]: BUFFER_TIME = (41 682667) -> (41 170667)
Rule 20 [e1d047f0]: PERIOD_BYTES = [8 4096] -> [8 4096]
Rule 21 [e1cff230]: BUFFER_BYTES = [16 65536] -> [16 65536]
Rule 2 [e1cfeea0]: SAMPLE_BITS = [16 16] -> [16 16]
Rule 4 [e1cfef90]: FRAME_BITS = [64 64] -> [64 64]
Rule 5 [e1cfef90]: FRAME_BITS = [64 64] -> [64 64]
Rule 7 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 8 [e1cfef90]: RATE = [48000 48000] -> [48000 48000]
Rule 9 [e1cfeea0]: PERIODS = [2 32] -> [2 32]
Rule 10 [e1cfeea0]: PERIOD_SIZE = [1 512] -> [1 512]
Rule 11 [e1cfef90]: PERIOD_SIZE = [1 512] -> [1 512]
Rule 12 [e1cfef10]: PERIOD_SIZE = [1 512] -> [1 512]
Rule 14 [e1cfef90]: BUFFER_SIZE = [2 8192] -> [2 8192]
Rule 15 [e1cfef10]: BUFFER_SIZE = [2 8192] -> [2 8192]
vortex_pcm_hw_free substream->stream=1
vortex_pcm_hw_free substream->stream=1
vortex_pcm_close substream->stream=1
vortex_pcm_hw_free substream->stream=0
vortex_pcm_close substream->stream=0


Is there any parameter in snd_vortex_playback_hw_adb cause
snd_pcm_set_period_size fail with -EINVAL ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-21-06 05:02 Raymond        New Issue                                    
01-21-06 05:25 rlrevell       Note Added: 0007735                          
01-21-06 05:36 rlrevell       Note Deleted: 0007735                        
01-21-06 07:36 Raymond        Note Added: 0007736                          
01-21-06 07:41 Raymond        Note Edited: 0007736                         
01-21-06 07:59 rlrevell       Note Added: 0007737                          
01-23-06 10:36 Raymond        Note Added: 0007761                          
01-23-06 10:42 Raymond        Note Edited: 0007761                         
01-24-06 11:25 Raymond        Note Added: 0007773                          
01-28-06 02:23 Raymond        Note Added: 0007816                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
