From: Lemon <qlwy_15@163.com>
Subject: baytrail crv2 audio mic no data
Date: Mon, 05 Oct 2015 16:07:39 +0800
Message-ID: <56122FCB.6020709@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m50-132.163.com (m50-132.163.com [123.125.50.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 32031260436
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 10:07:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: android-ia@lists.01.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello everyone,
     I have a Z3735F board which use ssp0 connect to rt5640, I
using linux mainline 4.2 and fw_sst_0f28.bin from
https://git.kernel.org/cgit/linux/kernel/git/vkoul/firmware.git/?h=byt
the audio sound is ok, I tried many alsa config but the analog mic 
record data is all 0, kernel no error message.

I don't know why mic record data is 0, does anyone knows ?


regards
LemonZou

========================================


arecord -f dat -t wav -d 5 foobar.wav
hexdump foobar.wav
0000000 4952 4646 a624 000e 4157 4556 6d66 2074
0000010 0010 0000 0001 0002 bb80 0000 ee00 0002
0000020 0004 0010 6164 6174 a600 000e 0000 0000
0000030 0000 0000 0000 0000 0000 0000 0000 0000
*
00ea62c

my board mic connect to alc5640 in2p, my main config include:
"Stereo ADC MIXL ADC1" on
"Stereo ADC1 Mux" "ADCL"
"RECMIXL INL"  on
"RECMIXL BST2" on
"pcm1_out mix 0 codec_in0" on
"pcm1_out mix 0 codec_in1" on


kernel message:
[ 5329.874448] sst-mfld-platform sst-mfld-platform: Enter: enable=1 
port_name=ssp0-port
[ 5329.979365] intel_sst_acpi 80860F28:00: Alloc for str 3 pipe 0xe
[ 5335.250574] sst-mfld-platform sst-mfld-platform: Enter: enable=0 
port_name=ssp0-port
[ 5335.253528] intel_sst_acpi 80860F28:00: Free for str 3 pipe 0xe

========================================
