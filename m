From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Re: Running PJSIP for voip calls in alsa
Date: Mon, 13 Jul 2015 07:22:42 +0000
Message-ID: <SIXPR04MB2534E33FAFB9024B6D68B2BC39C0@SIXPR04MB253.apcprd04.prod.outlook.com>
References: <SIXPR04MB253E749CD16977CEC4D4120C39F0@SIXPR04MB253.apcprd04.prod.outlook.com>,
 <559FCB17.2070200@ladisch.de>
 <SIXPR04MB253B5222E188DE9C4A86778C39D0@SIXPR04MB253.apcprd04.prod.outlook.com>,
 <55A3635C.7090009@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-HK1-obe.outbound.protection.outlook.com
 (mail-hk1bn0101.outbound.protection.outlook.com [134.170.140.101])
 by alsa0.perex.cz (Postfix) with ESMTP id E446F2614A6
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 09:22:46 +0200 (CEST)
In-Reply-To: <55A3635C.7090009@ladisch.de>
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

Thanks a lot Clemens for your quick responses

Could you please provide any suggestions or inputs from where this problem could arrive ie., in either platform driver or machine driver or codec driver??


Kindly do the needful as early as possible

Many Thanks in advance Clemens,

________________________________________
From: Clemens Ladisch <clemens@ladisch.de>
Sent: Monday, July 13, 2015 12:36 PM
To: Srinivasan S
Cc: alsa-devel@alsa-project.org
Subject: Re: Running PJSIP for voip calls in alsa

Srinivasan S wrote:
> I suspect it might be the clock drift issue again, could you please let me know whether my suspection is correct or wrong??
>
> Because this issue might be, in one of my earlier reported threads for establishing the  GSM (ie., sound card & GSM streams were not synchronized)
>
> Could you please let me is there any chances of getting resolved in sound card driver or alsa??

If the new kernel behaves differently, then apparently the driver changes.
But you'd have to ask the author of the driver.

In any case, the sound card cannot know how fast data arrives over GSM.


Regards,
Clemens
