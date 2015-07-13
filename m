From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Re: Running PJSIP for voip calls in alsa
Date: Mon, 13 Jul 2015 05:16:24 +0000
Message-ID: <SIXPR04MB253C9B8F73F687235D8315CC39C0@SIXPR04MB253.apcprd04.prod.outlook.com>
References: <SIXPR04MB253E749CD16977CEC4D4120C39F0@SIXPR04MB253.apcprd04.prod.outlook.com>,
 <559FCB17.2070200@ladisch.de>,
 <SIXPR04MB253B5222E188DE9C4A86778C39D0@SIXPR04MB253.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-hk2apc01on0118.outbound.protection.outlook.com [104.47.124.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 42A4E261480
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 07:16:27 +0200 (CEST)
In-Reply-To: <SIXPR04MB253B5222E188DE9C4A86778C39D0@SIXPR04MB253.apcprd04.prod.outlook.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dear Clemens,

As I suspected, am seeing the Clock drifts in ti sdk 8 (linux kernel 3.14) but I dont see this in ti sdk 7 (linux kernel 3.12), Could you please help me out, is there any possibilities of this getting resolved in Kernel or alsa???? 

Audio Device Test
Here are the audio statistics:
Rec : interval (min/max/avg/dev)=
         0/41/20/13 (ms)
      max burst=3
Play: interval (min/max/avg/dev)=
         19/22/20/0 (ms)
      burst=2
There could be 1 problem(s) with the sound device:
 1: Clock drifts detected. Capture is 16 samples/sec faster than the playback device

1:OK


Kindly do the needful as early as possible

Awaiting for your replies

Many Thanks in advance again for all your support w.r.t all of my threads

________________________________________
From: Srinivasan S
Sent: Sunday, July 12, 2015 12:24 PM
To: Clemens Ladisch
Cc: alsa-devel@alsa-project.org
Subject: Re: Running PJSIP for voip calls in alsa

Dear Clemens,

Many Thanks a lot for your suggestions till so far

I suspect it might be the clock drift issue again, could you please let me know whether my suspection is correct or wrong??

Because this issue might be, in one of my earlier reported threads for establishing the  GSM (ie., sound card & GSM streams were not synchronized)

Could you please let me is there any chances of getting resolved in sound card driver (my understanding of sound card driver is codec driver, pls let me know whether my understanding is correct or not ) or alsa??

Could you please provide any inputs on this

Kindly do the needful as early as possible

Many Thanks in advance,


________________________________________
From: Clemens Ladisch <clemens@ladisch.de>
Sent: Friday, July 10, 2015 7:09 PM
To: Srinivasan S
Cc: alsa-devel@alsa-project.org
Subject: Re: Running PJSIP for voip calls in alsa

Srinivasan S wrote:
> we are seeing the below error messages in the PJSIP, Could you please let me know what could be issue ?

I don't know PJSIP.

> The above problem observed with new rootfs (ti sdk 8) but when we tried with old rootfs (ti sdk 7) we are able to make calls with no problem.

Apparently, the driver changed its behaviour in the new kernel.

> If possible, could you please validate this PJSIP version 2.3 on ti sdk 8 BSP's on your EVK kit

I don't have any such TI SDK.


Regards,
Clemens
