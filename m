From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Re: Cannot open shared
	library	/usr/lib/alsa-lib/libasound_module_pcm_jack.so
Date: Tue, 28 Jul 2015 05:23:44 +0000
Message-ID: <SIXPR04MB253CEF806D289FF068A4E8FC38D0@SIXPR04MB253.apcprd04.prod.outlook.com>
References: <SIXPR04MB25362E92C1A38365A48DF57C3900@SIXPR04MB253.apcprd04.prod.outlook.com>,
 <559F687D.3040305@ladisch.de>
 <SIXPR04MB253428BCF6788F2160EC91DC39F0@SIXPR04MB253.apcprd04.prod.outlook.com>,
 <559FB521.9010901@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-hk2apc01on0092.outbound.protection.outlook.com [104.47.124.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 219212651C0
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 07:23:48 +0200 (CEST)
In-Reply-To: <559FB521.9010901@ladisch.de>
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

Dear Clemens,

I have cross_compiled on my own the alsa-lib-1.0.26 & I am seeing "alsa.pc" in the pkgconfig
does this alsa-lib-version supports libasound_module_pcm_jack.so, but am unable to find in this alsa-lib verison, will I get the libasound_module_pcm_jack.so in any of the latest alsa-lib verison apart from this version

srinivasan@tata-HP-Elite-7100-Microtower-PC:~/alsa_libraries/alsa-lib-1.0.26/binaries/lib/pkgconfig$ ls
alsa.pc
srinivasan@tata-HP-Elite-7100-Microtower-PC:~/alsa_libraries/alsa-lib-1.0.26/binaries/lib/pkgconfig$

Could you please kindly help me out, Is it possible to get libasound_module_pcm_jack.so, if I cross_compile alsa-plugins inorder to get the libasound_module_pcm_jack.so

Can you please provide the build command to cross_compile alsa_plugins & get the libasound_module_pcm_jack.so,

Kindly do the needful as early as possible

________________________________________
From: Clemens Ladisch <clemens@ladisch.de>
Sent: Friday, July 10, 2015 5:35 PM
To: Srinivasan S; alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Cannot open shared library    /usr/lib/alsa-lib/libasound_module_pcm_jack.so

(please don't top-post)

Srinivasan S wrote:
>> Srinivasan S wrote:
>>> ...
>>> checking for pkg-config... /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin//pkg-config
>>> checking pkg-config is at least version 0.9.0... yes
>>> checking for ALSA... no
>>> configure: error: Package requirements (alsa >= 1.0.11) were not met:
>>
>> Well, did you cross-compile alsa-lib?
>
> I have never cross_compiled alsa-lib 1.0.27.2-r0 am using the alsa-lib version which is provided in ti sdk 8 BSP's

That pkg-config does not know about "alsa".  Apparently, TI's SDK did
not install alsa.pc together with the rest of alsa-lib.

Report this bug to TI.

As a workaround, try cross-compiling alsa-lib yourself.


Regards,
Clemens
