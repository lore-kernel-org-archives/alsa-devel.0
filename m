From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Running PJSIP for voip calls in alsa
Date: Mon, 13 Jul 2015 09:06:04 +0200
Message-ID: <55A3635C.7090009@ladisch.de>
References: <SIXPR04MB253E749CD16977CEC4D4120C39F0@SIXPR04MB253.apcprd04.prod.outlook.com>,
 <559FCB17.2070200@ladisch.de>
 <SIXPR04MB253B5222E188DE9C4A86778C39D0@SIXPR04MB253.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 6953626149D
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 09:06:07 +0200 (CEST)
In-Reply-To: <SIXPR04MB253B5222E188DE9C4A86778C39D0@SIXPR04MB253.apcprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

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
