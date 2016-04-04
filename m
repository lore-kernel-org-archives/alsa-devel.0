From: =?UTF-8?Q?Emmanuel_Fust=c3=a9?= <emmanuel.fuste@laposte.net>
Subject: simple-audio-card and external dynamic clock
Date: Mon, 4 Apr 2016 23:56:16 +0200
Message-ID: <5702E300.8060101@laposte.net>
References: <56F46168.7040201@laposte.net>
Reply-To: emmanuel.fuste@laposte.net
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.laposte.net (smtpoutz25.laposte.net [194.117.213.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 54E73261504
 for <alsa-devel@alsa-project.org>; Mon,  4 Apr 2016 23:56:14 +0200 (CEST)
Received: from smtp.laposte.net (localhost [127.0.0.1])
 by lpn-prd-vrout013 (Postfix) with ESMTP id D352B1040B7
 for <alsa-devel@alsa-project.org>; Mon,  4 Apr 2016 23:56:13 +0200 (CEST)
Received: from lpn-prd-vrin003 (lpn-prd-vrin003.laposte [10.128.63.4])
 by lpn-prd-vrout013 (Postfix) with ESMTP id CE68A1040B2
 for <alsa-devel@alsa-project.org>; Mon,  4 Apr 2016 23:56:13 +0200 (CEST)
Received: from lpn-prd-vrin003 (localhost [127.0.0.1])
 by lpn-prd-vrin003 (Postfix) with ESMTP id B4A3348C380
 for <alsa-devel@alsa-project.org>; Mon,  4 Apr 2016 23:56:13 +0200 (CEST)
In-Reply-To: <56F46168.7040201@laposte.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: peter.ujfalusi@ti.com
List-Id: alsa-devel@alsa-project.org

Le 24/03/2016 22:51, Emmanuel Fust=E9 a =E9crit :
> Hello,
>
> I m very new to ASoC (and not native english speaker) so be indulgent ;-)
> The context  : am335x-boneblack.
> I want to drive simple I2S targets. With the ongoing developments, and =

> recent patches posted here, this is a very simple job for the =

> simple-audio-card machine driver even with fixed external master clock.
> I want to go further using a programmable external clock (si570) which =

> is not very complicated thanks to the CCF.
> But now I want to use the dynamic nature of this external master clock =

> (through CCF) to be able to generate 44.1khz AND 48 multiples of fs =

> which is not natively possible on the BBB because of integer fs =

> scaling only and/or no dedicated audio PLL.
> I know that the same could be achieved on the BBB with switching =

> between internal clock (24mhz) and external one (24.576mhz) gated by =

> GPIO1_27, but this is another story.
>
> Which direction is the right one ?
> - dedicated machine driver ?
> - or something more generic / reusable implemented in the =

> simple-audio-card drivers through helpers routines ?
> - or something else ?
>

Ok,

I did a little bit of homework and mailing list digging.
If I understand the "problem"  correctly, here we are:
- ASoc is now completely CCF aware
- McASP driver is not, but it is not a real problem in most use cases =

when we omit the possibilities offered by AHCLKX or if we use a static =

AHCLKX configuration.
My use case needs two different level of ccf work on the McASP driver:
First, a "basic" conversion to CCF to be able to use simple-audio-card, =

choosing the used clock (AHCLKX or AUXCLK) with the =

assigned-clocks/assigned-clock-parents standard DT properties as it =

seems to be the way to go (February discussion about selecting system =

clocks by ID ).
Next, a more advanced support for the external AHCLKX case, which could =

be driven by a programmable clock (clk_set_rate available). Most use =

cases would be covered by a 24mhz and 24.576mhz AHCLKX and the correct =

divisors sets as need by the McASP driver.
With more complexity, arbitrary I2S rate (with arbitrary AHCLKX) or =

better accuracy ( dynamic switching between internal AUXCLK @24mhz and =

external fixed AHCLKX @24.576mhz) could be achieved.
And no need for a machine driver, simple-audio-card would be sufficient.

Right ?

Emmanuel.
