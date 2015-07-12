From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Re: Running PJSIP for voip calls in alsa
Date: Sun, 12 Jul 2015 06:54:23 +0000
Message-ID: <SIXPR04MB253B5222E188DE9C4A86778C39D0@SIXPR04MB253.apcprd04.prod.outlook.com>
References: <SIXPR04MB253E749CD16977CEC4D4120C39F0@SIXPR04MB253.apcprd04.prod.outlook.com>,
 <559FCB17.2070200@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-HK1-obe.outbound.protection.outlook.com
 (mail-hk1on0130.outbound.protection.outlook.com [134.170.140.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 218BD26062B
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2015 08:54:29 +0200 (CEST)
In-Reply-To: <559FCB17.2070200@ladisch.de>
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
