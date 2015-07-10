From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Re: Cannot open
	shared	library	/usr/lib/alsa-lib/libasound_module_pcm_jack.so
Date: Fri, 10 Jul 2015 07:27:19 +0000
Message-ID: <SIXPR04MB253428BCF6788F2160EC91DC39F0@SIXPR04MB253.apcprd04.prod.outlook.com>
References: <SIXPR04MB25362E92C1A38365A48DF57C3900@SIXPR04MB253.apcprd04.prod.outlook.com>,
 <559F687D.3040305@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sg2apc01on0104.outbound.protection.outlook.com [104.47.125.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 942F426044B
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 09:27:22 +0200 (CEST)
In-Reply-To: <559F687D.3040305@ladisch.de>
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
To: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks a lot for your responses, I was eagerly waiting for your replies,

Am sorry, as am poor in alsa 

Could you please help me out in resolving this issue

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



Even I installed libasound2-dev in my linux host machine still the same issue

srinivasan@tata-HP-Elite-7100-Microtower-PC:~/alsa-plugins-1.0.29$ ./configure --prefix=/home/srinivasan/alsa-plugins-1.0.29/exes --host=arm-arago-linux-gnueabi
checking for a BSD-compatible install... /usr/bin/install -c

checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... no
checking for ANSI C header files... (cached) yes
./configure: line 11534: CC_NOUNDEFINED: command not found
checking for arm-arago-linux-gnueabi-pkg-config... no
checking for pkg-config... /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin//pkg-config
checking pkg-config is at least version 0.9.0... yes
checking for ALSA... no
configure: error: Package requirements (alsa >= 1.0.11) were not met:

No package 'alsa' found

Consider adjusting the PKG_CONFIG_PATH environment variable if you
installed software in a non-standard prefix.

Alternatively, you may set the environment variables ALSA_CFLAGS
and ALSA_LIBS to avoid the need to call pkg-config.
See the pkg-config man page for more details.

Am sorry I wrongly understood, where I get libasound_module_pcm_jack.so is it in alsa-lib?? or alsa-plugins??, I just blindly tried cross compiling alsa-plugins-1.0.29 with above errors, without cross compiling alsa-lib 1.0.27.2-r0, does this alsa lib version supports this library???

I have never cross_compiled alsa-lib 1.0.27.2-r0 am using the alsa-lib version which is provided in ti sdk 8 BSP's

Could you please help me out first how to cross_compile alsa-lib 1.0.27.2-r0 version??? & then alsa-plugins


Many Thanks in advance..
________________________________________
From: alsa-devel-bounces@alsa-project.org <alsa-devel-bounces@alsa-project.org> on behalf of Clemens Ladisch <clemens@ladisch.de>
Sent: Friday, July 10, 2015 12:08 PM
To: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Cannot open shared    library /usr/lib/alsa-lib/libasound_module_pcm_jack.so

Srinivasan S wrote:
> ...
> checking for pkg-config... /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin//pkg-config
> checking pkg-config is at least version 0.9.0... yes
> checking for ALSA... no
> configure: error: Package requirements (alsa >= 1.0.11) were not met:

Well, did you cross-compile alsa-lib?


Regards,
Clemens
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
