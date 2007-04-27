From: Markus Korber <korbse@gmx.at>
Subject: Re: [ASoC] Sample format non available
Date: Fri, 27 Apr 2007 08:13:43 +0200
Message-ID: <6zps5qwdig.fsf@odpc25.int.ondemand.co.at>
References: <6zwszzjn7u.fsf@odpc25.int.ondemand.co.at>
	<1177595163.32188.465.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 810D82478E
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2007 08:13:54 +0200 (CEST)
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

Thus spake Liam Girdwood:

> On Thu, 2007-04-26 at 15:10 +0200, Markus Korber wrote:
>
>> I'm currently implementing a ASoC solution for a custom chip and I've
>> written a codec, I2S, PCM, and machine driver.  However, when using
>> aplay I get the following error (requested format was: 2):
>> 
>> root:~# aplay -M -D hw:0,0 test.wav 
>> Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
>> aplay: set_params:906: Sample format non available
>> 
>> However, I've told each piece involved, that it is capable of playing
>> S16_LE.  So I don't know what I am missing here?
>
> Is your target CPU ARM based ?

Yes, it's an arm926ejs.

> If so, there is a gcc optimisation bug that causes a refinement error
> (like above).  
>
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=27363

I'm using buildroot:

,----[ arm-linux-gcc -v ]
| Using built-in specs.
| Target: arm-linux-uclibcgnueabi
| gcc version 4.1.1
`----

> Fwiw, Openembedded builds a working toolchain for ARM and ALSA.

Unfortunately, so far I have had no luck building this toolchain.  I'll
give it another try as soon as possible.  Meanwhile I've compiled with
-O1 with the results shown below.

>> Should I provide more debugging output like RULES_DEBUG output from
>> sound/core/pcm_native.c?
>
> Yes please. Can you also set SOC_DEBUG to 1 in soc-core.c
> [...]
> Can you send the debug output with the debug turned on (as above) and
> with aplay writing directly to the hardware  i.e.
>
> aplay -Dhw:0,0 test.wav

root:~# ./alsa-hg/alsa-utils/aplay/aplay -M -D hw:0,0 test.wav 
chip-pcm: Entered chip_pcm_open
board_cs4265: Entered board_cs4265_startup
asoc: CS4265 <-> chip-i2s info:
asoc: rate mask 0xe0
asoc: min ch 2 max ch 2
asoc: min rate 32000 max rate 48000
Playing WAVE 'teACCESS = st.wav' : Signed00000000ffffffffffffffff ->  16 bit Lit
tle E0000000000000012
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
Rule 0 [c01b0ea8]: FORMAT = 4 -> 0
aplay: set_params:878: Broken configuration for this PCM: no configurations available

Regards,
Markus Korber
