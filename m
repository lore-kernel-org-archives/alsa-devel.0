From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: alsa audio open error
Date: Tue, 27 Oct 2015 08:46:18 +0000
Message-ID: <SG2PR04MB069529C060558B48A7586228C3220@SG2PR04MB0695.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-pu1apc01on0127.outbound.protection.outlook.com [104.47.126.127])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BA9C2608BB
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 09:46:23 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Dear Alsa community,

I facing the below error, am using am335x & ti sdk 8

Something wrong when execute arecord & aplay :

arecord and aplay does not work for the first time & it works after throwing error after 5 times

Couple of times I get the below error:


root@lifeline:/# arecord -D VINL8 -f S16_LE | aplay -D VOUTR8
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
^CAborted by signal Interrupt...
Aborted by signal Interrupt...
root@lifeline:/# arecord -D VINL8 -f S16_LE | aplay -D VOUTR8
ALSA lib /home/jenkins/amsdk-nightly-build/build-CORTEX_1/arago-tmp-external-linaro-toolchain/work/cortexa8t2hf-vfp-neon-oe-linux-gnueabi/alsa-lib/1.0.27.2-r0/alsa-lib-1.0.27.2/src/pcm/pcm_dsnoop.c:618:(snd_pcm_dsnoop_open) unable to open slave
arecord: main:722: audio open error: Invalid argument
aplay: playback:2715: read error
root@lifeline:/# arecord -D VINL8 -f S16_LE | aplay -D VOUTR8
ALSA lib /home/jenkins/amsdk-nightly-build/build-CORTEX_1/arago-tmp-external-linaro-toolchain/work/cortexa8t2hf-vfp-neon-oe-linux-gnueabi/alsa-lib/1.0.27.2-r0/alsa-lib-1.0.27.2/src/pcm/pcm_dshare.c:710:(snd_pcm_dshare_open) unable to open slave
aplay: main:722: audio open error: Invalid argument
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
root@lifeline:/# arecord -D VINL8 -f S16_LE | aplay -D VOUTR8
ALSA lib /home/jenkins/amsdk-nightly-build/build-CORTEX_1/arago-tmp-external-linaro-toolchain/work/cortexa8t2hf-vfp-neon-oe-linux-gnueabi/alsa-lib/1.0.27.2-r0/alsa-lib-1.0.27.2/src/pcm/pcm_dshare.c:710:(snd_pcm_dshare_open) unable to open slave
aplay: main:722: audio open error: Invalid argument
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
root@lifeline:/# arecord -D VINL8 -f S16_LE | aplay -D VOUTR8
ALSA lib /home/jenkins/amsdk-nightly-build/build-CORTEX_1/arago-tmp-external-linaro-toolchain/work/cortexa8t2hf-vfp-neon-oe-linux-gnueabi/alsa-lib/1.0.27.2-r0/alsa-lib-1.0.27.2/src/pcm/pcm_dshare.c:710:(snd_pcm_dshare_open) unable to open slave
aplay: main:722: audio open error: Invalid argument
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
root@lifeline:/# arecord -D VINL8 -f S16_LE | aplay -D VOUTR8
ALSA lib /home/jenkins/amsdk-nightly-build/build-CORTEX_1/arago-tmp-external-linaro-toolchain/work/cortexa8t2hf-vfp-neon-oe-linux-gnueabi/alsa-lib/1.0.27.2-r0/alsa-lib-1.0.27.2/src/pcm/pcm_dshare.c:710:(snd_pcm_dshare_open) unable to open slave
aplay: main:722: audio open error: Invalid argument
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
root@lifeline:/# arecord -D VINL8 -f S16_LE | aplay -D VOUTR8
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono

But there is no answer...

Could someone give me some clues?

Kindly do the needful as early as possible

Many Thanks in advance
