From: Pavan Krishna Guntooru <pavankrishna@tataelxsi.co.in>
Subject: Fw: kernel panic with ALSA driver
Date: Mon, 19 Sep 2016 12:15:34 +0000
Message-ID: <PS1PR0401MB1545DFF718843D40C542DBAE96F40@PS1PR0401MB1545.apcprd04.prod.outlook.com>
References: <PS1PR0401MB1545D4F8724C2FB04F14ADC596F40@PS1PR0401MB1545.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sg2apc01on0091.outbound.protection.outlook.com [104.47.125.91])
 by alsa0.perex.cz (Postfix) with ESMTP id 72B71266539
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2016 14:15:37 +0200 (CEST)
In-Reply-To: <PS1PR0401MB1545D4F8724C2FB04F14ADC596F40@PS1PR0401MB1545.apcprd04.prod.outlook.com>
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
List-Id: alsa-devel@alsa-project.org


Dear All,


Please find the below email and suggest us.



Thanks,
-Pavan G


________________________________
From: Pavan Krishna Guntooru
Sent: Monday, September 19, 2016 5:40 PM
To: clemens@ladisch.de; lrg@slimlogic.co.uk; broonie@opensource.wolfsonmicro.com
Subject: kernel panic with ALSA driver



Dear all,


We are using ti-sdk of version 8 and linux kernel version of 3.0.14. We have ported ti-sdk-8 to our Linux embedded box. Some times kernel Panic is happening and by decoding the generated kernel panic , crash happening in kernel at place linux-3.14.26-g2489c02/sound/core/pcm_dmaengine.c:134. the issue is in PCM engine driver.


After reading the some articles, people saying that there is a kernel bug and so happening.


My question here are

1) If its a known kernel issue, ALSA developers are aware of this bug?

2) Even though it is a kernel issue, is there a way to avoid from application in using of ALSA API's?

3) Do you have any fix for this?

4) If it is kernel issue, so many people could have reported by this time.


For every audio announcement playing, we are opening and closing the audio device in our application.


Please kindly suggest and awaiting for your reply. If I sent to a wrong person, please forward to the concern person.






Thanks,
-Pavan G
