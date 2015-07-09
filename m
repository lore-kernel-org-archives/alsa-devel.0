From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Re: Fw: Using loopback card to Connect GSM two way
	call	to the real sound card UDA1345TS
Date: Thu, 9 Jul 2015 05:25:43 +0000
Message-ID: <SIXPR04MB2531164CB90147849B2757EC3900@SIXPR04MB253.apcprd04.prod.outlook.com>
References: <1425878251963.1340@tataelxsi.co.in>
 <1425878360800.70892@tataelxsi.co.in>,	<54FD552C.7020902@ladisch.de>,
 <1425922601141.50130@tataelxsi.co.in>	<1425964490006.15084@tataelxsi.co.in>,
 <54FECC69.9020600@ladisch.de>	<1427510661706.37789@tataelxsi.co.in>,
 <551D0F35.6010709@ladisch.de> <1427970980529.96067@tataelxsi.co.in>,
 <551D5B78.60703@ladisch.de> <1429683117651.11394@tataelxsi.co.in>,
 <5539F971.2030407@ladisch.de> <1429877130444.23317@tataelxsi.co.in>,
 <553A3ADB.7040108@ladisch.de>,
 <HKXPR04MB2774E6DD22F054989C74F86C3C90@HKXPR04MB277.apcprd04.prod.outlook.com>
 <HKXPR04MB277B58064C140058C37487EC3B60@HKXPR04MB277.apcprd04.prod.outlook.com>,
 <556C6EB8.7030401@ladisch.de>,
 <HKXPR04MB277069B809070671B95BAFCC3B40@HKXPR04MB277.apcprd04.prod.outlook.com>,
 <SIXPR04MB2530654AB664B2CE19B4665C3A80@SIXPR04MB253.apcprd04.prod.outlook.com>
 <SIXPR04MB2531DB716093D09C156BEA0C3A80@SIXPR04MB253.apcprd04.prod.outlook.com>,
 <5593F513.4030705@ladisch.de>,
 <SIXPR04MB2537D3E909AD64CEEE825C4C3910@SIXPR04MB253.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sg2apc01on0125.outbound.protection.outlook.com [104.47.125.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FAC9265D21
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 07:25:55 +0200 (CEST)
In-Reply-To: <SIXPR04MB2537D3E909AD64CEEE825C4C3910@SIXPR04MB253.apcprd04.prod.outlook.com>
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-audio-dev@lists.linuxaudio.org" <linux-audio-dev@lists.linuxaudio.org>
List-Id: alsa-devel@alsa-project.org

Dear Clemens

Could you please kindly help me out to cross_compile this alsa_plugins, so that I can resolve the below error & & get jack plugins working as you suggested earlier

Many Thanks in advance
Srinivasan S
________________________________________
From: Srinivasan S
Sent: Wednesday, July 8, 2015 8:55 PM
To: Clemens Ladisch
Cc: alsa-devel@alsa-project.org; linux-audio-dev@lists.linuxaudio.org
Subject: Re: [alsa-devel] Fw: Using loopback card to Connect GSM two way call   to the real sound card UDA1345TS

Dear Clemens,

Thanks a lot for your support Clemens

As you suggested, When I try to use alsa jack plugin, am facing the below error

root@lifeline:/# vi etc/asound.conf
pcm.rawjack {
type jack
playback_ports {
0 system:playback_1
1 system:playback_2
}
capture_ports {
0 system:capture_1
1 system:capture_2
}
}

pcm.jack {
type plug
slave { pcm "rawjack" }
hint {
description "JACK Audio Connection Kit"
}
}

pcm.!default {
type plug
slave { pcm "rawjack" }
}

root@lifeline:/opt/tunstall/audio# aplay -D pcm.jack TangoForTajMusic11.wav
ALSA lib /home/jenkins/amsdk-nightly-build/build-CORTEX_1/arago-tmp-external-linaro-toolchain/work/cortexa8t2hf-vfp-neon-oe-linux-gnueabi/alsa-lib/1.0.27.2-r0/alsa-lib-1.0.27.2/src/dlmisc.c:252:(snd1_dlobj_cache_get) Cannot open shared library /usr/lib/alsa-lib/libasound_module_pcm_jack.so
aplay: main:722: audio open error: No such device or address
root@lifeline:/opt/tunstall/audio#


I feel order to resolve this error,

1. I feel that there is no libasound_module_pcm_jack.so,  I have downloaded the alsa-plugins-1.0.29 could you please help me out how this can be cross compiled for my TI AM335x platform

2. Could you please let me know to cross compile &  install the package libasound2-dev

Could you please help me out in resolving this issue

Kindly do the needful as early as possible

Many Thanks a lot for your support once again w.r.t this thread so far

________________________________________
From: Clemens Ladisch <clemens@ladisch.de>
Sent: Wednesday, July 1, 2015 7:41 PM
To: Srinivasan S
Cc: alsa-devel@alsa-project.org; linux-audio-dev@lists.linuxaudio.org
Subject: Re: [alsa-devel] Fw: Using loopback card to Connect GSM two way call   to the real sound card UDA1345TS

Srinivasan S wrote:
> Am facing overrun & underrun issues, when I run the the above GSM application with the attached asound.conf

The sound card and the GSM streams are not synchronized.
You need to compensate for the drift between the clocks, typically by resampling.
(Jack's alsa_in/alsa_out would automatically do this.)


Regards,
Clemens
