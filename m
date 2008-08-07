From: Simon Tremblay <bidou@videotron.qc.ca>
Subject: Questions about /dev/snd and /proc/asound (new ASoC
	driver)
Date: Thu, 07 Aug 2008 17:03:30 -0400
Message-ID: <489B6322.8080307@videotron.qc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from randymail-a4.g.dreamhost.com (sd-green-bigip-202.dreamhost.com
	[208.97.132.202])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BF72249B9
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Aug 2008 23:03:54 +0200 (CEST)
Received: from BiDoUMaC.local (unknown [64.235.206.228])
	by randymail-a4.g.dreamhost.com (Postfix) with ESMTP id 56E77131982
	for <alsa-devel@alsa-project.org>; Thu,  7 Aug 2008 14:03:51 -0700 (PDT)
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

I have some issues with /dev/snd. First I should explain what I try to do.

I am developing a driver for TLV320AIC23B codec and want to use it on a
AT91RM9200-based board.

I read documentation in sound/soc and created a codec driver
(tlv320aic23b) and a machine driver (for my board). I think it's all I
have to do since AT91 is supported and tlv320aic23b works with i2c and I2S.

When I load my module I obtain that output:


# modprobe snd-soc-armus-tlv320aic23b
ASoC version 0.13.1
AIC23B Audio Codec 0.1
<6>asoc: aic23b <-> at91-ssc1 mapping ok
<6>armus_tlv320aic23b: MCLK rate 12000000Hz
armus_tlv320aic23b: Codec in Master Mode

(I activated debug in soc-core and in my machine driver (based mainly on
eti_b1_wm8731 machine driver)).

I think there is no error here for now...


But there is no /dev/snd created. I don't know for now why... Maybe
someone has an idea?

I think all I have in /proc/asound is correct too:

In /proc/asound I have this listing:

lrwxrwxrwx    1 root     root            5 Jan  1 00:02 ARMUSTLV320AIC2
-> card0
dr-xr-xr-x    4 root     root            0 Jan  1 00:02 card0
-r--r--r--    1 root     root            0 Jan  1 00:02 cards
-r--r--r--    1 root     root            0 Jan  1 00:02 devices
-r--r--r--    1 root     root            0 Jan  1 00:02 modules
-r--r--r--    1 root     root            0 Jan  1 00:02 pcm
-r--r--r--    1 root     root            0 Jan  1 00:02 timers
-r--r--r--    1 root     root            0 Jan  1 00:02 version


cat cards:

 0 [ARMUSTLV320AIC2]: aic23b - ARMUS_TLV320AIC23B
                      ARMUS_TLV320AIC23B (aic23b)

cat devices:

  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 24: [ 0- 0]: digital audio capture
 33:        : timer

cat modules:

 0 snd_soc_tlv320aic23b

cat pcm:

00-00: TLV320AIC23B PCM aic23b-PCM-0 :  : playback 1 : capture 1

cat timers:

G0: system timer : 7812.500us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE

cat version (of alsa): Advanced Linux Sound Architecture Driver Version
1.0.15 (Tue Nov 20 19:16:42 2007 UTC).

My Linux Kernel version (uname -a): Linux uclibc 2.6.24 #32 PREEMPT Thu
Aug 7 16:20:06 EDT 2008 armv4tl unknown.


When I try to use aplay it doesn't work. I have this error ouput from aplay:

ALSA lib confmisc.c:769:(parse_card) cannot find card ''
ALSA lib conf.c:3510:(_snd_config_evaluate) function
snd_func_card_driver returned error: No such device
ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
ALSA lib conf.c:3510:(_snd_config_evaluate) function snd_func_concat
returned error: No such device
ALSA lib confmisc.c:1251:(snd_func_refer) error evaluating name
ALSA lib conf.c:3510:(_snd_config_evaluate) function snd_func_refer
returned error: No such device
ALSA lib conf.c:3982:(snd_config_expand) Evaluate error: No such device
ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM default
aplay: main:545: audio open error: No such device

I think it's because I have nothing in /dev/snd. I'm right?


Thank you,


Simon Tremblay
