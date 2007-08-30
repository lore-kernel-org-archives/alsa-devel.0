From: "John Utz" <john.utz@dmx.com>
Subject: Dealing with 'siamesed' DAC sample rates
Date: Thu, 30 Aug 2007 11:51:12 -0700
Message-ID: <20070830115112.02820301@jutz-gnto64>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id BA48424366
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Aug 2007 20:51:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello All;

The thrice cursed vt1618 has the DAC sample rates regs for the Surround
and Center/LFE DAC's (0x2E, 0x30) set to RO and locked to whatever rate
that the Front DAC is set to.

This was probably a reasonable choice with respect to what the typical
end user might want to do, but i have to support content at 44100, not
48K.

So, here's the example of setting the front dac and getting the other
dac's changed:

jutz-gntdv alsa-kernel # echo 0x2c 0xac44> /proc/asound/card0/codec97#0/ac97#0-0+regs 
jutz-gntdv alsa-kernel # cat /proc/asound/card0/codec97#0/ac97#0-0+regs| grep ac44
0:2c = ac44
0:2e = ac44
0:30 = ac44

The *problem* seems to be that alsa wants to *set* the register even
tho the value that's in the register is already the right value
(44100=ac44)

So, i *think* that i want to change my driver code to poke the value
for setting hw:0,1 (should be reg 0x2e) into 0x2c instead? or am i
barking up the wrong tree?

Here's the problem that i am trying to solve:

Here's the output of speaker-test on the front (hw:0,0) and
surround (hw:0,1) devices.

[root@DMX-116248 jutz]# ./speaker-test -c2 -Dhw:0,0 -r 44100

speaker-test 1.0.14rc2

Playback device is hw:0,0
Stream parameters are 44100Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
Rate set to 44100Hz (requested 44100Hz)
Buffer size range from 16 to 16384
Period size range from 8 to 8192
Using max buffer size 16384
Periods = 4
was set period_size = 4096
was set buffer_size = 16384
 0 - Front Left
^X
[root@DMX-116248 jutz]# ./speaker-test -c2 -Dhw:0,1 -r 44100

speaker-test 1.0.14rc2

Playback device is hw:0,1
Stream parameters are 44100Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
ALSA ERROR hw_params: set (RATE)
           value = 44100 : Invalid argument
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 48000
PERIOD_TIME: (166 170667)
PERIOD_SIZE: [8 8192]
PERIOD_BYTES: [32 32768]
PERIODS: [2 127]
BUFFER_TIME: (333 341334)
BUFFER_SIZE: [16 16384]
BUFFER_BYTES: [64 65536]
TICK_TIME: 1000
Rate 44100Hz not available for playback: Invalid argument
Setting of hwparams failed: Invalid argument
[root@DMX-116248 jutz]# 


Does anybody have any suggestions?

tnx!

johnu
