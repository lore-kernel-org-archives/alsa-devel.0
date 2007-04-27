From: Markus Korber <korbse@gmx.at>
Subject: Re: [ASoC] Sample format non available
Date: Fri, 27 Apr 2007 11:35:35 +0200
Message-ID: <6zzm4utb14.fsf@odpc25.int.ondemand.co.at>
References: <6zwszzjn7u.fsf@odpc25.int.ondemand.co.at>
	<1177595163.32188.465.camel@a10072.wolfsonmicro.main>
	<6zps5qwdig.fsf@odpc25.int.ondemand.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 79B1424B10
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2007 11:35:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thus spake Markus Korber:

> Thus spake Liam Girdwood:
>
>> Yes please. Can you also set SOC_DEBUG to 1 in soc-core.c
>> [...]
>> Can you send the debug output with the debug turned on (as above) and
>> with aplay writing directly to the hardware  i.e.
>>
>> aplay -Dhw:0,0 test.wav

So now with 4.1.2 from buildroot everything looks fine - apart from my
driver :).  Thanks.

root:~# aplay -M -D hw:0,0 test.wav 
chip-pcm: Entered chip_pcm_open
board_cs4265: Entered board_cs4265_startup
asoc: CS4265 <-> chip-i2s info:
asoc: rate mask 0xe0
asoc: min ch 2 max ch 2
asoc: min rate 32000 max rate 48000
Playing WAVE 'teACCESS = st.wav' : Signed00000000ffffffffffffffff ->  16 bit Little E0000000000000012
ndian, Rate 4410FORMAT = 0 Hz, Stereo
00000000ffffffffffffffff -> 0000000000000004
SUBFORMAT = 00000000ffffffffffffffff -> 0000000000000001
SAMPLE_BITS = [0 4294967295] -> [0 4294967295]
FRAME_BITS = [0 4294967295] -> [0 4294967295]
CHANNELS = [0 4294967295] -> [2 2]
RATE = [0 4294967295] -> [32000 48000]
PERIOD_TIME = [0 4294967295] -> [0 4294967295]
PERIOD_SIZE = [0 4294967295] -> [0 4294967295]
PERIOD_BYTES = [0 4294967295] -> [32 8192]
PERIODS = [0 4294967295] -> [2 1024]
BUFFER_TIME = [0 4294967295] -> [0 4294967295]
BUFFER_SIZE = [0 4294967295] -> [0 4294967295]
BUFFER_BYTES = [0 4294967295] -> [32 32768]
TICK_TIME = [0 4294967295] -> [10000 10000]
Rule 0 [c01b3a4c]: FORMAT = 4 -> 4
Rule 1 [c01b3774]: SAMPLE_BITS = [0 4294967295] -> [16 16]
Rule 2 [c01b38f4]: SAMPLE_BITS = [16 16] -> [16 16]
Rule 3 [c01b3884]: FRAME_BITS = [0 4294967295] -> [32 32]
Rule 4 [c01b39d8]: FRAME_BITS = [32 32] -> [32 32]
Rule 5 [c01b39d8]: FRAME_BITS = [32 32] -> [32 32]
Rule 6 [c01b38f4]: CHANNELS = [2 2] -> [2 2]
Rule 7 [c01b39d8]: RATE = [32000 48000] -> [32000 48000]
Rule 8 [c01b39d8]: RATE = [32000 48000] -> [32000 48000]
Rule 9 [c01b38f4]: PERIODS = [2 1024] -> [2 1024]
Rule 10 [c01b38f4]: PERIOD_SIZE = [0 4294967295] -> [0 2147483647]
Rule 11 [c01b39d8]: PERIOD_SIZE = [0 2147483647] -> [8 2048]
Rule 12 [c01b3964]: PERIOD_SIZE = [8 2048] -> [8 2048]
Rule 13 [c01b3884]: BUFFER_SIZE = [0 4294967295] -> [16 2097152]
Rule 14 [c01b39d8]: BUFFER_SIZE = [16 2097152] -> [16 8192]
Rule 15 [c01b3964]: BUFFER_SIZE = [16 8192] -> [16 8192]
Rule 16 [c01b3964]: PERIOD_BYTES = [32 8192] -> [32 8192]
Rule 17 [c01b3964]: BUFFER_BYTES = [32 32768] -> [64 32768]
Rule 18 [c01b39d8]: PERIOD_TIME = [0 4294967295] -> (166 64000]
Rule 19 [c01b39d8]: BUFFER_TIME = [0 4294967295] -> (333 256000]
Rule 20 [c01b2a88]: BUFFER_BYTES = [64 32768] -> [64 32768]
Rule 21 [c01b3848]: RATE = [32000 48000] -> [32000 48000]
Rule 0 [c01b3a4c]: FORMAT = 4 -> 4
Rule 2 [c01b38f4]: SAMPLE_BITS = [16 16] -> [16 16]
Rule 4 [c01b39d8]: FRAME_BITS = [32 32] -> [32 32]
Rule 5 [c01b39d8]: FRAME_BITS = [32 32] -> [32 32]
Rule 7 [c01b39d8]: RATE = [32000 48000] -> [32000 48000]
Rule 8 [c01b39d8]: RATE = [32000 48000] -> [32000 48000]
Rule 9 [c01b38f4]: PERIODS = [2 1024] -> [2 1024]
Rule 10 [c01b38f4]: PERIOD_SIZE = [8 2048] -> [8 2048]
Rule 12 [c01b3964]: PERIOD_SIZE = [8 2048] -> [8 2048]
Rule 14 [c01b39d8]: BUFFER_SIZE = [16 8192] -> [16 8192]
Rule 15 [c01b3964]: BUFFER_SIZE = [16 8192] -> [16 8192]
ACCESS = 0000000000000002 -> 0000000000000002
RATE = [44100 48000] -> [44100 48000]
Rule 12 [c01b3964]: PERIOD_SIZE = [8 2048] -> [8 2048]
Rule 15 [c01b3964]: BUFFER_SIZE = [16 8192] -> [16 8192]
Rule 18 [c01b39d8]: PERIOD_TIME = (166 64000] -> (166 46440)
Rule 19 [c01b39d8]: BUFFER_TIME = (333 256000] -> (333 185760)
Rule 21 [c01b3848]: RATE = [44100 48000] -> [44100 48000]
Rule 7 [c01b39d8]: RATE = [44100 48000] -> [44100 48000]
Rule 8 [c01b39d8]: RATE = [44100 48000] -> [44100 48000]
Rule 12 [c01b3964]: PERIOD_SIZE = [8 2048] -> [8 2048]
Rule 15 [c01b3964]: BUFFER_SIZE = [16 8192] -> [16 8192]
RATE = [44100 44100] -> [44100 44100]
Rule 12 [c01b3964]: PERIOD_SIZE = [8 2048] -> [8 2048]
Rule 15 [c01b3964]: BUFFER_SIZE = [16 8192] -> [16 8192]
Rule 18 [c01b39d8]: PERIOD_TIME = (166 46440) -> (181 46440)
Rule 19 [c01b39d8]: BUFFER_TIME = (333 185760) -> (362 185760)
Rule 21 [c01b3848]: RATE = [44100 44100] -> [44100 44100]
Rule 7 [c01b39d8]: RATE = [44100 44100] -> [44100 44100]
Rule 8 [c01b39d8]: RATE = [44100 44100] -> [44100 44100]
Rule 12 [c01b3964]: PERIOD_SIZE = [8 2048] -> [8 2048]
Rule 15 [c01b3964]: BUFFER_SIZE = [16 8192] -> [16 8192]
PERIOD_TIME = (46439 46440) -> (46439 46440)
Rule 7 [c01b39d8]: RATE = [44100 44100] -> [44100 44100]
Rule 12 [c01b3964]: PERIOD_SIZE = [8 2048] -> [2048 2048]
Rule 13 [c01b3884]: BUFFER_SIZE = [16 8192] -> [4096 8192]
Rule 16 [c01b3964]: PERIOD_BYTES = [32 8192] -> [8192 8192]
Rule 17 [c01b3964]: BUFFER_BYTES = [64 32768] -> [16384 32768]
Rule 18 [c01b39d8]: PERIOD_TIME = (46439 46440) -> (46439 46440)
Rule 19 [c01b39d8]: BUFFER_TIME = (362 185760) -> (92879 185760)
Rule 20 [c01b2a88]: BUFFER_BYTES = [16384 32768] -> [16384 32768]
Rule 4 [c01b39d8]: FRAME_BITS = [32 32] -> [32 32]
Rule 5 [c01b39d8]: FRAME_BITS = [32 32] -> [32 32]
Rule 7 [c01b39d8]: RATE = [44100 44100] -> [44100 44100]
Rule 8 [c01b39d8]: RATE = [44100 44100] -> [44100 44100]
Rule 9 [c01b38f4]: PERIODS = [2 1024] -> [2 4]
Rule 10 [c01b38f4]: PERIOD_SIZE = [2048 2048] -> [2048 2048]
Rule 11 [c01b39d8]: PERIOD_SIZE = [2048 2048] -> [2048 2048]
Rule 13 [c01b3884]: BUFFER_SIZE = [4096 8192] -> [4096 8192]
Rule 14 [c01b39d8]: BUFFER_SIZE = [4096 8192] -> [4096 8192]
Rule 15 [c01b3964]: BUFFER_SIZE = [4096 8192] -> [4096 8192]
BUFFER_TIME = (185759 185760) -> (185759 185760)
Rule 8 [c01b39d8]: RATE = [44100 44100] -> [44100 44100]
Rule 15 [c01b3964]: BUFFER_SIZE = [4096 8192] -> [8192 8192]
Rule 17 [c01b3964]: BUFFER_BYTES = [16384 32768] -> [32768 32768]
Rule 19 [c01b39d8]: BUFFER_TIME = (185759 185760) -> (185759 185760)
Rule 20 [c01b2a88]: BUFFER_BYTES = [32768 32768] -> [32768 32768]
Rule 5 [c01b39d8]: FRAME_BITS = [32 32] -> [32 32]
Rule 8 [c01b39d8]: RATE = [44100 44100] -> [44100 44100]
Rule 9 [c01b38f4]: PERIODS = [2 4] -> [4 4]
Rule 10 [c01b38f4]: PERIOD_SIZE = [2048 2048] -> [2048 2048]
Rule 13 [c01b3884]: BUFFER_SIZE = [8192 8192] -> [8192 8192]
Rule 14 [c01b39d8]: BUFFER_SIZE = [8192 8192] -> [8192 8192]
ACCESS = 0000000000000002 -> 0000000000000002
FORMAT = 0000000000000004 -> 0000000000000004
SUBFORMAT = 0000000000000001 -> 0000000000000001
SAMPLE_BITS = [16 16] -> [16 16]
FRAME_BITS = [32 32] -> [32 32]
CHANNELS = [2 2] -> [2 2]
RATE = [44100 44100] -> [44100 44100]
PERIOD_TIME = (46439 46440) -> (46439 46440)
PERIOD_SIZE = [2048 2048] -> [2048 2048]
PERIOD_BYTES = [8192 8192] -> [8192 8192]
PERIODS = [4 4] -> [4 4]
BUFFER_TIME = (185759 185760) -> (185759 185760)
BUFFER_SIZE = [8192 8192] -> [8192 8192]
BUFFER_BYTES = [32768 32768] -> [32768 32768]
TICK_TIME = [10000 10000] -> [10000 10000]
Rule 0 [c01b3a4c]: FORMAT = 4 -> 4
Rule 1 [c01b3774]: SAMPLE_BITS = [16 16] -> [16 16]
Rule 2 [c01b38f4]: SAMPLE_BITS = [16 16] -> [16 16]
Rule 3 [c01b3884]: FRAME_BITS = [32 32] -> [32 32]
Rule 4 [c01b39d8]: FRAME_BITS = [32 32] -> [32 32]
Rule 5 [c01b39d8]: FRAME_BITS = [32 32] -> [32 32]
Rule 6 [c01b38f4]: CHANNELS = [2 2] -> [2 2]
Rule 7 [c01b39d8]: RATE = [44100 44100] -> [44100 44100]
Rule 8 [c01b39d8]: RATE = [44100 44100] -> [44100 44100]
Rule 9 [c01b38f4]: PERIODS = [4 4] -> [4 4]
Rule 10 [c01b38f4]: PERIOD_SIZE = [2048 2048] -> [2048 2048]
Rule 11 [c01b39d8]: PERIOD_SIZE = [2048 2048] -> [2048 2048]
Rule 12 [c01b3964]: PERIOD_SIZE = [2048 2048] -> [2048 2048]
Rule 13 [c01b3884]: BUFFER_SIZE = [8192 8192] -> [8192 8192]
Rule 14 [c01b39d8]: BUFFER_SIZE = [8192 8192] -> [8192 8192]
Rule 15 [c01b3964]: BUFFER_SIZE = [8192 8192] -> [8192 8192]
Rule 16 [c01b3964]: PERIOD_BYTES = [8192 8192] -> [8192 8192]
Rule 17 [c01b3964]: BUFFER_BYTES = [32768 32768] -> [32768 32768]
Rule 18 [c01b39d8]: PERIOD_TIME = (46439 46440) -> (46439 46440)
Rule 19 [c01b39d8]: BUFFER_TIME = (185759 185760) -> (185759 185760)
Rule 20 [c01b2a88]: BUFFER_BYTES = [32768 32768] -> [32768 32768]
Rule 21 [c01b3848]: RATE = [44100 44100] -> [44100 44100]
board_cs4265: Entered board_cs4265_hw_params
chip-cs4265: Entered cs4265_set_dai_fmt
chip-i2s: Entered chip_i2s_set_dai_fmt
chip-i2s: txconfig: 00003000 
chip-cs4265: Entered cs4265_hw_params
cs4265: Invalid MCLK or rate
asoc: can't set codec CS4265 hw params
chip-pcm: Entered chip_pcm_hw_free
ALSA lib pcm_hw.c:366:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS failed: Invalid argument
chip-pcm: Entered chip_pcm_hw_free
aplay: set_params:962: Unable to install hw params:
ACCESS:  MMAP_NONINTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (46439 46440)
PERIOD_SIZE: 2048
PERIOD_BYTES: 8192
PERIODS: 4
BUFFER_TIME: (185759 185760)
BUFFER_SIZE: 8192
BUFFER_BYTES: 32768
TICK_TIME: 10000
pop wq checking: Playback status: inactive waiting: yes
pop wq D3 CS4265 Playback

lg,
Markus Korber
