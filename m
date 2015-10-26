From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Re: Delay issue in ALSA in connecting GSM call
Date: Mon, 26 Oct 2015 09:44:34 +0000
Message-ID: <SG2PR04MB069561F1F542C929AAF5EC64C3230@SG2PR04MB0695.apcprd04.prod.outlook.com>
References: <SG2PR04MB0695C70149EFD11BF229C903C3260@SG2PR04MB0695.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sg2apc01on0092.outbound.protection.outlook.com [104.47.125.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 8287A26061E
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 10:44:38 +0100 (CET)
In-Reply-To: <SG2PR04MB0695C70149EFD11BF229C903C3260@SG2PR04MB0695.apcprd04.prod.outlook.com>
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


Am awaiting, Could you please provide your valuable guidance or inputs w.r.t the below issue


Kindly do the needful as early as possible


Many Thanks in advance


________________________________
From: Srinivasan S
Sent: Friday, October 23, 2015 2:40 PM
To: Clemens Ladisch
Cc: alsa-devel@alsa-project.org; linux-audio-dev@lists.linuxaudio.org
Subject: Delay issue in ALSA in connecting GSM call


Dear Clemens,


I am using the above ALSA application to connect GSM two way call, I see that there seems to be a delay of 3 seconds, when GSM call is made, that ie., it takes 3 seconds to hear on the speaker of our custom board when ever we talk from GSM & the delay is same when  ever we talk from board MIC to speaker of GSM

But I tried to do loopback using the below command instead of using the above attached ALSA application, but still the delay issue persists
arecord -D VINL8 -f S16_LE | aplay -D VOUTR8

Could you please let me know how this delay issue can be resolved, Could you please provide any inputs or guidance w.r.t this issue


Any help would be greatly appreciated

Kindly do the needful as early as possible

Many Thanks in advance
