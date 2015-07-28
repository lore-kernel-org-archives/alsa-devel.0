From: maruthi srinivas <maruthi.srinivas.b@gmail.com>
Subject: Re: Running PJSIP for voip calls in alsa
Date: Tue, 28 Jul 2015 12:22:31 +0530
Message-ID: <CANv6ZMYDHVH_9P-TxoTue-p2Q2ssPVpXEDsX=HGTN9R+U+G6xw@mail.gmail.com>
References: <SIXPR04MB253E749CD16977CEC4D4120C39F0@SIXPR04MB253.apcprd04.prod.outlook.com>
 <559FCB17.2070200@ladisch.de>
 <SIXPR04MB253B5222E188DE9C4A86778C39D0@SIXPR04MB253.apcprd04.prod.outlook.com>
 <55A3635C.7090009@ladisch.de>
 <SIXPR04MB2534E33FAFB9024B6D68B2BC39C0@SIXPR04MB253.apcprd04.prod.outlook.com>
 <55A36F98.8060408@ladisch.de>
 <SIXPR04MB253C2AE64F54AC46DA26414C3990@SIXPR04MB253.apcprd04.prod.outlook.com>
 <SIXPR04MB253C33418EA367F37CFDC53C3850@SIXPR04MB253.apcprd04.prod.outlook.com>
 <SIXPR04MB253482862078B53CC765D74C38E0@SIXPR04MB253.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f50.google.com (mail-qg0-f50.google.com
 [209.85.192.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 15347260459
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 08:52:33 +0200 (CEST)
Received: by qged69 with SMTP id d69so68624835qge.0
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 23:52:32 -0700 (PDT)
In-Reply-To: <SIXPR04MB253482862078B53CC765D74C38E0@SIXPR04MB253.apcprd04.prod.outlook.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Considering playback,

period_size  :  your sound card will generate interrupt after period_size
bytes have been consumed and ALSA core is informed of this, in driver's
interrupt handler.
Periods :    Number of buffer slices , each having period_size bytes.
Buffer_size :  periods * period_size

Your application should query the driver for the parameters and set
accordingly. Below is one good example for writing a alsa application :

http://equalarea.com/paul/alsa-audio.html

Regards,
Maruthi

On Tue, Jul 28, 2015 at 10:38 AM, Srinivasan S <srinivasan.s@tataelxsi.co.in
> wrote:

> Dear Clemens,
>
> Could you please helpme out in this
>
> I am trying to understand few terminologies w.r.t the following for
> developing alsa application
>
> Period_size
> Periods
> period_time
> Buffer_time
> Buffer_size
>
>
>
> ________________________________________
> From: alsa-devel-bounces@alsa-project.org <
> alsa-devel-bounces@alsa-project.org> on behalf of Srinivasan S <
> srinivasan.s@tataelxsi.co.in>
> Sent: Monday, July 20, 2015 12:18 PM
> To: Clemens Ladisch
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Running PJSIP for voip calls in alsa
>
> Dear Clemens,
>
> Could you pls let me know, do you know any alsa linux utilities/tools
> similar to aplay arecord to determine this clock drift issue in driver
>
> Kindly do the needful,
>
> Many Thanks in advance
> ________________________________________
> From: Srinivasan S
> Sent: Thursday, July 16, 2015 10:09 AM
> To: Clemens Ladisch
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Running PJSIP for voip calls in alsa
>
> Dear Clemens,
>
> Thanks a lot for your replies,
>
> Could you pls let me know, do you know any alsa linux utilities/tools
> similar to aplay arecord to determine this clock drift issue in driver
>
> Kindly do the needful,
>
> Many Thanks in advance
>
> ________________________________________
> From: Clemens Ladisch <clemens@ladisch.de>
> Sent: Monday, July 13, 2015 1:28 PM
> To: Srinivasan S
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Running PJSIP for voip calls in alsa
>
> Srinivasan S wrote:
> > Could you please provide any suggestions or inputs from where this
> problem could arrive ie., in either platform driver or machine driver or
> codec driver??
>
> I do not know that driver.
>
>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
