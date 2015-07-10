From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Re: Cannot open shared
	library	/usr/lib/alsa-lib/libasound_module_pcm_jack.so
Date: Fri, 10 Jul 2015 12:15:15 +0000
Message-ID: <SIXPR04MB25359BD822771FC347C8B18C39F0@SIXPR04MB253.apcprd04.prod.outlook.com>
References: <SIXPR04MB25362E92C1A38365A48DF57C3900@SIXPR04MB253.apcprd04.prod.outlook.com>,
 <559F687D.3040305@ladisch.de>
 <SIXPR04MB253428BCF6788F2160EC91DC39F0@SIXPR04MB253.apcprd04.prod.outlook.com>,
 <559FB521.9010901@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sg2apc01on0122.outbound.protection.outlook.com [104.47.125.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 71C8026043C
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 14:15:18 +0200 (CEST)
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

am sorry Clemens will not top post once again

Thanks a lot for your support as am alone working in alsa in my team & newbie to it

Thanks,
Srinivasan S

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
