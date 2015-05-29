From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Re: Fw: Using loopback card to Connect GSM two way
	call	to the real sound card UDA1345TS
Date: Fri, 29 May 2015 11:20:33 +0000
Message-ID: <HKXPR04MB2774E6DD22F054989C74F86C3C90@HKXPR04MB277.apcprd04.prod.outlook.com>
References: <1425878251963.1340@tataelxsi.co.in>
 <1425878360800.70892@tataelxsi.co.in>,	<54FD552C.7020902@ladisch.de>,
 <1425922601141.50130@tataelxsi.co.in>	<1425964490006.15084@tataelxsi.co.in>,
 <54FECC69.9020600@ladisch.de>	<1427510661706.37789@tataelxsi.co.in>,
 <551D0F35.6010709@ladisch.de> <1427970980529.96067@tataelxsi.co.in>,
 <551D5B78.60703@ladisch.de> <1429683117651.11394@tataelxsi.co.in>,
 <5539F971.2030407@ladisch.de>
 <1429877130444.23317@tataelxsi.co.in>,<553A3ADB.7040108@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-SG1-obe.outbound.protection.outlook.com
 (mail-sg1on0130.outbound.protection.outlook.com [134.170.132.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C9B3266748
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 13:20:37 +0200 (CEST)
In-Reply-To: <553A3ADB.7040108@ladisch.de>
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

Dear Clemens,

As you suggested am using jack plugin, but am facing the below error

etc/asound.conf

pcm.!default {
    type plug
    slave { pcm "jack" }
}

pcm.jack {
    type jack
    playback_ports {
        0 alsa_pcm:playback_1
        1 alsa_pcm:playback_2
    }
    capture_ports {
        0 alsa_pcm:capture_1
        1 alsa_pcm:capture_2
    }
}

ctl.mixer0 {
    type hw
    card 0
}

root@am335x-evm:/# aplay -D pcm.jack TangoForTajMusic11.wav
ALSA lib 
/home/jenkins/amsdk-nightly-build/build-CORTEX_1/arago-tmp-external-linaro-toolchain/work/cortexa8t2hf-vfp-neon-oe-linux-gnueabi/alsa-lib/1.0.27.2-r0/alsa-lib-1.0.27.2/src/pcm/pcm.c:2239:(snd_pcm_open_noupdate) 
Unknown PCM pcm.jack
aplay: main:722: audio open error: No such file or directory
root@am335x-evm:/#


Pls find the details of the architecture as below:

what ever the GSM analog audio out data is pumped as VINR to stereo codec & the output of the stereo codec ie., VOUTR is pumped to the Speaker of the custom board

what ever the GSM analog audio out data is pumped as VINR to stereo codec & the output of the stereo codec ie., VOUTR is pumped to the Speaker of the custom board
GSM MIC-> VINR -> stereo codec->VOUTR -> board speaker

what ever the board MIC data is pumped as VINL to stereo codec & the output of the stereo codec ie., VOUTL is pumped as analog input to the GSM Speaker
Board Mic -> VINL-> stereo codec -> VOUTL ->GSM speaker

Pls let me know if any other details is required from my side

Kindly do the needful as early as possible
Awaiting for your suggestions

________________________________________
From: Clemens Ladisch <clemens@ladisch.de>
Sent: Friday, April 24, 2015 6:15 PM
To: Srinivasan S
Cc: alsa-devel@alsa-project.org; linux-audio-dev@lists.linuxaudio.org
Subject: Re: [alsa-devel] Fw: Using loopback card to Connect GSM two way call   to the real sound card UDA1345TS

Srinivasan S wrote:
> did you mean that , If I use Jack plugin , does it resolve this
> problem (ie., does the CPU consumption reduce drastically instead of
> dshare)

It is unlikely that running your two programs on top of Jack will use
less CPU than with dshare.  However, I don't know the details of your
architecture, so the only way to find out would be for you to try it.


Regards,
Clemens
